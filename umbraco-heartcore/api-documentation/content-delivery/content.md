# Content

**BASE URL**: `https://cdn.umbraco.io`

## Table of Contents

* [Common Headers](content.md#common-headers)
* [Errors](content.md#errors)
* [Get Root Content](content.md#get-root-content)
* [Get By Id](content.md#get-by-id)
* [Get By Url](content.md#get-by-url)
* [Get By Type](content.md#get-by-type)
* [Get Ancestors](content.md#get-ancestors)
* [Get Children](content.md#get-children)
* [Get Descendants](content.md#get-descendants)
* [Content Filter](content.md#content-filter)
* [Search](content.md#search)

## Common Headers

```http
Accept-Language: {culture}
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Depth

The `depth` querystring parameter controls how many levels of referenced Content or Media items that is included in the result.

Lets say a Content item have a `Multi Node Tree Picker` and one of the Content items that can be picked have a `Media Picker`. In this case, if the level is set to `1` the returned data will contain the referenced Content items, but their Media property will be null. To include the Media property (which is at level 2) the `depth` parameter should be `2` or higher.

The lowest supported depth value is `0` and the highest is `5`.

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code                 | Message                                                                                                                                                       |
| ----------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 400         | AmbiguousCulture           | The following cultures were requested: {cultures}. At most, only a single culture may be specified. Please update the intended culture and retry the request. |
| 400         | LanguageForCultureNotFound | Could not find a language for culture {culture}.                                                                                                              |
| 401         | Unauthorized               | Authorization has been denied for this request.                                                                                                               |
| 404         | NotFound                   | Published content with id '{id}' and culture '{culture}' could not be found.                                                                                  |
| 500         | InternalServerError        | Internal server error.                                                                                                                                        |

**JSON example**:

```json
{
  "error": {
    "code": "LanguageForCultureNotFound",
    "message": "Could not find a language for culture en-GB."
  }
}
```

## Get root content

Gets all published content at the root of the tree.

**URL**: `/content`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?contentType={string}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_links": {
    "self": {
      "href": "https://cdn.umbraco.io/content"
    },
    "content": [
      {
        "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62"
      }
    ]
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/people/",
        "_urls": {
            "en-us": "/people/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": true,
        "_level": 1,
        "_createDate": "2019-06-17T13:46:24.543Z",
        "_id": "e8ad9b65-cff6-4952-ac5b-efe56a60db62",
        "_updateDate": "2019-06-17T13:46:54.97Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62"
          }
        },
        "contentTypeAlias": "people",
        "name": "People",
        "sortOrder": 1,
        "seoMetaDescription": "",
        "keywords": [],
        "umbracoNavihide": false,
        "pageTitle": "Nice crazy people",
        "featuredPeople": null
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/",
        "_urls": {
            "en-us": "/products/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": true,
        "_level": 1,
        "_createDate": "2019-06-17T13:46:24.093Z",
        "_id": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "_updateDate": "2019-09-17T14:43:14.827Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "products",
        "name": "Products",
        "sortOrder": 3,
        "seoMetaDescription": "",
        "keywords": [],
        "umbracoNavihide": false,
        "pageTitle": "Our Gorgeous Selection",
        "defaultCurrency": "€",
        "featuredProducts": [
          {
            "_creatorName": "Rasmus",
            "_url": "/products/biker-jacket/",
            "_writerName": "Rasmus",
            "_hasChildren": false,
            "_level": 2,
            "_createDate": "2019-06-17T13:46:24.497Z",
            "_id": "262beb70-53a6-49b8-9e98-cfde2e85a78e",
            "_updateDate": "2019-09-16T11:25:44.433Z",
            "_links": null,
            "contentTypeAlias": "product",
            "name": "Biker Jacket",
            "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
            "sortOrder": 7,
            "productName": "Biker Jacket",
            "price": 199.0,
            "description": "Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.",
            "sku": "UMB-BIKER-JACKET",
            "photos": null,
            "features": [
              {
                "contentTypeAlias": "feature",
                "featureName": "Free shipping",
                "featureDetails": "Isn't that awesome - you only pay for the product"
              },
              {
                "contentTypeAlias": "feature",
                "featureName": "1 Day return policy",
                "featureDetails": "You'll need to make up your mind fast"
              },
              {
                "contentTypeAlias": "feature",
                "featureName": "100 Years warranty",
                "featureDetails": "But if you're satisfied it'll last a lifetime"
              }
            ]
          },
          {
            "_creatorName": "Rasmus",
            "_url": "/products/tattoo/",
            "_urls": {
                "en-us": "/products/tattoo/"
            },
            "_writerName": "Rasmus",
            "_hasChildren": false,
            "_level": 2,
            "_createDate": "2019-06-17T13:46:24.14Z",
            "_id": "df1eb830-411b-4d41-a343-3917b76d533c",
            "_updateDate": "2019-06-26T22:11:05.727Z",
            "_links": null,
            "contentTypeAlias": "product",
            "name": "Tattoo",
            "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
            "sortOrder": 0,
            "productName": "Tattoo",
            "price": 499.0,
            "description": "Cras ultricies ligula sed magna dictum porta.",
            "sku": "UMB-TATTOO",
            "photos": null,
            "features": []
          },
          {
            "_creatorName": "Rasmus",
            "_url": "/products/unicorn/",
            "_urls": {
                "en-us": "/products/unicorn/"
            },
            "_writerName": "Rasmus",
            "_hasChildren": false,
            "_level": 2,
            "_createDate": "2019-06-17T13:46:24.187Z",
            "_id": "4e96411a-b8e1-435f-9322-2faee30ef5f2",
            "_updateDate": "2019-06-26T22:11:05.803Z",
            "_links": null,
            "contentTypeAlias": "product",
            "name": "Unicorn",
            "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
            "sortOrder": 1,
            "productName": "Unicorn",
            "price": 249.0,
            "description": "Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Cras ultricies ligula sed magna dictum porta.",
            "sku": "UMB-UNICORN",
            "photos": null,
            "features": []
          }
        ]
      }
    ]
  }
}
```

## Get by id

Get a single published content by its ID.

**URL**: `/content/{id}`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?depth={integer=1}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_creatorName": "Rasmus",
  "_url": "/products/",
  "_urls": {
    "en-us": "/products/"
  },
  "_writerName": "Rasmus",
  "_hasChildren": true,
  "_level": 1,
  "_createDate": "2019-06-17T13:46:24.093Z",
  "_id": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
  "_updateDate": "2019-09-17T14:43:14.827Z",
  "_links": {
    "self": {
      "href": "https://cdn.umbraco.io/content/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
    },
    "featuredproducts": [
      {
        "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e",
        "title": "Biker Jacket"
      },
      {
        "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c",
        "title": "Tattoo"
      },
      {
        "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2",
        "title": "Unicorn"
      }
    ],
    "root": {
      "href": "https://cdn.umbraco.io/content"
    },
    "children": {
      "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324/children"
    },
    "ancestors": {
      "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324/ancestors"
    },
    "descendants": {
      "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324/descendants"
    },
    "parent": {
      "href": "https://cdn.umbraco.io/content"
    }
  },
  "contentTypeAlias": "products",
  "name": "Products",
  "sortOrder": 3,
  "seoMetaDescription": "",
  "keywords": [],
  "umbracoNavihide": false,
  "pageTitle": "Our Gorgeous Selection",
  "defaultCurrency": "€",
  "featuredProducts": [
    {
      "_creatorName": "Rasmus",
      "_url": "/products/biker-jacket/",
      "_urls": {
        "en-us": "/products/biker-jacket/"
      },
      "_writerName": "Rasmus",
      "_hasChildren": false,
      "_level": 2,
      "_createDate": "2019-06-17T13:46:24.497Z",
      "_id": "262beb70-53a6-49b8-9e98-cfde2e85a78e",
      "_updateDate": "2019-09-16T11:25:44.433Z",
      "_links": {
        "photos": {
          "href": "https://cdn.umbraco.io/media/55514845-b8bd-487c-b370-9724852fd6bb",
          "title": "Biker Jacket"
        }
      },
      "contentTypeAlias": "product",
      "name": "Biker Jacket",
      "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
      "sortOrder": 7,
      "productName": "Biker Jacket",
      "price": 199.0,
      "description": "Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.",
      "sku": "UMB-BIKER-JACKET",
      "photos": null,
      "features": [
        {
          "contentTypeAlias": "feature",
          "featureName": "Free shipping",
          "featureDetails": "Isn't that awesome - you only pay for the product"
        },
        {
          "contentTypeAlias": "feature",
          "featureName": "1 Day return policy",
          "featureDetails": "You'll need to make up your mind fast"
        },
        {
          "contentTypeAlias": "feature",
          "featureName": "100 Years warranty",
          "featureDetails": "But if you're satisfied it'll last a lifetime"
        }
      ]
    },
    {
      "_creatorName": "Rasmus",
      "_url": "/products/tattoo/",
      "_urls": {
        "en-us": "/products/tattoo/"
      },
      "_writerName": "Rasmus",
      "_hasChildren": false,
      "_level": 2,
      "_createDate": "2019-06-17T13:46:24.14Z",
      "_id": "df1eb830-411b-4d41-a343-3917b76d533c",
      "_updateDate": "2019-06-26T22:11:05.727Z",
      "_links": {
        "photos": {
          "href": "https://cdn.umbraco.io/media/20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
          "title": "Tattoo"
        }
      },
      "contentTypeAlias": "product",
      "name": "Tattoo",
      "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
      "sortOrder": 0,
      "productName": "Tattoo",
      "price": 499.0,
      "description": "Cras ultricies ligula sed magna dictum porta.",
      "sku": "UMB-TATTOO",
      "photos": null,
      "features": []
    },
    {
      "_creatorName": "Rasmus",
      "_url": "/products/unicorn/",
      "_urls": {
        "en-us": "/products/unicorn/"
      },
      "_writerName": "Rasmus",
      "_hasChildren": false,
      "_level": 2,
      "_createDate": "2019-06-17T13:46:24.187Z",
      "_id": "4e96411a-b8e1-435f-9322-2faee30ef5f2",
      "_updateDate": "2019-06-26T22:11:05.803Z",
      "_links": {
        "photos": {
          "href": "https://cdn.umbraco.io/media/1bc5280b-8658-4027-89d9-58e2576e469b",
          "title": "Unicorn"
        }
      },
      "contentTypeAlias": "product",
      "name": "Unicorn",
      "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
      "sortOrder": 1,
      "productName": "Unicorn",
      "price": 249.0,
      "description": "Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Cras ultricies ligula sed magna dictum porta.",
      "sku": "UMB-UNICORN",
      "photos": null,
      "features": []
    }
  ]
}
```

## Get by URL

Get a single published content by its URL.

**URL**: `/content/url?url={url}`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?depth={integer=1}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_creatorName": "Rasmus",
  "_url": "/people/",
  "_urls": {
    "en-us": "/people/"
  },
  "_writerName": "Rasmus",
  "_hasChildren": true,
  "_level": 1,
  "_createDate": "2019-06-17T13:46:24.543Z",
  "_id": "e8ad9b65-cff6-4952-ac5b-efe56a60db62",
  "_updateDate": "2019-06-17T13:46:54.97Z",
  "_links": {
    "self": {
      "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62"
    }
  },
  "contentTypeAlias": "people",
  "name": "People",
  "sortOrder": 1,
  "seoMetaDescription": "",
  "keywords": [],
  "umbracoNavihide": false,
  "pageTitle": "Nice crazy people",
  "featuredPeople": null
}
```

## Get by type

Get content by its Content Type.

Use the Content Type alias to filter all returned content to that specific type.

Example: `GET /content/type?contentType=product` gets all content based on the `product` Content Type.

**URL**: `/content/type?contentType={string}`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?page={integer=1}
?pageSize={integer=10}
```

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
      "href": "https://cdn.umbraco.io/content/type?contentType=product&page=1&pageSize=10"
    },
    "page": {
      "href": "https://cdn.umbraco.io/content/type{?contentType,page,pageSize}",
      "templated": true
    },
    "root": {
      "href": "https://cdn.umbraco.io/content{?contentType}",
      "templated": true
    },
    "content": [
      {
        "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c"
      },
      {
        "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2"
      },
      {
        "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752"
      }
    ]
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/products/tattoo/",
        "_urls": {
          "en-us": "/products/tattoo/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.14Z",
        "_id": "df1eb830-411b-4d41-a343-3917b76d533c",
        "_updateDate": "2019-06-26T22:11:05.727Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
            "title": "Tattoo"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content{?contentType}",
            "templated": true
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Tattoo",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 0,
        "productName": "Tattoo",
        "price": 499.0,
        "description": "Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-TATTOO",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/20e3a8ffad1b4fe9b48cb8461c46d2d0/00000006000000000000000000000000/7371127652_e01b6ab56f_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.503Z",
          "_id": "20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
          "_updateDate": "2019-06-17T13:46:42.503Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Tattoo",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/20e3a8ffad1b4fe9b48cb8461c46d2d0/00000006000000000000000000000000/7371127652_e01b6ab56f_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 683,
          "umbracoHeight": 1024,
          "umbracoBytes": 258796,
          "umbracoExtension": "jpg"
        },
        "features": []
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/unicorn/",
        "_urls": {
          "en-us": "/products/unicorn/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.187Z",
        "_id": "4e96411a-b8e1-435f-9322-2faee30ef5f2",
        "_updateDate": "2019-06-26T22:11:05.803Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/1bc5280b-8658-4027-89d9-58e2576e469b",
            "title": "Unicorn"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content{?contentType}",
            "templated": true
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Unicorn",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 1,
        "productName": "Unicorn",
        "price": 249.0,
        "description": "Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-UNICORN",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/1bc5280b8658402789d958e2576e469b/00000006000000000000000000000000/14272036539_469ca21d5c_h.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.64Z",
          "_id": "1bc5280b-8658-4027-89d9-58e2576e469b",
          "_updateDate": "2019-06-17T13:46:42.64Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Unicorn",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/1bc5280b8658402789d958e2576e469b/00000006000000000000000000000000/14272036539_469ca21d5c_h.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 1067,
          "umbracoHeight": 1600,
          "umbracoBytes": 367954,
          "umbracoExtension": "jpg"
        },
        "features": []
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/ping-pong-ball/",
        "_urls": {
          "en-us": "/products/ping-pong-ball/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.247Z",
        "_id": "d390a562-107d-4f02-8df7-57aa86bad752",
        "_updateDate": "2019-06-26T22:11:05.847Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/c09ec77f-08e3-466a-ac58-c979befd3cd6",
            "title": "Ping Pong Ball"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content{?contentType}",
            "templated": true
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Ping Pong Ball",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 2,
        "productName": "Ping Pong Ball",
        "price": 2.0,
        "description": "Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-PINGPONG",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/c09ec77f08e3466aac58c979befd3cd6/00000006000000000000000000000000/5852022211_9028df67c0_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.767Z",
          "_id": "c09ec77f-08e3-466a-ac58-c979befd3cd6",
          "_updateDate": "2019-06-17T13:46:42.767Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Ping Pong Ball",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/c09ec77f08e3466aac58c979befd3cd6/00000006000000000000000000000000/5852022211_9028df67c0_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 1024,
          "umbracoHeight": 683,
          "umbracoBytes": 205417,
          "umbracoExtension": "jpg"
        },
        "features": []
      }
    ]
  }
}
```

## Get ancestors

Get ancestors of a single published content.

**URL**: `/content/{id}/ancestors`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?contentType={string}
```

### Success Response

**Code**: 200

**Content Example**:

```json
{
  "_links": {
    "self": {
      "href": "https://cdn.umbraco.io/content/4f0b7052-d854-43b5-bb7c-6c82af4d96d1/ancestors"
    },
    "content": [
      {
        "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62"
      },
      {
        "href": "https://cdn.umbraco.io/content/32ded4f8-191a-418e-a4c9-0dabceba90ee"
      }
    ]
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/home/people/",
        "_urls": {
          "en-us": "/home/people/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": true,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.543Z",
        "_id": "e8ad9b65-cff6-4952-ac5b-efe56a60db62",
        "_updateDate": "2019-06-17T13:46:54.97Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/e8ad9b65-cff6-4952-ac5b-efe56a60db62/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/32ded4f8-191a-418e-a4c9-0dabceba90ee"
          }
        },
        "contentTypeAlias": "people",
        "name": "People",
        "parentId": "32ded4f8-191a-418e-a4c9-0dabceba90ee",
        "sortOrder": 0,
        "seoMetaDescription": "",
        "keywords": [],
        "umbracoNavihide": false,
        "pageTitle": "Nice crazy people",
        "featuredPeople": null
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/home/",
        "_urls": {
          "en-us": "/home/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": true,
        "_level": 1,
        "_createDate": "2019-06-17T13:46:24.012Z",
        "_id": "32ded4f8-191a-418e-a4c9-0dabceba90ee",
        "_updateDate": "2019-06-17T13:46:24.012Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/32ded4f8-191a-418e-a4c9-0dabceba90ee"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/32ded4f8-191a-418e-a4c9-0dabceba90ee/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/32ded4f8-191a-418e-a4c9-0dabceba90ee/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/32ded4f8-191a-418e-a4c9-0dabceba90ee/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content"
          }
        },
        "contentTypeAlias": "home",
        "name": "Home",
        "sortOrder": 4
      }
    ]
  }
}
```

## Get children

Get children of a single published content.

**URL**: `/content/{id}/children`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?contentType={string}
?page={integer=1}
?pageSize={integer=10}
```

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
      "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324/children?page=1"
    },
    "page": {
      "href": "https://cdn.umbraco.io/content/{id}/children{?page,pageSize}",
      "templated": true
    },
    "root": {
      "href": "https://cdn.umbraco.io/content"
    },
    "content": [
      {
        "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c"
      },
      {
        "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2"
      },
      {
        "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752"
      }
    ]
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/products/tattoo/",
        "_urls": {
          "en-us": "/products/tattoo/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.14Z",
        "_id": "df1eb830-411b-4d41-a343-3917b76d533c",
        "_updateDate": "2019-06-26T22:11:05.727Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
            "title": "Tattoo"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Tattoo",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 0,
        "productName": "Tattoo",
        "price": 499.0,
        "description": "Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-TATTOO",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/20e3a8ffad1b4fe9b48cb8461c46d2d0/00000006000000000000000000000000/7371127652_e01b6ab56f_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.503Z",
          "_id": "20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
          "_updateDate": "2019-06-17T13:46:42.503Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Tattoo",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/20e3a8ffad1b4fe9b48cb8461c46d2d0/00000006000000000000000000000000/7371127652_e01b6ab56f_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 683,
          "umbracoHeight": 1024,
          "umbracoBytes": 258796,
          "umbracoExtension": "jpg"
        },
        "features": []
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/unicorn/",
        "_urls": {
          "en-us": "/products/unicorn/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.187Z",
        "_id": "4e96411a-b8e1-435f-9322-2faee30ef5f2",
        "_updateDate": "2019-06-26T22:11:05.803Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/1bc5280b-8658-4027-89d9-58e2576e469b",
            "title": "Unicorn"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Unicorn",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 1,
        "productName": "Unicorn",
        "price": 249.0,
        "description": "Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-UNICORN",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/1bc5280b8658402789d958e2576e469b/00000006000000000000000000000000/14272036539_469ca21d5c_h.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.64Z",
          "_id": "1bc5280b-8658-4027-89d9-58e2576e469b",
          "_updateDate": "2019-06-17T13:46:42.64Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Unicorn",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/1bc5280b8658402789d958e2576e469b/00000006000000000000000000000000/14272036539_469ca21d5c_h.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 1067,
          "umbracoHeight": 1600,
          "umbracoBytes": 367954,
          "umbracoExtension": "jpg"
        },
        "features": []
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/ping-pong-ball/",
        "_urls": {
          "en-us": "/products/ping-pong-ball/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.247Z",
        "_id": "d390a562-107d-4f02-8df7-57aa86bad752",
        "_updateDate": "2019-06-26T22:11:05.847Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/c09ec77f-08e3-466a-ac58-c979befd3cd6",
            "title": "Ping Pong Ball"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Ping Pong Ball",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 2,
        "productName": "Ping Pong Ball",
        "price": 2.0,
        "description": "Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-PINGPONG",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/c09ec77f08e3466aac58c979befd3cd6/00000006000000000000000000000000/5852022211_9028df67c0_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.767Z",
          "_id": "c09ec77f-08e3-466a-ac58-c979befd3cd6",
          "_updateDate": "2019-06-17T13:46:42.767Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Ping Pong Ball",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/c09ec77f08e3466aac58c979befd3cd6/00000006000000000000000000000000/5852022211_9028df67c0_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 1024,
          "umbracoHeight": 683,
          "umbracoBytes": 205417,
          "umbracoExtension": "jpg"
        },
        "features": []
      }
    ]
  }
}
```

## Get descendants

Get descendants of a single published content.

**URL**: `/content/{id}/descendants`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
?contentType={string}
?page={integer=1}
?pageSize={integer=10}
```

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
      "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324/descendants?page=1"
    },
    "page": {
      "href": "https://cdn.umbraco.io/content/{id}/descendants{?page,pageSize}",
      "templated": true
    },
    "root": {
      "href": "https://cdn.umbraco.io/content"
    },
    "content": [
      {
        "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c"
      },
      {
        "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2"
      },
      {
        "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752"
      }
    ]
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/products/tattoo/",
        "_urls": {
          "en-us": "/products/tattoo/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.14Z",
        "_id": "df1eb830-411b-4d41-a343-3917b76d533c",
        "_updateDate": "2019-06-26T22:11:05.727Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
            "title": "Tattoo"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/df1eb830-411b-4d41-a343-3917b76d533c/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Tattoo",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 0,
        "productName": "Tattoo",
        "price": 499.0,
        "description": "Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-TATTOO",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/20e3a8ffad1b4fe9b48cb8461c46d2d0/00000006000000000000000000000000/7371127652_e01b6ab56f_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.503Z",
          "_id": "20e3a8ff-ad1b-4fe9-b48c-b8461c46d2d0",
          "_updateDate": "2019-06-17T13:46:42.503Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Tattoo",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/20e3a8ffad1b4fe9b48cb8461c46d2d0/00000006000000000000000000000000/7371127652_e01b6ab56f_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 683,
          "umbracoHeight": 1024,
          "umbracoBytes": 258796,
          "umbracoExtension": "jpg"
        },
        "features": []
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/unicorn/",
        "_urls": {
          "en-us": "/products/unicorn/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.187Z",
        "_id": "4e96411a-b8e1-435f-9322-2faee30ef5f2",
        "_updateDate": "2019-06-26T22:11:05.803Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/1bc5280b-8658-4027-89d9-58e2576e469b",
            "title": "Unicorn"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/4e96411a-b8e1-435f-9322-2faee30ef5f2/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Unicorn",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 1,
        "productName": "Unicorn",
        "price": 249.0,
        "description": "Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-UNICORN",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/1bc5280b8658402789d958e2576e469b/00000006000000000000000000000000/14272036539_469ca21d5c_h.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.64Z",
          "_id": "1bc5280b-8658-4027-89d9-58e2576e469b",
          "_updateDate": "2019-06-17T13:46:42.64Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Unicorn",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/1bc5280b8658402789d958e2576e469b/00000006000000000000000000000000/14272036539_469ca21d5c_h.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 1067,
          "umbracoHeight": 1600,
          "umbracoBytes": 367954,
          "umbracoExtension": "jpg"
        },
        "features": []
      },
      {
        "_creatorName": "Rasmus",
        "_url": "/products/ping-pong-ball/",
        "_urls": {
          "en-us": "/products/ping-pong-ball/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.247Z",
        "_id": "d390a562-107d-4f02-8df7-57aa86bad752",
        "_updateDate": "2019-06-26T22:11:05.847Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/c09ec77f-08e3-466a-ac58-c979befd3cd6",
            "title": "Ping Pong Ball"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/d390a562-107d-4f02-8df7-57aa86bad752/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Ping Pong Ball",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 2,
        "productName": "Ping Pong Ball",
        "price": 2.0,
        "description": "Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ultricies ligula sed magna dictum porta.",
        "sku": "UMB-PINGPONG",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/c09ec77f08e3466aac58c979befd3cd6/00000006000000000000000000000000/5852022211_9028df67c0_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.767Z",
          "_id": "c09ec77f-08e3-466a-ac58-c979befd3cd6",
          "_updateDate": "2019-06-17T13:46:42.767Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Ping Pong Ball",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/c09ec77f08e3466aac58c979befd3cd6/00000006000000000000000000000000/5852022211_9028df67c0_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 1024,
          "umbracoHeight": 683,
          "umbracoBytes": 205417,
          "umbracoExtension": "jpg"
        },
        "features": []
      }
    ]
  }
}
```

## Content Filter

Get content filtered by property values and optionally content type.

This endpoint can be used for advanced filtering of content based on the value of specific properties. You can choose to filter on one or more properties by their `alias` and a `value`. The matching criteria include whether the property `contains` or is `like` the passed-in value.

Say you have a property with an `alias` called "title" and you want all content, which `contains` the word "world". The payload you post to the `/content/filter` endpoint would be as shown below.

```json
{
  "contentTypeAlias": "",
  "properties": [{
    "alias": "title",
    "value": "world",
    "match": "CONTAINS"
  }]
}
```

Setting the above properties to "hello world" results in content with a "title" property containing either "hello" or "world" as values.

If you want the value of a property to match on both "page" and "pages" then you could use `like` with a payload as shown below.

```json
{
  "contentTypeAlias": "",
  "properties": [{
    "alias": "title",
    "value": "page",
    "match": "LIKE"
  }]
}
```

Filtering is performed on individual content items, indicating that content matching is not conducted on related content or media.

**URL**: `/content/filter`

**Method**: `POST`

**Query Strings**

```
?hyperlinks={boolean=true}
?page={integer=1}
?pageSize={integer=10}
```

### Headers

This endpoint is available from **API-Version: 2.1**. Specify the header as shown below when using the REST API.

```http
Api-Version: 2.1
Umb-Project-Alias: {project-alias}
```

### Request

In this example, we perform a filter with criteria for a "productName"-property containing the value "Jacket" and a "description"-property containing the value "Vivamus". Additionally, the Document Type should have the alias "product."

At least one object with `alias`, `value` and `match` in the `properties` array is required. The `contentTypeAlias` is optional and the `match` property can be either `CONTAINS` or `LIKE`.

```json
{
  "contentTypeAlias": "product",
  "properties": [{
    "alias": "productName",
    "value": "Jacket",
    "match": "CONTAINS"
  },
  {
    "alias": "description",
    "value": "Vivamus",
    "match": "CONTAINS"
  }]
}
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
      "href": "https://cdn.umbraco.io/content/filter?page=1&pageSize=10"
    },
    "page": {
      "href": "https://cdn.umbraco.io/content/filter{?page,pageSize}",
      "templated": true
    },
    "root": {
      "href": "https://cdn.umbraco.io/content{?contentType}"
    },
    "content": {
      "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e"
    }
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/products/biker-jacket/",
        "_urls": {
          "en-us": "/products/biker-jacket/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.497Z",
        "_id": "262beb70-53a6-49b8-9e98-cfde2e85a78e",
        "_updateDate": "2019-09-16T11:25:44.433Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/55514845-b8bd-487c-b370-9724852fd6bb",
            "title": "Biker Jacket"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Biker Jacket",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 7,
        "productName": "Biker Jacket",
        "price": 199.0,
        "description": "Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.",
        "sku": "UMB-BIKER-JACKET",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/55514845b8bd487cb3709724852fd6bb/00000006000000000000000000000000/4730684907_8a7f8759cb_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.377Z",
          "_id": "55514845-b8bd-487c-b370-9724852fd6bb",
          "_updateDate": "2019-06-17T13:46:42.377Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Biker Jacket",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/55514845b8bd487cb3709724852fd6bb/00000006000000000000000000000000/4730684907_8a7f8759cb_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 680,
          "umbracoHeight": 1024,
          "umbracoBytes": 224349,
          "umbracoExtension": "jpg"
        },
        "features": [
          {
            "contentTypeAlias": "feature",
            "featureName": "Free shipping",
            "featureDetails": "Isn't that awesome - you only pay for the product"
          },
          {
            "contentTypeAlias": "feature",
            "featureName": "1 Day return policy",
            "featureDetails": "You'll need to make up your mind fast"
          },
          {
            "contentTypeAlias": "feature",
            "featureName": "100 Years warranty",
            "featureDetails": "But if you're satisfied it'll last a lifetime"
          }
        ]
      }
    ]
  }
}
```

## Search

Search for published content by keyword.

**URL**: `/content/search?term={string}`

**Method**: `GET`

**Query Strings**

```
?hyperlinks={boolean=true}
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
      "href": "https://cdn.umbraco.io/content/search?term=jacket&page=1&pageSize=10"
    },
    "page": {
      "href": "https://cdn.umbraco.io/content/search{?term,page,pageSize}",
      "templated": true
    },
    "root": {
      "href": "https://cdn.umbraco.io/content"
    },
    "content": {
      "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e"
    }
  },
  "_embedded": {
    "content": [
      {
        "_creatorName": "Rasmus",
        "_url": "/products/biker-jacket/",
        "_urls": {
          "en-us": "/products/biker-jacket/"
        },
        "_writerName": "Rasmus",
        "_hasChildren": false,
        "_level": 2,
        "_createDate": "2019-06-17T13:46:24.497Z",
        "_id": "262beb70-53a6-49b8-9e98-cfde2e85a78e",
        "_updateDate": "2019-09-16T11:25:44.433Z",
        "_links": {
          "self": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e"
          },
          "photos": {
            "href": "https://cdn.umbraco.io/media/55514845-b8bd-487c-b370-9724852fd6bb",
            "title": "Biker Jacket"
          },
          "root": {
            "href": "https://cdn.umbraco.io/content"
          },
          "children": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e/children"
          },
          "ancestors": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e/ancestors"
          },
          "descendants": {
            "href": "https://cdn.umbraco.io/content/262beb70-53a6-49b8-9e98-cfde2e85a78e/descendants"
          },
          "parent": {
            "href": "https://cdn.umbraco.io/content/ec4aafcc-0c25-4f25-a8fe-705bfae1d324"
          }
        },
        "contentTypeAlias": "product",
        "name": "Biker Jacket",
        "parentId": "ec4aafcc-0c25-4f25-a8fe-705bfae1d324",
        "sortOrder": 7,
        "productName": "Biker Jacket",
        "price": 199.0,
        "description": "Donec rutrum congue leo eget malesuada. Vivamus suscipit tortor eget felis porttitor volutpat.",
        "sku": "UMB-BIKER-JACKET",
        "photos": {
          "_creatorName": "Rasmus",
          "_url": "https://media.umbraco.io/my-headless-site/media/55514845b8bd487cb3709724852fd6bb/00000006000000000000000000000000/4730684907_8a7f8759cb_b.jpg",
          "_writerName": "Rasmus",
          "_hasChildren": false,
          "_level": 2,
          "_createDate": "2019-06-17T13:46:42.377Z",
          "_id": "55514845-b8bd-487c-b370-9724852fd6bb",
          "_updateDate": "2019-06-17T13:46:42.377Z",
          "_links": null,
          "mediaTypeAlias": "Image",
          "name": "Biker Jacket",
          "parentId": "6d5bf746-cb82-45c5-bd15-dd3798209b87",
          "sortOrder": 0,
          "umbracoFile": {
            "src": "/media/55514845b8bd487cb3709724852fd6bb/00000006000000000000000000000000/4730684907_8a7f8759cb_b.jpg",
            "focalPoint": null,
            "crops": null
          },
          "umbracoWidth": 680,
          "umbracoHeight": 1024,
          "umbracoBytes": 224349,
          "umbracoExtension": "jpg"
        },
        "features": [
          {
            "contentTypeAlias": "feature",
            "featureName": "Free shipping",
            "featureDetails": "Isn't that awesome - you only pay for the product"
          },
          {
            "contentTypeAlias": "feature",
            "featureName": "1 Day return policy",
            "featureDetails": "You'll need to make up your mind fast"
          },
          {
            "contentTypeAlias": "feature",
            "featureName": "100 Years warranty",
            "featureDetails": "But if you're satisfied it'll last a lifetime"
          }
        ]
      }
    ]
  }
}
```
