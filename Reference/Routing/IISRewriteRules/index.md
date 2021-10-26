---
versionFrom: 9.0.0
---

# Url Rewrites in Umbraco 9

With the release of Umbraco 9 and the change of the underlying framework to .NET 5, the way that you use rewrites has changed as well.

The URL Rewriting extension in IIS has been replaced with [URL Rewriting Middleware in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting?view=aspnetcore-5.0) for rewriting in Umbraco 9.

:::note
If you are publishing Umbraco 9 on IIS you can still add web.configs to your project to configure IIS features such as URL rewrites.
:::

## When to use URL Rewriting Middleware

Make sure to check the official [URL Rewriting Middleware in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/url-rewriting?view=aspnetcore-5.0#when-to-use-url-rewriting-middleware) documentation for more information to when you should or should not use the URL Rewriting Middleware.

## Using URL Rewriting Middleware

To use Rewrites with Umbraco 9 you need to create an XML file with your rules and register it in your `Startup.cs` in your project by creating an instance of the `RewriteOptions` class with extension methods for each of your rewrite rules.

### Example

An example of how this can be done is

- Create an XML file with your rewrites in and place it in your project:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<rewrite>
  <rules>
    <rule name="Redirects umbraco.io to actual domain" stopProcessing="true">
      <match url=".*" />
      <conditions>
        <add input="{HTTP_HOST}" pattern="^(.*)?.euwest01.umbraco.io$" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/DependencyHandler.axd" />
        <add input="{REQUEST_URI}" negate="true" pattern="^/App_Plugins" />
        <add input="{REQUEST_URI}" negate="true" pattern="localhost" />
      </conditions>
      <action type="Redirect" url="http://jonathanpabst.com>.com/{R:0}"
        appendQueryString="true" redirectType="Permanent" />
    </rule>
  </rules>
</rewrite>
```

- Create an instance of the `RewriteOptions` class:

```Csharp
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            using (StreamReader iisUrlRewriteStreamReader = File.OpenText("Umbraco/Rewrites.xml"))
            {
                var options = new RewriteOptions()
                    .AddIISUrlRewrite(iisUrlRewriteStreamReader);
                app.UseRewriter(options);
            }
```

## Examples of rewrite rules

* A great site showing 10 very handy IIS Rewrite rules: [https://ruslany.net/2009/04/10-url-rewriting-tips-and-tricks/](https://ruslany.net/2009/04/10-url-rewriting-tips-and-tricks/)
* Another site showing some handy examples of IIS Rewrite rules: [https://odetocode.com/blogs/scott/archive/2014/03/27/some-useful-iis-rewrite-rules.aspx](https://odetocode.com/blogs/scott/archive/2014/03/27/some-useful-iis-rewrite-rules.aspx)
* If you needed to a lot of static rewrites using rewrite maps: [https://www.iis.net/learn/extensions/url-rewrite-module/rule-with-rewrite-map-rule-template](https://www.iis.net/learn/extensions/url-rewrite-module/rule-with-rewrite-map-rule-template)

For example, to always remove trailing slash from the URL:

```xml
<rule name="Remove trailing slash" stopProcessing="true">
  <match url="(.*)/$" />
    <conditions>      
      <add input="{REQUEST_URI}" negate="true" pattern="^/umbraco" />
      <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
      <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
    </conditions>
  <action type="Redirect" redirectType="Permanent" url="{R:1}" />
</rule>
```

Another example would be to enforce HTTPS only on your site:

```xml
<rule name="HTTP to HTTPS redirect" stopProcessing="true">
  <match url="(.*)" />
  <conditions>
    <add input="{HTTPS}" pattern="off" ignoreCase="true" />
    <add input="{HTTP_HOST}" pattern="localhost" negate="true" />
  </conditions>
  <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="Permanent" />
</rule>
```

Another example would be to redirect from non-www to www:

```xml
<rule name="Non WWW to WWW" stopProcessing="true">
  <match url="(.*)" ignoreCase="true" />
  <conditions>
    <add input="{HTTP_HOST}" pattern="^google\.com" />
  </conditions>
  <action type="Redirect" url="https://www.google.com/{R:1}" redirectType="Permanent" />
</rule>
```
