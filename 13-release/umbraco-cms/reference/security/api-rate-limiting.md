---
description: How to take advantage of the built-in rate limiting middleware of ASP.NET Core in Umbraco.
---

# API rate limiting

Since ASP.NET Core 7, you can use the [built-in rate limiting middleware](https://learn.microsoft.com/en-us/aspnet/core/performance/rate-limit) to rate limit your APIs. You can apply the `EnableRateLimiting` and `DisableRateLimiting` attributes to add rate limiting on a controller or endpoint level. In this article, we will go through how you can configure and utilize different rate limiting strategies for Umbraco APIs.

## What is rate limiting?

Rate limiting helps control the number of requests to an API, typically within a specified time frame or based on other parameters. This ensures the stability, availability, and security of your APIs. The key benefits are:
- Preventing server or application overload
- Improving security and protecting against DDoS attacks
- Reducing unnecessary resource usage, thereby cutting down on costs

## Configuring rate limiting
You can configure rate limiting in Umbraco by composition. To use the middleware, you need to register the rate limiting services first:

{% code title="ApiRateLimiterComposer.cs" %}
```csharp
public class ApiRateLimiterComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddRateLimiter(rateLimiterOptions =>
        {
            // Default is 503 (Service Unavailable)
            rateLimiterOptions.RejectionStatusCode = StatusCodes.Status429TooManyRequests;

            // Write your code to configure the middleware here (rate limiting policies)
        });
    }
}
```
{% endcode %}
After that, you have to apply the `RateLimitingMiddleware` by creating an Umbraco pipeline filter. `UseRateLimiter()` must be called after `UseRouting()`, therefore we use the `PostRouting` to make sure this happens in the correct order:

{% code title="ApiRateLimiterComposer.cs" %}
```csharp
public class ApiRateLimiterComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter("UmbracoApiRateLimiter")
            {
                PostRouting = postRouting =>
                {
                    // Apply the RateLimitingMiddleware
                    // Must be called after UseRouting()
                    postRouting.UseRateLimiter();
                }
            });
        });
    }
}
```
{% endcode %}

With the set-up in place, let's take a look at some limiter options.

### Global limiter
Inside `AddRateLimiter()` we can use the `GlobalLimiter` option to set a global rate limiter for all requests:

{% code title="ApiRateLimiterComposer.cs" %}
```csharp
            // Write your code to configure the middleware here (rate limiting policies)

            // Use GlobalLimiter for all requests
            rateLimiterOptions.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(httpContext =>
            {
                return RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: httpContext.Request.Headers.Host.ToString(), 
                    partition => new FixedWindowRateLimiterOptions
                    {
                        PermitLimit = 2,
                        Window = TimeSpan.FromSeconds(10),
                        AutoReplenishment = true
                    });
            });
```
{% endcode %}

In the above example, we have added a `FixedWindowLimiter` and configured it to automatically replenish permitted requests and permit 2 requests per 10 seconds. There are different algorithms and techniques for implementing rate limiting, which can vary depending on your use case. For more information, check the currently supported [rate limiter algorithms](https://learn.microsoft.com/en-us/aspnet/core/performance/rate-limit#rate-limiter-algorithms).

### Limit specific endpoints
If you want to be more granular, you can configure different rate limits for different endpoints in `AddRateLimiter()` as well:

{% code title="ApiRateLimiterComposer.cs" %}
```csharp
            // Write your code to configure the middleware here (rate limiting policies)

            // Add specific rate limiting policies
            rateLimiterOptions.AddFixedWindowLimiter(policyName: "fixed1", options =>
            {
                options.PermitLimit = 2;
                options.Window = TimeSpan.FromSeconds(10);
                options.AutoReplenishment = true;
            });
            
            rateLimiterOptions.AddFixedWindowLimiter(policyName: "fixed2", options =>
            {
                options.PermitLimit = 5;
                options.Window = TimeSpan.FromSeconds(10);
                options.AutoReplenishment = true;
            });
```
{% endcode %}

In the code snippet above, we have configured 2 fixed window limiters with different settings, and different policy names (`"fixed1"` and `"fixed2"`). We can apply these policies to specific endpoints within Umbraco using the same `UmbracoPipelineFilter`:

{% code title="ApiRateLimiterComposer.cs" %}
```csharp
                    // Applying EnableRateLimitingAttribute to specific endpoint
                    postRouting.Use(async (context, next) =>
                    {
                        // Limit specific controller(s)
                        var controllerName = ControllerExtensions.GetControllerName<AuthenticationController>();
                        var actionName = nameof(AuthenticationController.PostRequestPasswordReset);

                        var currentEndpoint = context.GetEndpoint();
                        var actionDescriptor = currentEndpoint?.Metadata.GetMetadata<ControllerActionDescriptor>();

                        // Apply rate limiting logic based on your conditions
                        if (currentEndpoint is not null &&
                            actionDescriptor is not null &&
                            actionDescriptor.ControllerName == controllerName &&
                            actionDescriptor.ActionName == actionName)
                        {
                            // Apply rate limiting logic based on your conditions
                            
                            // Add Attribute to endpoint's metadata
                            var endpointMetadataCollection = new EndpointMetadataCollection(
                                new List<object>(currentEndpoint.Metadata)
                                {
                                    new EnableRateLimitingAttribute("fixed1")
                                });

                            // Update endpoint
                            var updatedEndpoint = new Endpoint(
                                currentEndpoint.RequestDelegate,
                                endpointMetadataCollection,
                                currentEndpoint.DisplayName);

                            context.SetEndpoint(updatedEndpoint);
                        }

                        await next.Invoke();
                    });
```
{% endcode %}

This part of the code shows how to apply the `fixed1` policy to the `AuthenticationController.PostRequestPasswordReset` endpoint, responsible for handling password reset requests. We can do that by dynamically modifying the endpoint's metadata - attaching the `EnableRateLimitingAttribute` with the name of the policy which needs to be applied. This enables us to enforce the defined rate limits on a particular endpoint.

For your reference, here is the complete `ApiRateLimiterComposer.cs` implementation.

{% code title="ApiRateLimiterComposer.cs" lineNumbers="true" %}
```csharp
using System.Threading.RateLimiting;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.RateLimiting;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Web.BackOffice.Controllers;
using Umbraco.Cms.Web.Common.ApplicationBuilder;

namespace Umbraco.Docs.Samples;

public class ApiRateLimiterComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Register the rate limiting services
        builder.Services.AddRateLimiter(rateLimiterOptions =>
        {
            // Default is 503 (Service Unavailable)
            rateLimiterOptions.RejectionStatusCode = StatusCodes.Status429TooManyRequests;

            // Use GlobalLimiter for all requests
            // rateLimiterOptions.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(httpContext =>
            // {
            //     return RateLimitPartition.GetFixedWindowLimiter(
            //         partitionKey: httpContext.Request.Headers.Host.ToString(),
            //         partition => new FixedWindowRateLimiterOptions
            //         {
            //             PermitLimit = 2,
            //             Window = TimeSpan.FromSeconds(10),
            //             AutoReplenishment = true
            //         });
            // });

            // Add specific rate limiting policies
            rateLimiterOptions.AddFixedWindowLimiter(policyName: "fixed1", options =>
            {
                options.PermitLimit = 2;
                options.Window = TimeSpan.FromSeconds(10);
                options.AutoReplenishment = true;
            });
            
            rateLimiterOptions.AddFixedWindowLimiter(policyName: "fixed2", options =>
            {
                options.PermitLimit = 5;
                options.Window = TimeSpan.FromSeconds(10);
                options.AutoReplenishment = true;
            });
        });

        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter("UmbracoApiRateLimiter")
            {
                PostRouting = postRouting =>
                {
                    // Applying EnableRateLimitingAttribute to specific endpoint
                    postRouting.Use(async (context, next) =>
                    {
                        // Limit specific controller(s)
                        var controllerName = ControllerExtensions.GetControllerName<AuthenticationController>();
                        var actionName = nameof(AuthenticationController.PostRequestPasswordReset);

                        var currentEndpoint = context.GetEndpoint();
                        var actionDescriptor = currentEndpoint?.Metadata.GetMetadata<ControllerActionDescriptor>();
                        
                        // Apply rate limiting logic based on your conditions
                        if (currentEndpoint is not null &&
                            actionDescriptor is not null &&
                            actionDescriptor.ControllerName == controllerName &&
                            actionDescriptor.ActionName == actionName)
                        {   
                            // Add EnableRateLimiting attribute to endpoint's metadata
                            var endpointMetadataCollection = new EndpointMetadataCollection(
                                new List<object>(currentEndpoint.Metadata)
                                {
                                    new EnableRateLimitingAttribute("fixed1")
                                });

                            // Update endpoint
                            var updatedEndpoint = new Endpoint(
                                currentEndpoint.RequestDelegate,
                                endpointMetadataCollection,
                                currentEndpoint.DisplayName);

                            context.SetEndpoint(updatedEndpoint);
                        }

                        await next.Invoke();
                    });

                    // Apply the RateLimitingMiddleware
                    // Must be called after UseRouting()
                    postRouting.UseRateLimiter();
                }
            });
        });
    }
}
```
{% endcode %}