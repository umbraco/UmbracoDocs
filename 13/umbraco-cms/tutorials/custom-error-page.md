# Implementing Custom Error Pages

Umbraco is built upon Microsoft's .NET Framework and is using ASP.NET. This provides a number of options when setting up custom error pages on your website.

Custom error handling might make your site look more on-brand and minimize the impact of errors on user experience. An example, a custom 404 with some helpful links (or a search function) could bring some value to the site.

## Contents

This article contains guides on how to create custom error pages for the following types of errors:

* [404 errors ("Page not found")](custom-error-page.md#id-404-errors)
* [500 errors ("Internal Server Error")](custom-error-page.md#id-500-errors)
* [Maintenance Page](custom-error-page.md#maintenance-page)

## In-code error page handling

One way is to watch for error events and serve corresponding pages via C# code.

## 404 errors

In this method, we will use a 404 page created via the backoffice.

#### Create a 404 page in the backoffice

First, create a new Document Type (though you could also use a more generic Document Type if you already have one) called Page404. Make sure the permissions are set to create it under Content. Properties on this Document Type are optional - in most cases, the 404 not found page would be static. Make sure to assign (and fill out) the template for your error page, and then create it in Content.

#### Set a custom 404 page in appsettings.json

Once all of that is done, grab your published error page's ID, GUID or path and head on over to the `appsettings.json`.

The value for error pages can be:

* A content item's GUID ID (example: 26C1D84F-C900-4D53-B167-E25CC489DAC8)
* An XPath statement (example: //errorPages\[@nodeName='My cool error']
* A content item's integer ID (example: 1234)

{% hint style="warning" %}

The current implementation of XPath is suboptimal, marked as obsolete, and scheduled for removal in Umbraco 14. The replacement for ContentXPath is [IContentLastChanceFinder](../implementation/custom-routing/README.md#last-chance-icontentfinder).

If you have implemented XPath in previous versions and upgraded to v13 you might encounter issues with XPath. This article will be updated when we have more details on how the article should be updated.

{% endhint %}

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

{% hint style="info" %}
With this approach, you can set different 404 pages for different languages (cultures) - such as `en-us`, `it` etc.
{% endhint %}

{% hint style="warning" %}
If you are hosting your site on Umbraco Cloud, using an XPath statement is the best approach. This is because content IDs might differ across Cloud environments.
{% endhint %}

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

{% hint style="info" %}
In the above XPath example `//errorPages` is the DocTypeAlias
{% endhint %}

Id example:

```json
{
    "Umbraco": {
        "CMS": {
            "Content": {
                "Error404Collection": [
                    {
                        "Culture": "default",
                        "ContentId": 1088
                    }
                ]
            }
        }
    }
}
```

The above example uses an integer Id value.

## Errors with booting a project

Sometimes you might experience issues with booting up your Umbraco project. This could be a brand new project, or it could be an existing project after an upgrade.

When there is an error during boot you will be presented with a generic error page.

![Boot Failed. Umbraco failed to boot, if you are the owner of the website please see the log file for more details.](images/BootFailedGeneric.png)

In order to customize this error page it is recommend that you create a **new HTML file** using the name `BootFailed.html`. The file must be in a folder `config/errors` in the `wwwroot` on the Physical file system.

The `BootFailed.html` page will only be shown if debugging is disabled in the `appsettings.json` file i.e.

```json
{
    "Umbraco": {
        "CMS": {
            "Hosting": {
                "Debug": false
            }
        }
    }
}
```

The full error can always be found in the log file.

## 500 errors

The following steps guides you through setting up a page for internal server errors (500 errors).

* Create a `~/controllers` folder in your Umbraco web project.
* Create a file in this folder, called `ErrorController.cs`.
* Add the following code to the file:

    ```csharp
    using Microsoft.AspNetCore.Mvc;

    namespace [YOUR_PROJECT_NAME].Controllers;

    public class ErrorController : Controller
    {
        [Route("Error")]
        public IActionResult Index()
        {
            if (Response.StatusCode == StatusCodes.Status500InternalServerError)
            {
                return Redirect("/statuscodes/500");
            }
            else if (Response.StatusCode != StatusCodes.Status200OK)
            {
                return Redirect("/statuscodes");
            }
            return Redirect("/");
        }
    }
    ```

{% hint style="info" %}
**Namespace** replace \[YOUR\_PROJECT\_NAME] by the actual project name. In Visual Studio you can use _Sync Namespaces_ from the project context menu (in _Solution Explorer_ View).
{% endhint %}

* Add an entry in `appSettings.json` for the new route "Error" like so

    ```json
    "Umbraco": {
    "CMS": {
        "Global": {
        "ReservedPaths": "~/app_plugins/,~/install/,~/mini-profiler-resources/,~/umbraco/,~/error/",
        ...
    ```

* Create the redirect pages from 1. step as regular content nodes in the backoffice. They should neither appear in navigation menus or sitemaps. In this example you would create under root node `Statuscodes` with a subnode `500`.
* Update `Program.cs`

```csharp
...
WebApplication app = builder.Build();

if (builder.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/error");
}
```

{% hint style="info" %}
To **test this locally**, in Visual Studio replace `app.UseDeveloperExceptionPage();` by `app.UseExceptionHandler("/error");`. Otherwise you will get the default error page with stack trace etc.&#x20;
{% endhint %}

#### Trigger a 500 error

You can trigger a 500 error on your frontend by changing a Model.Value property in your template. For example, on a Document Type with a property called `test`. The way to render it in the frontend would be `Model.Value("test");` To trigger a 500 error page you can add anything after Value such as `Model.ValueTest("test");`

## Maintenance Page

While upgrading Umbraco in the past it would redirect visitors of the website to the upgrading page.

To prevent this we have added a `maintenance page` that will be shown when visiting the website while Umbraco is in Upgrade runtime mode.

![Maintenance page](images/maintenancePage.png)

It is possible to disable the maintenance page as most upgrades can be done without the website having to restart or go down.

To disable the maintenance page, add the following configuration in the `appSettings.json` file:

```json
{
    "Umbraco": {
        "CMS": {
            "global": {
                "ShowMaintenancePageWhenInUpgradeState": false
            }
        }
    }
}
```

To customize the Maintenance page, in the Umbraco folder create a new folder called: `UmbracoWebsite`.

in this folder create a new file called `maintenance.cshtml`.

Once the file has been created you can style it so it looks the way you want it to.

{% hint style="warning" %}
It is not recommended to let Umbraco be in Upgrade mode for longer periods. Most migrations can be executed while the website continues to work. Consider using this feature, if you know what you are doing.
{% endhint %}

## Are the error pages not working?

If you set up everything correctly and the error pages are not showing correctly, make sure that you are not using

* Custom [ContentFinders](../reference/routing/request-pipeline/icontentfinder.md) in your solution,
* Any packages that allow you to customize redirects, or
* Rewrite rules in web.config that might interfere with custom error handling.

{% hint style="warning" %}
If your code or any packages configures a custom `IContentLastChanceFinder`, the settings in `appSettings.json` will not be used.
{% endhint %}

## Handling errors in ASP.NET Core

For common approaches to handling errors in ASP.NET Core web apps, see the [Handle errors in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling?view=aspnetcore-6.0) article in the Microsoft Documentation.
