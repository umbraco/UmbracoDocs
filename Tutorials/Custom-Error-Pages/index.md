---
versionFrom: 9.0.0
---

# Implementing custom error pages

Since Umbraco is built upon Microsoft's .NET Framework and is using ASP.NET, you have several options when it comes to setting up custom error pages on your website.

Custom error handling might make your site look more on-brand and minimize the impact of errors on user experience - for example, a custom 404 with some helpful links (or a search function) could bring some value to the site.

## Contents

This article contains guides on how to create custom error pages for the following types of errors:

- [404 errors ("Page not found")](#404-errors)

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

- A content item's GUID ID (example: 26C1D84F-C900-4D53-B167-E25CC489DAC8)
- An XPath statement (example: //errorPages[@nodeName='My cool error']
- A content item's integer ID (example: 1234)

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

:::note
In the above XPath example `//errorPages` is the DocTypeAlias
:::

## Errors with booting a project

Sometimes you might experience issues with booting up your Umbraco project. This could be a brand new project, or it could be an existing project after an upgrade.

When there is an error during boot you will presented with a generic error page.

![Boot Failed. Umbraco failed to boot, if you are the owner of the website please see the log file for more details.](images/BootFailedGeneric.png "Screen shot of generic BootFailed page")

In order to customize this error page it is recommend that you create a **new HTML file** using the name `BootFailed.html`. The file must be in a folder `config/errors` in the wwwroot on the Physical file system.

:::note
The `BootFailed.html` page will only be shown if debugging is disabled in `appsettings.json` i.e.

```json  
"Umbraco": {
    "CMS": {
      "Hosting": {
        "Debug": false
      }
    }
  }
```

The full error can always be found in the log file.
:::

## Are the error pages not working?

If you set up everything correctly and the error pages are not showing correctly, make sure that you are not using

- Custom [ContentFinders](../../Reference/routing/request-pipeline/IContentFinder/) in your solution,
- Any packages that allow you to customize redirects, or
- Rewrite rules in web.config that might interefere with custom error handling.

## Handling errors in ASP.NET Core

For common approaches to handling errors in ASP.NET Core web apps, see the [Handle errors in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling?view=aspnetcore-6.0) article in the Microsoft Documentation.
