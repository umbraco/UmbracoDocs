# Rewrite rules

Use the ASP.NET Core URL Rewriting Middleware to add rewrite rules to your Umbraco Cloud project.

{% hint style="info" %}
Middleware rewrites are recommended over IIS rewrites on Umbraco Cloud for two reasons:

* The middleware runs after Umbraco Cloud corrects the request host at startup. IIS rewrite rules run before that correction, so they can act on an incorrect host.
* Middleware rewrites work with any hosting provider. IIS rewrites only work on IIS.
{% endhint %}

Middleware rules are part of your project code, so you don't need a config transform to add them.

If your project runs Umbraco 8, use IIS rewrite rules instead. For more information, see the [IIS rewrite rules](#iis-rewrite-rules) section.

For more information about the middleware, see Microsoft's [URL Rewriting Middleware in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting) documentation.

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

* Always skip requests to the Umbraco backoffice path (`/umbraco`). Rewriting this path may prevent you from deploying to and from the environment.
* To continue working locally with your Umbraco Cloud project, skip requests to `localhost`.
* Skip the default `umbraco.io` hostnames, unless the rule is meant to target them.
* To serve verification files from the `.well-known` directory (for example, Apple Pay or Google), follow the [Rewrite rule workaround in the CMS documentation](https://docs.umbraco.com/umbraco-cms/reference/routing/iisrewriterules#example-serving-files-from-the-well-known-path).
* Middleware rules run in every environment. If a rule should only apply to the Live environment, check the hostname or the environment in the rule.
* If you move a rule from IIS to middleware, remove the IIS rule. Otherwise, both rules run, and the IIS rule still runs first.
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
This rule does not rewrite anything under the `/umbraco` path, so you can still do content deployments. You don't have to give your editors the `umbraco.io` URL, and they won't see it if you give them the actual hostname. This rule also does not apply to your Development and Staging environments, or to your local copy of the site running on `localhost`.
{% endhint %}

## Running your site on HTTPS only

Once you've applied a certificate to your site, anybody visiting your site will always end up on HTTPS instead of the insecure HTTP.

To accomplish this, add the following rule to your rewrite options. It redirects all requests for the <http://example.com> URL to the secure <https://example.com> URL and responds with a permanent redirect status.

```csharp
rewriteOptions.Add(context =>
{
    var request = context.HttpContext.Request;

    if (request.IsHttps
        || CloudRewriteHelpers.IsLocalhost(request)
        || CloudRewriteHelpers.PathStartsWithAny(request, "/.well-known/acme-challenge"))
    {
        return;
    }

    CloudRewriteHelpers.RedirectPermanent(context,
        $"https://{request.Host}{request.PathBase}{request.Path}{request.QueryString}");
});
```

{% hint style="info" %}
This redirect rule does not apply when the request is already going to the secure HTTPS URL. It also does not apply to your local copy of the site running on `localhost`.
{% endhint %}

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

## Redirect from non-www to www

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

## IIS rewrite rules

Umbraco 8 projects can't use ASP.NET Core middleware, so they need IIS rewrite rules. The IIS Rewrite Module is installed on all Umbraco Cloud servers. The best practices above also apply to IIS rules.

For Umbraco 9 and later, use a [config transform](/umbraco-cloud/build-and-customize-your-solution/set-up-your-project/project-settings/config-transforms.md) to add IIS rewrite rules.

{% hint style="info" %}
If you are running Umbraco 8, the rewrite rule can be added directly to your project's `web.config`.
{% endhint %}

The rewrite rules should be added to the `<system.webServer><rewrite>` module in your project's `web.config` file.

```xml
<!--
<rewrite>
    <rules></rules>
</rewrite>
-->
```

### Hiding the default `umbraco.io` URL with IIS

```xml
<rule name="Redirect umbraco.io to primary hostname" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTP_HOST}" pattern="\.umbraco\.io$" />
    <add input="{HTTP_HOST}" pattern="^(dev-|stage-)(.*)?\.umbraco\.io$" ignoreCase="true" negate="true" />
    <add input="{REQUEST_URI}" pattern="^/umbraco" ignoreCase="true" negate="true" />
    <add input="{REQUEST_URI}" pattern="^/App_Plugins" ignoreCase="true" negate="true" />
    <add input="{REQUEST_URI}" pattern="^/sb" negate="true" /> <!-- Don't redirect Smidge Bundle -->
    <add input="{HTTP_COOKIE}" pattern="^(.+; )?UMB_UCONTEXT=([^;]*)(;.+)?$" negate="true" /> <!-- Ensure preview can render -->
    <add input="{HTTP_HOST}" pattern="^localhost(:[0-9]+)?$" negate="true" />
  </conditions>
  <action type="Redirect" url="https://www.example.com/{R:0}" redirectType="Permanent" />
</rule>
```

### Running your site on HTTPS only with IIS

```xml
<rule name="Redirect HTTP to HTTPS" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTPS}" pattern="^OFF$" />
    <add input="{HTTP_HOST}" negate="true" pattern="^localhost(:[0-9]+)?$" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/\.well-known/acme-challenge/" />
  </conditions>
  <action type="Redirect" url="https://{HTTP_HOST}/{R:0}" redirectType="Permanent" />
</rule>
```

### Adding a trailing slash with IIS

```xml
<rule name="Add trailing slash" stopProcessing="true">
  <match url="(.*[^/])$" />
  <conditions>
    <add input="{REQUEST_FILENAME}" negate="true" matchType="IsDirectory" />
    <add input="{REQUEST_FILENAME}" negate="true" matchType="IsFile" />
    <add input="{REQUEST_FILENAME}" negate="true" pattern="(.*?)\.[a-zA-Z0-9]{1,4}$" />
    <add input="{REQUEST_URI}" pattern="^/umbidlocallogin" negate="true" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins/" />
    <add input="{REQUEST_URI}" negate="true" pattern="^/\.well-known/acme-challenge/" />
  </conditions>
  <action type="Redirect" url="{R:1}/" />
</rule>
```

### Redirect from non-www to www with IIS

```xml
<rule name="Redirect to www prefix" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTP_HOST}" negate="true" pattern="^www\." />
    <add input="{HTTP_HOST}" negate="true" pattern="^localhost(:[0-9]+)?$" />
    <add input="{HTTP_HOST}" negate="true" pattern="\.umbraco\.io$" />
  </conditions>
  <action type="Redirect" url="https://www.{HTTP_HOST}/{R:0}" />
</rule>
```

### Custom IIS rewrite rules for Umbraco Cloud

An example config transform to help ensure your custom rules integrate properly:

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
  <location path="." inheritInChildApplications="false">
    <system.webServer>
      <rewrite xdt:Transform="Insert">
        <rules>
          <!-- Add your custom rules here -->
        </rules>
      </rewrite>
    </system.webServer>
  </location>
</configuration>
```
