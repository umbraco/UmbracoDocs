# Content Management API for Members

**BASE URL**: `https://api.umbraco.io`

## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get by username](#get-by-username)
* [Create Member](#create-member)
* [Update Member](#update-member)
* [Delete Member](#delete-member)
* [Change Member Password](#change-member-password)
* [Get a reset member password token](#get-a-reset-member-password-token)
* [Reset member password](#reset-member-password)
* [Add member to member group](#add-member-to-member-group)
* [Remove member from member group](#remove-member-from-member-group)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Authentication

Authentication is required for this API. You must supply a Bearer Token via an Authorization header or an API Key through an Authorization or Api-Key header.

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code           | Message                                                                  |
| ----------- | -------------------- | ------------------------------------------------------------------------ |
| 400         | BadRequest           | Body cannot be empty.                                                    |
| 400         | CouldNotUnlockUser   | Could not unlock the user.                                               |
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Member with username '{username}' could not be found.                    |
| 422         | ValidationFailed     | Validation error occured when trying to save or update the member.       |
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

To set a password when creating a member a `password` field must be included in the posted data.
If the password field is omitted no password will be set.

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

A member can be unlocked by setting `isLockedOut` to `false` in the request. **Note** that a member cannot be locked by setting the value to `true`; it will be ignored if the user is not already locked out.

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

## Change member password

Change a members password.

**URL**: `/member/{username}/password`

**Method**: `POST`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
{
    "currentPassword": "<current password>",
    "newPassword": "<new password>"
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

## Get a reset member password token

Get a reset password token.

**URL**: `/member/{username}/password/reset-token`

**Method**: `GET`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "token": "ydAcKSmv+zAdPqFeYPuBAGojmFvJeiI2B6K79x0eOGX5EMevdu/vs16eq5sZ85crk2V+/7JmxN6s/5MJFvNg2K9Iex3cFmNlI8uTmvw2HuQzCr3Zo9KyKh19Gy4iTfzx+Q3Q0z1TCuSdBxjpiI6nuQ==",
    "expires_in": 86399,
    "_links": {
        "self": {
            "href": "/api/member/jane%40example.com/password/reset-token"
        },
        "member": {
            "href": "/api/member/jane%40example.com"
        }
    },
    "_embedded": {
        "member": {
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
}
```

## Reset member password

Reset a members password.

**URL**: `/member/{username}/password/reset`

**Method**: `POST`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
{
    "token": "ydAcKSmv+zAdPqFeYPuBAGojmFvJeiI2B6K79x0eOGX5EMevdu/vs16eq5sZ85crk2V+/7JmxN6s/5MJFvNg2K9Iex3cFmNlI8uTmvw2HuQzCr3Zo9KyKh19Gy4iTfzx+Q3Q0z1TCuSdBxjpiI6nuQ==",
    "newPassword": "<new password>"
}
```

### Success Response

**Code**: 200

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
## Add member to member group

Add an existing member to an existing member group.

**URL**: `/member/{username}/groups/{groupName}`

**Method**: `PUT`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

## Remove member from member group

Remove a specific member from a specific member group.

**URL**: `/member/{username}/groups/{groupName}`

**Method**: `DELETE`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200
