import { ComponentFixture, TestBed } from '@angular/core/testing';

import { WorkloadDashboard } from './workload-dashboard';

describe('WorkloadDashboard', () => {
  let component: WorkloadDashboard;
  let fixture: ComponentFixture<WorkloadDashboard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [WorkloadDashboard]
    })
    .compileComponents();

    fixture = TestBed.createComponent(WorkloadDashboard);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
