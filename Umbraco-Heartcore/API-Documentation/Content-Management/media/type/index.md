# Content Management API for Media Types

**BASE URL**: `https://api.umbraco.io`


## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get all Media Types](#get-all-media-types)
* [Get by alias](#get-by-alias)

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
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Media Type with alias '{alias}' could not be found.                      |
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

## Get all Media Types

Get a list of all available Media Types.

**URL**: `/media/type`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/type"
        },
        "root": {
            "href": "https://api.umbraco.io/media/type"
        },
        "mediatypes": [
            {
                "href": "https://api.umbraco.io/media/type/Folder"
            },
            {
                "href": "https://api.umbraco.io/media/type/Image"
            },
            {
                "href": "https://api.umbraco.io/media/type/File"
            }
        ]
    },
    "_embedded": {
        "mediatypes": [
            {
                "alias": "Folder",
                "compositions": [],
                "groups": [],
                "name": "Folder",
                "_createDate": "2019-09-20T12:07:43.973Z",
                "_id": "f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d",
                "_updateDate": "2019-09-20T12:07:43.973Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/type/Folder"
                    }
                }
            },
            {
                "alias": "Image",
                "compositions": [],
                "groups": [
                    {
                        "name": "Image",
                        "sortOrder": 1,
                        "properties": [
                            {
                                "alias": "umbracoFile",
                                "label": "Upload image",
                                "propertyEditorAlias": "Umbraco.ImageCropper",
                                "sortOrder": 0,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "alias": "umbracoWidth",
                                "description": "in pixels",
                                "label": "Width",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "alias": "umbracoHeight",
                                "description": "in pixels",
                                "label": "Height",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "alias": "umbracoBytes",
                                "description": "in bytes",
                                "label": "Size",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 3,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "alias": "umbracoExtension",
                                "label": "Type",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 4,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Image",
                "_createDate": "2019-09-20T12:07:43.973Z",
                "_id": "cc07b313-0843-4aa8-bbda-871c8da728c8",
                "_updateDate": "2019-09-20T12:07:43.973Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/type/Image"
                    }
                }
            },
            {
                "alias": "File",
                "compositions": [],
                "groups": [
                    {
                        "name": "File",
                        "sortOrder": 1,
                        "properties": [
                            {
                                "alias": "umbracoFile",
                                "label": "Upload file",
                                "propertyEditorAlias": "Umbraco.UploadField",
                                "sortOrder": 0,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "alias": "umbracoExtension",
                                "label": "Type",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "alias": "umbracoBytes",
                                "description": "in bytes",
                                "label": "Size",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "File",
                "_createDate": "2019-09-20T12:07:43.973Z",
                "_id": "4c52d8ab-54e6-40cd-999c-7a5f24903e4d",
                "_updateDate": "2019-09-20T12:07:43.973Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/type/File"
                    }
                }
            }
        ]
    }
}
```

## Get by alias

Get a specific Media Type by its alias.

**URL**: `/media/type/{alias}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "alias": "Image",
    "compositions": [],
    "groups": [
        {
            "name": "Image",
            "sortOrder": 1,
            "properties": [
                {
                    "alias": "umbracoFile",
                    "label": "Upload image",
                    "propertyEditorAlias": "Umbraco.ImageCropper",
                    "sortOrder": 0,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "alias": "umbracoWidth",
                    "description": "in pixels",
                    "label": "Width",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 1,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "alias": "umbracoHeight",
                    "description": "in pixels",
                    "label": "Height",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 2,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "alias": "umbracoBytes",
                    "description": "in bytes",
                    "label": "Size",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 3,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "alias": "umbracoExtension",
                    "label": "Type",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 4,
                    "validation": {
                        "required": false
                    }
                }
            ]
        }
    ],
    "name": "Image",
    "_createDate": "2019-09-20T12:07:43.973Z",
    "_id": "cc07b313-0843-4aa8-bbda-871c8da728c8",
    "_updateDate": "2019-09-20T12:07:43.973Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/type/Image"
        }
    }
}
```
