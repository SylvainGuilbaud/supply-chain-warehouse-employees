import { Injectable } from '@angular/core';
import { IChatbotMessage } from '../models/chatbot-message';


@Injectable({ providedIn: 'root' })
export class ChatHistoryService {
    private chatHistories: { [issueId: string]: IChatbotMessage[] } = {};
    private sessionIds: { [issueId: string]: string } = {};

    getSessionId(issueId: string): string {
        return this.sessionIds[issueId] || "";
    }

    setSessionId(issueId: string, sessionId: string) {
        this.sessionIds[issueId] = sessionId
    }

    getNextMessageId(issueId: string): string {
        return this.chatHistories[issueId]?.length.toString() ?? "0";
    }

    getMessages(issueId: string): IChatbotMessage[] {
        return this.chatHistories[issueId] || [];
    }

    setMessages(issueId: string, messages: IChatbotMessage[]): void {
        this.chatHistories[issueId] = messages;
    }

    clearMessages(issueId?: string): void {
        if (issueId) {
            delete this.chatHistories[issueId];
        } else {
            this.chatHistories = {};
        }
    }
}


