# Content Management API for Member Groups

**BASE URL**: `https://api.umbraco.io`

## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get All](#get-all)
* [Get By Name](#get-by-name)
* [Create member group](#create-member-group)
* [Delete member group](#delete-member-group)


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
| 404         | NotFound             | Member Group with name '{name}' could not be found.                      |
| 422         | ValidationFailed     | Validation error occured when trying to save or update the member group. |
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

## Get all

Get all Member Groups.

**URL**: `/member/group`

**Method**: `GET`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_links": {
    "self": {
      "href": "/api/member/group"
    },
    "membergroups": {
      "href": "/api/member/group/Club%20Blue%20Members",
      "href": "/api/member/group/Elite%20Shoppers%20Group"
    }
  },
  "_embedded": {
    "membergroups": [
      {
        "name": "Club Blue Members",
        "_createDate": "2019-10-10T12:02:50.83Z",
        "_id": "15a1a854-596c-4b72-b462-769015a6b0eb",
        "_updateDate": "0001-01-01T00:00:00Z",
        "_links": {
          "self": {
            "href": "/api/member/group/Club%20Blue%20Members"
          }
        }
      },
      {
        "name": "Elite Shoppers Group",
        "_createDate": "2019-10-10T12:09:58.5982624Z",
        "_id": "1ae62150-e54c-4fd7-aabe-9ad46d1b7109",
        "_updateDate": "0001-01-01T00:00:00Z",
        "_links": {
          "self": {
            "href": "/api/member/group/Elite%20Shoppers%20Group"
          }
        }
      }
    ]
  }
}
```

## Get by name

Get a specific Member Group by its name.

**URL**: `/member/group/{name}`

**Method**: `GET`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "name": "Club Blue Members",
  "_createDate": "2019-10-10T12:02:50.83Z",
  "_id": "15a1a854-596c-4b72-b462-769015a6b0eb",
  "_updateDate": "0001-01-01T00:00:00Z",
  "_links": {
    "self": {
    "href": "/api/member/group/Club%20Blue%20Members"
    }
  }
}
```

## Create member group

Create a new Member Group.

**URL**: `/member/group`

**Method**: `POST`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Request

```json
{
  "name": "Elite Shoppers Group"
}
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
  "name": "Elite Shoppers Group",
  "_createDate": "2019-10-10T12:09:58.5982624Z",
  "_id": "1ae62150-e54c-4fd7-aabe-9ad46d1b7109",
  "_updateDate": "2019-10-10T12:09:58.5982624Z",
  "_links": {
    "self": {
    "href": "/api/member/group/Elite%20Shoppers%20Group"
    }
  }
}
```

## Delete member group

Delete an existing Member Group.

**URL**: `/member/group/{name}`

**Method**: `DELETE`

**Permissions required** : Access to Member section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

`DELETE https://api.umbraco.io/member/group/Elite%20Shoppers%20Group`

```json
{
  "name": "Elite Shoppers Group",
  "_createDate": "2019-10-10T12:09:58.597Z",
  "_id": "1ae62150-e54c-4fd7-aabe-9ad46d1b7109",
  "_updateDate": "0001-01-01T00:00:00Z",
  "_deleteDate": "2019-10-10T12:10:45.0657415Z",
  "_links": {
    "self": {
    "href": "/api/member/group/Elite%20Shoppers%20Group"
    }
  }
}
```
