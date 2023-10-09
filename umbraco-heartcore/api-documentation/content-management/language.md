# Languages

**BASE URL**: `https://api.umbraco.io`

## Table of Contents

* [Common Headers](language.md#common-headers)
* [Authentication](language.md#authentication)
* [Errors](language.md#errors)
* [Get languages](language.md#get-languages)
* [Get by ISO code](language.md#get-by-iso-code)
* [Create language](language.md#create-language)
* [Update language](language.md#update-language)
* [Delete language](language.md#delete-language)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Authentication

Auth is required for this API meaning that you must supply a Bearer Token via an Authorization header or an API Key via an Authorization or Api-Key header.

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code                     | Message                                                              |
| ----------- | ------------------------------ | -------------------------------------------------------------------- |
| 400         | BadRequest                     | Body cannot be empty.                                                |
| 401         | Unauthorized                   | Authorization has been denied for this request.                      |
| 403         | Forbidden                      | You are not authorized to access the given resource.                 |
| 404         | NotFound                       | Language with id '{id}' could not be found.                          |
| 409         | LanguageForCultureAlreadyExist | The language '{isoCode}' already exists.                             |
| 422         | ValidationFailed               | Validation error occured when trying to save or update the language. |
| 500         | InternalServerError            | Internal server error.                                               |

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
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/language"
        },
        "languages": [
            {
                "href": "https://api.umbraco.io/language/en-US"
            },
            {
                "href": "https://api.umbraco.io/language/da-DK"
            }
        ]
    },
    "_embedded": {
        "languages": [
            {
                "isoCode": "en-US",
                "cultureName": "English (United States)",
                "isDefault": true,
                "isMandatory": false,
                "_createDate": "0001-01-01T00:00:00Z",
                "_id": "2a8adac1-c405-4de8-997b-cacc68f75dd2",
                "_updateDate": "0001-01-01T00:00:00Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/language/en-US"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/language"
                    }
                }
            },
            {
                "isoCode": "da-DK",
                "cultureName": "Danish",
                "isDefault": false,
                "isMandatory": false,
                "_createDate": "0001-01-01T00:00:00Z",
                "_id": "afe0b0d0-7bb9-4b1b-b4f3-3c2b5d14c4cc",
                "_updateDate": "0001-01-01T00:00:00Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/language/da-DK"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/language"
                    }
                }
            }
        ]
    }
}
```

## Get by ISO code

Get a specific langauge by its ISO code.

**URL**: `/language/{id}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "isoCode": "en-US",
    "cultureName": "English (United States)",
    "isDefault": true,
    "isMandatory": false,
    "_createDate": "0001-01-01T00:00:00Z",
    "_id": "d29bb164-7afb-471f-b49f-81c91200b56c",
    "_updateDate": "0001-01-01T00:00:00Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/language/en-US"
        },
        "root": {
            "href": "https://api.umbraco.io/language"
        }
    }
}
```

## Create language

Create a new language for use on content.

{% hint style="info" %}
The number of languages that can be created is determined by the [pricing tier](https://umbraco.com/products/umbraco-heartcore/pricing/).
{% endhint %}

**URL**: `/language`

**Method**: `POST`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Request

```json
{
    "isoCode": "da-DK",
    "cultureName": "Danish",
    "isDefault": false,
    "isMandatory": false
}
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
    "isoCode": "da-DK",
    "cultureName": "Danish",
    "isDefault": false,
    "isMandatory": false,
    "_createDate": "2019-10-10T11:39:57.270409Z",
    "_id": "4cb6b2c5-0de4-42c9-bcfc-a86f58eb8763",
    "_updateDate": "2019-10-10T11:39:57.270409Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/language/da-DK"
        },
        "root": {
            "href": "https://api.umbraco.io/language"
        }
    }
}
```

## Update language

Updates an existing language.

**URL**: `/language/{id}`

**Method**: `PUT`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Request

```json
{
    "isoCode": "da-DK",
    "cultureName": "Danish",
    "isDefault": false,
    "isMandatory": true
}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "isoCode": "da-DK",
    "cultureName": "Danish",
    "isDefault": false,
    "isMandatory": true,
    "_createDate": "2019-10-10T11:39:57.270409Z",
    "_id": "4cb6b2c5-0de4-42c9-bcfc-a86f58eb8763",
    "_updateDate": "2019-10-10T11:39:57.270409Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/language/da-DK"
        },
        "root": {
            "href": "https://api.umbraco.io/language"
        }
    }
}
```

## Delete language

Deletes an existing language.

{% hint style="info" %}
Deleting a language that is in use will result in setting the content based on this language to `invariant`.
{% endhint %}

**URL**: `/language/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

`DELETE https://api.umbraco.io/language/da-DK`

```json
{
    "isoCode": "da-DK",
    "cultureName": "Danish",
    "isDefault": false,
    "isMandatory": false,
    "_createDate": "0001-01-01T00:00:00Z",
    "_id": "afe0b0d0-7bb9-4b1b-b4f3-3c2b5d14c4cc",
    "_updateDate": "0001-01-01T00:00:00Z",
    "_deleteDate": "2019-10-10T11:43:16.0824903Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/language/da-DK"
        },
        "root": {
            "href": "https://api.umbraco.io/language"
        }
    }
}
```
