---
description: >-
  A set of tutorials creating and implementating custom error pages in an
  Umbraco CMS project.
---

# Implement Custom Error Pages

Umbraco is built on Microsoft's .NET Framework and uses ASP.NET. This provides different options when setting up custom error pages on your website.

Implementing custom error handling can make your site look more on-brand and minimize the impact that errors have on user experience. For example, a custom 404 page with helpful links or a search function can add extra value to your site.

## In-code error page handling

In Umbraco, in-code error page handling refers to managing and displaying custom error pages directly through code. This method provides greater flexibility and control over how errors are handled and presented to users, especially within the context of an Umbraco site.

This article contains guides on how to create custom error pages for the most common scenarios:

* [404 errors ("Page not found")](custom-error-page.md#id-404-errors)
* [500 errors ("Internal Server Error")](custom-error-page.md#id-500-errors)
* [Boot Failed errors](custom-error-page.md#errors-with-booting-a-project)

{% hint style="info" %}
**Are you looking for a guide to create a custom maintenance page?**

This has been moved to a separate article: [Create a custom maintenance page](create-a-custom-maintenance-page.md).
{% endhint %}

## 404 errors

This kind of error can occur when something has been removed, when a path has been changed, or when the chosen path is invalid.

This method will use a 404 page created via the backoffice.

### Create a 404 page in the backoffice

1. Navigate to the **Settings** section.
2. Create a new "_Document Type with Template_".
3. Name the Document Type **404**.
4. Adjust the alias to "Page404" before saving the Document Type. Umbraco will not allow you to create a Document Type with a numeric alias.
5. \[Optional] Add properties on the Document Type.
   1. In most cases, the 404 not found page would be static.
6. Fill out the Template with your custom markup.
7. Create another **Document Type**, but create it without the Template.
8. Call this Document Type **Statuscodes**.
9. Open the **Structure** Workspace view.
10. Check the **Allow at root** option.
11. Add the **404 Page** Document Type as an **Allowed child note type**.
12. Navigate to the **Content** section.
13. Create a **Statuscodes** content item called **Statuscodes**.
14. Create a **404 Page** content item under the **Statuscodes** content.

### Set a custom 404 page in the configuration

Once that is done, the next step focuses on setting up the appropriate configuration.

1. Take note of the published error page's GUID.
2. Open the `appsettings.json` file in a code editor.
3. Add the `Error404Collection` section to `Umbraco:CMS:Content`, like shown below:

```json
{
    "Umbraco": {
        "CMS": {
            "Content": {
                "Error404Collection": [
                    {
                        "Culture": "default",
                        // Replace the value for ContentKey with the GUID from step 1
                        "ContentKey": "81dbb860-a2e3-49df-9a1c-2e04a8012c03"
                    }
                ]
            }
        }
    }
}
```

{% hint style="info" %}
With this approach, you can set different 404 pages for specific languages (cultures) - such as `en-us`, `it` etc.
{% endhint %}

### Set a custom 404 page using IContentLastChanceFinder

It is also possible to set up a 404 error page programmatically using `IContentLastChanceFinder`. To learn more about `IContentLastChanceFinder` read the [Custom Routing ](../implementation/custom-routing/)article.

Before following this example, follow the [Create a 404 page in the backoffice](custom-error-page.md#create-a-404-page-in-the-backoffice) part. The example below will use the `Page404` alias of the Document Type to find and display the error page.

1. Create a new `.cs` file called `Error404Page` at the root of the project.
2. Add the following code to the newly created class:

{% code title="Error404Page.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Web;

namespace YourProjectNamespace;

public class Error404Page : IContentLastChanceFinder
{
 private readonly IUmbracoContextAccessor _contextAccessor;

 public Error404Page(IUmbracoContextAccessor contextAccessor)
 {
  _contextAccessor = contextAccessor;
 }

 public Task<bool> TryFindContent(IPublishedRequestBuilder request)
 {
  // In the rare case that an umbracoContext cannot be built from the request,
  // we will not be able to find the page
  if (_contextAccessor.TryGetUmbracoContext(out var umbracoContext) == false)
  {
   return Task.FromResult(false);
  }

  // Find the first notFound page at the root level through the published content cache by its documentTypeAlias
  // You can make this search as complex as you want, you can return different pages based on anything in the original request
  var notFoundPage = umbracoContext.Content?.GetAtRoot().FirstOrDefault(c => c.ContentType.Alias == "Page404");
  if (notFoundPage == null)
  {
   return Task.FromResult(false);
  }

  //Set the content on the request and mark our search as successful
  request.SetPublishedContent(notFoundPage);
  request.SetResponseStatus(404);
  return Task.FromResult(true);
 }
}

// ContentFinders need to be registered into the DI container through a composer
public class Mycomposer : IComposer
{
 public void Compose(IUmbracoBuilder builder)
 {
  builder.SetContentLastChanceFinder<Error404Page>();
 }
}

```
{% endcode %}

## 500 errors

The following steps will guide you through setting up a page for internal server errors.

### Create a 500-page in the backoffice

The first step is to create the content and structure for it in the Umbraco backoffice.

1. Access the Umbraco Backoffice.
2. Navigate to the **Settings** section.
3. Create a new **Document Type with Template** called **500**.
4. \[Optional] Add relevant properties to the Document Types and define the Template.
5. Fill out the Template with your custom markup.
6. Follow steps 6-9 in the [Create a 404 page in the backoffice](custom-error-page.md#create-a-404-page-in-the-backoffice).
   1. This step can be skipped if you already have a content structure for error content nodes in the project.
7. Add the **500** Document Type as an **Allowed child node type** on the **Statuscode** Document Type.
8. Navigate to the **Content** section.
9. Create a **Statuscodes** content item if one does not exist already.
10. Create a **500** content item under the **Statuscodes** content.

### Configure the 500 error page programmatically

The next step in this guide is to configure the 500 pages to be shown when an internal server error occurs.

1. Create a folder in the root of your Umbraco project, called `Controllers`.
2. Create a file in this folder, called `ErrorController.cs`.
3. Add the following code to the file:

{% code title="ErrorController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;

namespace YourProjectNamespace.Controllers;

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
{% endcode %}

{% hint style="info" %}
**Namespace:** Replace _YourProjectNamespace_ with the actual project name. In Visual Studio, you can use _Sync Namespaces_ from the project context menu (in _Solution Explorer_ View).
{% endhint %}

4. Add an entry in `appSettings.json` for the new "Error" route:

{% code title="appSettings.json" %}
```json
"Umbraco": {
"CMS": {
    "Global": {
    "ReservedPaths": "~/app_plugins/,~/install/,~/mini-profiler-resources/,~/umbraco/,~/error/",
    ...
```
{% endcode %}

5. Update `Program.cs` with the following code:

{% code title="Program.cs" %}
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
{% endcode %}

{% hint style="info" %}
To **test this locally**, in Visual Studio replace `app.UseDeveloperExceptionPage();` by `app.UseExceptionHandler("/error");`. Otherwise, you will get the default error page.
{% endhint %}

### How to trigger a 500 error for testing

You can trigger a 500 error on your front end by changing a `Model.Value` property in your template. For example, on a Document Type with a property called `test`. The way to render it in the front would be `Model.Value("test");` To trigger a 500 error page you can add anything after Value such as `Model.ValueTest("test");`

## Errors with booting a project

Sometimes you might experience issues with booting up your Umbraco project. This could be a brand new project, or it could be an existing project after an upgrade.

You will be presented with a generic error page when there is an error during boot.

![Boot Failed. Umbraco failed to boot, if you are the owner of the website please see the log file for more details.](../../../10/umbraco-cms/tutorials/images/BootFailedGeneric.png)

This page can be overwritten with a custom BootFailed HTML page. Follow the steps below to set it up:

1. Open your project files.
2. Navigate to `wwwroot/config/errors`
   1. If this folder does not exist already, create it.
3. Add a new file called **`BootFailed.html`**.
4. Add your custom markup to the file.

The `BootFailed.html` page will only be shown if debugging is disabled in the `appsettings.json` file. Debugging is handled using the **Debug** key under `Umbraco:CMS:Hosting`:

{% code title="appSettings.json" %}
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
{% endcode %}

{% hint style="info" %}
The full error can always be found in the log file.
{% endhint %}

## Are the error pages not working?

If you set up everything correctly and the error pages are not showing correctly, make sure that you are not using

* Custom [ContentFinders](../reference/routing/request-pipeline/icontentfinder.md) in your solution,
* Any packages that allow you to customize redirects, or
* Rewrite rules that might interfere with custom error handling.

{% hint style="warning" %}
If your code or any packages configure a custom `IContentLastChanceFinder`, the settings in `appSettings.json` will not be used.
{% endhint %}

## Handling errors in ASP.NET Core

For common approaches to handling errors in ASP.NET Core web apps, see the [Handle errors in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling) article in the Microsoft Documentation.
