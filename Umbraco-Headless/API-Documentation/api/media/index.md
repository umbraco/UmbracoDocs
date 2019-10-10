# Content Management API for Media

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
| 404         | NotFound             | Media with id '{id}' could not be found.                                 |
| 422         | Unprocessable Entity | Validation error occured when trying to save or update the media item.   |
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

## Get root media

Get all media at the root of the tree, which the authorized user has access to according to the 'Start node'-permissions.

**URL**: `/media`

**Method**: `GET`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get by id

Get specific media item by its guid id.

**URL**: `/media/{id}`

**Method**: `GET`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get children

Get a list of children (media items) by their parent guid id.

**URL**: `/media/{id}/children`

**Method**: `GET`

**Query Strings**

```none
?page={integer=1}
?pageSize={integer=10}
```

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Create media

Create a new media item and optionally upload a file to the created item.

**URL**: `/media`

**Method**: `POST`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 201

**Content Example**:

```json
```

## Update media

Updates an existing media item and optionally uploads a file to the updated item.

**URL**: `/media/{id}`

**Method**: `PUT`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Delete media

Delete a media item. This will also delete any file that is attached to the media item.

**URL**: `/media/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```
