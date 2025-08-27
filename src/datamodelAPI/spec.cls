/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class datamodelAPI.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

XData OpenAPI [ MimeType = application/json ]
{
{
    "swagger": "2.0",
    "info": {
        "version": "1.0",
        "title": "IRIS Supply Chain Data Model API",
        "description": "API for InterSystems IRIS supply chain data model",
        "contact": {
            "name": "Ming Zhou"
        }
    },
    "basePath": "/api/{$namespace}/scdata/v1",
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
        "/backend-version": {
            "get": {
                "description": "Returns the version of the backend.",
                "operationId": "GetBackendVersion",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "text/plain"
                ],
                "responses": {
                    "200": {
                        "description": "The version of the backend",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/objects/{objectName}": {
            "get": {
                "description": "Returns the definition of the specified data objects",
                "operationId": "GetObjectDefinitionByName",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
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
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
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
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
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
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/customers/{customerId}": {
            "get": {
                "description": "Returns details about a particular customer",
                "operationId": "GetCustomerById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Customer"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Customer not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one customer customer",
                "operationId": "UpdateCustomer",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New customer info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Customer"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Customer"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Customer not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one customer",
                "operationId": "SyncCustomer",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New customer info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Customer"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Customer"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Customer"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Customer not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }

            },
            "delete": {
                "description": "Delete existing Customer",
                "operationId": "DeleteCustomer",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Customer not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/customers": {
            "get": {
                "description": "Get all customers in the server, truncate after certain number\n",
                "operationId": "GetCustomers",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new customer",
                "operationId": "CreateCustomer",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Customer"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/locations/{locationId}": {
            "get": {
                "description": "Returns details about a particular location",
                "operationId": "GetLocationById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Location"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a Location by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Location"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Location not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one location",
                "operationId": "UpdateLocation",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the location"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New location info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Location"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Location"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Location not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one location",
                "operationId": "SyncLocation",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the location"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New location info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Location"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Location"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Location"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Location not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing location",
                "operationId": "DeleteLocation",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the location"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Location not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/locations": {
            "get": {
                "description": "Get all locations",
                "operationId": "GetLocations",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create a new location",
                "operationId": "CreateLocation",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Location"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesorders/{orderId}": {
            "get": {
                "description": "Returns details about a particular sales order",
                "operationId": "GetSalesOrderById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404":{
                        "description" : "Sales order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one sales order",
                "operationId": "UpdateSalesOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Sales order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                        
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one sales order",
                "operationId": "SyncSalesOrder",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Sales order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales order",
                "operationId": "DeleteSalesOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Sales order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/salesorders": {
            "get": {
                "description": "Get all sales orders, truncate after certain number\n",
                "operationId": "GetSalesOrders",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales order",
                "operationId": "CreateSalesOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesorderlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular sales order line",
                "operationId": "GetSalesOrderLineById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    },
                    "404":{
                        "description": "Sales order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one sales order line",
                "operationId": "UpdateSalesOrderLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales order line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Sales order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one sales order line",
                "operationId": "SyncSalesOrderLine",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales order line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Sales order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },

            "delete": {
                "description": "Delete existing sales order line",
                "operationId": "DeleteSalesOrderLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Sales order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/salesorderlines": {
            "get": {
                "description": "Get all sales order lines, truncate after certain number\n",
                "operationId": "GetSalesOrderLines",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales order line",
                "operationId": "CreateSalesOrderLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/products/{productId}": {
            "get": {
                "description": "Returns details about a particular product",
                "operationId": "GetProductById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product by ID",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one product",
                "operationId": "UpdateProduct",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one product",
                "operationId": "SyncProduct",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "201": {
                        "description": "Details about a product",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing product",
                "operationId": "DeleteProduct",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Product not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/products": {
            "get": {
                "description": "Get all products in the server, truncate after certain number\n",
                "operationId": "GetProducts",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Product"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new product",
                "operationId": "CreateProduct",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created product",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/carriers/{carrierId}": {
            "get": {
                "description": "Returns details about a particular carrier",
                "operationId": "GetCarrierById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a carrier by ID",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Carrier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one carrier",
                "operationId": "UpdateCarrier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New carrier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a carrier",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Carrier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one carrier",
                "operationId": "SyncCarrier",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New carrier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a carrier",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "201": {
                        "description": "Details about a carrier",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Carrier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing carrier",
                "operationId": "DeleteCarrier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Carrier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/carriers": {
            "get": {
                "description": "Get all carriers in the server, truncate after certain number\n",
                "operationId": "GetCarriers",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Carrier"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new carrier",
                "operationId": "CreateCarrier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created product",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/suppliers/{supplierId}": {
            "get": {
                "description": "Returns details about a particular supplier",
                "operationId": "GetSupplierById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supplier by ID",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Supplier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one supplier",
                "operationId": "UpdateSupplier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supplier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supplier",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Supplier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one supplier",
                "operationId": "SyncSupplier",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supplier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supplier",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "201": {
                        "description": "Details about a supplier",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Supplier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing supplier",
                "operationId": "DeleteSupplier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Supplier not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/suppliers": {
            "get": {
                "description": "Get all suppliers in the server, truncate after certain number\n",
                "operationId": "GetSuppliers",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Supplier"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new supplier",
                "operationId": "CreateSupplier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created supplier",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/billofmaterials/{bomId}": {
            "get": {
                "description": "Returns details about a particular bill of material",
                "operationId": "GetBOMById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a BOM by ID",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "BOM not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one BOM",
                "operationId": "UpdateBOM",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New BOM info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a BOM",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "BOM not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one BOM",
                "operationId": "SyncBOM",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New BOM info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a BOM",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "201": {
                        "description": "Details about a BOM",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "BOM not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing BOM",
                "operationId": "DeleteBOM",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "BOM not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/billofmaterials": {
            "get": {
                "description": "Get all BOMs in the server, truncate after certain number\n",
                "operationId": "GetBOMs",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/BOM"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new BOM",
                "operationId": "CreateBOM",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created supplier",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/demandplans/{planId}": {
            "get": {
                "description": "Returns details about a particular demand plan",
                "operationId": "GetDemandPlanById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a demand plann by ID",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Demand plan not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one demand plan",
                "operationId": "UpdateDemandPlan",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New demand plan info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a demand plan",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one demand plan",
                "operationId": "SyncDemandPlan",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New demand plan info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a demand plan",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "201": {
                        "description": "Details about a demand plan",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing demand plan",
                "operationId": "DeleteDemandPlan",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/demandplans": {
            "get": {
                "description": "Get all demand plans in the server, truncate after certain number\n",
                "operationId": "GetDemandPlans",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/DemandPlan"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new demand plan",
                "operationId": "CreateDemandPlan",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/scexceptions/{exceptionId}": {
            "get": {
                "description": "Returns details about a particular exception",
                "operationId": "GetExceptionById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a exception by ID",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one exception",
                "operationId": "UpdateException",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New exception info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a exception",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one exception",
                "operationId": "SyncException",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New exception info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a exception",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "201": {
                        "description": "Details about a exception",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing exception",
                "operationId": "DeleteException",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        } 
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/scexceptions": {
            "get": {
                "description": "Get all exceptions in the server, truncate after certain number\n",
                "operationId": "GetExceptions",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Exception"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new exception",
                "operationId": "CreateException",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/inventorythresholds/{inventoryThresholdId}": {
            "get": {
                "description": "Returns details about a particular inventory threshold",
                "operationId": "GetInventoryThresholdById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a inventory threshold by ID",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one inventory threshold",
                "operationId": "UpdateInventoryThreshold",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New inventory threshold info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a inventory threshold",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one inventory threshold",
                "operationId": "SyncInventoryThreshold",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New inventory threshold info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a inventory threshold",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "201": {
                        "description": "Details about a inventory threshold",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing inventory threshold",
                "operationId": "DeleteInventoryThreshold",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/inventorythresholds": {
            "get": {
                "description": "Get all inventory thresholds in the server, truncate after certain number\n",
                "operationId": "GetInventoryThresholds",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/InventoryThreshold"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new inventory threshold",
                "operationId": "CreateInventoryThreshold",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/manufacturingorders/{orderId}": {
            "get": {
                "description": "Returns details about a particular mfg order",
                "operationId": "GetMfgOrderById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a mfg order by ID",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one mfg order",
                "operationId": "UpdateMfgOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New mfg order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a mfg order",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one mfg order",
                "operationId": "SyncMfgOrder",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New mfg order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a mfg order",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "201": {
                        "description": "Details about a mfg order",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing mfg order",
                "operationId": "DeleteMfgOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/manufacturingorders": {
            "get": {
                "description": "Get all mfg orders in the server, truncate after certain number\n",
                "operationId": "GetMfgOrders",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/MfgOrder"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new mfg order",
                "operationId": "CreateMfgOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/leadtimevariants/{leadtimeVariantId}": {
            "get": {
                "description": "Returns details about a particular leadtime variant",
                "operationId": "GetLeadtimeVariantById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a leadtime variant by ID",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one leadtime variant",
                "operationId": "UpdateLeadtimeVariant",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New leadtime variant info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a leadtime variant",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one leadtime variant",
                "operationId": "SyncLeadtimeVariant",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New leadtime variant info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a leadtime variant",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "201": {
                        "description": "Details about a leadtime variant",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing leadtime variant",
                "operationId": "DeleteLeadtimeVariant",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/leadtimevariants": {
            "get": {
                "description": "Get all leadtime variants in the server, truncate after certain number\n",
                "operationId": "GetLeadtimeVariants",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/LeadtimeVariant"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new leadtime variant",
                "operationId": "CreateLeadtimeVariant",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/milestones/{milestoneId}": {
            "get": {
                "description": "Returns details about a particular milestone",
                "operationId": "GetMilestoneById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a milestone by ID",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one milestone",
                "operationId": "UpdateMilestone",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New milestone info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a milestone",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one milestone",
                "operationId": "SyncMilestone",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New milestone info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a milestone",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "201": {
                        "description": "Details about a milestone",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing milestone",
                "operationId": "DeleteMilestone",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/milestones": {
            "get": {
                "description": "Get all milestones in the server, truncate after certain number\n",
                "operationId": "GetMilestones",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Milestone"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new milestone",
                "operationId": "CreateMilestone",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productsuppliers/{prodSuplId}": {
            "get": {
                "description": "Returns details about a particular product supplier",
                "operationId": "GetProductSupplierById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product supplier by ID",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one product supplier",
                "operationId": "UpdateProductSupplier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product supplier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product supplier",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one product supplier",
                "operationId": "SyncProductSupplier",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product supplier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product supplier",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "201": {
                        "description": "Details about a product supplier",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing product supplier",
                "operationId": "DeleteProductSupplier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productsuppliers": {
            "get": {
                "description": "Get all product suppliers in the server, truncate after certain number\n",
                "operationId": "GetProductSuppliers",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ProductSupplier"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new product supplier",
                "operationId": "CreateProductSupplier",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/slas/{slaId}": {
            "get": {
                "description": "Returns details about a particular SLA",
                "operationId": "GetSLAById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a SLA by ID",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one SLA",
                "operationId": "UpdateSLA",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New SLA info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a SLA",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one SLA",
                "operationId": "SyncSLA",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New SLA info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a SLA",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "201": {
                        "description": "Details about a SLA",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing SLA",
                "operationId": "DeleteSLA",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/slas": {
            "get": {
                "description": "Get all SLAs in the server, truncate after certain number\n",
                "operationId": "GetSLAs",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SLA"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new SLA",
                "operationId": "CreateSLA",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyplans/{planId}": {
            "get": {
                "description": "Returns details about a particular supply plan",
                "operationId": "GetSupplyPlanById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply plann by ID",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Demand plan not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one supply plan",
                "operationId": "UpdateSupplyPlan",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply plan info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply plan",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one supply plan",
                "operationId": "SyncSupplyPlan",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply plan info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply plan",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "201": {
                        "description": "Details about a supply plan",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing supply plan",
                "operationId": "DeleteSupplyPlan",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyplans": {
            "get": {
                "description": "Get all supply plans in the server, truncate after certain number\n",
                "operationId": "GetSupplyPlans",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyPlan"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new supply plan",
                "operationId": "CreateSupplyPlan",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productinventories/{inventoryId}": {
            "get": {
                "description": "Returns details about a particular product inventory",
                "operationId": "GetProductInventoryById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product inventory by ID",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product inventory not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one product inventory",
                "operationId": "UpdateProductInventory",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product inventory info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product inventory",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product inventory not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one product inventory",
                "operationId": "SyncProductInventory",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product inventory info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product inventory",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "201": {
                        "description": "Details about a product inventory",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product inventory not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing product inventory",
                "operationId": "DeleteProductInventory",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "product inventory not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productinventories": {
            "get": {
                "description": "Get all product inventories in the server, truncate after certain number\n",
                "operationId": "GetProductInventories",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ProductInventory"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new product inventory",
                "operationId": "CreateProductInventory",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created product inventory",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/purchaseorders/{orderId}": {
            "get": {
                "description": "Returns details about a particular purchase order",
                "operationId": "GetPurchaseOrderById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404":{
                        "description": "purchase order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one purchase order",
                "operationId": "UpdatePurchaseOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New purchase order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "purchase order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one purchase order",
                "operationId": "SyncPurchaseOrder",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New purchase order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "purchase order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing purchase order",
                "operationId": "DeletePurchaseOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "purchase order not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/purchaseorders": {
            "get": {
                "description": "Get all purchase orders, truncate after certain number\n",
                "operationId": "GetPurchaseOrders",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an purchase order",
                "operationId": "CreatePurchaseOrder",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/purchaseorderlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular purchase order line",
                "operationId": "GetPurchaseOrderLineById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one purchase order line",
                "operationId": "UpdatePurchaseOrderLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New purchase order line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "purchase order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one purchase order line",
                "operationId": "SyncPurchaseOrderLine",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New purchase order line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "purchase order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing purchase order line",
                "operationId": "DeletePurchaseOrderLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "purchase order line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/purchaseorderlines": {
            "get": {
                "description": "Get all purchase order lines, truncate after certain number\n",
                "operationId": "GetPurchaseOrderLines",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an purchase order line",
                "operationId": "CreatePurchaseOrderLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesshipments/{shipmentId}": {
            "get": {
                "description": "Returns details about a particular sales shipment",
                "operationId": "GetSalesShipmentById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one sales shipment",
                "operationId": "UpdateSalesShipment",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales shipment info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one sales shipment",
                "operationId": "SyncSalesShipment",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales shipment info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales shipment",
                "operationId": "DeleteSalesShipment",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/salesshipments": {
            "get": {
                "description": "Get all sales shipments, truncate after certain number\n",
                "operationId": "GetSalesShipments",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales shipment",
                "operationId": "CreateSalesShipment",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesshipmentlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular sales shipment line",
                "operationId": "GetSalesShipmentLineById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one sales shipment line",
                "operationId": "UpdateSalesShipmentLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales shipment line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment lie not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one sales shipment line",
                "operationId": "SyncSalesShipmentLine",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales shipment line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment lie not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales shipment line",
                "operationId": "DeleteSalesShipmentLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "sales shipment line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/salesshipmentlines": {
            "get": {
                "description": "Get all sales shipment lines, truncate after certain number\n",
                "operationId": "GetSalesShipmentLines",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales shipment line",
                "operationId": "CreateSalesShipmentLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyshipments/{shipmentId}": {
            "get": {
                "description": "Returns details about a particular supply shipment",
                "operationId": "GetSupplyShipmentById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one supply shipment",
                "operationId": "UpdateSupplyShipment",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply shipment info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one supply shipment",
                "operationId": "SyncSupplyShipment",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply shipment info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing supply shipment",
                "operationId": "DeleteSupplyShipment",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/supplyshipments": {
            "get": {
                "description": "Get all supply shipments, truncate after certain number\n",
                "operationId": "GetSupplyShipments",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an supply shipment",
                "operationId": "CreateSupplyShipment",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyshipmentlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular supply shipment line",
                "operationId": "GetSupplyShipmentLineById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404":{
                        "description": "supply shipment lie not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one supply shipment line",
                "operationId": "UpdateSupplyShipmentLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply shipment line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment lie not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one supply shipment line",
                "operationId": "SyncSupplyShipmentLine",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply shipment line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment lie not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing supply shipment line",
                "operationId": "DeleteSupplyShipmentLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "supply shipment line not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/supplyshipmentlines": {
            "get": {
                "description": "Get all supply shipment lines, truncate after certain number\n",
                "operationId": "GetSupplyShipmentLines",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an supply shipment line",
                "operationId": "CreateSupplyShipmentLine",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productioncapacities/{productionCapacityId}": {
            "get": {
                "description": "Returns details about a particular production capacity",
                "operationId": "GetProductionCapacityById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one production capacity",
                "operationId": "UpdateProductionCapacity",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New production capacity info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the new production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one production capacity",
                "operationId": "SyncProductionCapacity",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New production capacity info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the new production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "201": {
                        "description": "Details of the new production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing production capacity",
                "operationId": "DeleteProductionCapacity",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productioncapacities": {
            "get": {
                "description": "Get all production capacity in the server, truncate after certain number\n",
                "operationId": "GetProductionCapacities",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ProductionCapacity"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new production capacity",
                "operationId": "CreateProductionCapacity",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/shippingcosts/{shippingCostId}": {
            "get": {
                "description": "Returns details about a particular shipping cost",
                "operationId": "GetShippingCostById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "patch": {
                "description": "Update one shipping cost",
                "operationId": "UpdateShippingCost",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipping cost info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the new shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one shipping cost",
                "operationId": "SyncShippingCost",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipping cost info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the new shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "201": {
                        "description": "Details of the new shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing shipping cost",
                "operationId": "DeleteShippingCost",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Record not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/shippingcosts": {
            "get": {
                "description": "Get all shipping cost in the server, truncate after certain number\n",
                "operationId": "GetShippingCosts",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShippingCost"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new shipping cost",
                "operationId": "CreateShippingCost",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/issues/{issueId}": {
            "get": {
                "description": "Returns a specific issue by ID",
                "operationId": "GetIssueById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "issue uid"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Issue details",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/issue"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404":{
                        "description": "Issue not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one issuer",
                "operationId": "UpdateIssue",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the issue"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New issue info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about an issue by ID",
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Issue not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one issuer",
                "operationId": "SyncIssue",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the issue"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New issue info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about an issue by ID",
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    },
                    "201": {
                        "description": "Details about an issue by ID",
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Issue not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing Customer",
                "operationId": "DeleteIssue",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the issue"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Issue not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/issues": {
            "get": {
                "description": "Get all issues in the system",
                "operationId": "GetIssues",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/issue"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create a new issue",
                "operationId": "CreateIssue",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/routelegs/{routeLegId}": {
            "get": {
                "description": "Returns a specific route leg by ID",
                "operationId": "GetRouteLegById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "Route leg uid"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Route leg details",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/routeLeg"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404":{
                        "description": "Route leg not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            },
            "patch": {
                "description": "Update one route leg",
                "operationId": "UpdateRouteLeg",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "Route leg uid"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New route leg info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the route leg",
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Route leg not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one route leg",
                "operationId": "SyncRouteLeg",
                "x-ISC_RequiredResource":["SC_Data_API:WRITE"],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "Route leg uid"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New route leg info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the route leg",
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    },
                    "201": {
                        "description": "Details of the route leg",
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Route leg not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing route leg",
                "operationId": "DeleteRouteLeg",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the route leg"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Route leg not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/routelegs": {
            "get": {
                "description": "Get all route legs in the system",
                "operationId": "GetRouteLegs",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/routeLeg"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create a route leg",
                "operationId": "CreateRouteLeg",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/predictedinventories": {
            "get": {
                "description": "Get all predicted inventory records\n",
                "operationId": "GetPredictedInventories",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PredictedInventory"
                            }
                        }
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/bulkupload/{uploadId}": {
            "get": {
                "description": "Get status of given upload",
                "operationId": "GetUploadStatus",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:USE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "uploadId",
                        "required": true,
                        "type": "string",
                        "description": "uploadId"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid uid error"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/bulkupload/contents/{uploadId}": {
            "get": {
                "description": "Get file contents of given upload",
                "operationId": "ReturnFile",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:USE"
                ],
                "produces": [
                    "text/csv"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "uploadId",
                        "required": true,
                        "type": "string",
                        "description": "uploadId"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid uid error"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/bulkupload/details/uploadIds": {
            "get": {
                "description": "Get list of upload ids",
                "operationId": "GetUploadIds",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:USE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid status error"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/bulkupload/error": {
            "post": {
                "description": "Return errors for a given upload",
                "operationId": "GetRowErrors",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:USE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/bulkUploadErrors"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid uid error"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/bulkupload": {
            "post": {
                "description": "Start a new bulk upload",
                "operationId": "UploadData",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:USE"
                ],
                "produces": [
                    "application/json"
                ],
                "consumes": [
                    "multipart/form-data"
                ],
                "parameters": [
                    {
                        "name": "file",
                        "in": "formData",
                        "description": "The uploaded file data",
                        "required": false,
                        "type": "file"
                    },
                    {
                        "in": "formData",
                        "name": "body",
                        "required": true,
                        "type": "string"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Bad request error"
                    },
                    "403": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/shipmentmilestones/{shipmentMilestoneId}": {
            "get": {
                "description": "Returns details about a particular shipment milestone",
                "operationId": "GetShipmentMilestoneById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentMilestoneId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Shipment Milestone"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a Shipment Milestone by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentMilestone"
                            }
                        }
                    },
                    "404":{
                        "description": "Shipment Milestone not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "patch": {
                "description": "Update one shipment milestone",
                "operationId": "UpdateShipmentMilestone",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentMilestoneId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment milestone"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipment milestone info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentMilestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipment milestone by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentMilestone"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Shipment Milestone not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one shipment milestone",
                "operationId": "SyncShipmentMilestone",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentMilestoneId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment milestone"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipment milestone info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentMilestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipment milestone by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentMilestone"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a shipment milestone by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentMilestone"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Shipment Milestone not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing shipment milestone",
                "operationId": "DeleteShipmentMilestone",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentMilestoneId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment milestone"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Shipment Milestone not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/shipmentmilestones": {
            "get": {
                "description": "Get all shipment milestone",
                "operationId": "GetShipmentMilestones",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
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
                "description": "Create a new shipmnt milestone",
                "operationId": "CreateShipmentMilestone",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentMilestone"
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
        "/shipmentstops/{shipmentStopId}": {
            "get": {
                "description": "Returns details about a particular shipment stop",
                "operationId": "GetShipmentStopById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentStopId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Shipment Stop"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a Shipment Stop by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentStop"
                            }
                        }
                    },
                    "404":{
                        "description": "Shipment Milestone not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "patch": {
                "description": "Update one shipment stop",
                "operationId": "UpdateShipmentStop",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentStopId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment stop"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipment stop info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentStop"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipment stop by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentStop"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Shipment stop not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one shipment stop",
                "operationId": "SyncShipmentStop",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentStopId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment stop"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipment stop info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentStop"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipment stop by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentStop"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a shipment stop by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentStop"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Shipment stop not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing shipment stop",
                "operationId": "DeleteShipmentStop",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentStopId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment stop"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Shipment Stop not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/shipmentstops": {
            "get": {
                "description": "Get all shipment stops",
                "operationId": "GetShipmentStops",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
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
                "description": "Create a new shipment stop",
                "operationId": "CreateShipmentStop",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentStop"
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
        "/shipmenttrackings/{shipmentTrackingId}": {
            "get": {
                "description": "Returns details about a particular shipment tracking",
                "operationId": "GetShipmentTrackingById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentTrackingId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Shipment Tracking"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a Shipment Tracking by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentTracking"
                            }
                        }
                    },
                    "404":{
                        "description": "Shipment tracking not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "patch": {
                "description": "Update one shipment tracking",
                "operationId": "UpdateShipmentTracking",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentTrackingId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment tracking"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipment tracking info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentTracking"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipment tracking by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentTracking"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Shipment tracking not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one shipment tracking",
                "operationId": "SyncShipmentTracking",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentTrackingId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment tracking"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipment tracking info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentTracking"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipment tracking by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentTracking"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a shipment tracking by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShipmentTracking"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Shipment tracking not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing shipment tracking",
                "operationId": "DeleteShipmentTracking",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentTrackingId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment tracking"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Shipment Tracking not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/shipmenttrackings": {
            "get": {
                "description": "Get all shipment trackings",
                "operationId": "GetShipmentTrackings",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
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
                "description": "Create a new Shipment Tracking and update Shipment's trackingStatus",
                "operationId": "CreateShipmentTracking",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShipmentTracking"
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
        "/trackingservices/{trackingServiceId}": {
            "get": {
                "description": "Returns details about a particular tracking service",
                "operationId": "GetTrackingServiceById",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "trackingServiceId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Tracking Service"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a Tracking Service by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/TrackingService"
                            }
                        }
                    },
                    "404":{
                        "description": "Tracking service not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "patch": {
                "description": "Update one tracking service",
                "operationId": "UpdateTrackingService",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "trackingServiceId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the tracking service"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New tracking service info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/TrackingService"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a tracking service by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/TrackingService"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Tracking Service not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one tracking service",
                "operationId": "SyncTrackingService",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "trackingServiceId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the tracking service"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New tracking service info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/TrackingService"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a tracking service by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/TrackingService"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a tracking service by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/TrackingService"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Tracking Service not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing tracking service",
                "operationId": "DeleteTrackingService",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "trackingServiceId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the tracking service"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Tracking Service not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/trackingservices": {
            "get": {
                "description": "Get all tracking services",
                "operationId": "GetTrackingServices",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:READ"
                ],
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
                "description": "Create a new tracking service",
                "operationId": "CreateTrackingService",
                "x-ISC_RequiredResource": [
                    "SC_Data_API:WRITE"
                ],
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/TrackingService"
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
        "/serviceslas/{serviceSLAId}": {
            "get": {
                "description": "Returns details about a particular service SLA",
                "operationId": "GetServiceSLAById",
                "x-ISC_RequiredResource": ["SC_Data_API:READ"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "serviceSLAId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Service SLA"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a ServiceSLA by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ServiceSLA"
                            }
                        }
                    },
                    "404":{
                        "description": "Service SLA not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "patch": {
                "description": "Update one service SLA",
                "operationId": "UpdateServiceSLA",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "serviceSLAId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the service SLA"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New service SLA info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ServiceSLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a service SLA by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ServiceSLA"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Service SLA not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "put": {
                "description": "Synchronize one service SLA",
                "operationId": "SyncServiceSLA",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "serviceSLAId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the service SLA"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New service SLA info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ServiceSLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a service SLA by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ServiceSLA"
                            }
                        }
                    },
                    "201": {
                        "description": "Details about a service SLA by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ServiceSLA"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Service SLA not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing service SLA",
                "operationId": "DeleteServiceSLA",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "path",
                        "name": "serviceSLAId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Service SLA"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Service SLA not found",
                        "schema": {
                            "$ref": "#/definitions/ErrorMessage"
                        }
                    }
                }
            }
        },
        "/serviceslas": {
            "get": {
                "description": "Get all service SLAs",
                "operationId": "GetServiceSLAs",
                "x-ISC_RequiredResource": ["SC_Data_API:READ"],
                "produces": ["application/json"],
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
                "description": "Create a new service SLA",
                "operationId": "CreateServiceSLA",
                "x-ISC_RequiredResource": ["SC_Data_API:WRITE"],
                "produces": ["application/json"],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ServiceSLA"
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
                "name",
                "attributes"
            ],
            "properties": {
                "name": {
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
        },
        "Customer": {
            "type": "object",
            "required": [
                "uid",
                "name"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "primaryContact": {
                    "type": "string"
                },
                "primaryPhone": {
                    "type": "string"
                },
                "url": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "shipToLocationId": {
                    "type": "string"
                },
                "primaryLocationId": {
                    "type": "string"
                }
            }
        },
        "Location": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "locationName": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "street": {
                    "type": "string"
                },
                "city": {
                    "type": "string"
                },
                "stateProvince": {
                    "type": "string"
                },
                "stateProvinceIso2": {
                    "type": "string"
                },
                "country": {
                    "type": "string"
                },
                "countryIso2": {
                    "type": "string"
                },
                "countryIso3": {
                    "type": "string"
                },
                "countryPhoneCode": {
                    "type": "string"
                },
                "postalCode": {
                    "type": "string"
                },
                "coordinates": {
                    "type": "string"
                },
                "gln": {
                    "type": "string"
                },
                "currencyIso3": {
                    "type": "string"
                },
                "region": {
                    "type": "string"
                },
                "subregion": {
                    "type": "string"
                },
                "street2": {
                    "type": "string"
                },
                "neighborhood": {
                    "type": "string"
                }
            }
        },
        "SalesOrder": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "orderStatus": {
                    "type": "string"
                },
                "customerId": {
                    "type": "string"
                },
                "customerPoNumber": {
                    "type": "string"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "orderPlacedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "changeOrderDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "lastModifiedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipToLocationId": {
                    "type": "string"
                },
                "orderValue": {
                    "type": "number"
                },
                "orderCurrency": {
                    "type": "string"
                },
                "dataSource": {
                    "type": "string"
                },
                "sourceOrderId": {
                    "type": "string"
                },
                "salesOrganization": {
                    "type": "string"
                },
                "salesRegion": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SalesOrderLine"
                    }
                }
            }
        },
        "SalesOrderLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "salesOrderId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "shipToLocationId": {
                    "type": "string"
                }
            }
        },
        "Product": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "productClass": {
                    "type": "string"
                },
                "productCategory": {
                    "type": "string"
                },
                "productBrand": {
                    "type": "string"
                },
                "productFamily": {
                    "type": "string"
                },
                "productSegment": {
                    "type": "string"
                },
                "productNumber": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "gtin": {
                    "type": "string"
                },
                "defaultUom": {
                    "type": "string"
                },
                "shelfLife": {
                    "type": "number"
                },
                "shelfLifeUom": {
                    "type": "string"
                },
                "agingThreshold": {
                    "type": "number"
                },
                "agingThresholdUom": {
                    "type": "string"
                },
                "defaultLeadTime": {
                    "type": "number"
                },
                "leadTimeUom": {
                    "type": "string"
                },
                "defaultGoodReceiptProcessingTime": {
                    "type": "number"
                },
                "goodReceiptProcessingTimeUom": {
                    "type": "string"
                },
                "costControl": {
                    "type": "string"
                },
                "standardCost": {
                    "type": "number"
                },
                "movingAverageCost": {
                    "type": "number"
                },
                "costCurrency": {
                    "type": "string"
                }
            }
        },
        "Carrier": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "url": {
                    "type": "string"
                },
                "scac": {
                    "type": "string"
                },
                "trackingUrl": {
                    "type": "string"
                },
                "primaryContact": {
                    "type": "string"
                },
                "primaryPhone": {
                    "type": "string"
                }
            }
        },
        "Supplier": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "primaryLocationId": {
                    "type": "string"
                },
                "primaryPhone": {
                    "type": "string"
                },
                "primaryContact": {
                    "type": "string"
                },
                "url": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "BOM": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "itemId": {
                    "type": "string"
                },
                "parentItemId": {
                    "type": "string"
                },
                "isAlternate": {
                    "type": "boolean"
                },
                "substituteFor": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "effectiveStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "effectiveEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "productionRelevant": {
                    "type": "boolean"
                }
            }
        },
        "DemandPlan": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "locationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "planCycle": {
                    "type": "string"
                },
                "planType": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "startDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validFromDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validToDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "Exception": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "category": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "reason": {
                    "type": "string"
                },
                "action": {
                    "type": "string"
                },
                "source": {
                    "type": "string"
                },
                "actionDetails": {
                    "type": "string"
                },
                "associatedObjectType": {
                    "type": "string"
                },
                "associatedObjectId": {
                    "type": "string"
                }
            }
        },
        "InventoryThreshold": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "siteLocationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "expectedLeadTime": {
                    "type": "number"
                },
                "daysOfSupplyUpperThreshold": {
                    "type": "number"
                },
                "daysOfSupplyLowerThreshold": {
                    "type": "number"
                },
                "targetDaysOfSupply": {
                    "type": "number"
                },
                "quantityUpperThreshold": {
                    "type": "number"
                },
                "quantityLowerThreshold": {
                    "type": "number"
                },
                "quantityUom": {
                    "type": "string"
                },
                "velocityCode": {
                    "type": "string"
                },
                "safetyStock": {
                    "type": "number"
                },
                "minSafetyStock": {
                    "type": "number"
                }
            }
        },
        "MfgOrder": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "workDescription": {
                    "type": "string"
                },
                "orderStatus": {
                    "type": "string"
                },
                "workLocationId": {
                    "type": "string"
                },
                "orderEntryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "salesOrderId": {
                    "type": "string"
                },
                "salesOrderLineNumber": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "notes": {
                    "type": "string"
                },
                "plannedStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "plannedEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualEndDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "LeadtimeVariant": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "facilityLocationId": {
                    "type": "string"
                },
                "timePeriod": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "meanValue": {
                    "type": "number"
                },
                "standardDeviation": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                }
            }
        },
        "Milestone": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "milestoneNumber": {
                    "type": "number"
                },
                "description": {
                    "type": "string"
                },
                "associatedObjectType": {
                    "type": "string"
                },
                "associatedObjectId": {
                    "type": "string"
                },
                "milestoneOwner": {
                    "type": "string"
                },
                "notes": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "plannedStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "plannedEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualEndDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "ProductSupplier": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "supplierId": {
                    "type": "string"
                },
                "supplierType": {
                    "type": "string"
                },
                "hasContract": {
                    "type": "number"
                },
                "unitPrice": {
                    "type": "number"
                },
                "currency": {
                    "type": "string"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "supplierStatus": {
                    "type": "string"
                },
                "leadTime": {
                    "type": "number"
                },
                "leadTimeUnit": {
                    "type": "string"
                },
                "effectiveStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "effectiveEndDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "SLA": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "productBrand": {
                    "type": "string"
                },
                "productFamily": {
                    "type": "string"
                },
                "operation": {
                    "type": "string"
                },
                "cycleTime": {
                    "type": "number"
                },
                "cycleTimeUnit": {
                    "type": "string"
                },
                "upperBound": {
                    "type": "number"
                },
                "lowerBound": {
                    "type": "number"
                },
                "boundUnit": {
                    "type": "string"
                }
            }
        },
        "SupplyPlan": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "locationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "planCycle": {
                    "type": "string"
                },
                "planType": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "startDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validFromDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validToDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "ProductInventory": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "siteLocationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "locationNumber": {
                    "type": "string"
                },
                "lotNumber": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "quantityUom": {
                    "type": "string"
                },
                "storageDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "expirationDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                },
                "inventoryType": {
                    "type": "string"
                },
                "inventoryClass": {
                    "type": "string"
                },
                "inventoryValue": {
                    "type": "number"
                },
                "valueCurrency": {
                    "type": "string"
                },
                "quantityReserved": {
                    "type": "number"
                },
                "quantityReservedUom": {
                    "type": "string"
                }
            }
        },
        "PurchaseOrder": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "orderStatus": {
                    "type": "string"
                },
                "supplierId": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "orderPlacedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "changeOrderDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "lastModifiedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipToLocationId": {
                    "type": "string"
                },
                "orderValue": {
                    "type": "number"
                },
                "orderCurrency": {
                    "type": "string"
                },
                "dataSource": {
                    "type": "string"
                },
                "sourceOrderId": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/PurchaseOrderLine"
                    }
                }
            }
        },
        "PurchaseOrderLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "purchaseOrderId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "shipToLocationId": {
                    "type": "string"
                }
            }
        },
        "SalesShipment": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "substatus": {
                    "type": "string"
                },
                "customerID": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "weight": {
                    "type": "string"
                },
                "weightUom": {
                    "type": "string"
                },
                "hoursDelayed": {
                    "type": "number"
                },
                "trackStartDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "currentStatusCityName": {
                    "type": "string"
                },
                "notifyCarrier": {
                    "type": "integer",
                    "minimum": 0,
                    "maximum": 1
                },
                "carrierId": {
                    "type": "string"
                },
                "originLocationId": {
                    "type": "string"
                },
                "destinationLocationId": {
                    "type": "string"
                },
                "freightForwarder": {
                    "type": "string"
                },
                "billOfLandingNumber": {
                    "type": "string"
                },
                "shipmentCategory": {
                    "type": "string"
                },
                "carrierBookingNumber": {
                    "type": "string"
                },
                "masterAirWaybillNumber": {
                    "type": "string"
                },
                "parcelTrackingNumber": {
                    "type": "string"
                },
                "houseAirwayBill": {
                    "type": "string"
                },
                "externalShipmentID": {
                    "type": "string"
                },
                "carrierContainer": {
                    "type": "string"
                },
                "transportMode": {
                    "type": "string"
                },
                "shipperAccountNumber": {
                    "type": "string"
                },
                "shipperName": {
                    "type": "string"
                },
                "shippingCost": {
                    "type": "number"
                },
                "shippingCostCurrency": {
                    "type": "string"
                },
                "requestedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "estimatedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "updatedEta": {
                    "type": "string",
                    "format": "date-time"
                },
                "predictedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "deliveredDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipmentCreatedDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "recipientName": {
                    "type": "string"
                },
                "purchaseOrder": {
                    "type": "string"
                },
                "orderCreatedSource": {
                    "type": "string"
                },
                "cancelledDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "latestCoordinate": {
                    "type": "string"
                },
                "latestCoordinateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "inTransitLocation": {
                    "type": "string"
                },
                "parentShipmentId": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SalesShipmentLine"
                    }
                },
                "vehicleId": {
                    "type": "string"
                },
                "trailerId": {
                    "type": "string"
                },
                "vehicleType": {
                    "type": "string"
                },
                "emailCopiesOfUpdatesTo": {
                    "type": "string"
                },
                "notes": {
                    "type": "string"
                },
                "railContainerNumber": {
                    "type": "string"
                },
                "trackingServiceProvider": {
                    "type": "string"
                },
                "trackingStatus": {
                    "type": "string"
                },
                "statusMessage": {
                    "type": "string"
                },
                "mobileNumber": {
                    "type": "string"
                }
            }
        },
        "SalesShipmentLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "salesShipmentId": {
                    "type": "string"
                },
                "quantityShipped": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "valueCurrency": {
                    "type": "string"
                },
                "salesOrderId": {
                    "type": "string"
                },
                "salesOrderLineNumber": {
                    "type": "string"
                },
                "salesOrderLineId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                }
            }
        },
        "SupplyShipment": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "substatus": {
                    "type": "string"
                },
                "supplierId": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "weight": {
                    "type": "number"
                },
                "weightUom": {
                    "type": "string"
                },
                "hoursDelayed": {
                    "type": "number"
                },
                "trackStartDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "currentStatusCityName": {
                    "type": "string"
                },
                "notifyCarrier": {
                    "type": "integer",
                    "minimum": 0,
                    "maximum": 1
                },
                "carrierId": {
                    "type": "string"
                },
                "originLocationId": {
                    "type": "string"
                },
                "destinationLocationId": {
                    "type": "string"
                },
                "freightForwarder": {
                    "type": "string"
                },
                "billOfLandingNumber": {
                    "type": "string"
                },
                "shipmentCategory": {
                    "type": "string"
                },
                "carrierBookingNumber": {
                    "type": "string"
                },
                "masterAirWaybillNumber": {
                    "type": "string"
                },
                "parcelTrackingNumber": {
                    "type": "string"
                },
                "houseAirwayBill": {
                    "type": "string"
                },
                "externalShipmentID": {
                    "type": "string"
                },
                "carrierContainer": {
                    "type": "string"
                },
                "transportMode": {
                    "type": "string"
                },
                "shipperAccountNumber": {
                    "type": "string"
                },
                "shipperName": {
                    "type": "string"
                },
                "shippingCost": {
                    "type": "number"
                },
                "shippingCostCurrency": {
                    "type": "string"
                },
                "requestedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "estimatedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "updatedEta": {
                    "type": "string",
                    "format": "date-time"
                },
                "predictedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "deliveredDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipmentCreatedDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "recipientName": {
                    "type": "string"
                },
                "purchaseOrder": {
                    "type": "string"
                },
                "orderCreatedSource": {
                    "type": "string"
                },
                "cancelledDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "latestCoordinate": {
                    "type": "string"
                },
                "latestCoordinateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "inTransitLocation": {
                    "type": "string"
                },
                "parentShipmentId": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SupplyShipmentLine"
                    }
                },
                "vehicleId": {
                    "type": "string"
                },
                "trailerId": {
                    "type": "string"
                },
                "vehicleType": {
                    "type": "string"
                },
                "emailCopiesOfUpdatesTo": {
                    "type": "string"
                },
                "notes": {
                    "type": "string"
                },
                "railContainerNumber": {
                    "type": "string"
                },
                "trackingServiceProvider": {
                    "type": "string"
                },
                "trackingStatus": {
                    "type": "string"
                },
                "statusMessage": {
                    "type": "string"
                },
                "mobileNumber": {
                    "type": "string"
                }
            }
        },
        "SupplyShipmentLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "supplyShipmentId": {
                    "type": "string"
                },
                "quantityShipped": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "valueCurrency": {
                    "type": "string"
                },
                "purchaseOrderId": {
                    "type": "string"
                },
                "purchaseOrderLineNumber": {
                    "type": "string"
                },
                "purchaseOrderLineId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                }
            }
        },
        "ProductionCapacity": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "facilityId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "bandwidth": {
                    "type": "number"
                },
                "bandwidthUom": {
                    "type": "string"
                },
                "leadTime": {
                    "type": "number"
                },
                "leadTimeUom": {
                    "type": "string"
                },
                "unitCost": {
                    "type": "number"
                },
                "costCurrency": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "ShippingCost": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "originLocationId": {
                    "type": "string"
                },
                "destinationLocationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "carrierId": {
                    "type": "string"
                },
                "transportationMode": {
                    "type": "string"
                },
                "shippingType": {
                    "type": "string"
                },
                "pricingType": {
                    "type": "string"
                },
                "unitCost": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "costCurrency": {
                    "type": "string"
                },
                "effectiveStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "effectiveEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "issue": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "triggerType": {
                    "type": "string",
                    "enum":["KPI", "externalEvent", "BPL", "API"]
                },
                "triggerObjectId": {
                    "type": "string"
                },
                "impactedObjectType": {
                    "type": "string"
                },
                "impactedObjectId": {
                    "type": "string"
                },
                "severity": {
                    "type": "number"
                },
                "closeTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "routeLeg": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "startLocationId": {
                    "type": "string"
                },
                "endLocationId": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "mode": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "route": {
                    "type": "string"
                },
                "network": {
                    "type": "string"
                },
                "leadTime": {
                    "type": "number"
                },
                "leadTimeUom": {
                    "type": "string"
                },
                "cost": {
                    "type": "number"
                },
                "costCurrency": {
                    "type": "string"
                }
            }
        },
        "bulkUpload": {
            "type": "object",
            "required": [
                "targetObject",
                "uploadType",
                "priority",
                "file",
                "mapping"
            ],
            "properties": {
                "targetObject": {
                    "type": "string"
                },
                "uploadType": {
                    "type": "string"
                },
                "priority": {
                    "type": "string"
                },
                "uidAutoGeneration": {
                    "type": "string"
                },
                "file": {
                    "type": "object",
                    "$ref": "#/definitions/file"
                },
                "mapping": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/mapping"
                    }
                }
            }
        },
        "file": {
            "type": "object",
            "required": [
                "fileSource",
                "fileName",
                "fileType",
                "csvSpec"
            ],
            "properties": {
                "fileSource": {
                    "type": "string"
                },
                "fileName": {
                    "type": "string"
                },
                "fileType": {
                    "type": "string"
                },
                "csvSpec": {
                    "type": "object",
                    "$ref": "#/definitions/csvSpec"
                },
                "connectionInfo": {
                    "type": "object",
                    "$ref": "#/definitions/connectionInfo"
                }
            }
        },
        "mapping": {
            "type": "object",
            "required": [
                "attributeName",
                "mappingType"
            ],
            "properties": {
                "attributeName": {
                    "type": "string"
                },
                "mappingType": {
                    "type": "string"
                },
                "defaultValue": {
                    "type": "string"
                },
                "csvColumnIndex": {
                    "type": "string"
                },
                "csvColumnHeader": {
                    "type": "string"
                },
                "transformation": {
                    "type": "object",
                    "$ref": "#/definitions/transformation"
                },
                "datetimeFormat": {
                    "type": "string"
                }
            }
        },
        "csvSpec": {
            "type": "object",
            "required": [
                "delimiter",
                "hasHeaderRow"
            ],
            "properties": {
                "delimiter": {
                    "type": "string"
                },
                "hasHeaderRow": {
                    "type": "string"
                },
                "defaultTimezone": {
                    "type": "string"
                }
            }
        },
        "transformation": {
            "type": "object",
            "required": [
                "sourceValue",
                "targetValue"
            ],
            "properties": {
                "sourceValue": {
                    "type": "string"
                },
                "targetValue": {
                    "type": "string"
                }
            }
        },
        "connectionInfo": {
            "type": "object",
            "required": [
                "userName",
                "password"
            ],
            "properties": {
                "url": {
                    "type": "string"
                },
                "userName": {
                    "type": "string"
                },
                "password": {
                    "type": "string"
                },
                "filePath": {
                    "type": "string"
                },
                "sessionToken": {
                    "type": "string"
                },
                "storageProvider": {
                    "type": "string"
                },
                "bucketName": {
                    "type": "string"
                },
                "storageRegion": {
                    "type": "string"
                },
                "email": {
                    "type": "string"
                },
                "clientId": {
                    "type": "string"
                }
            }
        },
        "bulkUploadErrors": {
            "type": "object",
            "required": [
                "uploadId",
                "fileType"
            ],
            "properties": {
                "uploadId": {
                    "type": "string"
                },
                "fileType": {
                    "type": "string"
                },
                "connectionInfo": {
                    "type": "object",
                    "$ref": "#/definitions/connectionInfo"
                }
            }
        },
        "ShipmentMilestone": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "shipmentId": {
                    "type": "string"
                },
                "shipmentType": {
                    "type": "string"
                },
                "stopId": {
                    "type": "string"
                },
                "milestone": {
                    "type": "string"
                },
                "estimatedTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "estimatedTimeLocal": {
                    "type": "string"
                },
                "distanceToStop": {
                    "type": "number"
                },
                "distanceToStopUnit": {
                    "type": "string"
                },
                "lastUpdatedTimeUTC": {
                    "type": "string",
                    "format": "date-time"
                },
                "lastUpdatedTimeLocal": {
                    "type": "string"
                },
                "unLocode": {
                    "type": "string"
                },
                "stopType": {
                    "type": "string"
                },
                "statusCode": {
                    "type": "string"
                },
                "updatedBy": {
                    "type": "string"
                }
            }
        },
        "ShipmentStop": {
            "type": "object",
            "required": [
                "uid",
                "shipmentId",
                "shipmentType"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "shipmentId": {
                    "type": "string"
                },
                "shipmentType": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "stopType": {
                    "type": "string"
                },
                "locationId": {
                    "type": "string"
                },
                "earliestDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "latestDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "geofence": {
                    "type": "number"
                },
                "geofenceUnit": {
                    "type": "string"
                },
                "stopNumber": {
                    "type": "number"
                },
                "notes": {
                    "type": "string"
                }
            }
        },
        "ShipmentTracking": {
            "type": "object",
            "required": [
                "uid",
                "shipmentId",
                "shipmentType"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "shipmentId": {
                    "type": "string"
                },
                "shipmentType": {
                    "type": "string"
                },
                "latestLocationId": {
                    "type": "string"
                },
                "trackingServiceProvider": {
                    "type": "string"
                },
                "trackingServiceOrderId": {
                    "type": "string"
                },
                "trackingServiceRequestId": {
                    "type": "string"
                },
                "trackingServiceStatus": {
                    "type": "string"
                },
                "trackingServiceLastUpdatedTimeUTC": {
                    "type": "string",
                    "format": "date-time"
                },
                "trackingServiceLastUpdatedTimelocal": {
                    "type": "string"
                },
                "trackingServiceShipmentStatus": {
                    "type": "string"
                },
                "trackingServiceShipmentMessage": {
                    "type": "string"
                },
                "etaDateTimeUTC": {
                    "type": "string",
                    "format": "date-time"
                },
                "etaDateTimeLocalTime": {
                    "type": "string"
                },
                "unLocode": {
                    "type": "string"
                },
                "uncertainty": {
                    "type": "number"
                },
                "datasource": {
                    "type": "string"
                },
                "locator": {
                    "type": "string"
                }
            }
        },
        "TrackingService": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "serviceProviderId": {
                    "type": "string"
                },
                "stopSequencingRequired": {
                    "type": "boolean"
                },
                "maximumAllowableDrivingHoursPerDay": {
                    "type": "number"
                },
                "trackingServiceProvider": {
                    "type": "string"
                },
                "startDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "endDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "ServiceSLA": {
            "type": "object",
            "required": ["uid"],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "serviceId": {
                    "type": "string"
                },
                "termName": {
                    "type": "string"
                },
                "termValue": {
                    "type": "string"
                },
                "termValueUOM": {
                    "type": "string"
                },
                "serviceObject": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                }
            }
        },
        "ErrorMessage":{
            "type": "object",
            "properties": {
                "Status" : {
                    "type" : "string"
                },
                "Message": {
                    "type" : "string"
                }
            }
        }
    }
}
}

}
