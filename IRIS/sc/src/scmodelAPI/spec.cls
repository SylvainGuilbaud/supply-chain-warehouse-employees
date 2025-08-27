/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class scmodelAPI.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

XData OpenAPI [ MimeType = application/json ]
{
{
    "swagger": "2.0",
    "info": {
        "version": "1.0",
        "title": "InterSystems IRIS Supply Chain Data Model API",
        "description": "API for InterSystems IRIS supply chain data model",
        "contact":{
            "email": "learning@intersystems.com",
            "url": "https://docs.intersystems.com"
        }
    },
    "host": "localhost:3000",
    "basePath": "/api/{$namespace}/scmodel/v1",
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
        "/objects/{objectName}": {
            "get": {
                "description": "Returns the definition of the specified data objects",
                "operationId": "GetObjectDefinitionByName",
                "x-ISC_RequiredResource":["SC_Data_Model_API:Read"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "objectName",
                        "type": "string",
                        "required": true,
                        "description": "object name"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Object definition",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ObjectDefinition"
                            }
                        }
                    }
                }
            }
        },
        "/objects": {
            "get": {
                "description": "Get the list of all objects defined in the system",
                "operationId": "GetObjects",
                "x-ISC_RequiredResource":["SC_Data_Model_API:Read"],
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
            },
            "post": {
                "description": "Create a new custom object and generate related data access APIs",
                "operationId": "CreateCustomObject",
                "x-ISC_RequiredResource":["SC_Data_Model_API:Write"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ObjectDefinition"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/attributes/{objectName}": {
            "post": {
                "description": "Add a custom attribute to an object",
                "operationId": "AddAttribute",
                "x-ISC_RequiredResource":["SC_Data_Model_API:Write"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "objectName",
                        "type": "string",
                        "required": true,
                        "description": "Object name"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PropertyDefinition"
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
        "/updatecustomapi": 
        {
            "post" :
            {
                "description" : "Generate/Update Custom API for User-defined object",
                "operationId" : "UpdateApiJSON",
                "x-ISC_RequiredResource":["SC_Data_Model_API:Write"],
                "produces":["application/json"],
                "parameters" :[],
                "responses" : {
                    "200": {
                        "description": "Success"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        }
    },
    "definitions": {
        "PropertyDefinition":{
            "type": "object",
            "required": [
                "name", "dataType"
            ],
            "properties":{
                "name": {
                    "type": "string"
                },
                "dataType": {
                    "type": "string",
                    "enum":["String","Integer","Boolean","Numeric", "DateTime","Date"]
                },
                "maxLength" :{
                    "type" : "number"
                },
                "required":{
                    "type" : "number",
                    "enum" :[0,1]
                },
                "description" :{
                    "type" : "string"
                }
            }
        },
        "ObjectDefinition": {
            "type": "object",
            "required": [
                "objectName", "attributes"
            ],
            "properties": {
                "objectName": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "attributes": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/PropertyDefinition"
                    }
                }
            }
        }
    },
    "securityDefinitions": {
        "BasicAuth": {
            "type": "basic"
        }
    },
    "security": [
        {
            "BasicAuth": []
        }
    ]
}
}

}
