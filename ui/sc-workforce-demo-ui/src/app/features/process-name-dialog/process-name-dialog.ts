import { Component, Inject, OnInit, inject } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { MatDialogModule, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';



export interface IProcessNameDialogData { 
  processName: string;
}


@Component({
  selector: 'app-process-name-dialog',
  templateUrl: './process-name-dialog.html',
  styleUrls: ['./process-name-dialog.css'],

  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatDialogModule,
    MatIconModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
  ],
})

export class ProcessNameDialog implements OnInit {

  public dialogRef = inject(MatDialogRef<ProcessNameDialog>);
  public data = inject<IProcessNameDialogData>(MAT_DIALOG_DATA);
  private fb = inject(FormBuilder);
  
  processForm = this.fb.group({
    processName: [this.data.processName]
  });

  ngOnInit(): void {
  }

}
