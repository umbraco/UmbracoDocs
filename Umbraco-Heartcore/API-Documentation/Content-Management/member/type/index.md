# Content Management API for Member Types

**BASE URL**: `https://api.umbraco.io`

## Table of Contents
* [Common Headers](#common-headers)
* [Authentication](#authentication)
* [Errors](#errors)
* [Get all member types](#get-all-member-types)
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
| 404         | NotFound             | Member Type with alias '{alias}' could not be found.                     |
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

## Get all member types

Get a list of all available member types.

**URL**: `/member/type`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/member/type"
        },
        "membertypes": [
            {
                "href": "https://api.umbraco.io/member/type/Member"
            },
            {
                "href": "https://api.umbraco.io/member/type/shopMembers"
            }
        ]
    },
    "_embedded": {
        "membertypes": [
            {
                "alias": "Member",
                "compositions": [],
                "groups": [
                    {
                        "name": "Membership",
                        "sortOrder": 1,
                        "properties": [
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberComments",
                                "label": "Comments",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberFailedPasswordAttempts",
                                "label": "Failed Password Attempts",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberApproved",
                                "label": "Is Approved",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLockedOut",
                                "label": "Is Locked Out",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 3,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLastLockoutDate",
                                "label": "Last Lockout Date",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 4,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLastLogin",
                                "label": "Last Login Date",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 5,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLastPasswordChangeDate",
                                "label": "Last Password Change Date",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 6,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Member",
                "_createDate": "2019-09-20T12:07:43.987Z",
                "_id": "d59be02f-1df9-4228-aa1e-01917d806cda",
                "_updateDate": "2019-09-20T12:07:43.987Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/member/type/Member"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/member/type"
                    }
                }
            },
            {
                "alias": "shopMembers",
                "compositions": [],
                "groups": [
                    {
                        "name": "Shop Details",
                        "sortOrder": 0,
                        "properties": [
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": true,
                                "alias": "favouriteProduct",
                                "label": "Favourite Product",
                                "propertyEditorAlias": "Umbraco.TextBox",
                                "sortOrder": 0,
                                "validation": {
                                    "required": true
                                }
                            }
                        ]
                    },
                    {
                        "name": "Membership",
                        "sortOrder": 1,
                        "properties": [
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberComments",
                                "label": "Comments",
                                "propertyEditorAlias": "Umbraco.TextArea",
                                "sortOrder": 0,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberFailedPasswordAttempts",
                                "label": "Failed Password Attempts",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 1,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberApproved",
                                "label": "Is Approved",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 2,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLockedOut",
                                "label": "Is Locked Out",
                                "propertyEditorAlias": "Umbraco.TrueFalse",
                                "sortOrder": 3,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLastLockoutDate",
                                "label": "Last Lockout Date",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 4,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLastLogin",
                                "label": "Last Login Date",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 5,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberLastPasswordChangeDate",
                                "label": "Last Password Change Date",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 6,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberPasswordRetrievalAnswer",
                                "label": "Password Answer",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 7,
                                "validation": {
                                    "required": false
                                }
                            },
                            {
                                "isSensitive": false,
                                "memberCanEdit": false,
                                "memberCanView": false,
                                "alias": "umbracoMemberPasswordRetrievalQuestion",
                                "label": "Password Question",
                                "propertyEditorAlias": "Umbraco.Label",
                                "sortOrder": 8,
                                "validation": {
                                    "required": false
                                }
                            }
                        ]
                    }
                ],
                "name": "Shop Members",
                "_createDate": "2019-10-10T12:07:17.37Z",
                "_id": "ff345c85-dd87-49f2-a1de-ab7a23e54aea",
                "_updateDate": "2019-10-10T12:07:17.37Z",
                "_links": {
                    "self": {
                        "href": "https://api.umbraco.io/member/type/shopMembers"
                    },
                    "root": {
                        "href": "https://api.umbraco.io/member/type"
                    }
                }
            }
        ]
    }
}
```

## Get by alias

Get a specific member type by its alias.

**URL**: `/member/type/{alias}`

**Method**: `GET`

**Permissions required** : Access to Settings section of the Umbraco Backoffice

### Success Response

**Code**: 200

**Content Example**:

```json
{
    "alias": "Member",
    "compositions": [],
    "groups": [
        {
            "name": "Membership",
            "sortOrder": 1,
            "properties": [
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberComments",
                    "label": "Comments",
                    "propertyEditorAlias": "Umbraco.TextArea",
                    "sortOrder": 0,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberFailedPasswordAttempts",
                    "label": "Failed Password Attempts",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 1,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberApproved",
                    "label": "Is Approved",
                    "propertyEditorAlias": "Umbraco.TrueFalse",
                    "sortOrder": 2,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberLockedOut",
                    "label": "Is Locked Out",
                    "propertyEditorAlias": "Umbraco.TrueFalse",
                    "sortOrder": 3,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberLastLockoutDate",
                    "label": "Last Lockout Date",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 4,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberLastLogin",
                    "label": "Last Login Date",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 5,
                    "validation": {
                        "required": false
                    }
                },
                {
                    "isSensitive": false,
                    "memberCanEdit": false,
                    "memberCanView": false,
                    "alias": "umbracoMemberLastPasswordChangeDate",
                    "label": "Last Password Change Date",
                    "propertyEditorAlias": "Umbraco.Label",
                    "sortOrder": 6,
                    "validation": {
                        "required": false
                    }
                }
            ]
        }
    ],
    "name": "Member",
    "_createDate": "2019-09-20T12:07:43.987Z",
    "_id": "d59be02f-1df9-4228-aa1e-01917d806cda",
    "_updateDate": "2019-09-20T12:07:43.987Z",
    "_links": {
        "self": {
            "href": "https://api.umbraco.io/member/type/Member"
        },
        "root": {
            "href": "https://api.umbraco.io/member/type"
        }
    }
}
```
