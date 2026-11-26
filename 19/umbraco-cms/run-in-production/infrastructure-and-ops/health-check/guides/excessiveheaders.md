# Health check: Excessive Headers

_Checks to see if your site reveals information in its headers that gives away unnecessary details about the technology used to build and host it._

## How to fix this health check

This health check can be fixed by removing headers before the response is started.

Be aware these headers are often added by the server and not by the application.

Unless you publicly expose the Kestrel server ([not recommended by Microsoft](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel?view=aspnetcore-2.1&tabs=aspnetcore2x#when-to-use-kestrel-with-a-reverse-proxy)), you can't handle this directly in middleware.

### Removing headers when hosted on IIS

For IIS you will need to manipulate `web.config` (If you don't have `web.config` already in your project you will need to add it at the root). Ensure to remove the custom `X-Powered-By` and `Server` header as shown in the following example.

{% hint style="info" %}
The `removeServerHeader` attribute is added in IIS 10.0 and does not work in versions of Windows prior to Windows Server version 1709 or Windows 10 version 1709.
{% endhint %}

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <system.webServer>
    <httpProtocol>
      <customHeaders>
        <remove name="X-Powered-By" />
      </customHeaders>
    </httpProtocol>
    <security>
      <requestFiltering removeServerHeader="true" />
    </security>
  </system.webServer>
</configuration>
```

### Removing headers when hosted on Kestrel

By default Kestrel will only expose the `Server` header. To disable this, you have to configure Kestrel in `Program.cs`. You can use the `UseKestrel` extension method on `WebApplicationBuilder` like in the following example.

```csharp
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.WebHost.UseKestrel(options => options.AddServerHeader = false);
...
```
