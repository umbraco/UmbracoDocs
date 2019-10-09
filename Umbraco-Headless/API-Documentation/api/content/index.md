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

Gets all content at the root of the tree, which the authorized user has access to according to the 'Start node'-permissions.

**URL**: `/content`

**Method**: `GET`

## Get by id

## Get children

## Create content

## Update content

## Publish content

## Unpublish content

## Delete content