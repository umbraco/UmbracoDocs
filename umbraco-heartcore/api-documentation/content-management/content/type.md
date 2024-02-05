# Content Management API for Content Types

**BASE URL**: `https://api.umbraco.io`

## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get all Content Types](#get-all-content-types)
* [Get by alias](#get-by-alias)

## Common Headers

```http
Api-Version: 2
Umb-Project-Alias: {project-alias}
```

## Authentication

Authentication is required for this API. You must supply a Bearer Token via an Authorization header or an API Key through an Authorization or Api-Key header.

## Errors

If an error occours you will receive a HTTP status code along with an API error code and an error message in the response body.

| Status Code | Error Code           | Message                                                                  |
| ----------- | -------------------- | ------------------------------------------------------------------------ |
| 401         | Unauthorized         | Authorization has been denied for this request.                          |
| 403         | Forbidden            | You are not authorized to access the given resource.                     |
| 404         | NotFound             | Content Type with alias '{alias}' could not be found.                    |
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

## Get all Content Types

Get a list of all available Content Types.

**URL**: `/content/type`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/type"
        },
        "contenttypes": [
            {
                "href": "https://api.umbraco.io/content/type/contentBase"
            },
            {
                "href": "https://api.umbraco.io/content/type/feature"
            },
            {
                "href": "https://api.umbraco.io/content/type/navigationBase"
            },
            {
                "href": "https://api.umbraco.io/content/type/home"
            },
            {
                "href": "https://api.umbraco.io/content/type/blog"
            },
            {
                "href": "https://api.umbraco.io/content/type/blogpost"
            },
            {
                "href": "https://api.umbraco.io/content/type/products"
            },
            {
                "href": "https://api.umbraco.io/content/type/product"
            }
        ]
    },
    "_embedded": {
        "contenttypes": [
            {
                "allowCultureVariant": false,
                "alias": "contentBase",
                "compositions": [],
                "groups": [
                    {
                        "name": "Content",
                        "sortOrder": 10,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "pageTitle",
                                "label": "Page Title",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "bodyText",
                                "label": "Content",
                                "propertyEditorAlias": "Umbraco.TinyMCE",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Content Base",
                "_createDate": "2019-10-04T07:10:08.99Z",
                "_id": "ffb4c01b-9b1b-41b7-8a51-dd1c86b847a8",
                "_updateDate": "2019-10-04T07:10:08.99Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/type/contentBase"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content/type"
                    }
                }
            },
            {
                "allowCultureVariant": false,
                "alias": "navigationBase",
                "compositions": [],
                "groups": [
                    {
                        "name": "Navigation & SEO",
                        "sortOrder": 20,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "seoMetaDescription",
                                "label": "Description",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "keywords",
                                "label": "Keywords",
                                "propertyEditorAlias": "Umbraco.Tags",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "umbNaviHide",
                                "label": "Hide in Navigation",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Navigation Base",
                "_createDate": "2019-10-04T10:15:14.937Z",
                "_id": "43b0c73e-effd-4ccd-8213-9828245b3feb",
                "_updateDate": "2019-10-04T10:15:14.937Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/type/navigationBase"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content/type"
                    }
                }
            },
            {
                "allowCultureVariant": false,
                "alias": "home",
                "compositions": [],
                "groups": [
                    {
                        "name": "Hero",
                        "sortOrder": 0,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "heroHeader",
                                "description": "This is the main headline for the hero area on the Homepage",
                                "label": "Header",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 0,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "heroDescription",
                                "label": "Description",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 1,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "heroCTACaption",
                                "label": "Call to Action Caption",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 2,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "heroCTALink",
                                "label": "Call to Action Link",
                                "propertyEditorAlias": "Umbraco.ContentPicker",
                                "sortOrder": 3,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    },
                    {
                        "name": "Content",
                        "sortOrder": 1,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "bodyText",
                                "label": "Content",
                                "propertyEditorAlias": "Umbraco.TinyMCE",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    },
                    {
                        "name": "Footer",
                        "sortOrder": 2,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "footerHeader",
                                "label": "Header",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "footerDescription",
                                "label": "Description",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "footerCTACaption",
                                "description": "Caption on the Call To Action Button",
                                "label": "Call to Action Caption",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "footerCTALink",
                                "label": "Call to Action Link",
                                "propertyEditorAlias": "Umbraco.ContentPicker",
                                "sortOrder": 3,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "footerAddress",
                                "label": "Address",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 4,
                                "validation": {
                                    "required": true
                                }
                            }
                        ]
                    },
                    {
                        "name": "Design",
                        "sortOrder": 3,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "heroBackgroundImage",
                                "description": "Spice up the homepage by adding a beautiful photo that relates to your business",
                                "label": "Hero Background",
                                "propertyEditorAlias": "Umbraco.MediaPicker",
                                "sortOrder": 0,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "font",
                                "label": "Font",
                                "propertyEditorAlias": "Umbraco.RadioButtonList",
                                "sortOrder": 1,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "colorTheme",
                                "label": "Color Theme",
                                "propertyEditorAlias": "Umbraco.RadioButtonList",
                                "sortOrder": 2,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "sitename",
                                "description": "Used on the homepage as well as the title and social cards",
                                "label": "Sitename",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 3,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "logo",
                                "description": "Optional. If you add a logo it'll be used in the upper left corner instead of the site name. Make sure to use a transparent logo for best results",
                                "label": "Logo",
                                "propertyEditorAlias": "Umbraco.MediaPicker",
                                "sortOrder": 4,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Home",
                "_createDate": "2019-10-04T10:54:53.297Z",
                "_id": "0a87cb29-ba6e-4520-8ce6-85e70d89e539",
                "_updateDate": "2019-10-04T10:54:53.297Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/type/home"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content/type"
                    }
                }
            },
            {
                "allowCultureVariant": false,
                "alias": "blog",
                "compositions": [
                    "contentBase",
                    "navigationBase"
                ],
                "groups": [
                    {
                        "name": "Content",
                        "sortOrder": 10,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "pageTitle",
                                "label": "Page Title",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "bodyText",
                                "label": "Content",
                                "propertyEditorAlias": "Umbraco.TinyMCE",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    },
                    {
                        "name": "Navigation & SEO",
                        "sortOrder": 20,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "seoMetaDescription",
                                "label": "Description",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "keywords",
                                "label": "Keywords",
                                "propertyEditorAlias": "Umbraco.Tags",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "umbNaviHide",
                                "label": "Hide in Navigation",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    },
                    {
                        "name": "Settings",
                        "sortOrder": 0,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "howManyPostsShouldBeShown",
                                "label": "How many posts should be shown?",
                                "propertyEditorAlias": "Umbraco.Slider",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "disqusShortname",
                                "description": "To use comments, you'll need to sign up for Disqus and enter your shortname here (more info: https://help.disqus.com/customer/portal/articles/472097-universal-embed-code)",
                                "label": "Disqus Shortname",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Blog",
                "_createDate": "2019-10-04T11:04:28.35Z",
                "_id": "558f0270-76dc-4b81-bd4b-0687eecce904",
                "_updateDate": "2019-10-04T11:04:28.35Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/type/blog"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content/type"
                    }
                }
            },
            {
                "allowCultureVariant": false,
                "alias": "blogpost",
                "compositions": [
                    "navigationBase"
                ],
                "groups": [
                    {
                        "name": "Navigation & SEO",
                        "sortOrder": 20,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "seoMetaDescription",
                                "label": "Description",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "keywords",
                                "label": "Keywords",
                                "propertyEditorAlias": "Umbraco.Tags",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "umbNaviHide",
                                "label": "Hide in Navigation",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    },
                    {
                        "name": "Content",
                        "sortOrder": 0,
                        "properties": [
                            {
                                "allowCultureVariant": false,
                                "alias": "pageTitle",
                                "label": "Page Title",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 0,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "categories",
                                "label": "Categories (tags)",
                                "propertyEditorAlias": "Umbraco.Tags",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "excerpt",
                                "label": "Excerpt",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 2,
                                "validation": {
                                    "required": true
                                }
                            },
                            {
                                "allowCultureVariant": false,
                                "alias": "bodyText",
                                "label": "Content",
                                "propertyEditorAlias": "Umbraco.TinyMCE",
                                "sortOrder": 3,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Blogpost",
                "_createDate": "2019-10-04T11:10:04.247Z",
                "_id": "5cb405d5-cb5e-4408-8117-f0ac51fcf524",
                "_updateDate": "2019-10-04T11:10:04.247Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/content/type/blogpost"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/content/type"
                    }
                }
            }
        ]
    }
}
```

## Get by alias

Get a specific Content Type by its alias.

**URL**: `/content/type/{alias}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "allowCultureVariant": false,
    "alias": "home",
    "compositions": [],
    "groups": [
        {
            "name": "Hero",
            "sortOrder": 0,
            "properties": [
                {
                    "allowCultureVariant": false,
                    "alias": "heroHeader",
                    "description": "This is the main headline for the hero area on the Homepage",
                    "label": "Header",
                    "propertyEditorAlias": "Umbraco.TextBox",
                    "sortOrder": 0,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "heroDescription",
                    "label": "Description",
                    "propertyEditorAlias": "Umbraco.TextArea",
                    "sortOrder": 1,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "heroCTACaption",
                    "label": "Call to Action Caption",
                    "propertyEditorAlias": "Umbraco.TextBox",
                    "sortOrder": 2,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "heroCTALink",
                    "label": "Call to Action Link",
                    "propertyEditorAlias": "Umbraco.ContentPicker",
                    "sortOrder": 3,
                    "validation": {
                        "required": false
                    }
                }
            ]
        },
        {
            "name": "Content",
            "sortOrder": 1,
            "properties": [
                {
                    "allowCultureVariant": false,
                    "alias": "bodyText",
                    "label": "Content",
                    "propertyEditorAlias": "Umbraco.TinyMCE",
                    "sortOrder": 0,
                    "validation": {
                        "required": false
                    }
                }
            ]
        },
        {
            "name": "Footer",
            "sortOrder": 2,
            "properties": [
                {
                    "allowCultureVariant": false,
                    "alias": "footerHeader",
                    "label": "Header",
                    "propertyEditorAlias": "Umbraco.TextBox",
                    "sortOrder": 0,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "footerDescription",
                    "label": "Description",
                    "propertyEditorAlias": "Umbraco.TextArea",
                    "sortOrder": 1,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "footerCTACaption",
                    "description": "Caption on the Call To Action Button",
                    "label": "Call to Action Caption",
                    "propertyEditorAlias": "Umbraco.TextBox",
                    "sortOrder": 2,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "footerCTALink",
                    "label": "Call to Action Link",
                    "propertyEditorAlias": "Umbraco.ContentPicker",
                    "sortOrder": 3,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "footerAddress",
                    "label": "Address",
                    "propertyEditorAlias": "Umbraco.TextBox",
                    "sortOrder": 4,
                    "validation": {
                        "required": true
                    }
                }
            ]
        },
        {
            "name": "Design",
            "sortOrder": 3,
            "properties": [
                {
                    "allowCultureVariant": false,
                    "alias": "heroBackgroundImage",
                    "description": "Spice up the homepage by adding a beautiful photo that relates to your business",
                    "label": "Hero Background",
                    "propertyEditorAlias": "Umbraco.MediaPicker",
                    "sortOrder": 0,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "font",
                    "label": "Font",
                    "propertyEditorAlias": "Umbraco.RadioButtonList",
                    "sortOrder": 1,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "colorTheme",
                    "label": "Color Theme",
                    "propertyEditorAlias": "Umbraco.RadioButtonList",
                    "sortOrder": 2,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "sitename",
                    "description": "Used on the homepage as well as the title and social cards",
                    "label": "Sitename",
                    "propertyEditorAlias": "Umbraco.TextBox",
                    "sortOrder": 3,
                    "validation": {
                        "required": true
                    }
                },
                {
                    "allowCultureVariant": false,
                    "alias": "logo",
                    "description": "Optional. If you add a logo it'll be used in the upper left corner instead of the site name. Make sure to use a transparent logo for best results",
                    "label": "Logo",
                    "propertyEditorAlias": "Umbraco.MediaPicker",
                    "sortOrder": 4,
                    "validation": {
                        "required": false
                    }
                }
            ]
        }
    ],
    "name": "Home",
    "_createDate": "2019-10-04T10:54:53.297Z",
    "_id": "0a87cb29-ba6e-4520-8ce6-85e70d89e539",
    "_updateDate": "2019-10-04T10:54:53.297Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/content/type/home"
        },
        "root": {
            "href": "https://api.umbraco.io/content/type"
        }
    }
}
```
