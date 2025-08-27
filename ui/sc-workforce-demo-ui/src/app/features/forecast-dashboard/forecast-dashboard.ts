// src/app/features/forecast-dashboard/forecast-dashboard.ts
import { Component, OnDestroy, OnInit, computed, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { Subscription } from 'rxjs';

import { ForecastApiService, LaborDeficit, KPIValuesResponse } from '../../services/forecast-api.service';
import { NgChartsModule } from 'ng2-charts';
import { ChartData, ChartEvent, ChartOptions } from 'chart.js';

import { OrderDetailsIssues } from '../order-details-issues/order-details-issues';
import { KpiApiService } from '../../services/kpi-api.service';
import { IIssue } from '../../models/issue-result';
import { IKpiListingResult } from '../../models/kpi-listing-result';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';

type WarehouseId = 'warehouse-01' | 'warehouse-02';
type OrderRef = Pick<IKpiListingResult, 'uid'>;

interface WeekBucket {
  key: string;
  label: string;
  date: Date;
}
interface TableRow {
  productId: string;
  gaps: number[];
}

@Component({
  selector: 'app-forecast-dashboard',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, NgChartsModule, OrderDetailsIssues],
  templateUrl: './forecast-dashboard.html',
  styleUrls: ['./forecast-dashboard.scss']
})
export class ForecastDashboard implements OnInit, OnDestroy {
  // ---------- Details panel ----------
  detailsOrder?: OrderRef;           // ✅ minimal shape
  detailsIssues: IIssue[] = [];
  allIssues = signal<IIssue[]>([]);
  private lastSelection: { weekIndex: number; productId: string } | null = null;

  // ---------- Services ----------
  private fb = inject(FormBuilder);
  private kpiApi = inject(KpiApiService);

  constructor(private api: ForecastApiService ) {}

  // ---------- Labels ----------
  private readonly profileLabels: Record<string, string> = {
    'laborproduct-01': 'Forklift operator',
    'laborproduct-02': 'Quality control',
    'laborproduct-03': 'General warehouse operations'
  };
  labelFor(pid: string): string { return this.profileLabels[pid] ?? pid; }

  // ---------- Form ----------
  form = this.fb.group({
    warehouse: ['warehouse-01' as WarehouseId],
    profiles: {} as Record<string, boolean>
  });

  // ---------- Base state ----------
  loading = signal(true);
  error   = signal<string | null>(null);
  raw     = signal<LaborDeficit[]>([]);
  profiles = signal<string[]>([]);
  weeks    = signal<WeekBucket[]>([]);
  weekLabels = computed(() => this.weeks().map(w => w.label));

  private sub = new Subscription();

  ngOnInit(): void {
    // Load deficits
    this.sub.add(
      this.api.getLaborDeficits().subscribe({
        next: data => {
          this.raw.set(data);
          this.initProfilesAndWeeks();
          this.initProfileFormDefaults();
          this.loading.set(false);
          this.refreshChartAndTable();
          this.loadKPI();
        },
        error: err => {
          this.error.set('Failed to load labor deficits');
          this.loading.set(false);
          console.error(err);
        }
      })
    );

    this.sub.add(
      this.kpiApi.getAllIssues('LaborDeficit', []).subscribe({
        next: issues => {
          console.log('[Forecast] loaded all issues', issues?.length || 0);
          this.allIssues.set(issues || []);
        },
        error: err => console.error('[Forecast] failed to load all issues', err)
      })
    );

    // React to filters
    this.sub.add(
      this.form.valueChanges.subscribe(() => {
        this.refreshChartAndTable();
        this.loadKPI();
      })
    );
  }

  ngOnDestroy(): void {
    this.sub.unsubscribe();
  }

  // ---------- Helpers ----------
  private filteredData(): LaborDeficit[] {
    const wh = (this.form.value.warehouse as WarehouseId) ?? 'warehouse-01';
    const selected = this.form.value.profiles || {};
    const selectedSet = new Set(Object.keys(selected).filter(k => selected[k]));
    return this.raw().filter(r =>
      r.locationId === wh &&
      (selectedSet.size === 0 || selectedSet.has(r.productId))
    );
  }

  private initProfilesAndWeeks(): void {
    const all = this.raw();
    this.profiles.set(Array.from(new Set(all.map(r => r.productId))).sort());

    const uniqueDates = Array.from(new Set(all.map(r => r.startDate)));
    const weeks = uniqueDates
      .map(d => ({ key: d, date: new Date(d) }))
      .sort((a, b) => a.date.getTime() - b.date.getTime())
      .map((w, i) => ({ ...w, label: `Week ${i + 1}` })) as WeekBucket[];
    this.weeks.set(weeks);
  }

  private initProfileFormDefaults(): void {
    const current = this.form.value;
    const entries = Object.fromEntries(this.profiles().map(p => [p, true]));
    this.form.patchValue({ profiles: { ...(current.profiles || {}), ...entries } }, { emitEvent: false });
  }

  // ---------- KPI ----------
  kpi = signal<KPIValuesResponse | null>(null);

  private loadKPI(): void {
    const wh = this.form.value.warehouse as WarehouseId;
    if (!wh) return;
    this.api.getStaffingIssues(wh).subscribe({
      next: res => this.kpi.set(res),
      error: err => {
        console.warn('KPI load failed', err);
        this.kpi.set(null);
      }
    });
  }

  // ---------- Chart & Table ----------
  chartType: 'line' = 'line';
  chartData: ChartData<'line'> = { labels: [], datasets: [] };
  chartOptions: ChartOptions<'line'> = {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      x: { title: { display: true, text: 'Week' } },
      y: { title: { display: true, text: 'Hours' }, beginAtZero: true }
    },
    plugins: {
      legend: { position: 'top' },
      tooltip: {
        callbacks: {
          label: (ctx) => {
            const label = ctx.dataset.label || '';
            const v = ctx.parsed.y as number;
            return `${label}: ${v.toFixed(2)} h`;
          }
        }
      }
    },
    elements: { line: { tension: 0.25 } }
  };

  tableRows: TableRow[] = [];
  tableTotal: number[] = [];
  gapByWeek: number[] = [];

  private refreshChartAndTable(): void {
    const data = this.filteredData();

    const uniqueDates = Array.from(new Set(data.map(r => r.startDate)));
    const weeks = uniqueDates
      .map(d => ({ key: d, date: new Date(d) }))
      .sort((a, b) => a.date.getTime() - b.date.getTime())
      .map((w, i) => ({ ...w, label: `Week ${i + 1}` })) as WeekBucket[];
    this.weeks.set(weeks);

    const supply: number[] = [];
    const demand: number[] = [];
    const gap: number[] = [];
    for (const w of this.weeks()) {
      const weekRecs = data.filter(r => r.startDate === w.key);
      const s = weekRecs.reduce((acc, r) => acc + (r.supplyQuantity || 0), 0);
      const d = weekRecs.reduce((acc, r) => acc + (r.demandQuantity || 0), 0);
      supply.push(+s.toFixed(2));
      demand.push(+d.toFixed(2));
      gap.push(+(s - d).toFixed(2));
    }
    this.gapByWeek = gap;

    this.chartData = {
      labels: this.weeks().map(w => w.label),
      datasets: [
        { label: 'Workforce available', data: supply, borderColor: '#00838f', backgroundColor: 'rgba(0,131,143,0.18)', fill: 'origin', pointRadius: 3, pointHoverRadius: 5 },
        { label: 'Workload',            data: demand, borderColor: '#7c3aed', backgroundColor: 'rgba(124,58,237,0.18)', fill: 'origin', pointRadius: 3, pointHoverRadius: 5 },
      ]
    };

    const selectedProfiles = Object.entries(this.form.value.profiles || {})
  .filter(([, v]) => !!v)
  .map(([k]) => k);

const rows: TableRow[] = selectedProfiles.map(pid => {
  const gaps = this.weeks().map(w => {
    const rec = data.find(r => r.productId === pid && r.startDate === w.key);
    const raw = rec ? Number(rec.quantity || 0) : 0;
    return Math.round(raw); // ← round up/down
  });
  return { productId: pid, gaps };
});
this.tableRows = rows;

// Totals per week — sum the rounded cells and round again for safety
this.tableTotal = this.weeks().map((_, i) => {
  const sum = rows.reduce((acc, row) => acc + (row.gaps[i] || 0), 0);
  return Math.round(sum); // ← round up/down
});
  }

  // ---------- Interactions ----------
  onChartClick(event: ChartEvent | undefined, elements: any[] | undefined) {
    if (!elements?.length || !event) return;
    const weekIndex: number = (elements[0] as any).index;
    const gap = this.gapByWeek?.[weekIndex] ?? 0;
    if (gap < 0) this.loadIssuesForSelection(weekIndex, 'ALL');
    else { this.detailsOrder = undefined; this.detailsIssues = []; }
  }

  // Find the LaborDeficit record UID for a given week/profile/warehouse
private uidForCell(wh: WarehouseId, productId: string, weekKey: string): string | null {
  const rec = this.raw().find(r =>
    r.locationId === wh && r.productId === productId && r.startDate === weekKey
  ) as any;
  return rec?.uid || null; // some APIs return a 'uid' like DEFwarehouse-01laborproduct-030
}

// Should the cell be clickable? (exists a matching issue for its UID & direction)
isCellActionable(weekIndex: number, productId: string, value: number): boolean {
  const wh = (this.form.value.warehouse as WarehouseId) ?? 'warehouse-01';
  const week = this.weeks()[weekIndex];
  if (!week || value === 0) return false;

  const expected = value < 0 ? 'understaffing' : 'overstaffing';
  const uid = this.uidForCell(wh, productId, week.key);
  if (!uid) return false;

  const impactedId = `${wh}${productId}`;
  const has = (this.allIssues() || []).some(iss =>
    iss.impactedObjectId === impactedId &&
    (iss.triggerObjectId?.toLowerCase?.() === expected) &&
    typeof iss.issueData === 'string' &&
    iss.issueData.includes(uid)
  );

  // console.log('[Forecast] cell actionable?', { week: week.label, productId, value, uid, impactedId, expected, has });
  return has;
}

// Pick the single matching issue for the cell (by UID + direction)
private findIssueForCell(weekIndex: number, productId: string, value: number): IIssue | undefined {
  const wh = (this.form.value.warehouse as WarehouseId) ?? 'warehouse-01';
  const week = this.weeks()[weekIndex];
  if (!week || value === 0) return undefined;

  const expected = value < 0 ? 'understaffing' : 'overstaffing';
  const uid = this.uidForCell(wh, productId, week.key);
  const impactedId = `${wh}${productId}`;

  let candidates = (this.allIssues() || []).filter(iss =>
    iss.impactedObjectId === impactedId &&
    (iss.triggerObjectId?.toLowerCase?.() === expected) &&
    typeof iss.issueData === 'string' &&
    (uid ? iss.issueData.includes(uid) : true)
  );

  candidates.sort((a, b) =>
    (b.severity ?? 0) - (a.severity ?? 0) ||
    new Date(b.lastUpdatedTime).getTime() - new Date(a.lastUpdatedTime).getTime()
  );

  const chosen = candidates[0];
  console.log('[Forecast] findIssueForCell', { week: week.label, productId, value, uid, impactedId, expected, found: !!chosen, chosen });
  return chosen;
}


  onCellClick(weekIndex: number, productId: string, value: number) {
  console.log('[Forecast] table cell clicked', { weekIndex, productId, value });

  if (!this.isCellActionable(weekIndex, productId, value)) {
    console.log('[Forecast] cell not actionable');
    return;
  }

  const issue = this.findIssueForCell(weekIndex, productId, value);
  if (!issue) {
    console.warn('[Forecast] no issue matched cell');
    return;
  }

  const wh = (this.form.value.warehouse as WarehouseId) ?? 'warehouse-01';
  const week = this.weeks()[weekIndex];

  // Fetch FULL issue (latestAnalysis etc.) and render inline
  this.kpiApi.getIssue(issue.uid).subscribe({
    next: (full) => {
      console.log('[Forecast] full issue loaded for cell', full);
      this.detailsOrder = { uid: `${wh}-${week.label}-${productId}` };
      this.detailsIssues = [full];
    },
    error: err => console.error('[Forecast] getIssue failed', err)
  });
}


  onWarehouseChange(id: WarehouseId): void {
    this.form.patchValue({ warehouse: id }, { emitEvent: true });
  }

  onProfileToggle(profile: string, checked: boolean): void {
    const current = this.form.value.profiles || {};
    const next = { ...current, [profile]: checked };
    this.form.patchValue({ profiles: next });
  }

  onReloadOrder(_uid: string) {
    if (this.lastSelection) {
      this.loadIssuesForSelection(this.lastSelection.weekIndex, this.lastSelection.productId);
    }
  }

  // ---------- Issues loader ----------
  private loadIssuesForSelection(weekIndex: number, productId: string, openDialog = false): void {
  const wh = (this.form.value.warehouse as 'warehouse-01' | 'warehouse-02') ?? 'warehouse-01';
  const week = this.weeks()[weekIndex];
  if (!week) {
    console.warn('[Forecast] week not found for index', weekIndex);
    return;
  }

  this.lastSelection = { weekIndex, productId };
  console.log('[Forecast] loadIssuesForSelection()', { wh, productId, week: week.label });

  // 1) Fetch all issues (server ignores filters)
  this.kpiApi.getAllIssues('LaborDeficit', []).subscribe({
    next: (issues) => {
      const total = issues?.length ?? 0;
      console.log('[Forecast] issues loaded', { count: total });

      // 2) Client-filter the exact issue
      const impactedId = `${wh}${productId}`;
      const matches = (issues || []).filter(iss =>
        iss.impactedObjectId === impactedId &&
        (iss.triggerObjectId?.toLowerCase?.() === 'understaffing')
      );

      console.log('[Forecast] client matches', { impactedId, matches: matches.length });

      // Prefer highest severity, then most recent
      matches.sort((a, b) =>
        (b.severity ?? 0) - (a.severity ?? 0) ||
        new Date(b.lastUpdatedTime).getTime() - new Date(a.lastUpdatedTime).getTime()
      );

      const candidate = matches[0];
      if (!candidate) {
        console.warn('[Forecast] no matching issue found', {
          expectedImpactedObjectId: impactedId,
          expectedTriggerObjectId: 'Understaffing'
        });
        return;
      }

      console.log('[Forecast] matched candidate (uid only, needs details)', { uid: candidate.uid });

      // 3) Fetch FULL details for the candidate by UID
      this.kpiApi.getIssue(candidate.uid).subscribe({
        next: (full) => {
          console.log('[Forecast] full issue loaded', full);
          
            // Inline fallback
          this.detailsOrder = { uid: `${wh}-${week.label}-${productId}` };
            this.detailsIssues = [full];
          
        },
        error: (err) => {
          console.error('[Forecast] getIssue(uid) failed', { uid: candidate.uid, err });
        }
      });
    },
    error: (err) => {
      console.error('[Forecast] issues list load failed', err);
    }
  });
}

}
