---
description: Configuring list view layouts in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# List View Layouts

{% hint style="danger" %}
**List View Layouts** in Umbraco UI Builder are now considered deprecated. Moving forward, only the table list view will be supported. Whilst you can continue to use this feature for the time being, it will be removed in a future release.
{% endhint %}

List view layouts allow you to provide custom angular views to be used by the list view UI. By default, there are two built-in layouts, `TableListViewLayout` which displays results in a tabular layout, and `GridListViewLayout` which displays results in a tiled grid layout.

## Defining a list view layout

To define a list view layout you create a class that inherits from the base class `ListViewLayout` and implements the abstract configuration properties.

````csharp
// Example
public class MyCustomListViewLayout : ListViewLayout
{
    public GridListViewLayout()
    {
        Name = "My Custom List";
        Alias = "my-custom-list";
        Icon = "icon-list";
        View = "/app_plugins/myplugin/views/mycustomlist.htm";
    }
}
````

The required configuration options are:

* **Name:** The name of the layout.
* **Alias:** A unique alias for the layout.
* **Icon:** An icon to display in the list view layouts dropdown.
* **View:** The path of the angular view to load by the list view.

As well as defining the list view layout class you will also need to implement the relevant angular view and controller. This is a little out of scope for the Umbraco UI Builder documentation, however in summary you will need to:

* Create a plugin folder in the root `App_Plugin` folder.
* Create a `package.manifest` file in your plugin folder.
* Create a HTML view to be loaded.
* Create an angular controller to control the view.
* Hook up the controller with the view using the `ng-controller` attribute.
* Add the controller JS file path to the `package.manifest`.
* Build your custom logic.

## Changing the list view layout of a list view

A list view layout is assigned to a list view as part of the list view configuration. For more information you can check the [List View API Documentation](list-views.md#changing-the-list-view-layout).
