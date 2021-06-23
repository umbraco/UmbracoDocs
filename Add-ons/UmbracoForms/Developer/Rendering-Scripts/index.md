---
versionFrom: 7.0.0
versionTo: 9.0.0
---

# Rendering Forms Scripts

:::tip
If you are using Umbraco Forms version 4.x, see the [Using Forms 4.x](#using-forms-4x) section.
:::

Forms output some JavaScript which is by default rendered right below the markup.

In many cases, you might prefer rendering your scripts at the bottom of the page, e.g. before the closing `</body>` tag, as this generally improves site performance.

In order to render your scripts where you want, you need to add the following snippet to your template. Make sure you add it below your scripts, right before the closing `</body>` tag:

```csharp
@if (TempData["UmbracoForms"] != null)
{
    foreach (var form in (List<Guid>)TempData["UmbracoForms"])
    {
        Html.RenderAction("RenderFormScripts", "UmbracoForms", new { formid = form, theme = "yourTheme" });
    }
}
```

Whether you are inserting your Form using a macro or adding it directly in your template, you need to make sure `ExcludeScripts` is checked/enabled:

- Enabling `ExcludeScripts` using the **Insert Form with Theme** macro:

    ![Exclude scripts](images/exclude-scripts.png)

- Enabling `ExcludeScripts` when inserting Forms **directly in your template**:

    ```csharp
    @Umbraco.RenderMacro("renderUmbracoForm", new {FormGuid="dfea5397-36cd-4596-8d3c-d210502b67de", FormTheme="bootstrap3-horizontal", ExcludeScripts="1"})
    ```

## Using Forms 4.x

### Changing the Forms Partial View Macro

First we'll need to tell the Forms partial macro (that is used to render forms) to only render the markup and not the scripts. 

To change the Forms partial view macro:

1. Navigate to the **Developer** section.
2. Open the **Partial View Macro File** and select **Insert Umbraco Form**.
3. The Form should have the following contents

    ```csharp
    @inherits Umbraco.Web.Macros.PartialViewMacroPage

    @if (Model.MacroParameters["FormGuid"] != null)
    {
        var s = Model.MacroParameters["FormGuid"].ToString();
        var g = new Guid(s);

        Html.RenderAction("Render", "UmbracoForms", new {formId = g});
    }
    ```

4. In the ``RenderAction`` call we'll provide an additional argument: `mode = "form"`

    So change this:

    ```csharp
    Html.RenderAction("Render", "UmbracoForms", new {formId = g});
    ```

    to this:

    ```csharp
    Html.RenderAction("Render", "UmbracoForms", new {formId = g, mode = "form"});
    ```

### Place the Render Scripts Macro on your Template

Now we'll need to let Forms know where we want to output the script instead.

1. Navigate to the **Settings** section.
2. Select the template that should contain the scripts.
3. Insert the **Render Umbraco Forms Scripts** macro where you need the scripts rendered:

    ```csharp
    @Umbraco.RenderMacro("FormsRenderScripts")
    ```

### Using RenderMacro in non-Umbraco Controllers

If you end up with an error like this:

```csharp
"CS0234: The type or namespace name 'RenderMacro' does not exist in the namespace 'Umbraco' (are you missing an assembly reference?)". 
```

This is probably due to the fact that you're using custom controllers and viewmodels where the UmbracoContext is not exposed. The fix is to create your own UmbracoContext first:

```csharp
@{
    // create your own Umbraco context
    var umbraco = new UmbracoHelper(UmbracoContext.Current);
}
@umbraco.RenderMacro("FormsRenderForm", new { FormGuid = "1203e391-30bb-4ffc-8fe6-1785d6093108" })
```

Please be aware, that is not the suggested way of inserting an Umbraco Form. We suggest you inherit from Umbraco Controllers. If you can not do that, you will need to create a new UmbracoContext. If you do so, please also read the Common Pitfalls.

---

Prev: [Preparing your Frontend](../Prepping-Frontend/index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Themes](../Themes/index.md)
