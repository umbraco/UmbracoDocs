# Content Management API for Relation Types

**BASE URL**: `https://api.umbraco.io`

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

## Get by alias

Get a specific relation type by its alias.

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
    "parentObjectType": "Unknown",
    "childObjectType": "Unknown",
    "_createDate": "0001-01-01T00:00:00Z",
    "_id": "4cbeb612-e689-3563-b755-bf3ede295433",
    "_updateDate": "0001-01-01T00:00:00Z"
}
```
