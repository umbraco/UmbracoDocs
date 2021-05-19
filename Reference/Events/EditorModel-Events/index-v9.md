---
keywords: EditorModelEventManager setting default values defaultvalue SendingContentNotifications
versionFrom: 9.0.0
meta.Title: "SendingContentNotifications - or how to set a default value"
meta.Description: "Explanation of how handle the SendingContentNotifications event to set an initial default value for a propery when the editor creates a new content item in the backoffice"
---

# SendingContentNotification Events

The `SendingContentNotification` class is used to emit events that enable you to manipulate the model used by the backoffice before it is loaded into an editor. For example the SendingContentModel event fires right before a content item is loaded into the backoffice for editing. It is therefore the perfect event to use to set a default value for a particular property, or perhaps to hide a property/tab/Content App from a certain editor.

## Usage

Example usage of the `SendingContentNotification` event - eg set the default PublishDate for a new NewsArticle to be today's date:

First register a composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace BetaTwo.Code.Events
{
    public class EditorModelComposer : IUserComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<SendingContentNotification, EditorModelNotificationHandler>();
        }
    }
}
```

Then add the notification handler class:

```csharp
using System;
using System.Linq;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models.ContentEditing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;

namespace BetaTwo.Code.Events
{
    public class EditorModelNotificationHandler : INotificationHandler<SendingContentNotification>
    {
        public void Handle(SendingContentNotification notification)
        {
            // fail if not the homepage type
            if (notification.Content.ContentTypeAlias != "NewsArticle")
                return;

            foreach(var variant in notification.Content.Variants)
            {
                // fail if its not a brand new node
                if (variant.State != ContentSavedState.NotCreated)
                    return;

                var pubDateProperty = variant.Tabs.SelectMany(f => f.Properties).FirstOrDefault(f => f.Alias.InvariantEquals("todaysDate"));

                // fail if the date property can't be found
                if (pubDateProperty == null)
                    return;
                    
                // set datetime value to current time
                pubDateProperty.Value = DateTime.UtcNow;       
            }            
        }
    }
}
```