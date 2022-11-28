---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# URL Rewrites

With the release of Umbraco 9 and the change of the underlying web framework that is decoupled from the webserver, the way that you configure rewrites has changed as well.

Instead of the URL Rewriting extension in IIS you can use the [URL Rewriting Middleware in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting?view=aspnetcore-5.0), which needs to be added to your project startup code first.

{% hint style="info" %}
If you are running Umbraco 9 on IIS you can still add a `web.config` file to configure IIS features such as URL rewrites.
{% endhint %}

## When to use the URL Rewriting Middleware

Make sure to check the official [URL Rewriting Middleware in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting?view=aspnetcore-5.0#when-to-use-url-rewriting-middleware) documentation for more information about when you should or should not use the URL Rewriting Middleware.

## Using the URL Rewriting Middleware

To use rewrites with Umbraco 9 you have to register the middleware in your `Startup.cs` by using the [`UseRewriter`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.builder.rewritebuilderextensions.userewriter?view=aspnetcore-5.0) extension method and then configure the rewrite options.

### Example

- Create an `IISUrlRewrite.xml` file in the root of your project (next to your `Startup.cs` file) containing:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<rewrite>
  <rules>
    <rule name="Redirect umbraco.io to preferred domain" stopProcessing="true">
      <match url=".*" />
      <conditions>
        <add input="{HTTP_HOST}" pattern="\.umbraco\.io$" />
        <add input="{REQUEST_URI}" pattern="^/App_Plugins/" negate="true" />
        <add input="{REQUEST_URI}" pattern="^/umbraco" negate="true" />
      </conditions>
      <action type="Redirect" url="https://example.com/{R:0}" />
    </rule>
  </rules>
</rewrite>
```

- In the `Startup.cs` file you can add the URL Rewriting Middleware just before the call to `app.UseUmbraco()` and use [`AddIISUrlRewrite`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.rewrite.iisurlrewriteoptionsextensions.addiisurlrewrite?view=aspnetcore-5.0)) to add the rewrite rules from the XML file:

```csharp
using Microsoft.AspNetCore.Rewrite;

app.UseRewriter(new RewriteOptions().AddIISUrlRewrite(env.ContentRootFileProvider, "IISUrlRewrite.xml"));

```

- In your csproj file add the XML file to a new item group and set `CopyToOutputDirectory` to `Always`:

```xml
<ItemGroup>
  <Content Include="IISUrlRewrite.xml">
    <CopyToOutputDirectory>Always</CopyToOutputDirectory>
  </Content>
</ItemGroup>
```

{% hint style="info" %}
On Umbraco Cloud the item group needs to be set to `<CopyToPublishDirectory>Always</CopyToPublishDirectory>` for the file to be published to your deployed site.
{% endhint %}

## Examples of rewrite rules

* A great site showing 10 very handy IIS Rewrite rules: [URL rewriting tips and tricks](https://ruslany.net/2009/04/10-url-rewriting-tips-and-tricks/)
* Another site showing some handy examples of IIS Rewrite rules: [Some useful IIS rewrite rules](https://odetocode.com/blogs/scott/archive/2014/03/27/some-useful-iis-rewrite-rules.aspx)
* If you needed to a lot of static rewrites using rewrite maps: [Rule with rewrite map rule template](https://www.iis.net/learn/extensions/url-rewrite-module/rule-with-rewrite-map-rule-template)

For example, to always remove a trailing slash from the URL (make sure Umbraco doesn't add a trailing slash to all generated URLs by setting `AddTrailingSlash` to `false` in your [RequestHandler settings](../../V9-Config/RequestHandlerSettings/index.md)):

```xml
<rule name="Remove trailing slash" stopProcessing="true">
  <match url="(.*)/+$" />
  <conditions>
    <add input="{REQUEST_URI}" pattern="^/umbraco" negate="true" />
    <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
    <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
  </conditions>
  <action type="Redirect" url="{R:1}" />
</rule>
```

Another example would be to enforce HTTPS only on your site:

```xml
<rule name="Redirect to HTTPS" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTPS}" pattern="^OFF$" />
    <add input="{HTTP_HOST}" pattern="^localhost(:[0-9]+)?$" negate="true" />
  </conditions>
  <action type="Redirect" url="https://{HTTP_HOST}/{R:0}" />
</rule>
```

Another example would be to redirect from non-www to www (except for the Umbraco Cloud project hostname):

```xml
<rule name="Redirect to www prefix" stopProcessing="true">
  <match url=".*" />
  <conditions>
    <add input="{HTTP_HOST}" pattern="^www\." negate="true" />
    <add input="{HTTP_HOST}" pattern="^localhost(:[0-9]+)?$" negate="true" />
    <add input="{HTTP_HOST}" pattern="\.umbraco\.io$" negate="true" />
  </conditions>
  <action type="Redirect" url="https://www.{HTTP_HOST}/{R:0}" />
</rule>
```
