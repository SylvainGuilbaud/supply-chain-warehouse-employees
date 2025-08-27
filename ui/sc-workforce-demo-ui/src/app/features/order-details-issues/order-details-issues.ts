// src/app/features/order-details-issues/order-details-issues.ts
import { Component, Input, OnInit, Output, EventEmitter, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder } from '@angular/forms';

import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatRadioModule } from '@angular/material/radio';

import { CommentsDialog } from '../comments-dialog/comments-dialog';   // ✅ correct class
import { ProcessNameDialog } from '../process-name-dialog/process-name-dialog';

import { SeverityService, Severity, defaultBackgroundColor } from '../../services/severity.service';
import { IIssue } from '../../models/issue-result';
import { IKpiListingResult } from '../../models/kpi-listing-result';
import { KpiApiService } from '../../services/kpi-api.service';

import { ChatbotDialog } from '../chatbot-dialog/chatbot-dialog';
import { ChatbotService } from '../../services/chatbot.service';

type OrderRef = Pick<IKpiListingResult, 'uid'>;

@Component({
  selector: 'app-order-details-issues',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatExpansionModule,
    MatIconModule,
    MatButtonModule,
    MatRadioModule,
    MatDialogModule
  ],
  templateUrl: './order-details-issues.html',
  styleUrls: ['./order-details-issues.css']
})
export class OrderDetailsIssues implements OnInit {
  // ---- Inputs / Outputs ----
  private _order: OrderRef | undefined;
  @Input() get order(): OrderRef | undefined { return this._order; }
  set order(value: OrderRef | undefined) { this._order = value; }

  private _issues: IIssue[] = [];
  @Input() get issues(): IIssue[] { return this._issues || []; }
  set issues(value: IIssue[]) { this._issues = value; }

  @Output() reloadOrder = new EventEmitter<string>();

  // ---- Services / DI ----
  private fb = inject(FormBuilder);
  constructor(
    private dialog: MatDialog,
    private severityService: SeverityService,
    private kpiApiService: KpiApiService,
  ) {}

  // ---- Local state ----
  chatbotEnabled = true;

  recommendationForm = this.fb.group({
    selectedOption: ['']
  });

  // ---- Derived counts ----
  get highCount() { return this.issues.filter(x => x.severity === 3).length; }
  get medCount()  { return this.issues.filter(x => x.severity === 2).length; }
  get lowCount()  { return this.issues.filter(x => x.severity === 1).length; }

  get Severity() { return Severity; }

  ngOnInit(): void {}

  // ---- UI helpers ----
  getAnalysisDate(issue: IIssue): string {
    if (!issue.closeTime) return new Date(issue.lastUpdatedTime!).toLocaleString();
    return '';
  }
  getClosedTime(issue: IIssue) {
    return new Date(issue.lastUpdatedTime!).toLocaleString();
  }

  severityLevel() {
    return this.severityService.getSeverityLevelForIssues(this.issues);
  }
  getForecolorForSeverity() {
    const rslt = this.severityService.getSeverityForegroundColor(this.severityLevel());
    return rslt !== defaultBackgroundColor ? rslt : '#FFF';
  }
  getBackcolorForSeverity() {
    const rslt = this.severityService.getSeverityBackgroundColor(this.severityLevel());
    return rslt !== defaultBackgroundColor ? rslt : '#919191';
  }

  // ---- Actions ----
  acceptScenario(issue: IIssue) {
    const dialogRef = this.dialog.open(CommentsDialog, {
      width: '600px',
      height: '325px',
      panelClass: 'comments-dialog-container',
      data: {
        headerText: 'Confirm Accept and Add Comments',
        bodyText: 'Please provide a reason for your selection.',
        acceptButtonText: 'Save & Accept',
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result?.comments && issue.uid && this.recommendationForm.value.selectedOption) {
        this.kpiApiService
          .completeWorkflowIssue(issue.uid, this.recommendationForm.value.selectedOption, result.comments)
          .subscribe(() => this.reloadOrder.emit(this.order?.uid || ''));
      }
    });
  }

  closeIssue(issue: IIssue) {
    const dialogRef = this.dialog.open(CommentsDialog, {
      width: '600px',
      height: '325px',
      panelClass: 'comments-dialog-container',
      data: {
        headerText: 'Confirm Close and Add Comments',
        bodyText: 'Please provide a reason for closing.',
        acceptButtonText: 'Save & Close',
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result?.comments && issue.uid) {
        this.kpiApiService
          .closeIssue(issue.uid, result.comments)
          .subscribe(() => this.reloadOrder.emit(this.order?.uid || ''));
      }
    });
  }

  updateAnalysis(issue: IIssue) {
    if (!issue) return;
    const dialogRef = this.dialog.open(ProcessNameDialog, {
      width: '300px',
      height: '220px',
      panelClass: 'process-name-dialog-container',
      data: { processName: issue.processName || '' }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result?.processName && issue.uid) {
        this.kpiApiService.updateAnalysis(issue.uid, result.processName).subscribe(() => {
          this.reloadOrder.emit(this.order?.uid || '');
        });
        issue.lastUpdatedTime = new Date().toString();
      }
    });
  }

   openDialog(issueId:string) {
     const dialogRef = this.dialog.open(ChatbotDialog, {
       width: '1000px',
       data: {issueId: issueId}
     });

     dialogRef.afterClosed().subscribe(result => {
       console.log('The dialog was closed');
     });
   }
}
