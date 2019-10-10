# Content Management API for Member Groups

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
| 404         | NotFound             | Member Group with name '{name}' could not be found.                      |
| 422         | Unprocessable Entity | Validation error occured when trying to save or update the member group. |
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

## Get by name

Get a specific member group by its name.

**URL**: `/member/group/{name}`

**Method**: `GET`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Create member group

Create a new member group.

**URL**: `/member/group`

**Method**: `POST`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 201

**Content Example**:

```json
```

## Delete member group

Delete an existing member group.

**URL**: `/member/group/{name}`

**Method**: `DELETE`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```
