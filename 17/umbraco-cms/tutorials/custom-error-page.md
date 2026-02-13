---
description: >-
  A set of tutorials for creating and implementating custom error pages in an
  Umbraco CMS project.
---

# Implement Custom Error Pages

Umbraco is built on Microsoft's .NET Framework and uses ASP.NET. This provides different options when setting up custom error pages on your website.

Implementing custom error handling can make your site look more on-brand and minimize the impact that errors have on user experience. For example, a custom 404 page with helpful links or a search function can add extra value to your site.

## In-code error page handling

In Umbraco, in-code error page handling refers to managing and displaying custom error pages directly through code. This method provides greater flexibility and control over how errors are handled and presented to users, especially within the context of an Umbraco site.

This article contains guides on how to create custom error pages for the most common scenarios:

* [404 Errors ("Page not found")](custom-error-page.md#404-errors)
* [500 Errors ("Internal Server Error")](custom-error-page.md#500-errors)
* [Boot Failed Errors](custom-error-page.md#boot-failed-errors)

{% hint style="info" %}
**Are you looking for a guide to create a custom maintenance page?**

This has been moved to a separate article: [Create a custom maintenance page](create-a-custom-maintenance-page.md).
{% endhint %}

## 404 Errors

{% hint style="warning" %}
To follow this guide successfully, ensure you're using Umbraco version 16.1 or later, as it fixes a regression from version 16.0. For more details, see the [Breaking changes](https://our.umbraco.com/download/releases/1610) section in the Release Notes.
{% endhint %}

A 404 error occurs when a requested page cannot be found, usually due to deleted content, a changed URL, or an invalid path. In Umbraco, you can create and configure custom 404 pages using content from the backoffice.

### Create a Page Not Found page in the backoffice

1. Go to the **Settings** section in the backoffice.
2. Create a new **Document Type with Template**.
3. Name the Document Type _Page Not Found_.
4. [Optional] Add custom properties (for example, title, message), though most 404 pages are static.
5. Click **Save**.
6. Go to the **Templates** folder and edit the generated template.
7. Add your custom markup and design for the error page in the template.
8. Click **Save**.

### [Optional] Create a Container for Error Pages

You can create a _Page Not Found_ page directly in your content tree, or organize it within a container for error pages. Using a container allows for better content organization, especially if you plan to handle multiple status codes (for example, 404, 500, maintenance, and so on). Both options work as long as the page ID is referenced correctly in the `appsettings.json` file.

1. Create a new **Document Type**.
2. Name it _Error Pages Container_.
3. Go to the **Structure** Workspace view.
   * Enable **Allow at root**.
   * Add the _Page Not Found_ Document Type as an **Allowed child node types**.
   * Click **Choose**.
4. Click **Save**.

![Container Config](../.gitbook/assets/container.png)

### Add the Content

1. Go to the **Content** section.
2. Create a new content node based on the _Error Pages Container_ Document Type. For example _Error Page_.
3. Click **Save** or **Save and Publish**.
4. Create a child node, using the _Page Not Found_ Document Type.
5. Name it _Page Not Found_ or similar.
   * This will be the content shown when a 404 error occurs.
6. Click **Save** or **Save and Publish**.

![Child Node](../.gitbook/assets/page-not-found.png)

### [Recommended]: Configuration via the `appsettings.json` file

After publishing the _Page Not Found_ page, connect it in the configuration:

1. Go to the **Info** tab of the _Page Not Found_ content item in the Backoffice.
2. Copy the **Id** of the page (for example: 06cf09c8-c83a-4dd7-84e5-6d98d51e4d12).
3. Go to your project's `appsettings.json` file.
4. Add the `Error404Collection` setting to `Umbraco:CMS:Content`, like shown below:

```json
{
    "Umbraco": {
        "CMS": {
            "Content": {
                "Error404Collection": [
                    {
                        "Culture": "default",
                        "ContentKey": "06cf09c8-c83a-4dd7-84e5-6d98d51e4d12"
                    }
                ]
            }
        }
    }
}
```

Replace the value for `ContentKey` with the ID of your own _Page Not Found_ page.

#### Support for Multilingual Sites

You can define different error pages for each language or culture (such as `en-us`, `da-dk`, and so on):

```json
"Error404Collection": [
  {
    "Culture": "en-us",
    "ContentKey": "guid-for-english-404"
  },
  {
    "Culture": "da-dk",
    "ContentKey": "guid-for-danish-404"
  }
]
```

Each entry maps a culture to its specific 404 page using the content’s GUID.

### [Advanced]: Set a custom 404 page using IContentLastChanceFinder

It is also possible to set up a 404 error page programmatically using `IContentLastChanceFinder`. To learn more about `IContentLastChanceFinder`, read the [Custom Routing](../implementation/custom-routing/) article. Use this approach only if you need dynamic logic, multi-tenant routing, or other custom behavior.

Before following this example, follow the [Create a Page Not Found page in the backoffice](custom-error-page.md#create-a-page-not-found-page-in-the-backoffice) part. The example below will use the _Page Not Found_ alias of the Document Type to find and display the error page.

1. Create a new `.cs` file called `PageNotFound.cs` at the root of the project.
2. Add the following code to the newly created class:

{% code title="PageNotFound.cs" lineNumbers="true" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Web;

namespace YourProjectNamespace;

public class PageNotFound : IContentLastChanceFinder
{
    private readonly IUmbracoContextFactory _umbracoContextFactory;

    // Replace with your actual 404 page GUID
    private static readonly Guid NotFoundPageKey =
        Guid.Parse("PUT-YOUR-404-GUID-HERE");

    public PageNotFound(IUmbracoContextFactory umbracoContextFactory)
    {
        _umbracoContextFactory = umbracoContextFactory;
    }

    public Task<bool> TryFindContent(IPublishedRequestBuilder request)
    {
        using var contextRef = _umbracoContextFactory.EnsureUmbracoContext();

        var notFoundPage = contextRef
            .UmbracoContext
            .Content?
            .GetById(NotFoundPageKey);

        if (notFoundPage == null)
            return Task.FromResult(false);

        request.SetPublishedContent(notFoundPage);
        request.SetResponseStatus(404);

        return Task.FromResult(true);
    }
}

// Register the content finder
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.SetContentLastChanceFinder<PageNotFound>();
    }
}
```
{% endcode %}

## 500 Errors

This section guides you in setting up a custom page for handling internal server errors (500 errors) in your Umbraco site. This setup works when:

* A template throws an error.
* A controller throws an unhandled exception.
* A request hits the application, but something fails during rendering or processing.

### Create a 500 error page in the Backoffice

1. Go to the **Settings** section in the Umbraco backoffice.
2. Create a new **Document Type with Template** called _ErrorPage500_.
3. [Optional] Add any relevant properties to the Document Type.
4. Click **Save**.
5. Go to the **Templates** folder.
6. Add your custom markup and design for the error page in the template. In this case, _ErrorPage500_.
7. Click **Save**.

### [Optional] Create a Container for Error Pages

1. Create a new **Document Type**.
2. Name it **Error Pages Container**.
3. Go to the **Structure** Workspace view.
   * Enable **Allow at root**.
   * Add the _ErrorPage500_ Document Type as an **Allowed child node types**.
   * Click **Choose**.
4. Click **Save**.

### Add the Content

1. Go to the **Content** section.
2. Create a new content node based on the _Error Pages Container_ Document Type. For example _Home Page_.
3. Click **Save** or **Save and Publish**.
4. Create a child node, using the _ErrorPage500_ Document Type.
5. Name it _Page 500_ or similar.
   * This will be the content shown when a 500 error occurs.

### Configure the 500 Error Page Programmatically

To ensure that the 500 page is shown during server errors, you’ll need to configure a custom error controller and route handling.

1. Create a folder called `Controllers` in the root of your Umbraco project.
2. Add a new file called `ErrorController.cs` in the `Controllers` folder.
3. Add the following code to the file:

{% code title="ErrorController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Web;

namespace YourProjectNamespace.Controllers;

public class ErrorController : Controller
{
    private readonly IUmbracoContextFactory _umbracoContextFactory;

    
    private static readonly Guid Error500PageKey =
        Guid.Parse("b80a6f63-b074-4932-bf36-550795db90d4"); // Replace with your actual 500 page GUID

    public ErrorController(IUmbracoContextFactory umbracoContextFactory)
    {
        _umbracoContextFactory = umbracoContextFactory;
    }

    [Route("Error")]
    public IActionResult Index()
    {
        if (Response.StatusCode == StatusCodes.Status500InternalServerError)
        {
            using var contextRef = _umbracoContextFactory.EnsureUmbracoContext();

            var error500Page = contextRef
                .UmbracoContext
                .Content?
                .GetById(Error500PageKey);

            if (error500Page != null)
            {
                Response.StatusCode = 500;
                return View(error500Page.GetTemplateAlias(), error500Page);
            }

            // Fallback if page not found
            Response.StatusCode = 500;
            return View("~/Views/Error500Fallback.cshtml");
        }

        return Redirect("/");
    }
}
```
{% endcode %}

{% hint style="info" %}
Replace _YourProjectNamespace_ with the actual project namespace. In Visual Studio, you can right-click the project and select **Sync Namespaces**.
{% endhint %}

4. Add the `/error/` route to the list of reserved paths in the `appSettings.json` file:

{% code title="appSettings.json" %}
```json
"Umbraco": {
"CMS": {
    "Global": {
    "ReservedPaths": "~/app_plugins/,~/install/,~/mini-profiler-resources/,~/umbraco/,~/error/",
    ...
    }
  }
}
```
{% endcode %}

5. Update `Program.cs` to ensure the error route is triggered by unhandled exceptions:

{% code title="Program.cs" %}
```csharp
await app.BootUmbracoAsync();

// Configure exception handling
if (app.Environment.IsDevelopment())
{
    // For testing error pages, use custom error handler
    app.UseExceptionHandler("/error");
    
    // For normal development with detailed errors, comment out the above line
    // and uncomment this line:
    // app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/error");
}

app.UseHttpsRedirection();
```
{% endcode %}

{% hint style="info" %}
To test locally, replace `app.UseDeveloperExceptionPage();` with `app.UseExceptionHandler("/error");`. Otherwise, you'll get the default .NET error page during development.
{% endhint %}

### Testing Your 500 Error Page

To trigger a 500 error on your site, try introducing a rendering error:

For example, if a Document Type has a property called `test`, it is normally rendered as:

```csharp
@Model.Value("test")
```

To trigger a 500 error, modify it to:

```csharp
@Model.ValueTest("test")
```

This will generate a server-side error, allowing you to verify that your custom 500 page is displayed correctly.

### Handling app startup failures

When Umbraco fails to start, you may see a blank screen or receive a `500.30` or `502.5` error. These indicate the web application crashed or failed to initialize.

#### Why can't the app serve an error page?

During startup, Umbraco relies on the ASP.NET Core pipeline. If the app crashes before this pipeline is fully initialized, it can't handle requests or serve custom error pages. That's why you can't rely on Umbraco or ASP.NET Core routing to show error content at this point as it has already failed. For more information, see the [Handle errors in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/error-handling) documentation.

Instead, the web server itself (IIS, NGINX, Apache, and so on) must serve a static fallback 500 page. This page is independent of the application and helps communicate the issue to users when the site is down.

To handle these types of issues:

* Configure your web server (IIS, NGINX, Apache) to serve a static HTML 500 page when the app fails to respond.
* Use uptime monitoring to catch failed starts.
* Check Umbraco logs in `App_Data/Logs` for startup errors.

## Boot Failed Errors

Sometimes you might experience issues with booting up your Umbraco project. This could be a brand new project, or it could be an existing project after an upgrade.

You will be presented with a generic error page when there is an error during boot.

![Boot Failed](<../.gitbook/assets/BootFailedGeneric (1).png>)

You can replace the default BootFailed page with a custom static `BootFailed.html`. Follow the steps below to set it up:

1. Open your project files.
2. Navigate to `wwwroot/config/errors`
   1. If this folder does not exist already, create it.
3. Add a new file called _BootFailed.html_.
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
