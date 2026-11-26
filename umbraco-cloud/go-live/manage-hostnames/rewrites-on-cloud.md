# Rewrite rules

Use the ASP.NET Core URL Rewriting Middleware to add rewrite rules to your Umbraco Cloud project.

{% hint style="info" %}
The middleware is recommended on Umbraco Cloud for two reasons:

* The rewrite middleware runs after the Umbraco Cloud platform middleware. This means Umbraco Cloud can handle request and proxy issues without any action from you.
* The middleware works with any hosting platform.
{% endhint %}

Middleware rules are part of your project code, so you don't need a config transform to add them.

For general guidance, see Microsoft's [When to use URL Rewriting Middleware](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting#when-to-use-url-rewriting-middleware) and [URL Rewriting Middleware in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting) documentation.

## Register the rewrite middleware

Register the middleware in your project's `Program.cs` file. Add it after `BootUmbracoAsync()` and before the call to `app.UseUmbraco()`.

```csharp
using Microsoft.AspNetCore.Rewrite;

// ...

WebApplication app = builder.Build();

await app.BootUmbracoAsync();

var rewriteOptions = new RewriteOptions();

// Add your rules here. See the examples below.

app.UseRewriter(rewriteOptions);

app.UseUmbraco()
    // ...
```

## Best practices

When setting up rewrite rules on Umbraco Cloud, there are a few important things to keep in mind:

* Always skip requests to the Umbraco backoffice path, `/umbraco`. Rewriting this path may prevent you from deploying to and from the environment.
* To continue working locally with your Umbraco Cloud project, skip requests to `localhost`.
* Skip the default `umbraco.io` hostnames, unless the rule is meant to target them.
* To serve verification files from the `.well-known` directory (for example, Apple Pay or Google), follow the [Rewrite rule workaround in the CMS documentation](https://docs.umbraco.com/umbraco-cms/reference/routing/iisrewriterules#example-serving-files-from-the-well-known-path).
* Middleware rules run in every environment. If a rule should only apply to the Live environment, check the hostname or the environment in the rule.
* If you move a rule from `web.config` to the middleware, remove the original rule. Otherwise, both rules run.
* If the Umbraco Cloud baseline feature is used, only apply the rewrites to the child project and not the baseline itself.

## Add a helper class for the rules

The examples in this article use a small helper class. The helper keeps the exclusions consistent across your rules.

Add the following class to your project, for example as `CloudRewriteHelpers.cs`:

```csharp
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Rewrite;
using Microsoft.Net.Http.Headers;

public static class CloudRewriteHelpers
{
    public static bool IsLocalhost(HttpRequest request) =>
        request.Host.Host.Equals("localhost", StringComparison.OrdinalIgnoreCase);

    public static bool IsUmbracoIoHost(HttpRequest request) =>
        request.Host.Host.EndsWith(".umbraco.io", StringComparison.OrdinalIgnoreCase);

    public static bool PathStartsWithAny(HttpRequest request, params string[] paths) =>
        paths.Any(path => request.Path.StartsWithSegments(path, StringComparison.OrdinalIgnoreCase));

    public static void RedirectPermanent(RewriteContext context, string location)
    {
        var response = context.HttpContext.Response;
        response.StatusCode = StatusCodes.Status301MovedPermanently;
        response.Headers[HeaderNames.Location] = location;
        context.Result = RuleResult.EndResponse;
    }
}
```

## Hiding the default `umbraco.io` URL

After assigning a hostname to your live environment, you may want to hide the project's default URL (for example, example.euwest01.umbraco.io). This could be for improving Search Engine Optimization (SEO) or to communicate to your users that the site is accessible only through the primary hostname.

To do this, add the following rule to your rewrite options. It redirects all requests for `example.euwest01.umbraco.io` to `example.com`. It uses HTTPS and includes the `www.` prefix, responding with a permanent redirect status.

```csharp
rewriteOptions.Add(context =>
{
    var request = context.HttpContext.Request;
    var host = request.Host.Host;

    if (!CloudRewriteHelpers.IsUmbracoIoHost(request)
        || host.StartsWith("dev-", StringComparison.OrdinalIgnoreCase)
        || host.StartsWith("stage-", StringComparison.OrdinalIgnoreCase)
        || CloudRewriteHelpers.IsLocalhost(request)
        || CloudRewriteHelpers.PathStartsWithAny(request, "/umbraco", "/App_Plugins", "/sb")
        || request.Cookies.ContainsKey("UMB_UCONTEXT")) // Ensure preview can render
    {
        return;
    }

    CloudRewriteHelpers.RedirectPermanent(context,
        $"https://www.example.com{request.PathBase}{request.Path}{request.QueryString}");
});
```

{% hint style="info" %}
This rule does not rewrite anything under the `/umbraco` path, so you can still do content deployments. You don't have to give your editors the `umbraco.io` URL, and they won't see it if you give them the actual hostname.

The rule also skips your local copy of the site on `localhost`, and environments whose hostnames start with `dev-` or `stage-`. These prefixes match the default environment names. If you renamed an environment, replace the prefix with that environment's alias, for example `test-`.
{% endhint %}

## Running your site on HTTPS only

Umbraco Cloud forces HTTPS for all hostnames through its Cloudflare proxy. Requests are redirected to HTTPS before they reach your site, so no rewrite rule is needed.

## Adding a trailing slash to your URLs

It is possible to transform all of your URLs to use a trailing slash consistently for SEO.

To accomplish this, add the following rule to your rewrite options. It redirects all requests for `https://example.com/page` to `https://example.com/page/`, and responds with a permanent redirect status. This way you can ensure that you use the trailing slashes consistently on your site.

```csharp
rewriteOptions.Add(context =>
{
    var request = context.HttpContext.Request;
    var path = request.Path.Value ?? string.Empty;

    if (path.EndsWith('/')
        || Path.HasExtension(path) // Skip files, such as media
        || CloudRewriteHelpers.PathStartsWithAny(request, "/umbraco", "/App_Plugins", "/.well-known/acme-challenge"))
    {
        return;
    }

    CloudRewriteHelpers.RedirectPermanent(context,
        $"{request.PathBase}{path}/{request.QueryString}");
});
```

{% hint style="info" %}
Take note of the exclusions in the rewrite rule.

It is important to skip the file paths on your site. If a trailing slash is added, your media may not display correctly after [migrating to Azure Blob Storage](/umbraco-cloud/build-and-customize-your-solution/handle-deployments-and-environments/media.md).
{% endhint %}

## Redirect from `non-www` to `www`

Another example would be to redirect from `non-www` to `www`:

```csharp
rewriteOptions.Add(context =>
{
    var request = context.HttpContext.Request;

    if (request.Host.Host.StartsWith("www.", StringComparison.OrdinalIgnoreCase)
        || CloudRewriteHelpers.IsLocalhost(request)
        || CloudRewriteHelpers.IsUmbracoIoHost(request))
    {
        return;
    }

    CloudRewriteHelpers.RedirectPermanent(context,
        $"https://www.{request.Host}{request.PathBase}{request.Path}{request.QueryString}");
});
```
