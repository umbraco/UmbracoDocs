---
description: Learn about the data types in Umbraco.
---

# Data Types

_A Data Type defines the type of input for a property. So when adding a property (on Document Types, Media Types and Members) and selecting the Type you are selecting a Data Type. There are preconfigured Data Types available in Umbraco and more can be added in the Settings section._

## What is a Data Type?

A Data Type can be something basic (textstring, number, true/false,...) or it can be more complex (multi node tree picker, image cropper, Grid Layout).

The Data Type references a Property Editor and if the Property Editor has settings these are configured on the Data Type. This means you can have multiple Data Types referencing the same Property Editor.

An example of this could be to have two dropdown Data Types both referencing the same dropdown Property Editor. One configured to show a list of cities, the other a list of countries.

## Creating a new Data Type

To create a new Data Type, go to the **Settings** section within the backoffice. Thereafter click the menu icon to the right of the **Data Types** folder and select **Create**->**New Data Type**. Name the Data Type - we'll call it _Dropdown Cities_.

![Dropdown List](images/creating-a-data-type-v10.png)

* **Property Editor:** This is where you pick the Property Editor that our _Dropdown Cities_ Data Type will be referencing. Pick the **Dropdown** and now you will see the configuration options that are available for a Data Type referencing the Dropdown Property Editor.
* **Enable multiple choice:** By enabling this it will be possible to select multiple options from the dropdown.
* **Add prevalue:** Here you can add prevalues to the Data Type by entering the value you want into the input field and pressing the **add** button or hitting **Enter** on your keyboard.

When you're happy with the list press **Save**. It is now possible to select this Data Type for a property on Document Types, Media Types, and Members. Doing this will then create a dropdown list for the editor to choose from and save the choice as a string.

## Customizing Data Types

To customize an existing Data Type go to the **Settings** section, expand the **Data Types** folder and select the **Data Type** you want to edit.

Besides the Data Types that are available out of the box there are some additional **Property Editors**. For example, think of the **Slider** and **Block List**.

## Viewing Data Type References

To view the Data Type reference, go to the **Settings** section and expand the **Data Types** folder. Select the **Data Type** you wish to view the reference for and click the **Info** tab.

![Content Picker References](images/viewing-data-type-reference.png)

This gives you an overview of the Types that currently use the Data Type.

Learn more about viewing references or implementing tracking in the [Tracking References](../../../extending/property-editors/tracking.md) article.

### More information

* [List of available Data Types](default-data-types.md)
* [Property Editors](../../backoffice/property-editors/)

### Related Services

* [DataTypeService](../../../reference/management/services/datatypeservice.md)

### Umbraco Learning Base Channel

{% embed url="https://www.youtube.com/watch?ab_channel=UmbracoLearningBase&v=OW9pCHWebGE" %}
Document Types in Umbraco: Defining Properties, Data Types and Property Editors
{% endembed %}
