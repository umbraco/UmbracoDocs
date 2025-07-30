# Collection

`Schema Alias: Umbraco.ListView`

`UI Alias: Umb.PropertyEditorUi.Collection`

`Returns: IEnumerable<IPublishedContent>`

**Collection** displays a collection of categories when it is enabled on a Document Type with children.

![Collection example](images/listview-v14.png)

## Configure Collection

Once Collections are configured, the parent content item displays its child items in a list view format within the content item itself. If Collections are not configured, the child items are displayed directly in the Content Tree, rather than being grouped within the parent content item.

![Enable Collection example](images/enable-listview-v14.png)

## Settings

![Collection settings example](/14/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/images/list-view-settings.png)

### Columns Displayed

It is possible to add more columns to the collection, via adding the properties through the dropdown. These properties are based on the Data Types which are used by the Document Type. It will show up in the dropdown by its alias and not the name on the property.

![Collection property example](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/listview-property.png) ![Collection property example](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/listview-property-dropdown.png)

Once you have selected a column you want to display, define what its name should be and what kind of value it should display. You can also move the headers around, re-ordering how they should look. This is done by the move icon on the left side of the alias.

The template section is where you define what kind of value you want to display. The value of the column is in the `value` variable.

### Layouts

Collection comes with two layouts by default. A list and a grid view. These views can be disabled if you are not interested in any of them.

{% hint style="info" %}
A minimum of one layout needs to be enabled for Collection to work.
{% endhint %}

You can also make your own layout and add it to the settings. For example, if you wanted to change the width or length of the grid, you will be able to do so.

### Order By

Will sort your collection by the selection you choose in the dropdown. By default it selects "Last edited" and you get the following three columns:

* **Last edited** - When the content node was last edited and saved.
* **Name** - Name of the content node(s).
* **Created by** - This is the user who the content node was created by.

You can add more sorting to this collection by adding more datatypes to the columns in the "Columns Displayed" section.

### Order Direction

You can select order of the content nodes displayed, "Acsending" or "Descending". The order is affected by the "Order By" selection.

### Page Size

Defines how many child content nodes you want to see per page. This will limit how many content items you will see in your collection. If you set it to 5, then only 5 content items will be shown in the collection.

### Bulk Action Permissions

Select what kind of action is available on the collection.

* **Allow bulk publish** - content only
* **Allow bulk unpublish** - content only
* **Allow bulk copy** - content only
* **Allow bulk move**
* **Allow bulk delete**

### Content app icon

Changes the icon in the backoffice of the collection. By default, it will look like the image below.

![Collection icon example](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/list-icon.png)

### Content app name

You can change the name of the collection itself. Default if empty: 'Child Items'.

### Show Content App First

Enable this to show the Content Workspace View by default instead of the collection's.

## Content Example

### Generic field value

This example shows how to use a generic field from a child item and display its value in a collection.

![Collection content email label template](images/collection-label-template.png)

Here, the `{=value}` placeholder retrieves the value of the *Email* property and displays it in the collection, as shown in the image below:

![Collection content email value displayed](images/collections-display-email.png)

### Member name

First, a Member Picker property needs to be present on the content item. In this example, the `child item` has gotten a Member Picker Data Type with the alias of `isAuthor`.

![Collection member picker](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/member-picker.png)

The child item has a member and the value that should be displayed is the name of the picked value. The next step is to reconfigure the template value in the collection setting.

![Collection member picker](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/member-picker-settings.png)

This will take the value picked up by the member picker. ![Collection member picker](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/picked-member.png)

And display it in the collection. Shown in the example below: ![Collection member picker](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/list-member-picked.png)

### Other examples

![Collection other examples](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/others.png) ![Collection other examples](../../../../../../10/umbraco-cms/fundamentals/backoffice/property-editors/built-in-property-editors/images/others-result.png)
