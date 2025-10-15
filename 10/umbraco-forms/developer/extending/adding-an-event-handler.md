---
meta.Title: Adding Notification Handlers in Umbraco Forms
description: See an example of validating a form server-side
---

# Adding A Server-Side Notification Handler To Umbraco Forms

## Form validation notification

Add a new class to your project as a handler for the `FormValidateNotification` notification:

```csharp
using System.Linq;
using Microsoft.AspNetCore.Http;
using Umbraco.Cms.Core.Events;
using Umbraco.Forms.Core.Models;
using Umbraco.Forms.Core.Services.Notifications;

namespace MyFormsExtensions
{
    /// <summary>
    /// Catch form submissions before being saved and perform custom validation.
    /// </summary>
    public class FormValidateNotificationHandler : INotificationHandler<FormValidateNotification>
    {
        public void Handle(FormValidateNotification notification)
        {
            // If needed, be selective about which form submissions you affect.
            if (notification.Form.Name == "Form Name")
            {
                // Check the ModelState
                if (notification.ModelState.IsValid == false)
                {
                    return;
                }

                // A sample validation
                var email = GetPostFieldValue(notification.Form, notification.Context, "email");
                var emailConfirm = GetPostFieldValue(notification.Form, notification.Context, "verifyEmail");

                // If the validation fails, return a ModelError
                if (email.ToLower() != emailConfirm.ToLower())
                {
                    notification.ModelState.AddModelError(GetPostField(notification.Form, "verifyEmail").Id.ToString(), "Email does not match");
                }
            }
        }

        private static string GetPostFieldValue(Form form, HttpContext context, string key)
        {
            Field field = GetPostField(form, key);
            if (field == null)
            {
                return string.Empty;
            }


            return context.Request.HasFormContentType &&  context.Request.Form.Keys.Contains(field.Id.ToString())
                ? context.Request.Form[field.Id.ToString()].ToString().Trim()
                : string.Empty;
        }

        private static Field GetPostField(Form form, string key) => form.AllFields.SingleOrDefault(f => f.Alias == key);
    }
}
```

The handler will check the `ModelState` and `Form` field values provided in the notification. If validation fails, we add a `ModelError`.

To register the handler, add the following code into the startup pipeline. In this example, the registration is implemented as an extension method to `IUmbracoBuilder` and should be called from `Startup.cs`:

```csharp
public static IUmbracoBuilder AddUmbracoFormsCoreProviders(this IUmbracoBuilder builder)
{
    builder.AddNotificationHandler<FormValidateNotification, FormValidateNotificationHandler>();
}
```

## Service notifications

The services available via interfaces `IFormService`, `IFolderService`, `IDataSourceService` and `IPrevalueSourceService` trigger following notifications before or after an entity handled by the service is modified.

The "-ing" events allow for the entity being changed to be modified before the operation takes place, or to cancel the operation. The "-ed" events fire after the update is complete.

Both can be wired up using a composer and component:

```csharp
    public class TestSiteComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<FormSavingNotification, FormSavingNotificationHandler>();
        }
    }

    public class FormSavingNotificationHandler : INotificationHandler<FormSavingNotification>
    {
        public void Handle(FormSavingNotification notification)
        {
            foreach (Form form in notification.SavedEntities)
            {
                foreach (Page page in form.Pages)
                {
                    foreach (FieldSet fieldset in page.FieldSets)
                    {
                        foreach (FieldsetContainer fieldsetContainer in fieldset.Containers)
                        {
                            foreach (Field field in fieldsetContainer.Fields)
                            {
                                field.Caption += " (updated)";
                            }
                        }
                    }
                }
            }
        }
    }
```

When a form or folder is _moved_ there is no specific service event. However, information available in the `State` dictionary on the notification object can be used to determine whether the item was moved. If so, it can show where it was moved from:

```csharp
    public class TestSiteComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<FormSavingNotification, FormSavingNotificationHandler>();
        }
    }

    public class FormSavingNotificationHandler : INotificationHandler<FormSavingNotification>
    {
        private readonly ILogger<FormSavingNotification> _logger;

        public FormSavingNotificationHandler(ILogger<FormSavingNotification> logger) => _logger = logger;

        public void Handle(FormSavingNotification notification)
        {
            foreach (Form savedEntity in notification.SavedEntities)
            {
                _logger.LogInformation($"Form updated. New parent: {savedEntity.FolderId}. Old parent: {notification.State["MovedFromFolderId"]}");
            }
        }
    }
```

If a folder is being moved, the key within the `State` dictionary is `"MovedFromParentId"`.

## Backoffice entry rendering events

When an entry for a form is rendered in the backoffice, an event is available to allow modification of the record detail. This event is available before the record details are presented to the user. This is shown in the following example:

```csharp
    public class TestSiteComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<EntrySearchResultFetchingNotification, EntrySearchResultFetchingNotificationHandler>();
        }
    }

    public class EntrySearchResultFetchingNotificationHandler : INotificationHandler<EntrySearchResultFetchingNotification>
    {
        public void Handle(EntrySearchResultFetchingNotification notification)
        {
            var transformedFields = new List<object>();
            foreach (var field in notification.EntrySearchResult.Fields)
            {
                if (field?.ToString() == "Test")
                {
                    transformedFields.Add("Test (updated)");
                }
                else
                {
                    transformedFields.Add(field);
                }
            }

            notification.EntrySearchResult.Fields = transformedFields;
        }
    }
```
