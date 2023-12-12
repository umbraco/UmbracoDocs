---
description: Get started with Webhooks.
---

# Adding more events

To add more than just the default events to Umbraco, you can leverage the provided `IUmbracoBuilder` and `IComposer` interfaces. Below is an example of how you can extend the list of available webhook events using a custom `WebhookComposer`:

```csharp
using Umbraco.Cms.Core.Composing;

public class CustomWebhookComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.WebhookEvents()
            .Clear()
            .AddCms(cmsBuilder =>
            {
                // Add your custom events here
                cmsBuilder
                    .AddDefault()
                    .AddContent()
                    .AddContentType()
                    .AddDataType()
                    .AddDictionary()
                    .AddDomain()
                    .AddFile()
                    .AddHealthCheck()
                    .AddLanguage()
                    .AddMedia()
                    .AddMember()
                    .AddPackage()
                    .AddPublicAccess()
                    .AddRelation()
                    .AddRelationType()
                    .AddUser();
            });
    }
}
```
This is a list of all the current events that are available through Umbraco. If you want them all enabled, you can use the following:

```csharp
builder.WebhookEvents().Clear().AddCms(false);
```

# Creating custom events
