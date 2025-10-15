# List View

`Alias: Umbraco.Listview`

`Returns: IEnumerable<IPublishedContent>`

**List View** display a list of categories when it is enabled on a Document Type that has children.

![List view example](../built-in-property-editors/images/listview.png)

## Enable list view

If enabled, editors will be able to see multiple children from a list on a content node that has children. When not enabled, no list will be shown and all children will be shown in the Content Tree.

![Enable List view example](../built-in-property-editors/images/enable-listview.png)

## Settings

![List view settings example](../built-in-property-editors/images/list-view-settings1-v10.png) ![List view settings example 2](../built-in-property-editors/images/list-view-settings2-v10.png)

### Page Size

Defines how many child content nodes you want to see per page. This will limit how many content items you will see in your list. If you set it to 5, then only 5 content items will be shown in the list.

### Order By

Will sort your list by the selection you choose in the dropdown. By default it selects "Last edited" and you get the following three columns:

* **Last edited** - When the content node was last edited and saved.
* **Name** - Name of the content node(s).
* **Created by** - This is the user who the content node was created by.

You can add more sorting to this list by adding more datatypes to the columns in the "Columns Displayed" section.

### Order Direction

You can select order of the content nodes displayed, "Acsending" or "Descending". The order is affected by the "Order By" selection.

### Columns Displayed

It is possible to add more columns to the list, via adding the properties through the dropdown. These properties are based on the Data Types which are used by the Document Type. It will show up in the dropdown by its alias and not the name on the property.

![List view property example](../built-in-property-editors/images/listview-property.png) ![List view property example](../built-in-property-editors/images/listview-property-dropdown.png)

Once you have selected a column that you want to display, the next thing you want to do is define what its name should be and what kind of value it should display. You can also move the headers around, re-ordering how the headers should look. This is done by the move icon on the left side of the alias.

The template section is where you define what kind of value you want to display. The value of the column is in the `value` variable.

### Layouts

The list view comes with two layouts by default. A list and a grid view. These views can be disabled if you are not interested in any of them.

{% hint style="info" %}
A minimum of one layout needs to be enabled for the list view to work.
{% endhint %}

You can also make your own layout and add it to the settings. For example, if you wanted to change the width or length of the grid, you will be able to do so.

### Bulk Action Permissions

Select what kind of action is available on the list view.

* **Allow bulk publish** - content only
* **Allow bulk unpublish** - content only
* **Allow bulk copy** - content only
* **Allow bulk move**
* **Allow bulk delete**

### Content app icon

Changes the icon in the backoffice of the listview. By default it will look like the image below.

![List icon example](../built-in-property-editors/images/list-icon.png)

### Content app name

You can change the name of the listview itself. Default if empty: 'Child Items'.

### Show Content App First

Enable this to show the content app by default instead of the list view

## Content Example

### Generic field value

This example uses a generic field on a child item and displays it in the list. ![List view content example email](../built-in-property-editors/images/listview-content-example-email-settings.png)

The `{{ value }}` will take the value of the Email property and display it in the list, as shown on the image below.

![List view content example email](../built-in-property-editors/images/listview-content-example-email.png)

### Member name

First, a Member Picker property needs to be present on the content item. In this example, the `child item` has gotten a Member Picker Data Type with the alias of `isAuthor`.

![List view member picker](../built-in-property-editors/images/member-picker.png)

Now that the child item has a member and the value that should be displayed is the name of the picked value, the next step is to reconfigure the template value in the listview setting.

![List view member picker](../built-in-property-editors/images/member-picker-settings.png)

This will take the value picked up by the member picker. ![List view member picker](../built-in-property-editors/images/picked-member.png)

And display it in the listview. Shown in the example below: ![List view member picker](../built-in-property-editors/images/list-member-picked.png)

### Other examples

![List view other examples](../built-in-property-editors/images/others.png) ![List view other examples](../built-in-property-editors/images/others-result.png)
