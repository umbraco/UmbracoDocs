---
versionFrom: 7.0.0
needsV8Update: "true"
meta.Title: "Umbraco Forms Email Templates"
meta.Description: "Creating an email template for Umbraco Forms."
---

# Email Templates

From version 6+ we now include a new Workflow 'Send email with template (Razor)' that allows you to pick a Razor view file that will then be used to send out a *pretty HTML email* for form submissions.

We include an example email template for you to look at and understand how it works found at `~/Views/Partials/Forms/Emails/`.

## Creating an email template
If you wish to have one or more templates selectable from the 'Send email with template (Razor)' you will need to place all email templates into the folder `~/Views/Partials/Forms/Emails/`.

The Razor view must inherit from FormsHtmlModel:

```csharp
@inherits UmbracoViewPage<Umbraco.Forms.Core.Models.FormsHtmlModel>
```

Then you have a model that contains your Form fields which can be used in your email HTML markup, along with the UmbracoHelper methods such as `Umbraco.TypedContent` and `Umbraco.TypedMedia` etc.

Below is an example of an email template:

```csharp
@inherits UmbracoViewPage<Umbraco.Forms.Core.Models.FormsHtmlModel>

@{
    // This is an example email template where you can use Razor Views to send HTML emails

    // You can use Umbraco.TypedContent & Umbraco.TypedMedia etc to use Images & content from your site
    // directly in your email templates too

    // Strongly Typed
    // @Model.GetValue("aliasFormField")
    // @foreach (var color in Model.GetValues("checkboxField")){}

}

<h1>Explicitly Named Fields</h1>
<h2>Name:</h2>
@Model.GetValue("name")

<h2>Favourite Colors</h2>
<ul>
    @foreach (var color in Model.GetValues("favColors")) {
        <li>@color</li>
    }
</ul>

<hr/>

<h1>Generic/reusable template</h1>
@foreach (var field in Model.Fields)
{
    <h2>@field.Name</h2>

    switch (field.FieldType)
    {
        case "FieldType.FileUpload.cshtml":
            <a href="@siteDomain/@field.GetValue()">@field.GetValue()</a>
            break;

        case "FieldType.DatePicker.cshtml":
            @(Convert.ToDateTime(field.GetValue()).ToString("f"))
            break;

        case "FieldType.CheckboxList.cshtml":
            foreach (var color in field.GetValues())
            {
                @color<br/>
            }
            break;
        default:
            @field.GetValue()
            break;
    }
}
```
