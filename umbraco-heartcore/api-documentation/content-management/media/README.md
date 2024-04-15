# Media

**BASE URL**: `https://api.umbraco.io`

## Table of Contents

* [Common Headers](./#common-headers)
* [Authentication](./#authentication)
* [Errors](./#errors)
* [Get root media](./#get-root-media)
* [Get by id](./#get-by-id)
* [Get children](./#get-children)
* [Create media](./#create-media)
* [Update media](./#update-media)
* [Delete media](./#delete-media)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Authentication

Auth is required for this API meaning that you must supply a Bearer Token via an Authorization header or an API Key via an Authorization or Api-Key header.

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code          | Message                                                                |
| ----------- | ------------------- | ---------------------------------------------------------------------- |
| 400         | BadRequest          | Body cannot be empty.                                                  |
| 401         | Unauthorized        | Authorization has been denied for this request.                        |
| 403         | Forbidden           | You are not authorized to access the given resource.                   |
| 404         | NotFound            | Media with id '{id}' could not be found.                               |
| 422         | ValidationFailed    | Validation error occured when trying to save or update the media item. |
| 500         | InternalServerError | Internal server error.                                                 |

**JSON example**:

```json
{
  "error": {
    "code": "Unauthorized",
    "message": "Authorization has been denied for this request."
  }
}
```

## Get root media

Get all media at the root of the tree, which the authorized user has access to according to the 'Start node'-permissions.

**URL**: `/media`

**Method**: `GET`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media"
        },
        "media": [
            {
                "href": "https://api.umbraco.io/media/{id}",
                "templated": true
            },
            {
                "href": "https://api.umbraco.io/media/7bfa2332-cf7f-4c97-941d-50f43f085b06"
            },
            {
                "href": "https://api.umbraco.io/media/bff96d2a-18a7-4d72-b788-72e2034a5514"
            },
            {
                "href": "https://api.umbraco.io/media/9924b6e9-51fd-4686-ad9a-cb59dbe9b4b1"
            }
        ],
        "children": {
            "href": "https://api.umbraco.io/media/{id}/children{?page,pageSize}",
            "templated": true
        },
        "mediatype": {
            "href": "https://api.umbraco.io/media/type/{alias}",
            "templated": true
        }
    },
    "_embedded": {
        "media": [
            {
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-10-04T11:46:06.653Z",
                "_id": "7bfa2332-cf7f-4c97-941d-50f43f085b06",
                "_updateDate": "2019-10-04T11:46:06.653Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/7bfa2332-cf7f-4c97-941d-50f43f085b06"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/7bfa2332-cf7f-4c97-941d-50f43f085b06/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Folder"
                    }
                },
                "mediaTypeAlias": "Folder",
                "name": "Design",
                "sortOrder": 1
            },
            {
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-10-04T11:46:14.32Z",
                "_id": "bff96d2a-18a7-4d72-b788-72e2034a5514",
                "_updateDate": "2019-10-04T11:46:14.32Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/bff96d2a-18a7-4d72-b788-72e2034a5514"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/bff96d2a-18a7-4d72-b788-72e2034a5514/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Folder"
                    }
                },
                "mediaTypeAlias": "Folder",
                "name": "People",
                "sortOrder": 2
            },
            {
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-10-04T11:46:21.433Z",
                "_id": "9924b6e9-51fd-4686-ad9a-cb59dbe9b4b1",
                "_updateDate": "2019-10-04T11:46:21.433Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/9924b6e9-51fd-4686-ad9a-cb59dbe9b4b1"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/9924b6e9-51fd-4686-ad9a-cb59dbe9b4b1/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Folder"
                    }
                },
                "mediaTypeAlias": "Folder",
                "name": "Products",
                "sortOrder": 3
            }
        ]
    }
}
```

## Get by id

Get specific media item by its GUID ID.

**URL**: `/media/{id}`

**Method**: `GET`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_hasChildren": false,
    "_level": 2,
    "_createDate": "2019-10-04T13:08:52.203Z",
    "_id": "f2311d74-bc19-465b-8028-4af79f47f155",
    "_updateDate": "2019-10-04T13:08:52.203Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/f2311d74-bc19-465b-8028-4af79f47f155"
        },
        "root": {
            "href": "https://api.umbraco.io/media"
        },
        "children": {
            "href": "https://api.umbraco.io/media/f2311d74-bc19-465b-8028-4af79f47f155/children"
        },
        "mediatype": {
            "href": "https://api.umbraco.io/media/type/Image"
        }
    },
    "mediaTypeAlias": "Image",
    "name": "Banjo",
    "parentId": "9924b6e9-51fd-4686-ad9a-cb59dbe9b4b1",
    "sortOrder": 4,
    "umbracoFile": {
        "src": "/media/oiodd2qz/7373036290_5e8420bf36_b.jpg",
        "focalPoint": {
            "left": 0.5,
            "top": 0.5
        },
        "crops": null
    },
    "umbracoWidth": "1024",
    "umbracoHeight": "683",
    "umbracoBytes": "299546",
    "umbracoExtension": "jpg"
}
```

## Get children

Get a list of children (media items) by their parent GUID ID.

**URL**: `/media/{id}/children`

**Method**: `GET`

**Query Strings**

```
?page={integer=1}
?pageSize={integer=10}
```

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_totalItems": 5,
    "_totalPages": 1,
    "_page": 1,
    "_pageSize": 10,
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/bff96d2a-18a7-4d72-b788-72e2034a5514/children?page=1"
        },
        "media": [
            {
                "href": "https://api.umbraco.io/media/b0d9704a-8c1a-498f-8892-d3a18acc6f01"
            },
            {
                "href": "https://api.umbraco.io/media/3bc8bf5c-5f39-4a49-b8f3-a09c265aa739"
            },
            {
                "href": "https://api.umbraco.io/media/9b4a8092-a157-4a0e-9626-1f320a7a5f79"
            },
            {
                "href": "https://api.umbraco.io/media/9012c147-90dc-4c7e-8249-4b4092aff340"
            },
            {
                "href": "https://api.umbraco.io/media/313bf02d-bfba-4d61-a12c-1fbdbe0fee1c"
            }
        ]
    },
    "_embedded": {
        "media": [
            {
                "_hasChildren": false,
                "_level": 2,
                "_createDate": "2019-10-04T11:49:57.863Z",
                "_id": "b0d9704a-8c1a-498f-8892-d3a18acc6f01",
                "_updateDate": "2019-10-04T11:49:57.863Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/b0d9704a-8c1a-498f-8892-d3a18acc6f01"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/b0d9704a-8c1a-498f-8892-d3a18acc6f01/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Image"
                    }
                },
                "mediaTypeAlias": "Image",
                "name": "Jan Skovgaard",
                "parentId": "bff96d2a-18a7-4d72-b788-72e2034a5514",
                "sortOrder": 0,
                "umbracoFile": {
                    "src": "/media/jryntma0/18720470241_ff77768544_h.jpg",
                    "focalPoint": {
                        "left": 0.5,
                        "top": 0.5
                    },
                    "crops": null
                },
                "umbracoWidth": "1600",
                "umbracoHeight": "1067",
                "umbracoBytes": "240126",
                "umbracoExtension": "jpg"
            },
            {
                "_hasChildren": false,
                "_level": 2,
                "_createDate": "2019-10-04T11:50:12.933Z",
                "_id": "3bc8bf5c-5f39-4a49-b8f3-a09c265aa739",
                "_updateDate": "2019-10-04T11:50:12.933Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/3bc8bf5c-5f39-4a49-b8f3-a09c265aa739"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/3bc8bf5c-5f39-4a49-b8f3-a09c265aa739/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Image"
                    }
                },
                "mediaTypeAlias": "Image",
                "name": "Matt Brailsford",
                "parentId": "bff96d2a-18a7-4d72-b788-72e2034a5514",
                "sortOrder": 1,
                "umbracoFile": {
                    "src": "/media/lk5nqozz/18531852339_981b067419_h.jpg",
                    "focalPoint": {
                        "left": 0.5,
                        "top": 0.5
                    },
                    "crops": null
                },
                "umbracoWidth": "1600",
                "umbracoHeight": "1067",
                "umbracoBytes": "438249",
                "umbracoExtension": "jpg"
            },
            {
                "_hasChildren": false,
                "_level": 2,
                "_createDate": "2019-10-04T11:57:36.863Z",
                "_id": "9b4a8092-a157-4a0e-9626-1f320a7a5f79",
                "_updateDate": "2019-10-04T11:57:36.863Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/9b4a8092-a157-4a0e-9626-1f320a7a5f79"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/9b4a8092-a157-4a0e-9626-1f320a7a5f79/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Image"
                    }
                },
                "mediaTypeAlias": "Image",
                "name": "Lee Kelleher",
                "parentId": "bff96d2a-18a7-4d72-b788-72e2034a5514",
                "sortOrder": 2,
                "umbracoFile": {
                    "src": "/media/ssaevg0x/18531854019_351c579559_h.jpg",
                    "focalPoint": {
                        "left": 0.5,
                        "top": 0.5
                    },
                    "crops": null
                },
                "umbracoWidth": "1600",
                "umbracoHeight": "1067",
                "umbracoBytes": "324821",
                "umbracoExtension": "jpg"
            },
            {
                "_hasChildren": false,
                "_level": 2,
                "_createDate": "2019-10-04T11:57:56.267Z",
                "_id": "9012c147-90dc-4c7e-8249-4b4092aff340",
                "_updateDate": "2019-10-04T11:57:56.267Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/9012c147-90dc-4c7e-8249-4b4092aff340"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/9012c147-90dc-4c7e-8249-4b4092aff340/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Image"
                    }
                },
                "mediaTypeAlias": "Image",
                "name": "Jeavon Leopold",
                "parentId": "bff96d2a-18a7-4d72-b788-72e2034a5514",
                "sortOrder": 3,
                "umbracoFile": {
                    "src": "/media/ihabfeg2/18095416144_44a566a5f4_h.jpg",
                    "focalPoint": {
                        "left": 0.5,
                        "top": 0.5
                    },
                    "crops": null
                },
                "umbracoWidth": "1600",
                "umbracoHeight": "1067",
                "umbracoBytes": "348162",
                "umbracoExtension": "jpg"
            },
            {
                "_hasChildren": false,
                "_level": 2,
                "_createDate": "2019-10-04T11:58:15.54Z",
                "_id": "313bf02d-bfba-4d61-a12c-1fbdbe0fee1c",
                "_updateDate": "2019-10-04T11:58:15.54Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/media/313bf02d-bfba-4d61-a12c-1fbdbe0fee1c"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/media"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/media/313bf02d-bfba-4d61-a12c-1fbdbe0fee1c/children"
                    },
                    "mediatype": {
                        "href": "https://api.umbraco.io/media/type/Image"
                    }
                },
                "mediaTypeAlias": "Image",
                "name": "Jeroen Breuer",
                "parentId": "bff96d2a-18a7-4d72-b788-72e2034a5514",
                "sortOrder": 4,
                "umbracoFile": {
                    "src": "/media/fpydwmn0/18530280048_459b8b61b2_h.jpg",
                    "focalPoint": {
                        "left": 0.5,
                        "top": 0.5
                    },
                    "crops": null
                },
                "umbracoWidth": "1600",
                "umbracoHeight": "1067",
                "umbracoBytes": "240519",
                "umbracoExtension": "jpg"
            }
        ]
    }
}
```

## Create media

Create a new media item and optionally upload a file to the created item.

Media can be created by sending a POST request to the media endpoint. The request body should contain the media item properties and the file to upload. The file is sent as a multi-part request. The first `MultipartBoundary` contains the JSON body describing the content for the image. The second `MultipartBoundary` contains the file. If the media item does not contain a file you can send a regular JSON request to create the media.

The `umbracoFile.src` property in the first `MultipartBoundary`'s JSON body defines the name of the file to be uploaded. The `fileName` in the second `MultipartBoundary` must match the `umbracoFile.src` property's value.

{% hint style="info" %}
Different media property editors will require different request body formats.The File Upload property editor has the file name as the value `"umbracoFile": FILE_NAME`, and the Image Cropper property editor expects a JSON value `"umbracoFile": { "src": FILE_NAME }`. To verify the JSON structure you can manually upload the media file via the backoffice and fetch the data. It can then be used for reference. (See how in the [Creating Content with Media](../../../tutorials/creating-content-with-media.md) tutorial.)
{% endhint %}

**URL**: `/media`

**Method**: `POST`

**Header**: `Content-Type: multipart/form-data; boundary=MultipartBoundry`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Request

```http
--MultipartBoundary
Content-Disposition: form-data; name="content"
Content-Type: application/json

{
    "mediaTypeAlias": "Image",
    "name": "Han Solo",
    "parentId": "7bfa2332-cf7f-4c97-941d-50f43f085b06",
    "umbracoFile": { "src": "han-solo.png" }
}
--MultipartBoundary
Content-Disposition: form-data; name="umbracoFile"; fileName="han-solo.png"
Content-Type: image/png

BINARY DATA
--MultipartBoundary--
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
    "_hasChildren": false,
    "_level": 2,
    "_createDate": "2019-10-10T12:24:58.76Z",
    "_id": "b60a1257-4bef-4d5a-aeb6-4af17b6233b2",
    "_updateDate": "2019-10-10T12:24:58.76Z",
    "_deleteDate": "2019-10-10T12:25:15.3860527Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2"
        },
        "root": {
            "href": "https://api.umbraco.io/media"
        },
        "children": {
            "href": "https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2/children"
        },
        "mediatype": {
            "href": "https://api.umbraco.io/media/type/Image"
        }
    },
    "mediaTypeAlias": "Image",
    "name": "Han Solo",
    "parentId": "7bfa2332-cf7f-4c97-941d-50f43f085b06",
    "sortOrder": 1,
    "umbracoFile": {
        "src": "/media/kejavnxp/han-solo.png",
        "focalPoint": {
            "left": 0.5,
            "top": 0.5
        },
        "crops": null
    },
    "umbracoWidth": "672",
    "umbracoHeight": "896",
    "umbracoBytes": "489855",
    "umbracoExtension": "png"
}
```

## Update media

Updates an existing media item and optionally uploads a file to the updated item.

Media would typically contain an upload field (the `Image` and `File` media types has this by default), which means it is possible to send a file along with the request to update an existing media item. This is done by sending a multi-part request with the JSON body and the file. If the media item does not contain a file you can send a regular JSON request to update the media.

**URL**: `/media/{id}`

**Method**: `PUT`

**Header**: `Content-Type: multipart/form-data; boundary=MultipartBoundry`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Request

```http
Content-Type: multipart/form-data; boundary=MultipartBoundry

--MultipartBoundry
Content-Disposition: form-data; name="content"
Content-Type: application/json

{
    "mediaTypeAlias": "Image",
    "name": "Han Solo",
    "parentId": "7bfa2332-cf7f-4c97-941d-50f43f085b06",
    "sortOrder": 1,
    "umbracoFile": { "src": "han-solo.png" }
}
--MultipartBoundry
Content-Disposition: form-data; name="umbracoFile"
Content-Type: image/png

BINARY DATA
--MultipartBoundry--
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_hasChildren": false,
    "_level": 2,
    "_createDate": "2019-10-10T12:24:58.76Z",
    "_id": "b60a1257-4bef-4d5a-aeb6-4af17b6233b2",
    "_updateDate": "2019-10-10T12:24:58.76Z",
    "_deleteDate": "2019-10-10T12:25:15.3860527Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2"
        },
        "root": {
            "href": "https://api.umbraco.io/media"
        },
        "children": {
            "href": "https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2/children"
        },
        "mediatype": {
            "href": "https://api.umbraco.io/media/type/Image"
        }
    },
    "mediaTypeAlias": "Image",
    "name": "Han Solo",
    "parentId": "7bfa2332-cf7f-4c97-941d-50f43f085b06",
    "sortOrder": 1,
    "umbracoFile": {
        "src": "/media/kejavnxp/han-solo.png",
        "focalPoint": {
            "left": 0.5,
            "top": 0.5
        },
        "crops": null
    },
    "umbracoWidth": "672",
    "umbracoHeight": "896",
    "umbracoBytes": "489855",
    "umbracoExtension": "png"
}
```

## Delete media

Delete a media item. This will also delete any file that is attached to the media item.

**URL**: `/media/{id}`

**Method**: `DELETE`

**Permissions required** : Access to Media section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

`DELETE https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2`

```json
{
    "_hasChildren": false,
    "_level": 2,
    "_createDate": "2019-10-10T12:24:58.76Z",
    "_id": "b60a1257-4bef-4d5a-aeb6-4af17b6233b2",
    "_updateDate": "2019-10-10T12:24:58.76Z",
    "_deleteDate": "2019-10-10T12:25:15.3860527Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2"
        },
        "root": {
            "href": "https://api.umbraco.io/media"
        },
        "children": {
            "href": "https://api.umbraco.io/media/b60a1257-4bef-4d5a-aeb6-4af17b6233b2/children"
        },
        "mediatype": {
            "href": "https://api.umbraco.io/media/type/Image"
        }
    },
    "mediaTypeAlias": "Image",
    "name": "Han Solo",
    "parentId": "7bfa2332-cf7f-4c97-941d-50f43f085b06",
    "sortOrder": 1,
    "umbracoFile": {
        "src": "/media/kejavnxp/han-solo.png",
        "focalPoint": {
            "left": 0.5,
            "top": 0.5
        },
        "crops": null
    },
    "umbracoWidth": "672",
    "umbracoHeight": "896",
    "umbracoBytes": "489855",
    "umbracoExtension": "png"
}
```
