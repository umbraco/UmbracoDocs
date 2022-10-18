---
versionFrom: 9.5.0
versionTo: 10.0.0
---

# Sending Allowed Children Notification
The `SendingAllowedChildrenNotification` enable you to manipulate the content types that will be shown in the create menu.

## Usage
Example usage of the `SendingAllowedChildrenNotification` - for example show only the settings content type if none have been added yet.

```csharp
using System.Linq;
using System.Web;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;

namespace Umbraco.Docs.Samples.Web.Notifications
{
    public class SendingAllowedChildrenNotificationHandler : INotificationHandler<SendingAllowedChildrenNotification>
    {
        public void Handle(SendingAllowedChildrenNotification notification)
        {
            //try get the id from the content item in the back office 
            var queryStringCollection = HttpUtility.ParseQueryString(notification.UmbracoContext.OriginalRequestUrl.Query);
            
            if (!queryStringCollection.ContainsKey("contentId"))
            {
                return;
            }

            var contentId = queryStringCollection["contentId"].TryConvertTo<int>().ResultOr(-1);

            if (contentId == -1)
            {
                return;
            }

            var content = notification.UmbracoContext.Content?.GetById(true, contentId);

            if (content == null)
            {
                return;
            }

            // allowed children as configured in the backoffice
            var allowedChildren = notification.Children.ToList();

            if (content.ChildrenForAllCultures != null)
            {
                // get all children of current page.
                var childNodes = content.ChildrenForAllCultures.ToList();

                // if there is a settings page already created, then don't allow it anymore
                if (childNodes.Any(x => x.ContentType.Alias == Settings.ModelTypeAlias))
                {
                    allowedChildren.RemoveAll(x => x.Alias == Settings.ModelTypeAlias);
                }
            }

            // update the allowed children.
            notification.Children = allowedChildren;
        }
    }
}
```