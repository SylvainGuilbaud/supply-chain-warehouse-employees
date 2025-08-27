import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { IChatbotMessage, IChatbotResponse, IChatSession } from '../models/chatbot-message';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { IMemory } from '../models/memory';
import { response } from 'express';

@Injectable({
  providedIn: 'root'
})
export class ChatbotService {

  constructor(
    public httpClient: HttpClient,
  ) { }
  
  sendMessage(question:string, sessionId:string, additionalContext:string): Observable<IChatbotResponse> {
    const toSend = {"question": question, sessionId: sessionId, additionalContext: additionalContext}
    return this.httpClient.post(`${environment.apiRootUrl}/api/SC/scai/v1/chat`, toSend) as Observable<IChatbotResponse>;
  }

  createChatSession():Observable<IChatSession> {
    const user = "_system"
    const toSend = {"username": user}
    return this.httpClient.post(`${environment.apiRootUrl}/api/SC/scai/v1/sessions`, toSend) as Observable<IChatSession>;
  }

  createMemory(body:IMemory):Observable<IMemory> {
    return this.httpClient.post(`${environment.apiRootUrl}/api/SC/scai/v1/memories`, body) as Observable<IMemory>
  }

  getMemories(): Observable<IMemory[]> {
    const user = "_system"
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scai/v1/memories`) as Observable<IMemory[]>
  }

  deleteMemory(id:string): Observable<IChatbotResponse> {
    const user = "_system"
    return this.httpClient.delete(`${environment.apiRootUrl}/api/SC/scai/v1/memories/${id}`) as Observable<IChatbotResponse>
  }

}
