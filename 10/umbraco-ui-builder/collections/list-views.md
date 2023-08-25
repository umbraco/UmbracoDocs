---
description: Configuring the list view of a collection in Konstrukt, the back office UI builder for Umbraco.
---

# List Views

A list view is a list based view of a collections entities providing such features as pagination for large collections, custom data views, searching and bulk actions.

![A collection list view](../images/people_listview.png)

## Configuring a list view

The list view configuration is a sub configuration of a [`Collection`](the-basics.md) config builder instance and is accessed via it's `ListView` method.

#### **ListView(Lambda listViewConfig = null) : KonstruktListViewConfigBuilder&lt;TEntityType&gt;**

Accesses the list view config of the given collection.

````csharp
// Example
collectionConfig.ListView(listViewConfig => {
    ...
});
````

## Adding a field to the list view

#### **AddField(Lambda propertyExpression, Lambda fieldConfig = null) : KonstruktListViewFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Adds the given property to the list view.

````csharp
// Example
listViewConfig.AddField(p => p.FirstName, fieldConfig => {
    ...
});
````

## Changing the heading of a field

#### **SetHeading(string heading) : KonstruktListViewFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the heading for the list view field.

````csharp
// Example
fieldConfig.SetHeading("First Name");
````

## Formatting the value of a field

#### **SetFormat(Lambda formatExpression) : KonstruktListViewFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the format expression for the list view field.

````csharp
// Example
fieldConfig.SetFormat((v, p) => $"{v} years old");
````

## Setting the view of a field

Field views allow you to customize the markup of the field in the list view so that you can show more rich visualizations of the fields content. See [Field Views Documentation](field-views.md) for more info.

#### **SetView(string viewComponentName) : KonstruktListViewFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the view component for the list view field.

````csharp
// Example
fieldConfig.SetView("ImageFieldView");
````

#### **SetView&lt;TView&gt;() : KonstruktListViewFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the view component for the list view field.

````csharp
// Example
fieldConfig.SetView<ImageFieldView>();
````

## Setting the visibility of a field

#### **SetVisibility(Predicate&lt;KonstruktListViewFieldVisibilityContext&gt; visibilityExpression) : KonstruktListViewFieldConfigBuilder&lt;TEntityType, TValueType&gt;**

Sets the runtime visibility of the list view field.

````csharp
// Example
fieldConfig.SetVisibility(ctx => ctx.UserGroups.Any(x => x.Alias == "editor"));
````

## Changing the page size

#### **SetPageSize(int pageSize) : KonstruktListViewConfigBuilder&lt;TEntityType&gt;**

Sets the number of items to display per page for the given list view.

````csharp
// Example
listViewConfig.SetPageSize(20);
````