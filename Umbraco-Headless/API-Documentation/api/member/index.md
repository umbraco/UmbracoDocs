# Content Management API for Members

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

## Create member

## Update member

## Delete member

## Add member to member group

## Remove member from member group