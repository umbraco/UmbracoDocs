---
versionFrom: 8.0.0
meta.Title: "Adding Event Handlers in Umbraco Forms"
meta.Description: "See an example of validating a form server-side"
---

# Adding a server-side event handlers to Umbraco Forms

:::note
The samples in this article applies to Umbraco Forms version 8 and later versions.
:::

## Form validation event

Add a new class to your project and have it inherit from `IUserComposer`, implement the `Compose()` method. This method will contain a handler for the `FormValidate` event.

```csharp
using System.Linq;
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

            if (field == null)
            {
                return string.Empty;
            }
            
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

## Service events

The services available via interfaces `IFormService`, `IFolderService`, `IDataSourceService` and `IPrevalueSourceService` are used when forms definitions are stored within the Umbraco database. They expose the following events that are triggered just before or after an entity handled by the service is modified:

- Creating
- Created
- Deleting
- Deleted
- Saving
- Saved
- Updating
- Updated

The "-ing" events allow for the entity being changed to be modified before the operation takes place, or to cancel the operation.  The "-ed" events fire after the update is complete.

Both can be wired up using a composer and component:

```csharp
    public class TestSiteComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Components().Append<TestSiteComponent>();
        }
    }

    public class TestSiteComponent : IComponent
    {
        private readonly IFormService _formService;

        public TestSiteComponent(IFormService formService)
        {
            _formService = formService;
        }

        public void Initialize()
        {
            _formService.Saving += FormService_Saving;
            _formService.Saved += FormService_Saved;
        }

        private void FormService_Saving(object sender, FormEventArgs e)
        {
            // Modify before saving.
            e.Form.Name += " (updated)";

            // Cancel the operation.
            e.Cancel = true;
        }

        private void FormService_Saved(object sender, FormEventArgs e)
        {
        }

        public void Terminate()
        {
            _formService.Saving -= FormService_Saving;
            _formService.Saved -= FormService_Saved;
        }
    }
```

When a form or folder is _moved_ there is no specific service event.  However information available in the `AdditionalData` dictionary available on the `FormEventArgs` or `FolderEventArgs` can be used to determine whether the item was moved, and if so, where from:

```csharp
    public class TestSiteComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Components().Append<TestSiteComponent>();
        }
    }

    public class TestSiteComponent : IComponent
    {
        private readonly IFormService _formService;

        public TestSiteComponent(IFormService formService)
        {
            _formService = formService;
        }

        public void Initialize()
        {
            _formService.Updating += FormService_Updating;
            _formService.Updated += FormService_Updated;
        }

        private void FormService_Updated(object sender, FormEventArgs e) =>
            Current.Logger.Info(
                typeof(TestSiteComponent),
                $"Form updated. New parent: {e.Form.FolderId}. Old parent: {e.AdditionalData["MovedFromFolderId"]}");

        private void FolderService_Updated(object sender, FolderEventArgs e) =>
            Current.Logger.Info(
                typeof(TestSiteComponent),
                $"Folder updated. New parent: {e.Folder.ParentId}. Old parent: {e.AdditionalData["MovedFromFolderId"]}");

        public void Terminate()
        {
            _formService.Updating -= FormService_Updating;
            _formService.Updated -= FormService_Updated;
        }
    }
```

If a folder is being moved, the key within the `AdditionalData` dictionary is `"MovedFromParentId"`.

## Backoffice entry rendering events

When an entry for a form is rendered in the backoffice, and event is available to allow modification of the record details before they are presented to the user.  This is shown in the following example:

```csharp
    public class TestSiteComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Components().Append<TestSiteComponent>();
        }
    }

    public class TestSiteComponent : IComponent
    {
        private readonly IFormRecordSearcher _formRecordSearcher;

        public TestSiteComponent(IFormRecordSearcher formRecordSearcher)
        {
            _formRecordSearcher = formRecordSearcher;
        }

        public void Initialize()
        {
            _formRecordSearcher.EntrySearchResultFetching += FormRecordSearcher_EntrySearchResultFetching;
        }

        public void FormRecordSearcher_EntrySearchResultFetching(object sender, EntrySearchResultEventArgs e)
        {
            var transformedFields = new List<object>();
            foreach (var field in e.EntrySearchResult.Fields)
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

            e.EntrySearchResult.Fields = transformedFields;
        }

        public void Terminate()
        {
            _formRecordSearcher.EntrySearchResultFetching -= FormRecordSearcher_EntrySearchResultFetching;
        }
    }
```
















