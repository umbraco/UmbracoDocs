# URL Rewrites in Umbraco

Since the release of Umbraco v9 and the change of the underlying web framework that is decoupled from the webserver, the way that you configure rewrites has changed as well.

Instead of the URL Rewriting extension in IIS you can use the [URL Rewriting Middleware in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting), which needs to be added to your project startup code first.

{% hint style="info" %}
If you are running Umbraco v9+ on IIS you can still add a `web.config` file to configure IIS features such as URL rewrites.
{% endhint %}

## When to use the URL Rewriting Middleware

Make sure to check the official [URL Rewriting Middleware in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting#when-to-use-url-rewriting-middleware) documentation for more information about when you should or should not use the URL Rewriting Middleware.

## Using the URL Rewriting Middleware

To use rewrites with Umbraco v9+ you have to register the middleware in your `Program.cs` by using the [`UseRewriter`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.builder.rewritebuilderextensions.userewriter) extension method and then configure the rewrite options.

### Example

* Create an `IISUrlRewrite.xml` file in the root of your project (next to your `Program.cs` file) containing:

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

* In the `Program.cs` file you can add the URL Rewriting Middleware before the call to `app.UseUmbraco()` and use [`AddIISUrlRewrite`](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.rewrite.iisurlrewriteoptionsextensions.addiisurlrewrite) to add the rewrite rules from the XML file:

```csharp
using Microsoft.AspNetCore.Rewrite;

var rewriteOptions = new RewriteOptions()
    .AddIISUrlRewrite(builder.Environment.ContentRootFileProvider, "IISUrlRewrite.xml");

app.UseRewriter(rewriteOptions);

// This line is needed for the rewrites to take effect.
app.UseStaticFiles();
```

{% hint style="info" %}
On Linux, make sure to place the `app.UseStaticFiles()` after the `app.UseUmbraco()` statements for the redirect to work as intended.
{% endhint %}

* In your csproj file add the XML file to a new item group and set `CopyToOutputDirectory` to `Always`:

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

## Rewrite rule shortcuts

`RewriteOptions` has a number of "shortcut" methods to implement commonly used rewrites including:

* `AddRedirectToNonWww()`
* `AddRedirectToWww()`
* `AddRedirectToNonWwwPermanent()`
* `AddRedirectToWwwPermanent()`
* `AddRedirectToHttps()`

For more details and other examples, take a look at the [URL Rewriting Middleware in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting) and [RewriteOptions Class](https://learn.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.rewrite.rewriteoptions) documentation.

## Examples of rewrite rules

Below are some handy IIS Rewrite Rules you can use in your projects:

* **10 Handy IIS Rewrite Rules**

A great resource showcasing 10 practical IIS Rewrite rules: [URL rewriting tips and tricks](https://ruslany.net/2009/04/10-url-rewriting-tips-and-tricks/)

* **Examples of IIS Rewrite Rules**

Another useful collection of IIS rewrite rule examples:  [Some useful IIS rewrite rules](https://odetocode.com/blogs/scott/archive/2014/03/27/some-useful-iis-rewrite-rules.aspx)

* **Static Rewrites Using Rewrite Maps**

If you need to handle a lot of static rewrites, consider using rewrite maps: [Rule with rewrite map rule template](https://www.iis.net/learn/extensions/url-rewrite-module/rule-with-rewrite-map-rule-template)

### Example: Remove a Trailing Slash

The following rule removes any trailing slashes from the URL.

Ensure Umbraco does not add a trailing slash by setting `AddTrailingSlash` to `false` in your [RequestHandler settings](../configuration/requesthandlersettings.md).

```xml
<rule name="Remove trailing slash" stopProcessing="true">
  <match url="(.*)/+$" />
  <conditions>
    <add input="{REQUEST_URI}" pattern="^/umbraco" negate="true" />
    <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
    <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
  </conditions>
  <action type="Redirect" url="/{R:1}" />
</rule>
```

### Example: Enforce HTTPS

The following rule ensures your site only runs on HTTPS:

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

### Example: Redirect Non-www to www

The following rule redirects traffic from non-www to www (excluding the Umbraco Cloud project hostname):

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

### Example: Remove the .aspx Extension

The following rule redirects `.aspx` URLs to their extensionless counterparts. Make sure you also have a `web.config` file in the root of your site.

```xml
<configuration>
  <system.webServer>
    <rewrite>
      <rules>
        <!-- Redirect .aspx URLs to their extensionless counterparts -->
        <rule name="Remove ASPX extension" stopProcessing="true">
          <match url="^(.*)\.aspx$" />
          <conditions logicalGrouping="MatchAll">
            <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
            <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
          </conditions>
          <action type="Redirect" url="{R:1}" redirectType="Permanent" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>
```

### Example: Custom Rewrite Rules for Umbraco Cloud

An example configuration to help ensure your custom rules integrate properly:

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

{% hint style="info" %}
If you use **Umbraco Cloud**, check the [Rewrite Rules](https://docs.umbraco.com/umbraco-cloud/set-up/project-settings/manage-hostnames/rewrites-on-cloud) article.
{% endhint %}
