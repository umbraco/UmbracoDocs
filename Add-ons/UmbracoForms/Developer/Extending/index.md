---
versionFrom: 7.0.0
meta.Title: "Extending Umbraco Forms"
---

# Extending

Umbraco Forms functionality can be extended in various ways. In this section we focus on techniques available to a back-end/C# developer.

For front-end extensions, specifically via theming, see the [Themes](../Themes/index.md) section.

## Developing Custom Providers

Although the Forms package comes with many field, workflow and other built-in types, if you have a requirement that isn't served by any of these, you can create and develop your own.

### [Provider model](Adding-a-Type.md)

Many features of Forms use a provider model, which makes it quicker to add new parts to the application.

The model uses the notion that everything must have a type to exist. The type defines the capabilities of the item. For instance a Textfield on a form has a FieldType, this particular field type enables it to render an input field and save text strings. The same goes for workflows, which have a workflow type, datasources which have a datasource type and so on. Using the model you can seamlessly add new types and thereby extend the application.

It is possible to add new Field types, Data Source Types, Prevalue Source Types, Export Types, and Workflow Types.

### [Field types](Adding-a-Fieldtype.md)

A field type handles rendering of the UI for a field in a form. It renders a standard ASP.NET webcontrol and is able to return a list of values when the form is saved.

### Data Source Types

A data source type enables Umbraco Forms to connect to a custom source of data. A datasource can consist of any kind of storage as long as it possible to return a list of fields Umbraco Forms can map values to. For example: a Database data source can return a list of columns Forms can send data to, which enables Umbraco Forms to map a form to a data source. A data source type is responsible for connecting Forms to external storage.

### [Prevalue Source Types (version 10+)](https://docs.umbraco.com/umbraco-forms/developer/extending/adding-a-prevaluesourcetype)

:::warning
**This is only valid for Umbraco Forms version 10+.**
:::

A prevalue source type can connect to a 3rd party storage and retrieve a collection of values. These can can be used on fields that support prevalues. The prevalue source is responsible for connecting to the source and retrieving the collection of values.

### [Workflow Types](Adding-a-Workflowtype.md)

A workflow can be executed each time a form changes state (when it is submitted for instance). A workflow is responsible for executing logic which can modify the record or notify 3rd party systems.

### [Export Types](Adding-a-Exporttype.md)

Export types are responsible for turning form records into any other data format, which is then returned as a file.

## Handling Forms Events

Another option for extension via custom code is to hook into one of the many events available.

### [Validation](Adding-an-Event-Handler.md)

Form events are raised during the submission life cycle and can be handled for executing custom logic.

### [Default Workflows](Customize-default-workflows.md)

The default behavior when a new form is created is for a single workflow to be added, which will send a copy of the form to the current backoffice user's email address.

From versions 8.13/9.5/10.1 it's been possible to amend this behavior and change it to fit your needs.

## Responding to State Values

In the course of submitting a form, Umbraco Forms will set various values in `TempData` and/or `HttpContext.Items`, that you can use to customize the website functionality.

### Customizing Post-Submission Behavior

Whether displaying a message or redirecting, a developer can customize the page viewed after the form is submitted based on the presence of `TempData` variables.

One variable with a key of `UmbracoFormSubmitted` has a value containing the Guid identifier for the submitted form.

A second variable contains the Guid identifier of the record created from the form submission. You can find this using the `Forms_Current_Record_id` key.

In order to redirect to an external URL rather than a selected page on the Umbraco website, you will need to use a [custom workflow](../../Developer/Extending/Adding-a-Workflowtype.md). Within this workflow you can set the required redirect URL on the `HttpContext.Items` dictionary using the key `FormsRedirectAfterFormSubmitUrl` (defined in the constant `Umbraco.Forms.Core.Constants.ItemKeys.RedirectAfterFormSubmitUrl`).  This feature is available from versions 8.13 and 10.1.

For example, using an injected instance of `IHttpContextAccessor`:

```c#
_httpContextAccessor.HttpContext.Items[Constants.ItemKeys.RedirectAfterFormSubmitUrl] = "https://www.umbraco.com";
```

---

Prev: [Umbraco Forms in the Database](../Forms-in-the-Database/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Configuration](../Configuration/index.md)
