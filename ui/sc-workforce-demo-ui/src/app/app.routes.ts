import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'sales' },

  {
    path: 'sales',
    loadComponent: () =>
      import('./features/sales-dashboard/sales-dashboard')
        .then(m => m.SalesDashboard),
    data: { title: 'Sales Dashboard' }
  },
  {
    path: 'workload',
    loadComponent: () =>
      import('./features/workload-dashboard/workload-dashboard')
        .then(m => m.WorkloadDashboard),
    data: { title: 'Workload Dashboard' }
  },
  {
    path: 'forecast',
    loadComponent: () =>
      import('./features/forecast-dashboard/forecast-dashboard')
        .then(m => m.ForecastDashboard),
    data: { title: 'Forecast Dashboard' }
  },
  {
    path: 'settings',
    loadComponent: () =>
      import('./features/settings-panel/settings-panel')
        .then(m => m.SettingsPanel),
    data: { title: 'Settings' }
  },

  { path: '**', redirectTo: 'sales' }
];
