# Content Management API for Languages

**BASE URL**: `https://api.umbraco.io`

## Common Headers

```http
Api-Version: 2
Api-Key: {api-key}
Umb-Project-Alias: {project-alias}
```

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code           | Message                                                                  |
| ----------- | -------------------- | ------------------------------------------------------------------------ |
| 400         | Bad Request          | Body cannot be empty.                                                    |
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Language with id '{id}' could not be found.                              |
| 422         | Unprocessable Entity | Validation error occured when trying to save or update the language.     |
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

## Get languages

Gets all languages available for content creation.

**URL**: `/language`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```


## Get by iso code

Get a specific langauge by its iso code.

**URL**: `/language/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Create langauge

Create a new language for use on content.
Please note that the number of languages that can be created is defined by the pricing tier.

**URL**: `/language`

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

## Update language

Updates an existing language

**URL**: `/language/{id}`

**Method**: `PUT`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Request

```json
```

### Success Response

**Code**: 200

**Content Example**:

```json
```

## Delete language

Deletes an existing language.
Please note that deleting a language, which is in use means that content based on this language will be set to invariant.

**URL**: `/language/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
```