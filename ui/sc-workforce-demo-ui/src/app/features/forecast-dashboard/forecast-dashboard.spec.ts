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
  private lastSelection: { weekIndex: number; productId: string } | null = null;

  // ---------- Services ----------
  private fb = inject(FormBuilder);
  private kpiApi = inject(KpiApiService);

  constructor(private api: ForecastApiService) {}

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
        return rec ? +rec.quantity : 0;
      });
      return { productId: pid, gaps };
    });
    this.tableRows = rows;

    this.tableTotal = this.weeks().map((_, i) =>
      +rows.reduce((acc, row) => acc + (row.gaps[i] || 0), 0).toFixed(2)
    );
  }

  // ---------- Interactions ----------
  onChartClick(event: ChartEvent | undefined, elements: any[] | undefined) {
    if (!elements?.length || !event) return;
    const weekIndex: number = (elements[0] as any).index;
    const gap = this.gapByWeek?.[weekIndex] ?? 0;
    if (gap < 0) this.loadIssuesForSelection(weekIndex, 'ALL');
    else { this.detailsOrder = undefined; this.detailsIssues = []; }
  }

  onCellClick(weekIndex: number, productId: string, value: number) {
    if (value >= 0) { this.detailsOrder = undefined; this.detailsIssues = []; return; }
    this.loadIssuesForSelection(weekIndex, productId);
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
  private loadIssuesForSelection(weekIndex: number, productId: string): void {
    const wh = (this.form.value.warehouse as WarehouseId) ?? 'warehouse-01';
    const week = this.weeks()[weekIndex];
    if (!week) return;

    const filters: { key: string; value: string }[] = [
      { key: 'locationId', value: wh },
    ];
    // If backend filters by week, add:
    // filters.push({ key: 'startDate', value: week.key });

    if (productId !== 'ALL') {
      // change 'laborProfile' -> 'productId' if your API expects that key
      filters.push({ key: 'laborProfile', value: productId });
    }

    this.lastSelection = { weekIndex, productId };

    // ✅ Correct impacted object type and base URL is now from environment
    this.kpiApi.getAllIssues('LaborDeficit', filters).subscribe({
      next: (issues) => {
        this.detailsOrder = { uid: `${wh}-${week.label}-${productId}` };
        this.detailsIssues = issues || [];
      },
      error: () => {
        this.detailsOrder = { uid: `${wh}-${week.label}-${productId}` };
        this.detailsIssues = [];
      }
    });
  }
}
