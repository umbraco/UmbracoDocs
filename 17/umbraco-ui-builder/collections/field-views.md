---
description: Configuring Field Views in Umbraco UI Builder.
---

# Field Views

Field Views allow customization of the markup used by a field when displayed in a list view. Field Views are implemented as .NET Core View Components, which are passed a `FieldViewsContext` argument containing information about the entity/field being rendered.

## Defining a Field View

You can define a field view in one of two ways:

### Basic View File for the Built-In `FieldView` View Component

For field views, place a view file in the `/Views/Shared/Components/FieldView` folder with the following markup.

````csharp
@model Umbraco.UIBuilder.Web.Models.FieldViewContext
<!-- Insert your markup here -->
````

To register the view, pass the name of the view file (excluding the `.cshtml` file extension) to the relevant API method.

### Custom View Component

For more complex field views, create a custom view component class that can use dependency injection for any required dependencies. Use the following signature:

````csharp
// Example
public class MyComplexFieldViewViewComponent : ViewComponent
{
    public async Task<IViewComponentResult> InvokeAsync(FieldViewContext context)
    {
        // Do your custom logic here

        return View("Default", model);
    }
}
````

{% hint style="info" %}
The `FieldViewContext` parameter in the `InvokeAsync` method **must** be named `context`.
{% endhint %}

For the view component, place a `Default.cshtml` file into the `/Views/Shared/Components/MyComplexFieldView` folder with the following markup:

````csharp
@model Namespace.Of.Model.Returned.By.Custom.ViewComponent
<!-- Insert your markup here -->
````

## The Field View Context

Field view components are passed a `FieldViewContext` object with the following properties:

````csharp
public class FieldViewContext
{
    public string ViewName { get; set; }
    public object Entity { get; set; }
    public string PropertyName { get; set; }
    public object PropertyValue { get; set; }
}
````

## Setting the Field View of a List View Field

A field view is assigned to a list view field as part of the list view configuration. For more information, see the [List Views](list-views.md#setting-the-view-of-a-field) article.
