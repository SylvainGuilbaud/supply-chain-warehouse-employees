import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SettingsApiService, EmpKey, StaffResponse } from '../../services/settings-api.service';


type SaveState = 'idle' | 'saving' | 'saved' | 'error';

interface WarehouseVM {
  id: number;
  name: string;
  staff: Record<EmpKey, number>;
  loading: boolean;
  saveState: Record<EmpKey, SaveState>;
}

@Component({
  selector: 'app-settings-panel',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './settings-panel.html',
  styleUrls: ['./settings-panel.scss']
})
export class SettingsPanel implements OnInit {
  // inside the class:
  showInfo = signal(false);
  toggleInfo(): void { this.showInfo.set(!this.showInfo()); }
  // Employee types and labels for the UI
  readonly empTypes: { key: EmpKey; label: string }[] = [
    { key: 'general',  label: 'General warehouse management' },
    { key: 'quality',  label: 'Quality control' },
    { key: 'forklift', label: 'Forklift operator' },
  ];

  // View model for the two warehouses
  warehouses: WarehouseVM[] = [
    { id: 1, name: 'Warehouse 1', staff: { general: 0, quality: 0, forklift: 0 }, loading: true,
      saveState: { general: 'idle', quality: 'idle', forklift: 'idle' } },
    { id: 2, name: 'Warehouse 2', staff: { general: 0, quality: 0, forklift: 0 }, loading: true,
      saveState: { general: 'idle', quality: 'idle', forklift: 'idle' } },
  ];

  // Simulation run status
  simRunning = signal(false);
  simResult = signal<'idle' | 'ok' | 'error'>('idle');

  constructor(private api: SettingsApiService) {}

  ngOnInit(): void {
    // Load initial staff counts for both warehouses
    this.warehouses.forEach(w => {
      this.api.getWarehouseStaff(w.id).subscribe({
        next: (res: StaffResponse) => {
          w.staff = { general: res.general, quality: res.quality, forklift: res.forklift };
          w.loading = false;
        },
        error: () => {
          // keep zeros; mark not loading
          w.loading = false;
        }
      });
    });
  }

  runSimulation(): void {
    if (this.simRunning()) return;
    this.simRunning.set(true);
    this.simResult.set('idle');

    this.api.runSimulation().subscribe({
      next: (resp) => {
        this.simRunning.set(false);
        this.simResult.set(resp.status === 200 ? 'ok' : 'error');
      },
      error: () => {
        this.simRunning.set(false);
        this.simResult.set('error');
      }
    });
  }

  // Update local value while sliding (no network yet)
  onSlide(w: WarehouseVM, key: EmpKey, value: number) {
    w.staff[key] = value;
  }

  // Commit to API when slider released
  onCommit(w: WarehouseVM, key: EmpKey, value: number) {
    w.saveState[key] = 'saving';
    this.api.updateWarehouseStaff(w.id, key, value).subscribe({
      next: (resp) => {
        w.saveState[key] = resp.status === 200 ? 'saved' : 'error';
        // after a short delay, go back to idle to clear the badge
        setTimeout(() => (w.saveState[key] = 'idle'), 1200);
      },
      error: () => {
        w.saveState[key] = 'error';
      }
    });
  }
}
