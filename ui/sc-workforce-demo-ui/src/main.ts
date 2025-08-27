// main.ts
import { MatIconModule } from '@angular/material/icon';
import { provideAppIcons } from './app/icons.provider';
import '@angular/localize/init';
import { Chart, registerables } from 'chart.js';  // ✅ Chart.js v3
Chart.register(...registerables);

import { bootstrapApplication } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { App } from './app/app';
import { routes } from './app/app.routes';

bootstrapApplication(App, {
  providers: [
    provideRouter(routes),
    provideHttpClient(),
    MatIconModule,          // ensures MatIconRegistry providers are present
    provideAppIcons()
  ],
}).catch(err => console.error(err));