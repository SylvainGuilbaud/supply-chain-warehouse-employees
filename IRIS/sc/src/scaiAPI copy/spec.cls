/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class scaiAPI.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger": "2.0",
  "info": {
    "version": "1.0",
    "title": "Supply Chain AI Assistant API",
    "description": "API for InterSystems Supply Chain AI Assistant",
    "contact":{
        "email": "learning@intersystems.com",
        "url": "https://docs.intersystems.com"
    }
  },
  "basePath": "/api/{$namespace}/scai/v1",
  "schemes": [
    "http"
  ],
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ],
  "paths": {
    "/chat": {
      "post": {
        "description": "Chat with Supply Chain AI Assistant",
        "operationId": "RunAIAssistant",
        "x-ISC_RequiredResource":["SC_AI_Assistant_API:Use"],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ChatRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "AI Assistant response",
            "schema": {
              "$ref": "#/definitions/AssistantResponse"
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/usermemories": {
      "post": {
        "description": "Create a memory",
        "operationId": "CreateMemory",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Personal_Memory_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Memory"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "get": {
        "description": "Get all personal and system memories",
        "operationId": "GetAllMemories",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Personal_Memory_API:Read"],
        "produces": [
          "application/json"
        ],
        "parameters":[],
        "responses": {
          "200": {
            "description": "Memories",
            "schema": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/Memory"
              }
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/memories": {
      "post": {
        "description": "Create a memory",
        "operationId": "CreateMemoryByAdmin",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Admin_Memory_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Memory"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "get": {
        "description": "Get all personal and system memories",
        "operationId": "GetAllMemoriesByAdmin",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Admin_Memory_API:Read"],
        "produces": [
          "application/json"
        ],
        "parameters":[],
        "responses": {
          "200": {
            "description": "Memories",
            "schema": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/Memory"
              }
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },

    "/usermemories/{id}": {
      "get": {
        "description": "Get a personal or system memory by ID",
        "operationId": "GetMemoryById",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Personal_Memory_API:Read"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Memory UID"
          }
        ],
        "responses": {
          "200": {
            "description": "Memory",
            "schema": {
              "$ref": "#/definitions/Memory"
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "put": {
        "description": "Update a personal or system memory by ID",
        "operationId": "UpdateMemory",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Personal_Memory_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Memory UID"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Memory"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "delete": {
        "description": "Delete a personal or system memory by ID",
        "operationId": "DeleteMemory",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Personal_Memory_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Memory UID"
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/memories/{id}": {
      "get": {
        "description": "Get a personal or system memory by ID",
        "operationId": "GetMemoryByIdByAdmin",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Admin_Memory_API:Read"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Memory UID"
          }
        ],
        "responses": {
          "200": {
            "description": "Memory",
            "schema": {
              "$ref": "#/definitions/Memory"
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "put": {
        "description": "Update a personal or system memory by ID",
        "operationId": "UpdateMemoryByAdmin",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Admin_Memory_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Memory UID"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Memory"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "delete": {
        "description": "Delete a personal or system memory by ID",
        "operationId": "DeleteMemoryByAdmin",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Admin_Memory_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters":[
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Memory UID"
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/credentials": {
      "post": {
        "description": "Add new GenAI API credentials",
        "operationId": "CreateCredentials",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Credentials_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Credentials"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/credentials/{id}": {
      "put": {
        "description": "Update credentials by id",
        "operationId": "UpdateCredentials",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Credentials_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Credentials"
            }
          },
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Credentials ID"
          }
        ],
        "responses": {
          "200": {
            "description": "Credentials",
            "schema": {
              "$ref": "#/definitions/Credentials"
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/sessions": {
      "post": {
        "description": "Create new chat session",
        "operationId": "CreateChatSession",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Sessions_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters": [],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/sessions/{id}": {
      "delete": {
        "description": "Delete chat session by id",
        "operationId": "DeleteChatSession",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Sessions_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "id",
            "type": "string",
            "required": true,
            "description": "Session ID"
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    },
    "/sessions/{sessionId}/messages": {
      "post": {
        "description": "Add messages to session",
        "operationId": "AddMessages",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Sessions_API:Write"],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "sessionId",
            "type": "string",
            "required": true,
            "description": "Session ID"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/ChatMessage"
              }
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          },
          "500": {
            "description": "Server error"
          }
        }
      },
      "get": {
        "description": "Get chat messages by session ID",
        "operationId": "GetMessagesBySessionId",
        "x-ISC_RequiredResource":["SC_AI_Assistant_Sessions_API:Read"],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "sessionId",
            "type": "string",
            "required": true,
            "description": "Session ID"
          }
        ],
        "responses": {
          "200": {
            "description": "Chat messages",
            "schema": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/ChatMessage"
              }
            }
          },
          "500": {
            "description": "Server error"
          }
        }
      }
    }
  },
  "definitions": {
    "ChatRequest": {
      "type": "object",
      "required": [
        "question",
        "sessionId"
      ],
      "properties": {
        "question": {
          "type": "string"
        },
        "sessionId": {
          "type": "string"
        },
        "additionalContext": {
          "type": "string"
        }
      }
    },
    "AssistantResponse": {
      "type": "object",
      "properties": {
        "assistant_answer": {
          "type": "string"
        },
        "type": {
          "type": "string",
          "enum": ["unknown", "compound", "data_access", "issue_analysis"]
        },
        "details": {
          "type": "object",
          "additionalProperties": true
        }
      }
    },
    "Memory": {
      "type": "object",
      "required": [
        "document",
        "metadata"
      ],
      "properties": {
        "id": {
          "type": "string"
        },
        "document": {
          "type": "string"
        }, 
        "username": {
          "type": "string"
        }, 
        "isSystem": {
          "type": "boolean"
        },
        "metadata" : {
          "type": "object",
          "additionalProperties": true
        }
      }
    },
    "Credentials": {
      "type": "object",
      "required": [
        "name",
        "apiKey",
        "apiEndpoint",
        "LLMDeployment",
        "embeddingModelDeployment"
      ],
      "properties": {
        "name": {
          "type": "string"
        },
        "apiKey": {
          "type": "string"
        },
        "apiEndpoint": {
          "type": "string"
        },
        "LLMDeployment": {
          "type": "string"
        },
        "embeddingModelDeployment": {
          "type": "string"
        }
      }
    },
    "Session": {
      "type": "object",
      "properties": {
        "username": {
          "type": "string"
        }
      }
    },
    "ChatMessage": {
      "type": "object",
      "required": [
        "content",
        "type"
      ],
      "properties": {
        "content": {
          "type": "string"
        },
        "type": {
          "type": "string"
        },
        "metadata": {
          "type": "string"
        },
        "additionalContext": {
          "type": "string"
        }
      }
    }
  }
}
}

}
