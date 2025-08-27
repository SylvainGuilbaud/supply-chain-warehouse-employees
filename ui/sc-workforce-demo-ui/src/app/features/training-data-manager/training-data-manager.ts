import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ChatbotService } from '../../services/chatbot.service';
import { IMemory } from '../../models/memory';
import { FormBuilder } from '@angular/forms';
import { MatTableModule } from '@angular/material/table';
import { ReactiveFormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatDialogModule } from '@angular/material/dialog';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';

@Component({
  selector: 'app-training-data-manager',
  templateUrl: './training-data-manager.html',
  styleUrls: ['./training-data-manager.css'],
  imports: [CommonModule,
    MatTableModule,
    ReactiveFormsModule,   // needed for [formGroup]
    MatFormFieldModule,    // <mat-form-field>, matSuffix
    MatInputModule,        // matInput
    MatIconModule,         // <mat-icon>
    MatButtonModule,       // mat-button
    MatDialogModule 
  ],
})
export class TrainingDataManager implements OnInit {

  constructor(
    private chatbotService:ChatbotService,
  ) { }

  private fb = inject(FormBuilder);
  form = this.fb.group({
    content: [''],
      });


  memories:IMemory[] = [];

  displayedColumns = ['id', 'isSystem',  'content'];
  displayedColumns2 = ['id', 'isSystem', 'content', 'delete'];


  ngOnInit(): void {
    this.chatbotService.getMemories().subscribe(data => {
      this.memories = data
      console.log(data)
    })
  }

  refresh(): void {
    this.chatbotService.getMemories().subscribe(data => {
      this.memories = data
    })
  }

  onClose() {
  }

  add() {
    console.log(this.form.value)
    var form:IMemory = {
      document:this.form.value['content']!,
      metadata:{}
    };
    this.chatbotService.createMemory(form).subscribe(st =>
      {
        console.log(st)
        this.refresh()
        this.form.reset()
      }
    )
  }

  remove(id:string) {
    this.chatbotService.deleteMemory(id).subscribe(st =>
      {
        console.log(st)
        this.refresh()
      }
    )
    
  }

}
