---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Rendering Forms Scripts

Script delivery is done automatically using [Themes](/documentation/Add-ons/UmbracoForms/Developer/Themes/) without the need to include any additional code into your own views. The 'default' theme (bundled with Umbraco Forms) comes with the file `Scripts.cshtml` containing all the relevant logic & data required by the Umbraco Forms JavaScript. For reference, the file looks like this *(as per Umbraco Forms 10.2)*:

```csharp
@model Umbraco.Forms.Web.Models.FormViewModel

@using Newtonsoft.Json
@using Umbraco.Forms.Core
@using Umbraco.Forms.Web

@{
    Html.AddFormThemeScriptFile("~/App_Plugins/UmbracoForms/Assets/themes/default/umbracoforms.js");
}

<div class="umbraco-forms-form-config"
     style="display: none"
     data-id="@Model.FormClientId"
     data-serialized-page-button-conditions="@JsonConvert.SerializeObject(Model.PageButtonConditions, FormsJsonSerializerSettings.Default)"
     data-serialized-fieldset-conditions="@JsonConvert.SerializeObject(Model.FieldsetConditions, FormsJsonSerializerSettings.Default)"
     data-serialized-field-conditions="@JsonConvert.SerializeObject(Model.FieldConditions, FormsJsonSerializerSettings.Default)"
     data-serialized-fields-not-displayed="@JsonConvert.SerializeObject(Model.GetFieldsNotDisplayed(), FormsJsonSerializerSettings.Default)"
     data-trigger-conditions-check-on="@Model.TriggerConditionsCheckOn"
     data-form-element-html-id-prefix="@Model.FormElementHtmlIdPrefix"></div>

@* Only render out scripts on the page if the form has not been submitted yet *@
@if (Model.SubmitHandled == false)
{
    @*
        If the current page of the form has any Partial view files attached to render
        Likely used by events and third parties adding tracking or other 3rd party functionality to a form
    *@
    if (Model.CurrentPage.PartialViewFiles.Any())
    {
        foreach (var partial in Model.CurrentPage.PartialViewFiles)
        {
            @await Html.PartialAsync(partial.Value)
        }
    }

    @* Render references to javascript files needed by fields on the current page*@
    @Html.RenderFormsScripts(Url, Model, Model.JavaScriptTagAttributes)
    @Html.RenderFormsStylesheets(Url, Model)
}

```

:::note
If you are upgrading from an older version of Umbraco Forms and using a variant of `Scripts.cshtml` within your own project you may be missing some required and fundamental parts of this file. As an example, the `<div class="umbraco-forms-form-config" />` element introduced the `data-form-element-html-id-prefix` attribute in Umbraco Forms 10.2. Failing to update this within your own version of this file may lead to a loss of functionality and/or JavaScript errors.
:::

## Enabling `ExcludeScripts`

Forms output some JavaScript which is by default rendered right below the markup.

If you do not want to render the associated scripts with a Form, you need to explicitly say so. You need to make sure `ExcludeScripts` is checked/enabled, whether you are inserting your Form using a macro or adding it directly in your template.

To enable `ExcludeScripts`:

- Using the **Insert Form with Theme** macro:

    ![Exclude scripts](images/exclude-scripts-v9.png)

- While inserting Forms **directly** in your template:

    ```csharp
    @await Umbraco.RenderMacroAsync("renderUmbracoForm", new {FormGuid="6c3f053c-1774-43fa-ad95-710a01d9cd12", FormTheme="bootstrap3-horizontal", ExcludeScripts="1"})
    ```

:::note
`ExcludeScripts = "1"` prevents the associated scripts from being rendered. Any other value, an empty value, or if the parameter is excluded, will render the scripts on the Form.
:::

The `Scripts.cshtml` file (from the current or default theme) will not be initiated and won't be included as part of the current form. You may however use parts (or all) of the code from the snippet of `Scripts.cshtml` within your own template or partial views.


In many cases, you might prefer rendering your scripts at the bottom of the page, e.g. before the closing `</body>` tag, as this generally improves site performance.

---

Prev: [Preparing your Frontend](../Prepping-Frontend/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Themes](../Themes/index.md)
