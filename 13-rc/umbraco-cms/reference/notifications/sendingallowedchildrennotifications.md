# Sending Allowed Children Notification

The `SendingAllowedChildrenNotification` enables you to manipulate the Document Types that will be shown in the create menu when adding new content in the backoffice.

## Usage

With the example below we can ensure that a Document Type cannot be selected if the type already exists in the Content tree.

```csharp
using System.Web;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Docs.Samples.Web.Notifications
{
    public class SendingAllowedChildrenNotificationHandler : INotificationHandler<SendingAllowedChildrenNotification>
    {
        public void Handle(SendingAllowedChildrenNotification notification)
        {
            const string contentIdKey = "contentId";

            // Try get the id from the content item in the backoffice 
            var queryStringCollection = HttpUtility.ParseQueryString(notification.UmbracoContext.OriginalRequestUrl.Query);

            if (!queryStringCollection.ContainsKey(contentIdKey))
            {
                return;
            }

            var contentId = queryStringCollection[contentIdKey].TryConvertTo<int>().ResultOr(-1);

            if (contentId == -1)
            {
                return;
            }

            var content = notification.UmbracoContext.Content?.GetById(true, contentId);

            if (content is null)
            {
                return;
            }

            // Allowed children as configured in the backoffice
            var allowedChildren = notification.Children.ToList();

            if (content.ChildrenForAllCultures is not null)
            {
                // Get all children of current page
                var childNodes = content.ChildrenForAllCultures.ToList();

                // If there is a Settings page already created, then don't allow it anymore
                // You can also use the ModelTypeAlias property from your PublishedModel for comparison,
                // like Settings.ModelTypeAlias if you have set models builder to generate SourceCode models
                if (childNodes.Any(x => x.ContentType.Alias == "settings"))
                {
                    allowedChildren.RemoveAll(x => x.Alias == "settings");
                }
            }

            // Update the allowed children
            notification.Children = allowedChildren;
        }
    }
}
```

You also need to register this notification handler. You can achieve this by updating the `Startup` class like:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()             
        .AddWebsite()
        .AddComposers()
        .AddNotificationHandler<SendingAllowedChildrenNotification, SendingAllowedChildrenNotificationHandler>()
        .Build();
}
```

{% hint style="info" %}
For more information about registering notifications read the [Registering notification handlers](./) article.
{% endhint %}
