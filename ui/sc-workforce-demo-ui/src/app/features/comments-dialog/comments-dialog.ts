// src/app/features/comments-dialog/comments-dialog.ts
import { Component, Inject, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';

// Angular Material
import { MatDialogModule, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';


export interface ICommentsDialogData {
  headerText: string;
  bodyText: string;
  acceptButtonText: string;
}

@Component({
  selector: 'app-comments-dialog',
  templateUrl: './comments-dialog.html',
  styleUrls: ['./comments-dialog.css'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule,
    MatDividerModule
  ],
})
export class CommentsDialog implements OnInit {
  private fb = inject(FormBuilder);

  constructor(@Inject(MAT_DIALOG_DATA) public data: ICommentsDialogData) {}

  commentsForm = this.fb.group({
    comments: [''],
  });

  ngOnInit(): void {}

  // Optional: if you use (click)="acceptComments()" instead of [mat-dialog-close]
  acceptComments() {
    // You can close via MatDialogRef if you inject it, or rely on [mat-dialog-close] in the template
    // Example (if you inject MatDialogRef<CommentsDialogComponent> as 'ref'):
    // this.ref.close(this.commentsForm.value);
  }
}
