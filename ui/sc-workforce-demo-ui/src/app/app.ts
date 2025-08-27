import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive, RouterOutlet, ActivatedRoute } from '@angular/router';
import { NgClass } from '@angular/common';
import { filter, map } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterLink, RouterLinkActive, NgClass],
  templateUrl: './app.html',
  styleUrls: ['./app.scss']
})
export class App {
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  // Observable page title based on current route's data.title
  title$ = this.router.events.pipe(
    filter((e: any) => e.constructor.name === 'NavigationEnd'),
    map(() => {
      let r = this.route;
      while (r.firstChild) r = r.firstChild;
      return r.snapshot.data?.['title'] ?? 'SC Demo';
    })
  );
}
