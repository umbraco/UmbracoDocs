---
description: Configuring field views in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Field Views

Field Views allow you to customize the markup used by a field when displayed in a list view. Field Views are implemented as .NET Core View Components that are passed a single `FieldViewsContext` argument with information about the entity/field being rendered.

## Defining a field view

You can define a field view in one of two ways.

### **1. A basic view file for the built in `FieldView` view component**

The simplest way to define a field view for non-complex fields is to place a view file in the `/Views/Shared/Components/FieldView` folder with the following markup.

````csharp
@model Umbraco.UIBuilder.Web.Models.FieldViewContext
<!-- Insert your markup here -->
````

When registering a basic file view you can pass the name of the view file (excluding the `.cshtml` file extension) to the relevant API method.

### **2. A complete custom view component**

To define a more complex field view you can create your own view component class (which can use dependency injection for any required dependencies). This can be done by using the following signature:

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
It's important to know that the `FieldViewContext` parameter to the `InvokeAsync` method **MUST** be named `context`.
{% endhint %}

For the view element of your component, based on the example above, you would place a file `Default.cshtml` into the  `/Views/Shared/Components/MyComplexFieldView` folder with the following markup:

````csharp
@model Namespace.Of.Model.Returned.By.Custom.ViewComponent
<!-- Insert your markup here -->
````

## The field view context

Field view components are passed a `FieldViewContext` object with the following information:

````csharp
public class FieldViewContext
{
    public string ViewName { get; set; }
    public object Entity { get; set; }
    public string PropertyName { get; set; }
    public object PropertyValue { get; set; }
}
````

## Setting the field view of a list view field

A field view is assigned to a list view field as part of the list view configuration. For more information you can check the [List View Documentation](list-views.md#setting-the-view-of-a-field).
