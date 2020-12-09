---
versionFrom: 8.0.0
meta.Title: "Adding Event Handlers in Umbraco Forms"
meta.Description: "See an example of validating a form server-side"
---

# Adding a server-side event handler to Umbraco Forms

Add a new class to your project and have it inherit from `IUserComposer`, implement the `Compose()` method. This method will contain a handler for the `FormValidate` event. 

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Core.Composing;

namespace Forms8.EventHandlers
{
    /// <summary>
    /// Catch form submissions before being saved and perform custom validation.
    /// </summary>
    public class FormEventsComposer : IUserComposer
    {
        
        public void Compose(Composition composition)
        {
            // Attach a handler to the `FormValidate` event of UmbracoForms
            Umbraco.Forms.Web.Controllers.UmbracoFormsController.FormValidate += FormsController_FormValidate;
        }
        
        private void FormsController_FormValidate(object sender, Umbraco.Forms.Mvc.FormValidationEventArgs e)
        {
            // If needed, be selective about which form submissions you affect
            if (e.Form.Name == "Form Name")
            {
                // Access the Controller that handled the Request
                var controller = sender as Umbraco.Forms.Web.Controllers.UmbracoFormsController;

                // Check the ModelState
                if (controller == null || !controller.ModelState.IsValid)
                    return;

                // A sample validation
                var email = GetPostFieldValue(e, "email");
                var emailConfirm = GetPostFieldValue(e, "verifyEmail");
                
                // If the validation fails, return a ModelError
                if (email.ToLower() != emailConfirm.ToLower())
                    controller.ModelState.AddModelError(GetPostField(e, "verifyEmail").Id.ToString(), "Email does not match");

            }
        }

        // Helper method
        private static string GetPostFieldValue(Umbraco.Forms.Mvc.FormValidationEventArgs e, string key)
        {
            var field = GetPostField(e, key);
            var value = e.Context.Request[field.Id.ToString()] ?? "";
            return value.Trim();
        }
        
        // Helper method
        private static Umbraco.Forms.Core.Models.Field GetPostField(Umbraco.Forms.Mvc.FormValidationEventArgs e, string key)
        {
            return e.Form.AllFields.SingleOrDefault(f => f.Alias == key);
        }
       
    }
}
```

The `FormValidate` event will pass a reference to the Controller and Form objects. Use them to check ModelState and Form Field values. If validation fails, return a ModelError.
