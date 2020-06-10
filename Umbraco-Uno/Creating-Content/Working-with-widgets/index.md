---
versionFrom: 8.0.0
---

# Working with widgets

Widgets are the building blocks used to create and customize Umbraco Uno websites. There is [a long list of available widgets](../../Uno-pedia/Widgets), all tailored to specific purposes ranging from static text fields to elaborate grid structures.

Being the main way to add content to pages, widgets are available on the following content types:

* Start
* Page
* Feed
* Global Content
* Search

Contents of this article:

* [Adding a widget](#adding-a-widget)
* [Copying widgets](#copying-widgets)
* [Re-ordering widgets](#re-ordering-widgets)
* [Remove widgets](#remove-widgets)

## Adding a widget

Widgets are added in the *Content* group which can be found on the *Content tab* on each of the content types listed above.

To add a widget, follow these steps:

* Click "Add Content"
* Select a widget from the pop-up dialog

  ![Dialog with available widgets](images/available-widgets.png)

* An empty widget of the type selected in the dialog will be added to the page
* Fill in data and choose configuration options
* Save and/or publish the page in order for the changes to be reflected

:::tip
Find links to articles describing each available widget in the [Widgets](../../Uno-pedia/Widgets) article.
:::

## Copying widgets

Once a widget has been added and configured, it becomes possible to create a copy of that widget. This copy will include all filled in data as well as maintain the selected configuration options.

To **copy a widget**, follow these steps:

* Use the mouse to hover over the widget that needs to be copied
* Click on the *copy* icon in the right side of the widget (this will add the widget to the *clipboard*)
* Navigate to the page where you want a copy of the widget
* Select "Add content"
* The dialog will now be divided into two section:
  1. "Paste from clipboard" containing all copies made of other widgets and
  2. "Create new"

  ![Widgets clipboard with available widget copies](images/widgets-clipboard.png)

* Select the widget copied from the other page
* A copy of the widget (including data and configuration) will be added to the current page

To **copy multiple widgets**, follow these steps:

* Hover over the Widgets section of the page from where the widgets should be copied
* Click on the little three dots
* Select "Copy widgets" - this will add all widgets from the page to the *clipboard*
* Navigate to the page where you want a copy of the widgets
* Select "Add content"

  ![All widgets from a page grouped together in clipboard](images/widgets-multiple.png)

* The clipboard will now show a group of widgets containing a copy of all widgets from the specific page (in this case "Widgets from Start")
* Select the group of widgets
* All widgets (including data and configuration) will be pasted into the current page

It is possible to have multiple copies and groups in the clipboard at the same time.

In order to clear the clipboard, click on the "trashcan" icon in the top-right corner of the section.

:::note
Widgets that are copied in this way, will have no relation to each other. This means that once a widget has been copied, and the original is changed, the copies will not be updated to reflect those changes.

In order to create a set of widgets that can be used on multiple pages, while only needing to be maintained one place, use [Global Content](../../Uno-pedia/Content-Types/Global-Content)
:::

## Re-ordering widgets

Sometimes it might become necessary to re-arrange the order of widgets added to a page. This can be done by clicking and dragging the widgets around.

* Click and hold the widget that needs to be moved
* Drag the widget to where it should be in the list
* Let go of the widget
* Save and/or publish the page in order for the changes to be reflected

## Remove widgets

In some cases it might be needed to remove one or more widgets from a page. This can be done by either removing all widgets from a page or removing the widgets one by one.

To **remove a single widget**, follow these steps:

* Use the mouse to hover over the widget that needs to be removed
* Select the *trashcan* icon in the right side
* Confirm the action by selecting "Yes, delete" in the pop-up dialog
* The widget will be removed from the page
* Save and/or publish the page in order for the changes to be reflected

To **remove all widgets on a page**, follow these steps:

* Use the mouse to over the Widgets section on the page where all widgets needs to be removed
* Click on the little three dots
* Select "Remove all items"
* Confirm the action by selecting "Yes, delete" in the pop-up dialog
* All widgets will be cleared from the page
* Save and/or publish the page in order for the changes to be reflected

:::warning
It's recommended that the delete actions be used with caution as deleted widgets cannot be recovered.
:::
