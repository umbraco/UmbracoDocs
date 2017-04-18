#Email Templates #
From version 6.0.0+ we now include a new Workflow 'Send email with template (Razor)' that allows you to pick a Razor view file to send out a pretty HTML email for form submissions. We include an example email template for you to look at and understand how it works found at `/views/partials/forms/emails/`

## Creating an email template ##
If you wish to have one or more templates selectable from the 'Send email with template (Razor)' you will need to place all email templates into the folder `/views/partials/forms/emails/`

The Razor view must inherit from FormsHtmlModel like so:
`@inherits UmbracoViewPage<Umbraco.Forms.Core.Models.FormsHtmlModel>`

Then you have a model that contains the Form fields of your form where you can display the result in your email HTML markup, along with the usual normal UmbracoHelper methods such as `Umbraco.TypedContent` and `Umbraco.TypedMedia` etc..

Below is an example of a very simple email template with the HTML styling removed from the email example template that we ship with:

```
@inherits UmbracoViewPage<Umbraco.Forms.Core.Models.FormsHtmlModel>

@{
    //This is an example email template where you can use Razor Views to send HTML emails

    //You can use Umbraco.TypedContent & Umbraco.TypedMedia etc to use Images & content from your site
    //directly in your email templates too

    //Strongly Typed
    //@Model.GetValue("aliasFormField")
    //@foreach (var color in Model.GetValues("checkboxField")){}

    //Dynamics
    //@Model.DynamicFields.aliasFormField
    //@foreach(var color in Model.DynamicFields.checkboxField){}
}

<h1>Explicitly Named Fields</h1>
<h2>Name:</h2>
@Model.GetValue("name")

<h2>Favourite Colors</h2>
<ul>
    @foreach(var color in Model.GetValues("favColors")){
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