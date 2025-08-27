/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API for InterSystems Supply Chain AI Assistant<br/>
/// Business logic class defined by OpenAPI in scaiAPI.spec<br/>
/// Updated Août 21, 2025 12:16:49
Class scaiAPI.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Chat with Supply Chain AI Assistant<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod RunAIAssistant(body As %DynamicObject) As %DynamicObject [ Requires = "SC_AI_Assistant_API:Use" ]
{
    return ##class(AI.API.IssueChatbotAPIImpl).RunAIAssistantWrapper(body)
}

/// Create a memory<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateMemory(body As %DynamicObject) As %DynamicObject [ Requires = "SC_AI_Assistant_Personal_Memory_API:Write" ]
{
    return ##class(AI.API.MemoryAPIImpl).CreateMemoryWrapper(body)
}

/// Get all personal and system memories
ClassMethod GetAllMemories() As %DynamicObject [ Requires = "SC_AI_Assistant_Personal_Memory_API:Read" ]
{
    return ##class(AI.API.MemoryAPIImpl).GetAllMemoriesWrapper()
}

/// Get a personal or system memory by ID<br/>
/// The method arguments hold values for:<br/>
///     id, Memory UID<br/>
ClassMethod GetMemoryById(id As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Personal_Memory_API:Read" ]
{
    return ##class(AI.API.MemoryAPIImpl).GetMemoryByIdWrapper(id)
}

/// Update a personal or system memory by ID<br/>
/// The method arguments hold values for:<br/>
///     id, Memory UID<br/>
///     body<br/>
ClassMethod UpdateMemory(id As %String, body As %DynamicObject) As %DynamicObject [ Requires = "SC_AI_Assistant_Personal_Memory_API:Write" ]
{
    return ##class(AI.API.MemoryAPIImpl).UpdateMemoryWrapper(id, body)
}

/// Delete a personal or system memory by ID<br/>
/// The method arguments hold values for:<br/>
///     id, Memory UID<br/>
ClassMethod DeleteMemory(id As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Personal_Memory_API:Write" ]
{
    return ##class(AI.API.MemoryAPIImpl).DeleteMemoryWrapper(id)
}

/// Create a memory<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateMemoryByAdmin(body As %DynamicObject) As %DynamicObject [ Requires = "SC_AI_Assistant_Admin_Memory_API:Write" ]
{
    return ##class(AI.API.MemoryAPIImpl).CreateMemoryByAdminWrapper(body)
}

/// Get all personal and system memories
ClassMethod GetAllMemoriesByAdmin() As %DynamicObject [ Requires = "SC_AI_Assistant_Admin_Memory_API:Read" ]
{
    return ##class(AI.API.MemoryAPIImpl).GetAllMemoriesByAdminWrapper()
}

/// Get a personal or system memory by ID<br/>
/// The method arguments hold values for:<br/>
///     id, Memory UID<br/>
ClassMethod GetMemoryByIdByAdmin(id As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Admin_Memory_API:Read" ]
{
    return ##class(AI.API.MemoryAPIImpl).GetMemoryByIdByAdminWrapper(id)
}

/// Update a personal or system memory by ID<br/>
/// The method arguments hold values for:<br/>
///     id, Memory UID<br/>
///     body<br/>
ClassMethod UpdateMemoryByAdmin(id As %String, body As %DynamicObject) As %DynamicObject [ Requires = "SC_AI_Assistant_Admin_Memory_API:Write" ]
{
    return ##class(AI.API.MemoryAPIImpl).UpdateMemoryByAdminWrapper(id, body)
}

/// Delete a personal or system memory by ID<br/>
/// The method arguments hold values for:<br/>
///     id, Memory UID<br/>
ClassMethod DeleteMemoryByAdmin(id As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Admin_Memory_API:Write" ]
{
    return ##class(AI.API.MemoryAPIImpl).DeleteMemoryByAdminWrapper(id)
}

/// Add new GenAI API credentials<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateCredentials(body As %DynamicObject) As %DynamicObject [ Requires = "SC_AI_Assistant_Credentials_API:Write" ]
{
    return ##class(AI.API.CredentialsAPIImpl).CreateCredentials(body)
}

/// Update credentials by id<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
///     id, Credentials ID<br/>
ClassMethod UpdateCredentials(body As %DynamicObject, id As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Credentials_API:Write" ]
{
    return ##class(AI.API.CredentialsAPIImpl).UpdateCredentials(id, body)
}

/// Create new chat session
ClassMethod CreateChatSession() As %DynamicObject [ Requires = "SC_AI_Assistant_Sessions_API:Write" ]
{
    return ##class(AI.API.ChatHistoryAPIImpl).CreateChatSession()
}

/// Delete chat session by id<br/>
/// The method arguments hold values for:<br/>
///     id, Session ID<br/>
ClassMethod DeleteChatSession(id As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Sessions_API:Write" ]
{
    return ##class(AI.API.ChatHistoryAPIImpl).DeleteChatSession(id)
}

/// Add messages to session<br/>
/// The method arguments hold values for:<br/>
///     sessionId, Session ID<br/>
///     body<br/>
ClassMethod AddMessages(sessionId As %String, body As %DynamicArray) As %DynamicObject [ Requires = "SC_AI_Assistant_Sessions_API:Write" ]
{
    return ##class(AI.API.ChatHistoryAPIImpl).AddMessages(sessionId, body)
}

/// Get chat messages by session ID<br/>
/// The method arguments hold values for:<br/>
///     sessionId, Session ID<br/>
ClassMethod GetMessagesBySessionId(sessionId As %String) As %DynamicObject [ Requires = "SC_AI_Assistant_Sessions_API:Read" ]
{
    return ##class(AI.API.ChatHistoryAPIImpl).GetMessagesBySessionId(sessionId)
}

}
