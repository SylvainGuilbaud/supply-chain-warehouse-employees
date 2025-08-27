/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class sccloudserviceAPI.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

XData OpenAPI [ MimeType = application/json ]
{
{
        "swagger": "2.0",
        "info": {
            "version": "1.0",
            "title": "IRIS Supply Chain cloud service API",
            "description": "API for InterSystems IRIS supply chain cloud services",
            "contact": {
                "name": "Anup Thakkar"
            }
        },
        "host": "localhost:3000",
        "basePath": "/api/{$namespace}/sccs/v1",
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
            "/registertrackandtrace": {
                "post": {
                    "description": "Registers track and trace service to IRIS for SC",
                    "operationId": "RegisterTrackAndTrace",
                    "x-ISC_RequiredResource": ["SC_Cloud_Service_API:WRITE"],
                    "produces": [
                        "application/json"
                    ],
                    "parameters": [
                        {
                            "in": "body",
                            "name": "body",
                            "required": true,
                            "schema": {
                                "$ref": "#/definitions/TrackAndTraceInformation"
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
            }
        },
        "definitions": {
            "TrackAndTraceInformation":{
                "type":"object",
                "required":[
                    "T&T_Macropoint_URL",
                    "IRIS_Key_Digest",
                    "T&T_Contact_Email",
                    "T&T_Version_Number",
                    "T&T_API_Username",
                    "T&T_API_Password"
                ],
                "properties":{
                    "IRIS_Key_Digest": {
                        "type": "string"
                    },
                    "T&T_Contact_Email": {
                        "type": "string"
                    },
                    "T&T_Macropoint_URL": {
                        "type": "string"
                    },
                    "T&T_Version_Number": {
                        "type": "string"
                    },
                    "T&T_API_Username": {
                        "type": "string"
                    },
                    "T&T_API_Password": {
                        "type": "string"
                    }
                }
            }
        }

    }
}

}
