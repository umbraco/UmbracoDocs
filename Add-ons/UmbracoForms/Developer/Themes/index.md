#Themes
As of version 6.0.0 and newer Umbraco Forms supports Themes, allowing forms to be customised in a more simplier manner than found in version 4.x

##Creating a Theme
To create a theme you simply need to create a folder at `/views/partials/forms/themes/` The name of the folder is the name of theme that will be visible in the backoffice when choosing it. 

Copy the explicit files you wish to override in your theme, it may be a single file or all files from the default theme folder. Make the necessary changes you desire to CSS class names, markup etc. 
*A side note to consider is that Umbraco Forms conditional JS logic does depend on some CSS classes currently and that is advised that you add any additional classes you require but do not*

We highly recommend you never customise any files found in the `default` theme folder, as any customisations to these files that you do will most likely be lost with any future upgrades you do to Umbraco Forms.

##Theme Fallbacks
When using a theme Umbraco Forms, will use a view from the theme folder and then fallback to the same view in the default theme folder. This allows you to create a theme by only modifying the files necessary to make your customisations.

Files which can be overridden:
* Render.cshtml (overrides the entire form - usually not needed)
* Form.cshtml (overrides the generation of the fields on the current page)
* Script.cshmtl (overrides the way files are included with the form)
* /Fieldtypes/FieldType*.cshtml (overrides a specific view for a field)

##Using a Theme
To use a theme with a Form is simple, use the Insert Form macro where you will be presented with the options of the form you wish to insert along with an option to pick the theme folder. Which displays the list of theme folders found at `views/partials/forms/themes`. If you do not pick and set a theme the `default` theme will be used to render the form.

##Helper Methods
###SetFormThemeCssFile
Sets the primary form theme stylesheet path. This overrides an already assigned stylesheet and will be rendered out when inserting the form into the page
`@Html.SetFormThemeCssFile(Model, "~/App_Plugins/UmbracoForms/Assets/Themes/Default/style.css")`

###AddFormThemeScriptFile
Add a javascript file path to include on form render
`@Html.AddFormThemeScriptFile(Model, "~/App_Plugins/UmbracoForms/Assets/Themes/Default/umbracoforms-dependencies.js")`

###AddFormThemeScriptCommand
Add a javascript command to execute when the form is rendering, used to properly initialize fields on form render
`@Html.AddFormThemeScriptCommand(Model, "alert('hello')")`

###SetFormFieldClass
Adds a class to the form field html element of a given type. If no type is given, it will add the class to all fields
```
//Applies the CSS class 'form-control' to all fields - that GetFormFieldClass uses in FieldType views
@Html.SetFormFieldClass("form-control")

//Applies the CSS class 'some-other-class' for the FieldType of the Name 'Password'
@Html.SetFormFieldClass("some-other-class", "Password")
```

###GetFormFieldClass
Retrieves all classes for a given field type, used when rendering form fieldtype partial views
`class="@Html.GetFormFieldClass(Model.FieldTypeName)"`

###SetFormFieldWrapperClass
Adds a class to the div element wrapping around form fields of a given type. If no type is given, it will add the class to all fields
```
//Applies the CSS class 'form-group' around all fields, label & help texts
@Html.SetFormFieldWrapperClass("form-group")

//Applies the CSS class 'some-other-class' for the FieldType of the Name 'Password'
@Html.SetFormFieldWrapperClass("some-other-class", "Password")
```

###GetFormFieldWrapperClass
Retrieves all wrapper classes for a given field type, used when rendering form fields, this class wraps both label, help-text and the field itself in the default view
`class="@Html.GetFormFieldWrapperClass(f.FieldTypeName)`


##Rendering Script content seperately
Sometimes when you insert a form into a page you do not wish the JavaScript includes and CSS referecnes to be rendered directly alongside the form itself and more typically you would like to render these before the closing `</body>` tag.
To do this, when inserting the form using the macro ensure the checkbox for the property `Exclude Scripts` is checked/enabled and then you can use a snippet like below to render the necessary scripts in your main template before the clsoing `</body>`

```
@if (TempData["UmbracoForms"] != null)
{
    foreach (var form in (List<Guid>)TempData["UmbracoForms"])
    {
        Html.RenderAction("RenderFormScripts", "UmbracoForms", new { formid = form, theme = "yourTheme" });
    }
}
```

