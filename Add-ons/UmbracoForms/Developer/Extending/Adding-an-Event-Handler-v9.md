---
versionFrom: 9.0.0
meta.Title: "Adding Event Handlers in Umbraco Forms"
meta.Description: "See an example of validating a form server-side"
state: complete
verified-against: beta001
---

# Adding a server-side event handler to Umbraco Forms

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
                var email = GetPostFieldValue(notification.Form, "email");
                var emailConfirm = GetPostFieldValue(notification.Form, notification.Context, "verifyEmail");

                // If the validation fails, return a ModelError
                if (email.ToLower() != emailConfirm.ToLower())
                {
                    notification.ModelState.AddModelError(GetPostField(e, "verifyEmail").Id.ToString(), "Email does not match");
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

The handler will check the `ModelState` and `Form` field values provided in the notification. If validation fails, we add a ModelError.

To register the handler, add the following code into the startup pipeline.  In this example, the registration is implemented as an extension method to `IUmbracoBuilder` and should be called from `Startup.cs`:

```csharp
public static IUmbracoBuilder AddUmbracoFormsCoreProviders(this IUmbracoBuilder builder)
{
    builder.AddNotificationHandler<FormValidateNotification, FormValidateNotificationHandler>();
}
```