# Content Delivery API for Media

**BASE URL**: `https://cdn.umbraco.io`

## Table of Contents
* [Common Headers](#common-headers)
* [Errors](#errors)
* [Get Root Media](#get-root-media)
* [Get By Id](#get-by-id)
* [Get Children](#get-children)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code          | Message                                         |
| ----------- | ------------------- | ----------------------------------------------- |
| 401         | Unauthorized        | Authorization has been denied for this request. |
| 404         | NotFound            | Media with id '{id}' could not be found.        |
| 500         | InternalServerError | Internal server error.                          |

**JSON example**:

```json
{
  "error": {
    "code": "NotFound",
    "message": "Media with id 'b6f11172-373f-4473-af0f-0b0e5aefd21c' could not be found."
  }
}
```

## Get root media

Get all media at the root of the tree.

**URL**: `/media`

**Method**: `GET`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://cdn.umbraco.io/media"
        },
        "media": [
            {
                "href": "https://cdn.umbraco.io/media/b6f11172-373f-4473-af0f-0b0e5aefd21c"
            },
            {
                "href": "https://cdn.umbraco.io/media/1fd2ecaf-f371-4c00-9306-867fa4585e7a"
            },
            {
                "href": "https://cdn.umbraco.io/media/6d5bf746-cb82-45c5-bd15-dd3798209b87"
            }
        ]
    },
    "_embedded": {
        "media": [
            {
                "_creatorName": "Rasmus",
                "_url": "",
                "_writerName": "Rasmus",
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-06-17T13:46:41.47Z",
                "_id": "b6f11172-373f-4473-af0f-0b0e5aefd21c",
                "_updateDate": "2019-06-17T13:46:41.47Z",
                "_links": {
                    "self": {
                        "href": "https://cdn.umbraco.io/media/b6f11172-373f-4473-af0f-0b0e5aefd21c"
                    }
                },
                "mediaTypeAlias": "Folder",
                "name": "Design",
                "sortOrder": 1
            },
            {
                "_creatorName": "Rasmus",
                "_url": "",
                "_writerName": "Rasmus",
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-06-17T13:46:41.64Z",
                "_id": "1fd2ecaf-f371-4c00-9306-867fa4585e7a",
                "_updateDate": "2019-06-17T13:46:41.64Z",
                "_links": {
                    "self": {
                        "href": "https://cdn.umbraco.io/media/1fd2ecaf-f371-4c00-9306-867fa4585e7a"
                    }
                },
                "mediaTypeAlias": "Folder",
                "name": "People",
                "sortOrder": 1
            },
            {
                "_creatorName": "Rasmus",
                "_url": "",
                "_writerName": "Rasmus",
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-06-17T13:46:41.783Z",
                "_id": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
                "_updateDate": "2019-06-17T13:46:41.783Z",
                "_links": {
                    "self": {
                        "href": "https://cdn.umbraco.io/media/6d5bf746-cb82-45c5-bd15-dd3798209b87"
                    }
                },
                "mediaTypeAlias": "Folder",
                "name": "Products",
                "sortOrder": 1
            }
        ]
    }
}
```

## Get by id

Get a single media by its ID.

**URL**: `/media/{id}`

**Method**: `GET`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_creatorName": "Rasmus",
    "_url": "https://media.umbraco.io/my-headless-site/media/662af6ca411a4c93a6c722c4845698e7/00000006000000000000000000000000/16403439029_f500be349b_o.jpg",
    "_writerName": "Rasmus",
    "_hasChildren": false,
    "_level": 2,
    "_createDate": "2019-06-17T13:46:42.203Z",
    "_id": "662af6ca-411a-4c93-a6c7-22c4845698e7",
    "_updateDate": "2019-06-17T13:46:42.203Z",
    "_links": {
        "self": {
            "href": "https://cdn.umbraco.io/media/662af6ca-411a-4c93-a6c7-22c4845698e7"
        },
        "root": {
            "href": "https://cdn.umbraco.io/media"
        },
        "children": {
            "href": "https://cdn.umbraco.io/media/662af6ca-411a-4c93-a6c7-22c4845698e7/children"
        },
        "parent": {
            "href": "https://cdn.umbraco.io/media/b6f11172-373f-4473-af0f-0b0e5aefd21c"
        }
    },
    "mediaTypeAlias": "Image",
    "name": "Umbraco Campari Meeting Room",
    "parentId": "b6f11172-373f-4473-af0f-0b0e5aefd21c",
    "sortOrder": 0,
    "umbracoFile": {
        "src": "/media/662af6ca411a4c93a6c722c4845698e7/00000006000000000000000000000000/16403439029_f500be349b_o.jpg",
        "focalPoint": null,
        "crops": null
    },
    "umbracoWidth": 1600,
    "umbracoHeight": 1067,
    "umbracoBytes": 759116,
    "umbracoExtension": "jpg"
}
```

## Get children

Get children of a single media.

**URL**: `/media/{id}/children`

**Method**: `GET`

**Query Strings**

```none
?page={integer=1}
?pageSize={integer=10}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_totalItems": 1,
    "_totalPages": 1,
    "_page": 1,
    "_pageSize": 10,
    "_links": {
        "self": {
            "href": "https://cdn.umbraco.io/media/b6f11172-373f-4473-af0f-0b0e5aefd21c/children?page=1"
        },
        "page": {
            "href": "https://cdn.umbraco.io/media/{id}/children{?page,pageSize}",
            "templated": true
        },
        "root": {
            "href": "https://cdn.umbraco.io/media"
        },
        "media": {
            "href": "https://cdn.umbraco.io/media/662af6ca-411a-4c93-a6c7-22c4845698e7"
        }
    },
    "_embedded": {
        "media": [
            {
                "_creatorName": "Rasmus",
                "_url": "https://media.umbraco.io/my-headless-site/media/662af6ca411a4c93a6c722c4845698e7/00000006000000000000000000000000/16403439029_f500be349b_o.jpg",
                "_writerName": "Rasmus",
                "_contentTypeAlias": "Image",
                "_createDate": "2019-06-17T13:46:42.203Z",
                "_updateDate": "2019-06-17T13:46:42.203Z",
                "_hasChildren": false,
                "_id": "662af6ca-411a-4c93-a6c7-22c4845698e7",
                "_level": 2,
                "_name": "Umbraco Campari Meeting Room",
                "_parentId": "b6f11172-373f-4473-af0f-0b0e5aefd21c",
                "_sortOrder": 0,
                "_links": {
                    "self": {
                        "href": "https://cdn.umbraco.io/media/662af6ca-411a-4c93-a6c7-22c4845698e7"
                    },
                    "root": {
                        "href": "https://cdn.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://cdn.umbraco.io/media/662af6ca-411a-4c93-a6c7-22c4845698e7/children"
                    }
                },
                "umbracoFile": {
                    "src": "/media/662af6ca411a4c93a6c722c4845698e7/00000006000000000000000000000000/16403439029_f500be349b_o.jpg",
                    "focalPoint": null,
                    "crops": null
                },
                "umbracoWidth": 1600,
                "umbracoHeight": 1067,
                "umbracoBytes": 759116,
                "umbracoExtension": "jpg"
            }
        ]
    }
}
```
