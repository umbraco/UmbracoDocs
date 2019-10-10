# Content Management API for Content

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
| 404         | NotFound             | Content with id '{id}' could not be found.                               |
| 422         | Unprocessable Entity | Validation error occured when trying to save or update the content item. |
| 500         | InternalServerError  | Internal server error.                                                   |

**JSON example**:

```json
{
  "error": {
    "code": "Forbidden",
    "message": "Authorization has been denied for this request."
  }
}
```

## Get root content

Get all content at the root of the tree, which the authorized user has access to according to the 'Start node'-permissions.

**URL**: `/content`

**Method**: `GET`

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get by id

Get specific content item by its guid id.
Includes all language variations.

**URL**: `/content/{id}`

**Method**: `GET`

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Get children

Get a list of children (content items) by their parent guid id.
Includes all language variations per content item.

**URL**: `/content/{id}/children`

**Method**: `GET`

**Query Strings**

```none
?page={integer=1}
?pageSize={integer=10}
```

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Create content

Create a new content item with one or more language variations.

**URL**: `/content`

**Method**: `POST`

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 201

**Content Example**:

```json
```

## Update content

Updates an existing content item with one or more language variations.

**URL**: `/content/{id}`

**Method**: `PUT`

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Publish content

Publish specific content item with all language variations or for a specific language.

**URL**: `/content/{id}/publish`

**Method**: `PUT`

**Query Strings**

```none
?culture={string=en-US}
```

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Unpublish content

Unpublish specific content item with all language variations or for a specific language.

**URL**: `/content/{id}/unpublish`

**Method**: `PUT`

**Query Strings**

```none
?culture={string=en-US}
```

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Delete content

Delete a specific content item with all its language variations

**URL**: `/content/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Content section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```