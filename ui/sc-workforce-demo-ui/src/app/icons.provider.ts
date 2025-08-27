import { EnvironmentProviders, makeEnvironmentProviders } from '@angular/core';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';

export function provideAppIcons(): EnvironmentProviders {
  return makeEnvironmentProviders([{
    provide: 'APP_ICON_REGISTER',
    useFactory: (registry: MatIconRegistry, sanitizer: DomSanitizer) => {
      registry.addSvgIcon(
        'circle-check-solid',
        sanitizer.bypassSecurityTrustResourceUrl('assets/circle-check-solid.svg')
      );
      // add more here as needed
      return true;
    },
    deps: [MatIconRegistry, DomSanitizer]
  }]);
}
