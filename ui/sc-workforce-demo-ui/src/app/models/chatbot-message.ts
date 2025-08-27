export interface IChatbotMessage {
  role: string;
  content: string;
  additionalInfo?: string;
  id?: string;
  show?: boolean;
}
export interface AgentResponse {
  subquestion: string;
  agent_name: string;
  agent_output: { [key: string]: any };
  tool_outputs: { [key: string]: any }[];
}

interface UnknownResponse {
  assistant_answer: string;
  type: "unknown";
  details: {};
}

interface SingleAgentResponse {
  assistant_answer: string;
  type: "single";
  details: AgentResponse;
}

interface CompoundAgentResponse {
  assistant_answer: string;
  type: "compound";
  details: {
    "subtasks": AgentResponse[];
  };
}

export type IChatbotResponse =
  | UnknownResponse
  | SingleAgentResponse
  | CompoundAgentResponse;

export interface IChatSession {
  id: string;
  username: string;
}