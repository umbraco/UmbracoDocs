# Content Management API for Relations

**BASE URL**: `https://api.umbraco.io`


## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get By Id](#get-by-id)
* [Get by relation type alias](#get-by-relation-type-alias)
* [Get by parent id](#get-by-parent-id)
* [Get by child id](#get-by-child-id)
* [Create relation](#create-relation)
* [Delete relation](#delete-relation)

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
| 400         | BadRequest           | Body cannot be empty.                                                    |
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Relation with id '{id}' could not be found.                              |
| 422         | ValidationFailed     | Validation error occured when trying to save or update the relation.     |
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

## Get by id

Get a specific relation by its `integer` ID.

**URL**: `/relation/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_id": 4,
    "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
    "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
    "relationTypeAlias": "relateDocumentOnCopy",
    "comment": "Testing relations for relateDocumentOnCopy",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/4"
        }
    }
}
```

## Get by relation type alias

Get a list of relations by their Relation Type alias.

**URL**: `/relation/{alias}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/parent/"
        },
        "relations": {
            "href": "https://api.umbraco.io/relation/4"
        }
    },
    "_embedded": {
        "relations": [
            {
                "_id": 4,
                "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
                "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
                "relationTypeAlias": "relateDocumentOnCopy",
                "comment": "Testing relations for relateDocumentOnCopy",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/relation/4"
                    }
                }
            }
        ]
    }
}
```

## Get by parent id

Get a list of relations by their parents GUID ID.

**URL**: `/relation/parent/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/parent/af3e08fc-fb90-4c78-b11c-c1a0cf43bd31"
        },
        "relations": {
            "href": "https://api.umbraco.io/relation/4"
        }
    },
    "_embedded": {
        "relations": [
            {
                "_id": 4,
                "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
                "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
                "relationTypeAlias": "relateDocumentOnCopy",
                "comment": "Testing relations for relateDocumentOnCopy",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/relation/4"
                    }
                }
            }
        ]
    }
}
```

## Get by child id

Get a list of relations by their childs GUID ID.

**URL**: `/relation/child/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/child/e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5"
        },
        "relations": {
            "href": "https://api.umbraco.io/relation/4"
        }
    },
    "_embedded": {
        "relations": [
            {
                "_id": 4,
                "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
                "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
                "relationTypeAlias": "relateDocumentOnCopy",
                "comment": "Testing relations for relateDocumentOnCopy",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/relation/4"
                    }
                }
            }
        ]
    }
}
```

## Create relation

Create a new relation.

**URL**: `/relation/`

**Method**: `POST`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Request

```json
{
    "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
    "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
    "relationTypeAlias": "relateDocumentOnCopy",
    "comment": "Testing relations for relateDocumentOnCopy"
}
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
    "_id": 4,
    "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
    "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
    "relationTypeAlias": "relateDocumentOnCopy",
    "comment": "Testing relations for relateDocumentOnCopy",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/4"
        }
    }
}
```

## Delete relation

Delete a relation by its `integer` ID.

**URL**: `/relation/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

`DELETE https://api.umbraco.io/relation/4`

```json
{
    "_id": 4,
    "parentId": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
    "childId": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
    "relationTypeAlias": "relateDocumentOnCopy",
    "comment": "Testing relations for relateDocumentOnCopy",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/relation/4"
        }
    }
}
```
