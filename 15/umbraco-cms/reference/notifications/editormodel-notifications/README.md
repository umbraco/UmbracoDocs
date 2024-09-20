# EditorModel Notifications

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.

EditorModel notifications are no longer handled on the server-side, but on the client-side. As the documentation effort progresses, the samples on this page will be updated accordingly.
{% endhint %}

EditorModel notifications enable you to manipulate the model used by the backoffice before it is loaded into an editor. For example the `SendingContentNotification` is published right before a content item is loaded into the backoffice for editing. It is therefore the perfect notification to use to set a default value for a particular property, or perhaps to hide a property/tab/Content App from a certain editor.

## Usage

Example usage of the `SendingContentNotification` - e.g. set the default PublishDate for a new NewsArticle to be today's Date:

{% code overflow="wrap" lineNumbers="true" fullWidth="false" %}
```csharp
using System;
using System.Linq;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models.ContentEditing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;

namespace Umbraco.Docs.Samples.Web.Notifications;

public class EditorSendingContentNotificationHandler : INotificationHandler<SendingContentNotification>
{
    public void Handle(SendingContentNotification notification)
    {
        if (notification.Content.ContentTypeAlias.Equals("blogpost"))
        {
            // Access the property you want to pre-populate
            // each content item can have 'variations' - each variation is represented by the `ContentVariantDisplay` class.
            // if your site uses variants, then you need to decide whether to set the default value for all variants or a specific variant
            // eg. set by variant name:
            // var variant = notification.Content.Variants.FirstOrDefault(f => f.Name == "specificVariantName");
            // OR loop through all the variants:
            foreach (var variant in notification.Content.Variants)
            {
                // Check if variant is a 'new variant'
                // we only want to set the default value when the content item is first created
                if (variant.State == ContentSavedState.NotCreated)
                {
                    // each variant has an IEnumerable of 'Tabs' (property groupings)
                    // and each of these contain an IEnumerable of `ContentPropertyDisplay` properties
                    // find the first property with alias 'publishDate'
                    var pubDateProperty = variant.Tabs.SelectMany(f => f.Properties)
                        .FirstOrDefault(f => f.Alias.InvariantEquals("publishDate"));
                    if (pubDateProperty is not null)
                    {
                        // set default value of the publish date property if it exists
                        pubDateProperty.Value = DateTime.UtcNow;
                    }
                }
            }
        }
    }
}
```
{% endcode %}

Another example could be to set the default Member Group for a specific Member Type using `SendingMemberNotification`:

```csharp
using System.Collections.Generic;
using System.Linq;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Docs.Samples.Web.Notifications;

public class EditorSendingMemberNotificationHandler : INotificationHandler<SendingMemberNotification>
{
    private readonly IMemberGroupService _memberGroupService;

    public EditorSendingMemberNotificationHandler(IMemberGroupService memberGroupService)
    {
        _memberGroupService = memberGroupService;
    }

    public void Handle(SendingMemberNotification notification)
    {
        var isNew = !int.TryParse(notification.Member.Id?.ToString(), out int id) || id == 0;

        // We only want to set the default member group when the member is initially created, eg doesn't have an Id yet
        if (isNew is false)
        {
            return;
        }

        // Set a default value member group for the member type `Member`
        if (notification.Member.ContentTypeAlias.Equals("Member"))
        {
            var memberGroup = _memberGroupService.GetByName("Customer");
            if (memberGroup is null)
            {
                return;
            }

            // Find member group property on member model
            var property = notification.Member.MembershipProperties.FirstOrDefault(x =>
                x.Alias.Equals($"{Constants.PropertyEditors.InternalGenericPropertiesPrefix}membergroup"));

            if (property is not null)
            {
                // Assign a default value for member group property
                property.Value = new Dictionary<string, object>
                {
                    {memberGroup.Name, true}
                };
            }
        }
    }
}
```

## Notifications

| Notification                       | Members                                                                                                        | Description                                                                                                                                                                                                                                                                                                                                      |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| SendingContentNotification         | <ul><li>ContentItemDisplay Content</li><li>IUmbracoContext UmbracoContext</li></ul>                            | <p>Published right before the editor model is sent for editing in the content section.<br>NOTE: Content is a Umbraco.Cms.Core.Models.ContentEditing.ContentItemDisplay type which contains the tabs and properties of the elements about to be loaded for editing.</p>                                                                           |
| SendingMediaNotification           | <ul><li>MediaItemDisplay Media</li><li>IUmbracoContext UmbracoContext</li></ul>                                | <p>Published right before the editor model is sent for editing in the media section<br>NOTE: Media is a Umbraco.Cms.Core.Models.ContentEditing.MediaItemDisplay type which in turn contains the tabs and properties of the elements about to be loaded for editing.</p>                                                                          |
| SendingMemberNotification          | <ul><li>MemberDisplay Member</li><li>IUmbracoContext UmbracoContext</li></ul>                                  | <p>Published right before the editor model is sent for editing in the member section.<br>NOTE: Member is a Umbraco.Cms.Core.Models.ContentEditing.MemberDisplay type which in turn contains the tabs and properties of the elements about to be loaded for editing.</p>                                                                          |
| SendingUserNotification            | <ul><li>UserDisplay User</li><li>IUmbracoContext UmbracoContext</li></ul>                                      | <p>Published right before the editor model is sent for editing in the user section.<br>NOTE: User is a Umbraco.Cms.Core.Models.ContentEditing.UserDisplay type which in turn contains the tabs and properties of the elements about to be loaded for editing.</p>                                                                                |
| SendingDashboardsNotification      | <ul><li>IEnumerable&#x3C;Tab&#x3C;IDashboardSlim>> Dashboards</li><li>IUmbracoContext UmbracoContext</li></ul> | <p>Published right before the a dashboard is retrieved in a section.<br>NOTE: Dashboards is a collection of IDashboardSlim, each object gives you access to Label, Alias, Properties, whether it's expanded, and whether it IsActive.</p>                                                                                                        |
| SendingAllowedChildrenNotification | <ul><li>IEnumerable&#x3C;ContentTypeBasic> Children</li><li>IUmbracoContext UmbracoContext</li></ul>           | <p>Published right before the allowed children of the selected Content Type are sent back during content creation in the Content Section.<br>NOTE: Children is a collection of ContentTypeBasic, each object gives you access to Alias, Description, Thumbnail and more. You can remove or add new children to the list in the notification.</p> |

### Display models

#### ContentItemDisplay

A model representing a content item to be displayed in the backoffice

* TemplateAlias
* Urls
* AllowPreview - Determines whether previewing is allowed for this node, By default this is true but by using notifications developers can toggle this off for certain documents if there is nothing to preview
* AllowedActions - The allowed 'actions' based on the user's permissions - Create, Update, Publish, Send to publish
* IsBlueprint
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection
* And more...

#### MediaItemDisplay

A model representing a media item to be displayed in the backoffice

* Alias
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection
* And more...

#### MemberDisplay

A model representing a member to be displayed in the backoffice

* Username
* Email
* Tabs - Defines the tabs containing display properties
* Properties - properties based on the properties in the tabs collection
* And more...

## Samples

The EditorModel notifications gives you a lot of options to customize the backoffice experience. You can find inspiration from the various samples provided below:

* [Customizing the "Links" box](customizing-the-links-box.md)
