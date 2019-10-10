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
{
    "_failedPasswordAttempts": 0,
    "_groups": [
        "Club Blue Members"
    ],
    "_lastLoginDate": "2019-10-10T12:04:24Z",
    "_lastPasswordChangeDate": "2019-10-10T12:04:24Z",
    "_createDate": "2019-10-10T12:04:24.203Z",
    "_id": "153c22ad-2940-4d1c-9253-f62a2a873915",
    "_updateDate": "2019-10-10T12:04:24.487Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/member/john%40example.com"
        },
        "membertype": {
            "href": "https://api.umbraco.io/member/type/Member"
        }
    },
    "comments": "First Club Blue Member",
    "email": "john@example.com",
    "isApproved": true,
    "isLockedOut": false,
    "memberTypeAlias": "Member",
    "username": "john@example.com",
    "name": "John Doe"
}
```

## Create member

Create a new member.

**URL**: `/member/`

**Method**: `POST`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
{
    "comments": "A Valued Club Blue Member",
    "email": "jane@example.com",
    "isApproved": true,
    "isLockedOut": false,
    "memberTypeAlias": "Member",
    "username": "jane@example.com",
    "name": "Jane Doe"
}
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
    "_failedPasswordAttempts": 0,
    "_groups": [],
    "_createDate": "2019-10-10T12:18:06.6087436Z",
    "_id": "fbabbae4-738d-406a-a7b6-e6684a622882",
    "_updateDate": "2019-10-10T12:18:06.6087436Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/member/john%40example.com"
        },
        "membertype": {
            "href": "https://api.umbraco.io/member/type/Member"
        }
    },
    "comments": "A Valued Club Blue Member",
    "email": "jane@example.com",
    "isApproved": true,
    "isLockedOut": false,
    "memberTypeAlias": "Member",
    "username": "jane@example.com",
    "name": "Jane Doe"
}
```

## Update member

Update an existing member.

**URL**: `/member/{username}`

**Method**: `PUT`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
{
    "comments": "A Valued Club Blue Member",
    "email": "jane@example.com",
    "isApproved": true,
    "isLockedOut": false,
    "memberTypeAlias": "Member",
    "username": "jane@example.com",
    "name": "Jane A. Doe"
}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_failedPasswordAttempts": 0,
    "_groups": [],
    "_createDate": "2019-10-10T12:19:57.053Z",
    "_id": "59c97163-0ece-4b92-893a-d3da4af2c888",
    "_updateDate": "2019-10-10T12:20:30.1886381Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/member/jane%40example.com"
        },
        "membertype": {
            "href": "https://api.umbraco.io/member/type/Member"
        }
    },
    "comments": "A Valued Club Blue Member",
    "email": "jane@example.com",
    "isApproved": true,
    "isLockedOut": false,
    "memberTypeAlias": "Member",
    "username": "jane@example.com",
    "name": "Jane A. Doe"
}
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
{
    "_failedPasswordAttempts": 0,
    "_groups": [],
    "_lastLoginDate": "2019-10-10T12:04:24Z",
    "_lastPasswordChangeDate": "2019-10-10T12:04:24Z",
    "_createDate": "2019-10-10T12:04:24.203Z",
    "_id": "153c22ad-2940-4d1c-9253-f62a2a873915",
    "_updateDate": "2019-10-10T12:04:24.487Z",
    "_deleteDate": "2019-10-10T12:16:41.2371252Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/member/john%40example.com"
        },
        "membertype": {
            "href": "https://api.umbraco.io/member/type/Member"
        }
    },
    "comments": "First Club Blue Member",
    "email": "john@example.com",
    "isApproved": true,
    "isLockedOut": false,
    "memberTypeAlias": "Member",
    "username": "john@example.com",
    "name": "John Doe"
}
```

## Add member to member group

Add an existing member to an existing member group.

**URL**: `/member/{username}/groups/{groupName}`

**Method**: `PUT`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

`PUT https://api.umbraco.io/member/john@example.com/groups/Club%20Blue%20Members`

## Remove member from member group

Remove a specific member from a specific member group.

**URL**: `/member/{username}/groups/{groupName}`

**Method**: `DELETE`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

`DELETE https://api.umbraco.io/member/john@example.com/groups/Club%20Blue%20Members`