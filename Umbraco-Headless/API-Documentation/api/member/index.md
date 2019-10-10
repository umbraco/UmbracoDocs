# Content Management API for Members

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
| 404         | NotFound             | Member with username '{username}' could not be found.                    |
| 422         | Unprocessable Entity | Validation error occured when trying to save or update the member.       |
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

## Get by username

Get a specific member by their username.

**URL**: `/member/{username}`

**Method**: `GET`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Create member

Create a new member.

**URL**: `/member/`

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

## Update member

Update an existing member.

**URL**: `/member/{username}`

**Method**: `PUT`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Delete member

Delete an existing member by their username.

**URL**: `/member/{username}`

**Method**: `DELETE`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Add member to member group

Add an existing member to an existing member group.

**URL**: `/member/{username}/groups/{groupName}`

**Method**: `PUT`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Remove member from member group

Remove a specific member from a specific member group.

**URL**: `/member/{username}/groups/{groupName}`

**Method**: `DELETE`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```