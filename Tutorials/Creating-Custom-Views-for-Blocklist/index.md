---
versionFrom: 8.0.0
versionTo: 9.0.0
---

# Custom Views for Block List Editor



## Contents

This article contains guides on how to create custom error pages for the following types of errors:

-   [404 errors ("Page note found")](#404-errors)

## In-code error page handling

One way is to watch for error events and serve corresponding pages via C# code. Please refer to the [Custom 404 handlers](../../Reference/Config/404handlers/) article for an example.

## 404 errors

In this method we will use a 404 page created via the backoffice.

### Create a 404 page in the backoffice

First, create a new document type (though you could also use a more generic document type if you already have one) called Page404.
Make sure the permissions are set to create it under Content.
Properties on this document type are optional - in most cases, the 404 not found page would be static.
Make sure to assign (and fill out) the template for your error page, and then create it in Content.

### Set a custom 404 page in appsettings.json

Once all of that is done, grab your published error page's ID, GUID or path and head on over to the `appsettings.json`.

The value for error pages can be:

-   A content item's GUID ID (example: 26C1D84F-C900-4D53-B167-E25CC489DAC8)
-   An XPath statement (example: //errorPages[@nodeName='My cool error']
-   A content item's integer ID (example: 1234)

That is where the value you grabbed earlier comes in. Fill it out like so:

```json
{
    "Umbraco": {
        "CMS": {
            "Content": {
                "Error404Collection": [
                    {
                        "Culture": "default",
                        "ContentKey": "81dbb860-a2e3-49df-9a1c-2e04a8012c03"
                    }
                ]
            }
        }
    }
}
```

The above sample uses a GUID value.

:::note
With this approach, you can set different 404 pages for different languages (cultures) - such as `en-us`, `it` etc.
:::

:::warning
If you are hosting your site on Umbraco Cloud, the best approach would be using an XPath statement - since content IDs might differ across Cloud environments.
:::

XPath example:

```json
{
    "Umbraco": {
        "CMS": {
            "Content": {
                "Error404Collection": [
                    {
                        "Culture": "default",
                        "ContentXPath": "//errorPages[@nodeName='My cool error']"
                    }
                ]
            }
        }
    }
}
```
