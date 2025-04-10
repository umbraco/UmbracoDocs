---
description: >-
  Configure custom preview URLs to provide editors with seamless access to external preview environments for the Content Delivery API data.
---

# Additional preview environments support

{% hint style="warning" %}
The contents of this article have not yet been verified or updated for Umbraco 15.
{% endhint %}

With Umbraco, you can save and preview draft content before going live. The preview feature allows you to visualize how a page will look once it is published, directly from within the backoffice. This is also possible for the Content Delivery API data. You can extend the preview functionality in the backoffice by configuring external preview URLs for client libraries consuming the Content Delivery API.

{% hint style="info" %}
To get familiar with the preview functionality in the Delivery API, please refer to the [Preview concept](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#preview) section.
{% endhint %}

{% hint style="info" %}
The support for configuring additional preview environments in the Delivery API was introduced in version 12.3.
{% endhint %}

## Configuring custom preview URLs

If your client libraries feature preview functionality, you can enable editors in Umbraco to navigate directly to their preferred preview environments. To achieve this, start by generating the necessary URLs for each environment you wish to allow for preview. These URLs need to trigger preview mode within your application, which will fetch and present draft content from the Delivery API.

Once you have these preview URLs, you will need to register them through code in Umbraco.

Additionally, there are plans to simplify this process further. In an upcoming major version of Umbraco, a UI will be introduced, allowing you to configure these custom preview URLs directly from the backoffice.

{% include "../../.gitbook/includes/obsolete-warning-ipublishedsnapshotaccessor.md" %}

Here is an example of how to register such preview URLs for both variant and invariant content using a notification handler:

{% code title="AdditionalPreviewUrlsNotificationHandler.cs" %}

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models.ContentEditing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.PublishedCache;

namespace Umbraco.Docs.Samples;

public class AdditionalPreviewUrlsNotificationHandler : INotificationHandler<SendingContentNotification>
{
    private readonly IPublishedSnapshotAccessor _publishedSnapshotAccessor;

    public AdditionalPreviewUrlsNotificationHandler(IPublishedSnapshotAccessor publishedSnapshotAccessor)
        => _publishedSnapshotAccessor = publishedSnapshotAccessor;

    public void Handle(SendingContentNotification notification)
    {
        foreach (ContentVariantDisplay variantDisplay in notification.Content.Variants.Where(variant => variant.PublishDate.HasValue))
        {
            // Retrieve the route of each content item
            IPublishedSnapshot publishedSnapshot = _publishedSnapshotAccessor.GetRequiredPublishedSnapshot();
            var route = publishedSnapshot.Content?.GetRouteById(true, notification.Content.Id, variantDisplay.Language?.IsoCode);
            if (route == null)
            {
                continue;
            }

            route = route.TrimStart('/');

            variantDisplay.AdditionalPreviewUrls = new[]
            {
                new NamedUrl
                {
                    // Dynamically generate Preview URL
                    Name = $"Development{(variantDisplay.Language != null ? $" ({variantDisplay.Language.Name})" : null)}",
                    Url = $"https://dev.environment.org/{route}?culture={variantDisplay.Language?.IsoCode}&preview=true"
                },
                new NamedUrl
                {
                    // Dynamically generate Preview URL
                    Name = $"Staging{(variantDisplay.Language != null ? $" ({variantDisplay.Language.Name})" : null)}",
                    Url = $"https://staging.environment.org/{route}?culture={variantDisplay.Language?.IsoCode}&preview=true"
                }
            };
        }
    }
}
```

{% endcode %}

The purpose of this notification handler is to dynamically generate additional preview URLs for published content items only (_for the sake of simplicity_). It constructs two custom preview URLs, one for a development environment and another for a staging environment. These URLs include the content's route, culture variant, and a `preview` query parameter to enable preview mode in the client application.

You can then register your notification handler in a composer like this:

{% code title="AdditionalPreviewUrlsNotificationHandlerComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Docs.Samples;

public class AdditionalPreviewUrlsNotificationHandlerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.AddNotificationHandler<SendingContentNotification, AdditionalPreviewUrlsNotificationHandler>();
}
```
{% endcode %}

## Accessing preview environments

Now that we have set up additional preview URLs for the Delivery API data, you can access them from the Content section. When you open a content node, you will see new preview options for the external environments you have configured. Next to the regular "Save and preview" button, there is an arrow for the multiple URLs that have been added. Click it to see all the available preview URLs, as shown below:

![Preview invariant content with Delivery API](images/preview-invariant-content.png)

Below is an example with variants, showcasing both the English and Danish versions of a content node.

![Preview English variant with Delivery API](images/preview-variant-content-en.png)
![Preview Danish variant with Delivery API](images/preview-variant-content-da.png)