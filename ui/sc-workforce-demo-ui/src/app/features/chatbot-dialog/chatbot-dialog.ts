import {
  Component,
  Inject,
  Input,
  OnInit,
  AfterViewChecked,
  ViewChild,
  ElementRef, inject
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ChatbotService } from '../../services/chatbot.service';
import { IChatbotMessage, AgentResponse, IChatSession } from '../../models/chatbot-message';
import { MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { TrainingDataManager } from '../training-data-manager/training-data-manager';
import { ChatHistoryService } from '../../services/chat-history.service';
import { ReactiveFormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatDialogModule } from '@angular/material/dialog';

@Component({
  selector: 'app-chatbot-dialog',
  templateUrl: './chatbot-dialog.html',
  styleUrls: ['./chatbot-dialog.css'],
  imports: [CommonModule,ReactiveFormsModule,   // needed for [formGroup]
    MatFormFieldModule,    // <mat-form-field>, matSuffix
    MatInputModule,        // matInput
    MatIconModule,         // <mat-icon>
    MatButtonModule,       // mat-button
    MatDialogModule  ],
})
export class ChatbotDialog implements OnInit, AfterViewChecked {
  @ViewChild('scrollSection') private myScrollContainer!: ElementRef;
  constructor(
    private dialog:MatDialog,
    private chatbotService: ChatbotService,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private chatHistoryService: ChatHistoryService,
  ) {}

  private fb = inject(FormBuilder);
  form = this.fb.group({
    message: [''],
      });

  messages: IChatbotMessage[] = [];

  messageId: number = 0;

  questionToTrain = "";
  sqlToTrain:any = "";

  currentIssueId: string = '';  // New var to store Issue Id
  ngOnInit(): void {
    this.issueId = this.data.issueId;    
    const newIssueId = this.data.issueId;
    if (this.currentIssueId && this.currentIssueId !== newIssueId) {
      this.chatHistoryService.clearMessages(this.currentIssueId);
    }
    this.currentIssueId = newIssueId;
    this.messages = this.chatHistoryService.getMessages(this.currentIssueId);

    // Create a new chat session when the issue's chatbot dialog is opened for the first time
    if (this.chatHistoryService.getSessionId(this.currentIssueId) === "") {
      this.chatbotService
      .createChatSession()
      .subscribe((session) => {
          this.chatHistoryService.setSessionId(this.currentIssueId, session.id)
          console.log(`Issue [${this.currentIssueId}] chat sesion id: ${session.id}`)
        }, (error) => {
          const responseMessage: IChatbotMessage = {
            id: this.chatHistoryService.getNextMessageId(this.currentIssueId),
            role: 'assistant',
            content: "Failed to create a new chat session.",
            additionalInfo: `[HTTP ${error["status"]}] ${error["statusText"]}: ${JSON.stringify(error["error"])}`
          };
          this.messages.push(responseMessage);
          this.chatHistoryService.setMessages(this.issueId, this.messages);
        })
    }
  }

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  issueId: string = '';
  loading: boolean = false;

  onSubmit() {
    if (this.chatHistoryService.getSessionId(this.issueId) === "") {
      console.log("No active chat session")

      const responseMessage: IChatbotMessage = {
        id: this.chatHistoryService.getNextMessageId(this.issueId),
        role: 'assistant',
        content: "Chat session has not been created yet."
      };
      this.messages.push(responseMessage);
      this.chatHistoryService.setMessages(this.issueId, this.messages);
      this.loading = false;
      return;
    }

    const message = this.form.value['message'] || "";
    this.loading = true;
    this.messages.push({id: this.chatHistoryService.getNextMessageId(this.issueId), role: 'user', content: message });
    this.chatHistoryService.setMessages(this.issueId, this.messages);
    this.form.reset();
    this.questionToTrain = this.sqlToTrain =  "";
    this.chatbotService
    .sendMessage(message, this.chatHistoryService.getSessionId(this.issueId), `SC_Data.Issue uid = ${this.issueId}`)
    .subscribe((response) => {
        let res = response.assistant_answer;
        let additionalInfo = '';

        switch (response.type) {
          case 'single':
            additionalInfo += `\n${this.parseAgentResponse(response.details)}`
            break;
          case 'compound':
            additionalInfo += `\n\nThe question was broken down to ${response.details.subtasks.length} subquestions.`;
            response.details.subtasks.forEach((agentResponse, index) => {
              additionalInfo += `\n\n[${index + 1}] ${agentResponse.subquestion}`;
              additionalInfo += `\n${this.parseAgentResponse(agentResponse)}`
            });
            break;
          case 'unknown':
            break
        }
      
        const responseMessage: IChatbotMessage = {
          id: this.chatHistoryService.getNextMessageId(this.issueId),
          role: 'assistant',
          content: res,
          additionalInfo: additionalInfo.length>0? additionalInfo:undefined,
          show: false,
        };
        this.messages.push(responseMessage);
        this.chatHistoryService.setMessages(this.issueId, this.messages);
        this.loading = false;
      }, (error) => {
        console.log(JSON.stringify(error))
        const responseMessage: IChatbotMessage = {
          id: this.chatHistoryService.getNextMessageId(this.issueId),
          role: 'assistant',
          content: `Something went wrong, please fix the error and try again!`,
          additionalInfo: `[HTTP ${error["status"]}] ${error["statusText"]}: ${JSON.stringify(error["error"])}`,
          show: false,
        };
        this.messages.push(responseMessage);
        this.chatHistoryService.setMessages(this.issueId, this.messages);
        this.loading = false;
      });
  }

  // Minimal response format implementation 
  parseAgentResponse(response: AgentResponse): string {
    let additionalInfo = "";
  
    for (const tool of response.tool_outputs) {
      if (tool["tool_name"] === "get_issue_analysis_logic") {
        additionalInfo += `\nBusiness Process: ${tool["business_process_name"]}\n`
      }

      if (tool["tool_name"] === "query_data") {
        additionalInfo += `\nData Query: ${tool["question"]}\n`;
        additionalInfo += `\nSQL:\n${tool["sql"]}`;
        additionalInfo += `\nSQL Explanation: ${tool["sql_summary"]}\n`;
        additionalInfo += `\nSQL Result: ${tool["data"]}\n`;
      } 
    } 

    return additionalInfo
  }

  scrollToBottom(): void {
    try {
      this.myScrollContainer.nativeElement.scrollTop =
        this.myScrollContainer.nativeElement.scrollHeight;
    } catch (err) {}
  }

  onClose() {
    this.messages = [];
  }

  toggleCollapse(id?:string){
    if(id){
      const result = this.messages.filter(obj => {
        if(obj.id && obj.id == id){
          obj.show = !obj.show;
        }
      })
    }
  }

  openTrainingDataDialog() {
    const dialogRef = this.dialog.open(TrainingDataManager, {
      width: '1000px',
      data: {}
    });
  }
}
