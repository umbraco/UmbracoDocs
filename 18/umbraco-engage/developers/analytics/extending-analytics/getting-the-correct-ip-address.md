---
description: >-
  Learn how to extract client IP addresses in Umbraco Engage by implementing a
  custom IP address extractor for specific server environments.
---

# Getting the Correct IP Address

By default, Umbraco Engage extracts the IP address from the request by inspecting the `UserHostAddress` and the `X-Forwarded-For` header. The latter is commonly used if your website operates behind a load balancer. In most scenarios, this will correctly resolve the client's IP address.

If IP addresses are not being resolved accurately, your website may be behind a load-balancing server or another protected environment. It might not forward the original client IP in the default `X-Forwarded-For` header or could exclude it entirely.

In this case, you may need to provide a custom implementation of the `IHttpContextIpAddressExtractor` to handle your specific requirements.

The default extractor looks like this:

```csharp
using Microsoft.AspNetCore.Http;
using Umbraco.Engage.Infrastructure.Analytics.Collection.Extractors;

public string? ExtractIpAddress(HttpContext context)
{
    if (context?.Request?.Headers["X-Forwarded-For"].FirstOrDefault() is string ipAddresses)
    {
        var ipAddress = ipAddresses.Split(',')[0].Trim();
        if (System.Net.IPAddress.TryParse(ipAddress, out _)) return ipAddress;
    }
    return context?.Connection?.RemoteIpAddress?.ToString();
}
```

To override this behavior, implement your own `IHttpContextIpAddressExtractor` and instruct Umbraco to use your extractor instead of the default extractor:

```cs
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Engage.Infrastructure.Analytics.Collection.Extractors;

[ComposeAfter(typeof(Umbraco.Engage.Infrastructure.Analytics.Collection.Extractors.AnalyticsExtractorsComposer))]
public class CustomIpExtractorComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IHttpContextIpAddressExtractor, MyIpAddressExtractor>();
    }
}
```

{% hint style="info" %}
It is important that your `Composer` adjusts the service registration **after** Umbraco Engage has initialized.
{% endhint %}

This can be enforced using the `ComposeAfterAttribute`. Failing to add this attribute may result in Umbraco running your Composer before the Umbraco Engage composer, causing your changes to be overwritten.

Additionally, ensure you use `AddUnique<...>()` instead of `AddSingleton<...>()`. While you can use AddSingleton when multiple implementations of a single service exist, in this case, you want your own extractor to be resolved exclusively. Therefore, AddUnique will overwrite the Umbraco Engage extractor.

After implementing both classes and running your project, your extractor should be called to resolve IP addresses. You can verify the output of your extractor by inspecting the `umbracoEngageAnalyticsIpAddress` database table. The last portion of the IP address may be anonymized (set to 0) if this option is enabled in the Umbraco Engage configuration file.
