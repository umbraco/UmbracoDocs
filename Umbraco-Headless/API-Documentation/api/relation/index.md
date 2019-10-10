# Content Management API for Relations

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
| 400         | Bad Request          | Body cannot be empty.                                                    |
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Relation with id '{id}' could not be found.                              |
| 422         | Unprocessable Entity | Validation error occured when trying to save or update the relation.     |
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

Get a specific relation by its integer id.

**URL**: `/relation/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get by relation type alias

Get a list of relations by their relation type alias.

**URL**: `/relation/{alias}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get by parent id

Get a list of relations by their parent's integer id.

**URL**: `/relation/parent/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get by child id

Get a list of relations by their child's integer id.

**URL**: `/relation/child/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Create relation

Create a new relation.

**URL**: `/relation/`

**Method**: `POST`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 201

**Content Example**:

```json
```

## Delete relation

Delete a relation

**URL**: `/relation/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```