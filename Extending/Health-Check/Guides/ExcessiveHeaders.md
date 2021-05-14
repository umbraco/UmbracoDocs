---
versionFrom: 9.0.0
state: complete
updated-links: true
verified-against: alpha-3
---

# Health check: Excessive Headers

_Checks to see if your site is revealing information in its headers that gives away unnecessary details about the technology used to build and host it._

## How to fix this health check

This health check can be fixed by removing headers before the response is started.

Be aware these headers are often added by the server and not by the application.

Unless you public expose the Kestrel server ([not recommended by Microsoft](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel?view=aspnetcore-2.1&tabs=aspnetcore2x#when-to-use-kestrel-with-a-reverse-proxy)), you can't handle this directly in middleware.

### Removing headers when hosted on IIS

For IIS you will need to manipulate `web.config`. Ensure to remove the custom `X-Powered-By` and server header like in the following example.

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

By default Kestrel only expose the server header. To disable this, you have to configure kestrel in `Program.cs`. You can use the `UseKestrel` extension method on `IWebHostBuilder` like in the following example.

```cs
public class Program
{
    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder => { webBuilder.UseStartup<Startup>()
                .UseKestrel(x => x.AddServerHeader = false);
            });
}
```
