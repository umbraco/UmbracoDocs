---
description: "Customizing the ASP.NET middleware pipeline in Umbraco"
---

# Middleware

Middleware is a way of handling requests and responses before or after they are completed. An example can be checking if a user is logged in before adding an item to the cart. In this example it checks something before an http request is made.

In Umbraco we configure some middleware by default and in a specific order based on the [Microsoft Documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware/?view=aspnetcore-7.0#middleware-order).

You are also able to add your own in-between middleware by using the Umbraco pipeline filters. In addtion you can also add settings such as: the `PrePipeline`, `PostPipeline`, `PreRouting`, `PostRouting`, and [`Endpoints`](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-7.0#endpoints) callbacks.

- `PrePipeline` occurs as an early stage of request pipeline and an influence how requests are processed. An example of using Prepipeline can be for [URL rewrites](iisrewriterules.md)
- `PostPipeline`renders content. By using middleware, the response of content can be changed before being rendered.
- `PreRouting`can be used to change the incoming URL/definers which URL should be served for the content
- `PostRouting`can be used to change how the content should be displayed based on routing parameters.
- `Endpoints` is the final step of the request pipeline where the content is rendered and returned on the requested browser.

The addition of the `PreRouting` and `PostRouting` is to allow correctly configuring the Cross-Origin Resource Sharing (CORS) middleware. This is done using the `IUmbracoPipelineFilters` without having to use the `WithCustomMiddleware()`.

- `IUmbracoPipelineFilter` is an interface in Umbraco that allows the creation of custom filters which then modifies the behavior of the request pipeline. It can be used to change different aspects of how Umbraco handles incoming requests, such as changing content or adding security checks.
- `WithCustomMiddleware()` is a method that can be used in Umbraco for adding custom middleware. This includes some specific customizable instructions that run in the request processing pipeline. This method is often used in combination with IUmbracoPipelineFilter.

{% hint style="warning" %}

`WithCustomMiddleware` should only be used as a last resort, as Umbraco can break if you forget to add middleware or add them in the wrong order.  

{% endhint %}

## Configuring the Cross-Origin Resource Sharing (CORS) middleware

Create a composer with the following:

```csharp

using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Web.Common.ApplicationBuilder;

public class CorsComposer : IComposer
{
    public const string AllowAnyOriginPolicyName = nameof(AllowAnyOriginPolicyName);

    public void Compose(IUmbracoBuilder builder)
        => builder.Services
        .AddCors(options => options.AddPolicy(AllowAnyOriginPolicyName, policy => policy.AllowAnyOrigin()))
        .Configure<UmbracoPipelineOptions>(options => options.AddFilter(new UmbracoPipelineFilter("Cors", postRouting: app => app.UseCors())))
        // For testing only
        .Configure<UmbracoPipelineOptions>(options => options.AddFilter(new UmbracoPipelineFilter("CorsTest", endpoints: app => app.UseEndpoints(endpoints =>
        {
            endpoints.MapGet("/echo", context => context.Response.WriteAsync("echo")).RequireCors(AllowAnyOriginPolicyName);
            endpoints.MapGet("/echo2", context => context.Response.WriteAsync("echo2"));
        }))));
}
```

You should be able to request /echo from any origin, but get an error when trying to fetch /echo2. You can test this by pasting the following JavaScript code in your browser console when not on the local Umbraco website (such as Umbraco.com):

```javascript
fetch('https://localhost:44331/echo', {method: 'GET'}).then(result => result.text().then(text => console.log(text)));
fetch('https://localhost:44331/echo2', {method: 'GET'}).then(result => result.text().then(text => console.log(text)));
```

This should return the following:
<figure><img src="../images/custom-middleware-cors-browser-example.png" alt=""><figcaption><p>Browser result image</p></figcaption></figure>

An additional bonus is that this doesn't require any changes in your `Startup.cs` file. It also allows packages to enable Cross-Origin Resource Sharing (CORS) and configure their own policies.

Users that currently use `WithCustomMiddleware()` will need to add calls to `RunPreRouting()` and `RunPostRouting()`. This is similar to Umbraco adding additional middleware in future versions.

You can find more information about this example in the github PR [Add PreRouting and PostRouting pipeline filters](https://github.com/umbraco/Umbraco-CMS/pull/14503)
