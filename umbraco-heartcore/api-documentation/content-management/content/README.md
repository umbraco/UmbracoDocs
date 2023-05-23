# Content

**BASE URL**: `https://api.umbraco.io`

## Table of Contents

* [Common Headers](./#common-headers)
* [Authentication](./#authentication)
* [Permissions](./#permissions)
* [Errors](./#errors)
* [Get Root Content](./#get-root-content)
* [Get By Id](./#get-by-id)
* [Get Children](./#get-children)
* [Create Content](./#create-content)
* [Create Content with Files](./#create-content-with-files)
* [Update Content](./#update-content)
* [Publish Content](./#publish-content)
* [Unpublish Content](./#unpublish-content)
* [Delete Content](./#delete-content)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Authentication

Authentication is required for this API meaning that you must supply a Bearer Token via an Authorization header or an API Key via an Authorization or Api-Key header.

## Permissions

In addition to the specific permissions listed under each endpoint, all requests requires:

* Access to the Content Section of the Umbraco Backoffice and
* That the content being accessed is beneath the users start node configured in Umbraco

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code          | Message                                                                  |
| ----------- | ------------------- | ------------------------------------------------------------------------ |
| 400         | BadRequest          | Body cannot be empty.                                                    |
| 401         | Unauthorized        | Authorization has been denied for this request.                          |
| 403         | Forbidden           | You are not authorized to access the given resource.                     |
| 404         | NotFound            | Content with id '{id}' could not be found.                               |
| 422         | ValidationFailed    | Validation error occured when trying to save or update the content item. |
| 500         | InternalServerError | Internal server error.                                                   |

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

**Permissions required** : `Browse Node`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content"
        },
        "content": [
            {
                "href": "https://api.umbraco.io/content/{id}",
                "templated": true
            },
            {
                "href": "https://api.umbraco.io/content/6eb240ce-8f78-4467-ab51-68918cde2866"
            }
        ],
        "children": {
            "href": "https://api.umbraco.io/content/{id}/children{?page,pageSize}",
            "templated": true
        },
        "publish": {
            "href": "https://api.umbraco.io/content/{id}/publish{?culture}",
            "templated": true
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/{id}/unpublish{?culture}",
            "templated": true
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/{alias}",
            "templated": true
        }
    },
    "_embedded": {
        "content": [
            {
                "_currentVersionState": {
                    "$invariant": "PUBLISHED"
                },
                "name": {
                    "$invariant": "Home"
                },
                "_updateDate": {
                    "$invariant": "2019-10-07T07:58:48.477Z"
                },
                "_hasChildren": true,
                "_level": 1,
                "_createDate": "2019-10-07T07:45:21.363Z",
                "_id": "6eb240ce-8f78-4467-ab51-68918cde2866",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/6eb240ce-8f78-4467-ab51-68918cde2866"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/content/6eb240ce-8f78-4467-ab51-68918cde2866/children"
                    },
                    "publish": {
                        "href": "https://api.umbraco.io/content/6eb240ce-8f78-4467-ab51-68918cde2866/publish"
                    },
                    "unpublish": {
                        "href": "https://api.umbraco.io/content/6eb240ce-8f78-4467-ab51-68918cde2866/unpublish"
                    },
                    "contenttype": {
                        "href": "https://api.umbraco.io/content/type/home"
                    }
                },
                "contentTypeAlias": "home",
                "sortOrder": 4,
                "heroHeader": {
                    "$invariant": "Umbraco Demo"
                },
                "heroDescription": {
                    "$invariant": "Moonfish, steelhead, lamprey southern flounder tadpole fish sculpin bigeye, blue-redstripe danio collared dogfish. Smalleye squaretail goldfish arowana butterflyfish pipefish wolf-herring jewel tetra, shiner; gibberfish red velvetfish. Thornyhead yellowfin pike threadsail ayu cutlassfish."
                },
                "heroCTACaption": {
                    "$invariant": "Check our products"
                },
                "heroCTALink": {
                    "$invariant": "umb://document/082333be34b14c2d81a6be92640094fc"
                },
                "bodyText": {
                    "$invariant": null
                },
                "footerHeader": {
                    "$invariant": "Umbraco Demo"
                },
                "footerDescription": {
                    "$invariant": "Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Vivamus suscipit tortor eget felis porttitor volutpat"
                },
                "footerCTACaption": {
                    "$invariant": "Read All on the Blog"
                },
                "footerCTALink": {
                    "$invariant": "umb://document/8007e923e62a4ac1a33fcaf3052582f4"
                },
                "footerAddress": {
                    "$invariant": "Umbraco HQ - Unicorn Square - Haubergsvej 1 - 5000 Odense C - Denmark - +45 70 26 11 62"
                },
                "heroBackgroundImage": {
                    "$invariant": "umb://media/76966940c9ba471686cef3854a7f5bd6"
                },
                "font": {
                    "$invariant": "serif"
                },
                "colorTheme": {
                    "$invariant": "earth"
                },
                "sitename": {
                    "$invariant": "Umbraco Sample Site"
                },
                "logo": {
                    "$invariant": ""
                }
            }
        ]
    }
}
```

## Get by id

Get specific content item by GUID ID. Includes all language variations.

**URL**: `/content/{id}`

**Method**: `GET`

**Permissions required** : `Browse Node`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_currentVersionState": {
        "$invariant": "PUBLISHED"
    },
    "name": {
        "$invariant": "Unicorn"
    },
    "_updateDate": {
        "$invariant": "2019-10-07T11:50:56.5Z"
    },
    "_hasChildren": false,
    "_level": 3,
    "_createDate": "2019-10-07T11:50:34.48Z",
    "_id": "3de82763-c4bb-4bca-8f79-7b211b3ffffa",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/3de82763-c4bb-4bca-8f79-7b211b3ffffa"
        },
        "root": {
            "href": "https://api.umbraco.io/content"
        },
        "children": {
            "href": "https://api.umbraco.io/content/3de82763-c4bb-4bca-8f79-7b211b3ffffa/children"
        },
        "publish": {
            "href": "https://api.umbraco.io/content/3de82763-c4bb-4bca-8f79-7b211b3ffffa/publish"
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/3de82763-c4bb-4bca-8f79-7b211b3ffffa/unpublish"
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/product"
        }
    },
    "contentTypeAlias": "product",
    "parentId": "082333be-34b1-4c2d-81a6-be92640094fc",
    "sortOrder": 0,
    "productName": {
        "$invariant": "Unicorn"
    },
    "price": {
        "$invariant": "249"
    },
    "category": {
        "$invariant": [
            "animals"
        ]
    },
    "description": {
        "$invariant": "Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Cras ultricies ligula sed magna dictum porta."
    },
    "sku": {
        "$invariant": "UMB-UNICORN"
    },
    "photos": {
        "$invariant": "umb://media/8199c666b05c4527b857b99bee2e0616"
    },
    "features": {
        "$invariant": ""
    },
    "bodyText": {
        "$invariant": null
    }
}
```

## Get children

Get a list of children (content items) by parent GUID ID. Includes all language variations per content item.

**URL**: `/content/{id}/children`

**Method**: `GET`

**Query Strings**

```
?page={integer=1}
?pageSize={integer=10}
```

**Permissions required** : `Browse Node`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_totalItems": 3,
    "_totalPages": 1,
    "_page": 1,
    "_pageSize": 10,
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/8007e923-e62a-4ac1-a33f-caf3052582f4/children?page=1"
        },
        "content": [
            {
                "href": "https://api.umbraco.io/content/e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5"
            },
            {
                "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
            },
            {
                "href": "https://api.umbraco.io/content/af3e08fc-fb90-4c78-b11c-c1a0cf43bd31"
            }
        ]
    },
    "_embedded": {
        "content": [
            {
                "_currentVersionState": {
                    "$invariant": "PUBLISHED"
                },
                "name": {
                    "$invariant": "This will be great"
                },
                "_updateDate": {
                    "$invariant": "2019-10-07T11:52:31.143Z"
                },
                "_hasChildren": false,
                "_level": 3,
                "_createDate": "2019-10-07T11:52:31.143Z",
                "_id": "e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/content/e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5/children"
                    },
                    "publish": {
                        "href": "https://api.umbraco.io/content/e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5/publish"
                    },
                    "unpublish": {
                        "href": "https://api.umbraco.io/content/e0c5f0e5-c1f0-4422-9ac0-6dbb536e8eb5/unpublish"
                    },
                    "contenttype": {
                        "href": "https://api.umbraco.io/content/type/blogpost"
                    }
                },
                "contentTypeAlias": "blogpost",
                "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
                "sortOrder": 0,
                "seoMetaDescription": {
                    "$invariant": ""
                },
                "keywords": {
                    "$invariant": []
                },
                "umbNaviHide": {
                    "$invariant": "0"
                },
                "pageTitle": {
                    "$invariant": "This will be great"
                },
                "categories": {
                    "$invariant": [
                        "great",
                        "umbraco"
                    ]
                },
                "excerpt": {
                    "$invariant": "Proin eget tortor risus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Vivamus magna justo, lacinia eget consectetur sed"
                },
                "bodyText": {
                    "$invariant": null
                }
            },
            {
                "_currentVersionState": {
                    "$invariant": "PUBLISHED"
                },
                "name": {
                    "$invariant": "Another one"
                },
                "_updateDate": {
                    "$invariant": "2019-10-07T11:53:09.653Z"
                },
                "_hasChildren": false,
                "_level": 3,
                "_createDate": "2019-10-07T11:53:09.653Z",
                "_id": "041067a0-74f5-4d03-92af-40c3c0aa13e7",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/children"
                    },
                    "publish": {
                        "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/publish"
                    },
                    "unpublish": {
                        "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/unpublish"
                    },
                    "contenttype": {
                        "href": "https://api.umbraco.io/content/type/blogpost"
                    }
                },
                "contentTypeAlias": "blogpost",
                "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
                "sortOrder": 0,
                "seoMetaDescription": {
                    "$invariant": ""
                },
                "keywords": {
                    "$invariant": []
                },
                "umbNaviHide": {
                    "$invariant": "0"
                },
                "pageTitle": {
                    "$invariant": "Another one"
                },
                "categories": {
                    "$invariant": [
                        "cg16",
                        "codegarden",
                        "umbraco"
                    ]
                },
                "excerpt": {
                    "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
                },
                "bodyText": {
                    "$invariant": "<p>Donec sollicitudin molestie malesuada. Proin eget tortor risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Nulla porttitor accumsan tincidunt. Donec rutrum congue leo eget malesuada.</p>\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Sed porttitor lectus nibh.</p>\n<p>Pellentesque in ipsum id orci porta dapibus. Curabitur aliquet quam id dui posuere blandit. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat.</p>"
                }
            },
            {
                "_currentVersionState": {
                    "$invariant": "PUBLISHED"
                },
                "name": {
                    "$invariant": "My Blog Post"
                },
                "_updateDate": {
                    "$invariant": "2019-10-07T11:54:00.657Z"
                },
                "_hasChildren": false,
                "_level": 3,
                "_createDate": "2019-10-07T11:54:00.657Z",
                "_id": "af3e08fc-fb90-4c78-b11c-c1a0cf43bd31",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/af3e08fc-fb90-4c78-b11c-c1a0cf43bd31"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content"
                    },
                    "children": {
                        "href": "https://api.umbraco.io/content/af3e08fc-fb90-4c78-b11c-c1a0cf43bd31/children"
                    },
                    "publish": {
                        "href": "https://api.umbraco.io/content/af3e08fc-fb90-4c78-b11c-c1a0cf43bd31/publish"
                    },
                    "unpublish": {
                        "href": "https://api.umbraco.io/content/af3e08fc-fb90-4c78-b11c-c1a0cf43bd31/unpublish"
                    },
                    "contenttype": {
                        "href": "https://api.umbraco.io/content/type/blogpost"
                    }
                },
                "contentTypeAlias": "blogpost",
                "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
                "sortOrder": 0,
                "seoMetaDescription": {
                    "$invariant": ""
                },
                "keywords": {
                    "$invariant": []
                },
                "umbNaviHide": {
                    "$invariant": "0"
                },
                "pageTitle": {
                    "$invariant": "My Blog Post"
                },
                "categories": {
                    "$invariant": [
                        "demo",
                        "umbraco",
                        "starterkit",
                        "lorem ipsum"
                    ]
                },
                "excerpt": {
                    "$invariant": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis lorem ut libero malesuada feugiat. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada."
                },
                "bodyText": {
                    "$invariant": "<div class=\"anyipsum-output\">\n<p>Bacon ipsum dolor amet alcatra pig cow sirloin. Jerky pig kielbasa, pork chop beef spare ribs sirloin. Ham hock sausage biltong meatball pastrami capicola boudin alcatra chicken. Salami kielbasa short ribs shoulder brisket tri-tip, cupim meatball pork chop capicola. Kielbasa short ribs strip steak t-bone frankfurter. Pancetta kevin salami, turducken landjaeger sausage pig.</p>\n<p>Sausage tongue doner short ribs tri-tip pork belly. Kielbasa swine bresaola salami pork short ribs ribeye jerky ground round boudin burgdoggen. Beef ribs ribeye flank biltong cupim andouille beef kielbasa meatloaf ham sausage. Pancetta chuck picanha short loin pork t-bone ball tip, boudin buffalo biltong chicken kevin.</p>\n<p>Salami cupim sirloin turducken pancetta ground round spare ribs. Ham hock capicola prosciutto salami meatball alcatra. Ribeye t-bone pancetta burgdoggen, pork chop beef ribs cupim meatball. Tail pork belly leberkas, frankfurter burgdoggen beef ribs bresaola fatback turducken flank picanha filet mignon. Pig bresaola pancetta venison cow.</p>\n<p>Ham drumstick cupim pork belly t-bone shoulder. Prosciutto flank ham filet mignon shank. Fatback shank capicola, buffalo pig bacon kevin corned beef jerky turkey pork belly venison. Pork belly drumstick beef ribs corned beef. Short loin meatloaf capicola spare ribs chuck burgdoggen. Shankle ground round cow, biltong hamburger t-bone leberkas turkey. Swine leberkas kielbasa hamburger sirloin bacon.</p>\n<p>Cow turducken buffalo alcatra filet mignon kevin pastrami tail. Jerky short loin boudin pork chop. Corned beef tri-tip picanha pork pig boudin capicola sirloin flank. Ham hock cupim prosciutto fatback.</p>\n</div>\n<div class=\"anyipsum-form-header\">Does your lorem ipsum text long for something a little meatier? Give our generator a try… it’s tasty!</div>"
                }
            }
        ]
    }
}
```

## Create content

Create a new content item with one or more language variations.

{% hint style="info" %}
All newly created content will be `DRAFT` by default. If you want to publish it you will need to issue a publish request as well.
{% endhint %}

**URL**: `/content`

**Method**: `POST`

**Permissions required** : `Create`

### Request

In this example only one language exists, so the properties are marked with `$invariant` in the create request. If multiple languages exists the culture for each of the languages would be defined for each of the properties - example: `"name": { "en-US": "Another one", "da-DK": "Endnu en" }`.

When a property uses a multinode treepicker editor it is worth noting that the value for said property should be a comma seperated list of Umbraco UDI Identifiers. In this example the UDI Identifiers are referencing content items. See the [UDI Identifiers](https://docs.umbraco.com/umbraco-cms/reference/querying/udi-identifiers) documentation to learn more. 

```json
{
    "name": {
        "$invariant": "Another one"
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "multinodeTreePicker": {
        "$invariant": "umb://document/067c7c926709487ab01be84168b333cf,umb://document/8a4dec90cf394028a743eae0729d47ba,umb://document/5fdd887233394a3492000bbf74e3b005"
    },
    "bodyText": {
        "$invariant": "<p>Donec sollicitudin molestie malesuada. Proin eget tortor risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Nulla porttitor accumsan tincidunt. Donec rutrum congue leo eget malesuada.</p>\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Sed porttitor lectus nibh.</p>\n<p>Pellentesque in ipsum id orci porta dapibus. Curabitur aliquet quam id dui posuere blandit. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat.</p>"
    }
}
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
    "_currentVersionState": {
        "$invariant": "DRAFT"
    },
    "name": {
        "$invariant": "Another one"
    },
    "_updateDate": {
        "$invariant": "2019-10-10T11:19:04.3988745+00:00"
    },
    "_hasChildren": false,
    "_level": 3,
    "_createDate": "2019-10-07T11:53:09.653Z",
    "_id": "041067a0-74f5-4d03-92af-40c3c0aa13e7",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
        },
        "root": {
            "href": "https://api.umbraco.io/content"
        },
        "children": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/children"
        },
        "publish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/publish"
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/unpublish"
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/blogpost"
        }
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "bodyText": {
        "$invariant": "<p>Donec sollicitudin molestie malesuada. Proin eget tortor risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Nulla porttitor accumsan tincidunt. Donec rutrum congue leo eget malesuada.</p>\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Sed porttitor lectus nibh.</p>\n<p>Pellentesque in ipsum id orci porta dapibus. Curabitur aliquet quam id dui posuere blandit. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat.</p>"
    }
}
```

## Create content with files

Create a new content item with one or more language variations and files.

When content contains an upload field it is possible to send a file along with the request to create new content. This is done by sending a multi-part request with the JSON body and the file.

If the content item doesn't include files then you can send a standard reqeust with a JSON payload to create a new content item.

{% hint style="info" %}
All newly created content will be `DRAFT` by default. If you want to publish it you will need to issue a publish request as well.
{% endhint %}

**URL**: `/content`

**Method**: `POST`

**Header**: `Content-Type: multipart/form-data; boundary=MultipartBoundry`

**Permissions required** : `Create`

### Request

The request must contain a field named `content` that contains the content JSON.

For the files being uploaded the field names must be in the format `propertyName.culture`. An example could be when the content has an upload property with the name `fileUpload` and the file is being uploaded to the `en-US` lanugage. In that case the field name should be `fileUpload.en-US`.

The property must also be includud in the content JSON and the value shoud be the filename.

```http
Content-Type: multipart/form-data; boundary=MultipartBoundry

--MultipartBoundry
Content-Disposition: form-data; name="content"
Content-Type: application/json

{
  "contentTypeAlias": "withUpload",
  "name": {
    "en-US": "Upload Test"
  },
  "text": { "$invariant": "Here's some text" },
  "fileUpload": { "en-US": "han-solo.png" }
}
--MultipartBoundry
Content-Disposition: form-data; name="fileUpload.en-US"
Content-Type: image/png

BINARY DATA
--MultipartBoundry--
```

### Success Response

**Code**: 201

**Content Example**:

```json
{
  "contentTypeAlias": "withUpload",
  "_createDate": "2019-08-08T10:07:50.2777311+02:00",
  "_currentVersionState": {
    "en-US": "DRAFT",
    "da": "NOT_CREATED"
  },
  "name": {
    "en-US": "Upload Test",
    "da": null
  },
  "_updateDate": {
    "en-US": "2019-08-08T10:07:50.2828014+02:00",
    "da": null
  },
  "_hasChildren": false,
  "_id": "511a0927-3c56-4ec0-b308-1dea07753795",
  "_level": 1,
  "sortOrder": 21,
  "_links": {
    "self": {
      "href": "https://api.umbraco.io/content/511a0927-3c56-4ec0-b308-1dea07753795"
    },
    "root": {
      "href": "https://api.umbraco.io/content"
    },
    "children": {
      "href": "https://api.umbraco.io/content/511a0927-3c56-4ec0-b308-1dea07753795/children"
    }
  },
  "fileUpload": {
    "en-US": "/media/dg4gynhr/han-solo.png",
    "da": ""
  },
  "text": {
    "$invariant": "Here's some text"
  }
}
```

## Update content

Updates an existing content item that has one or more language variations.

When content contains an upload field it is possible to send a file along with the request to update content. This is done by sending a multi-part request with the json body and the file, see [Create content with files](./#create-content-with-files) for an example. If the content item doesn't include files then you can send a standard reqeust with a JSON payload to update the content item.

**URL**: `/content/{id}`

**Method**: `PUT`

**Permissions required** : `Update`

### Request

In this example only one language exists, so the properties are marked with `$invariant`. If multiple languages existed the culture for each of the languages would be defined for each of the properties. Ie.: `"name": { "en-US": "Another one", "da-DK": "Endnu en" }`.

When a property uses a multinode treepicker editor it is worth noting that the value for said property should be a comma seperated list of Umbraco UDI Identifiers. In this example the UDI Identifiers are referencing content items. See the [UDI Identifiers](https://docs.umbraco.com/umbraco-cms/reference/querying/udi-identifiers) documentation to learn more. 

```json
{
    "name": {
        "$invariant": "Another one"
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "multinodeTreePicker": {
        "$invariant": "umb://document/067c7c926709487ab01be84168b333cf,umb://document/8a4dec90cf394028a743eae0729d47ba,umb://document/5fdd887233394a3492000bbf74e3b005"
    },
    "bodyText": {
        "$invariant": "<p>Lorem Ipsum</p>"
    }
}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_currentVersionState": {
        "$invariant": "DRAFT"
    },
    "name": {
        "$invariant": "Another one"
    },
    "_updateDate": {
        "$invariant": "2019-10-07T11:53:09.653Z"
    },
    "_hasChildren": false,
    "_level": 3,
    "_createDate": "2019-10-07T11:53:09.653Z",
    "_id": "041067a0-74f5-4d03-92af-40c3c0aa13e7",
    "_deleteDate": "2019-10-10T11:19:53.6828938Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
        },
        "root": {
            "href": "https://api.umbraco.io/content"
        },
        "children": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/children"
        },
        "publish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/publish"
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/unpublish"
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/blogpost"
        }
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "bodyText": {
        "$invariant": "<p>Lorem Ipsum</p>"
    }
}
```

## Publish content

Publish specific content item with all language variations or for a specific language.

**URL**: `/content/{id}/publish`

**Method**: `PUT`

**Query Strings**

```
?culture={string=en-US}
```

**Permissions required** : `Publish`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_currentVersionState": {
        "$invariant": "PUBLISHED"
    },
    "name": {
        "$invariant": "Another one"
    },
    "_updateDate": {
        "$invariant": "2019-10-10T11:19:04.3988745+00:00"
    },
    "_hasChildren": false,
    "_level": 3,
    "_createDate": "2019-10-07T11:53:09.653Z",
    "_id": "041067a0-74f5-4d03-92af-40c3c0aa13e7",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
        },
        "root": {
            "href": "https://api.umbraco.io/content"
        },
        "children": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/children"
        },
        "publish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/publish"
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/unpublish"
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/blogpost"
        }
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "bodyText": {
        "$invariant": "<p>Donec sollicitudin molestie malesuada. Proin eget tortor risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Nulla porttitor accumsan tincidunt. Donec rutrum congue leo eget malesuada.</p>\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Sed porttitor lectus nibh.</p>\n<p>Pellentesque in ipsum id orci porta dapibus. Curabitur aliquet quam id dui posuere blandit. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat.</p>"
    }
}
```

## Unpublish content

Unpublish specific content item with all language variations or for a specific language.

**URL**: `/content/{id}/unpublish`

**Method**: `PUT`

**Query Strings**

```
?culture={string=en-US}
```

**Permissions required** : `Unpublish`

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_currentVersionState": {
        "$invariant": "DRAFT"
    },
    "name": {
        "$invariant": "Another one"
    },
    "_updateDate": {
        "$invariant": "2019-10-10T11:15:38.5964706+00:00"
    },
    "_hasChildren": false,
    "_level": 3,
    "_createDate": "2019-10-07T11:53:09.653Z",
    "_id": "041067a0-74f5-4d03-92af-40c3c0aa13e7",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
        },
        "root": {
            "href": "https://api.umbraco.io/content"
        },
        "children": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/children"
        },
        "publish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/publish"
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/unpublish"
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/blogpost"
        }
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "bodyText": {
        "$invariant": "<p>Donec sollicitudin molestie malesuada. Proin eget tortor risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Nulla porttitor accumsan tincidunt. Donec rutrum congue leo eget malesuada.</p>\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Sed porttitor lectus nibh.</p>\n<p>Pellentesque in ipsum id orci porta dapibus. Curabitur aliquet quam id dui posuere blandit. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat.</p>"
    }
}
```

## Delete content

Delete a specific content item with all its language variations.

**URL**: `/content/{id}`

**Method**: `DELETE`

**Permissions required** : `Delete`

### Success Response

**Code**: 200

**Content Example**:

`DELETE https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7`

```json
{
    "_currentVersionState": {
        "$invariant": "PUBLISHED"
    },
    "name": {
        "$invariant": "Another one"
    },
    "_updateDate": {
        "$invariant": "2019-10-07T11:53:09.653Z"
    },
    "_hasChildren": false,
    "_level": 3,
    "_createDate": "2019-10-07T11:53:09.653Z",
    "_id": "041067a0-74f5-4d03-92af-40c3c0aa13e7",
    "_deleteDate": "2019-10-10T11:19:53.6828938Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7"
        },
        "root": {
            "href": "https://api.umbraco.io/content"
        },
        "children": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/children"
        },
        "publish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/publish"
        },
        "unpublish": {
            "href": "https://api.umbraco.io/content/041067a0-74f5-4d03-92af-40c3c0aa13e7/unpublish"
        },
        "contenttype": {
            "href": "https://api.umbraco.io/content/type/blogpost"
        }
    },
    "contentTypeAlias": "blogpost",
    "parentId": "8007e923-e62a-4ac1-a33f-caf3052582f4",
    "sortOrder": 0,
    "seoMetaDescription": {
        "$invariant": ""
    },
    "keywords": {
        "$invariant": []
    },
    "umbNaviHide": {
        "$invariant": "0"
    },
    "pageTitle": {
        "$invariant": "Another one"
    },
    "categories": {
        "$invariant": [
            "cg16",
            "codegarden",
            "umbraco"
        ]
    },
    "excerpt": {
        "$invariant": "Donec sollicitudin molestie malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Sed porttitor lectus nibh."
    },
    "bodyText": {
        "$invariant": "<p>Donec sollicitudin molestie malesuada. Proin eget tortor risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Nulla porttitor accumsan tincidunt. Donec rutrum congue leo eget malesuada.</p>\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Donec rutrum congue leo eget malesuada. Nulla porttitor accumsan tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Sed porttitor lectus nibh.</p>\n<p>Pellentesque in ipsum id orci porta dapibus. Curabitur aliquet quam id dui posuere blandit. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Donec rutrum congue leo eget malesuada. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Nulla quis lorem ut libero malesuada feugiat.</p>"
    }
}
```
