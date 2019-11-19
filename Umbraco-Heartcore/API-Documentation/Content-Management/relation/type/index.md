# Content Management API for Relation Types

**BASE URL**: `https://api.umbraco.io`


## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get all relation types](#get-all-relation-types)
* [Get by alias](#get-by-alias)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Authentication

Auth is required for this API meaning that you must supply a Bearer Token via an Authorization header or an API Key via an Authorization or Api-Key header.

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code           | Message                                                                  |
| ----------- | -------------------- | ------------------------------------------------------------------------ |
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Relation Type with alias '{alias}' could not be found.                   |
| 500         | InternalServerError  | Internal server error.                                                   |

**JSON example**:

```json
{
  "error": {
    "code": "Unauthorized",
    "message": "Authorization has been denied for this request."
  }
}
```

## Get all relation types

Get a list of all available relation types.

**URL**: `/relation/type`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/type"
        },
        "relationtypes": [
            {
                "href": "https://api.umbraco.io/relation/type/relateDocumentOnCopy"
            },
            {
                "href": "https://api.umbraco.io/relation/type/relateParentDocumentOnDelete"
            },
            {
                "href": "https://api.umbraco.io/relation/type/relateParentMediaFolderOnDelete"
            }
        ]
    },
    "_embedded": {
        "relationtypes": [
            {
                "name": "Relate Document On Copy",
                "alias": "relateDocumentOnCopy",
                "isBidirectional": true,
                "parentObjectType": "DOCUMENT",
                "childObjectType": "DOCUMENT",
                "_createDate": "0001-01-01T00:00:00Z",
                "_id": "4cbeb612-e689-3563-b755-bf3ede295433",
                "_updateDate": "0001-01-01T00:00:00Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/relation/type/relateDocumentOnCopy"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/relation/type"
                    }
                }
            },
            {
                "name": "Relate Parent Document On Delete",
                "alias": "relateParentDocumentOnDelete",
                "isBidirectional": false,
                "parentObjectType": "DOCUMENT",
                "childObjectType": "DOCUMENT",
                "_createDate": "0001-01-01T00:00:00Z",
                "_id": "0cc3507c-66ab-3091-8913-3d998148e423",
                "_updateDate": "0001-01-01T00:00:00Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/relation/type/relateParentDocumentOnDelete"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/relation/type"
                    }
                }
            },
            {
                "name": "Relate Parent Media Folder On Delete",
                "alias": "relateParentMediaFolderOnDelete",
                "isBidirectional": false,
                "parentObjectType": "MEDIA",
                "childObjectType": "MEDIA",
                "_createDate": "0001-01-01T00:00:00Z",
                "_id": "8307994f-faf2-3844-bab9-72d34514edf2",
                "_updateDate": "0001-01-01T00:00:00Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/relation/type/relateParentMediaFolderOnDelete"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/relation/type"
                    }
                }
            }
        ]
    }
}
```

## Get by alias

Get a specific Relation Type by its alias.

**URL**: `/relation/type/{alias}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "name": "Relate Document On Copy",
    "alias": "relateDocumentOnCopy",
    "isBidirectional": true,
    "parentObjectType": "DOCUMENT",
    "childObjectType": "DOCUMENT",
    "_createDate": "0001-01-01T00:00:00Z",
    "_id": "4cbeb612-e689-3563-b755-bf3ede295433",
    "_updateDate": "0001-01-01T00:00:00Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/type/relateDocumentOnCopy"
        },
        "root": {
            "href": "https://api.umbraco.io/relation/type"
        }
    }
}
```
