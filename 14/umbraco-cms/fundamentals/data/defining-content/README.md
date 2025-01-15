---
description: Here you'll find an explanation of how content is defined in Umbraco
---

# Defining Content

Before a piece of content can be created in the Umbraco backoffice, first it needs to be defined. That is why, when opening a blank installation of Umbraco, it is not possible to create content in the **Content** section.

All content needs a blueprint that holds information about what kind of data can be stored on the content node or which editors are used.

Additionally, it also needs information on how it is organized, where in the structure it is allowed, and so forth. This blueprint or definition is called a **Document Type**.

## What is a Document Type?

Document Types define what kind of content can be created in the **Content** section and what an end-user sees and can interact with.

It can define entire pages or more limited content that can be reused on other nodes ie. a Search Engine Optimization (SEO) group. This means that you are in complete control of what type of content can be created and where.

Another example is if there is a "`Blog post`" Document Type that has some properties containing a thumbnail, a name, and an author image. Then all blog posts using the "`Blog post`" Document Type, will allow the end user to fill in a thumbnail, author name, and an author image.

A Document Type contains fieldsets (or groups) where you can apply rules about where the content can be created, allowed template(s), backoffice icons, etc.

## 1. Creating a Document Type

A Document Type is created using the Document Type editor in the **Settings** section.

* Go to the **Settings** section in the backoffice.
* On the **Document Types** node click the menu icon (•••) to bring up the context menu.
* Here choose **Document Type with Template**. This will create a new Document Type with a template. The Template can be found under **Templates** in the **Settings** section which will be assigned as the default template for the Document Type.

![CreateDoctype](../images/CreateDoctype.png)

You can also choose to create a **Document Type** without a template and create **Folders** to organize your Document Types. Other options are to create Compositions and Element types, which you can read more about in the [Default Document Types](default-document-types.md) section.

## 2. Defining the root node

### Name the Document Type

First, we're prompted to give the Document Type a **name**. This first Document Type will be the root node for our content, name it "`Home`".

![Name the Document Type](../images/homePage.png)

{% hint style="info" %}
The alias of the Document Type is automatically generated based on the property name. If you want to change the auto-generated alias, click the "**lock**" icon. The alias must be in camel case. For example: _`homePage`_.
{% endhint %}

Having a root node lets you quickly query content as you know everything will be under the root node.

### Adding Icons to the Document Type

Choosing appropriate icons for your content nodes is a good way to give editors a better overview of the content tree.

To set an icon for the Document Type click the document icon in the top left corner. This will open the icon select dialog. Search for "`Home"`and select the icon. This icon will be used in the content tree.

![Home icon](../images/docTypeIcon.png)

### Setting Permissions

This will allow this Document Type to be created as the first content in the **Content** section.

* Go to the **Structure** tab
* Tick the **Allow as root** toggle
* Save the Document Type by clicking **save** in the bottom right corner.

![Allow as root](../images/docTypePermissions.png)

## 3. Creating the content

Now that we have the Document Type in place, we can create the content.

* Go to the **Content section**
* Click on the menu icon next to **Content**
* Select the "`Home`" Document Type. We'll name it "`Home`"
* Then click the **Save and Publish** button.

![Create homepage](../images/createHomepage.png)

As we haven't created our properties, all we can see on the "`Home`" node is the Properties tab. This tab contains the default properties that are available on all content nodes in Umbraco.

Let's add some properties of our own.

## 4. Groups and properties

In order to add the option to create different content on the same Document Type, some groups and properties need to be added.

**Groups**

Groups are a way to organize and structure the properties within the content, making it more manageable. It also makes it more user-friendly for content editors when creating or editing content on a website.

A name can be added to the group and after properties can be added.

**Properties**

Each field on a Document Type is called a property. The property is given a **name**, an **alias** (used to output the properties contained in a template), and an **editor**.

The editor determines what type of data the property will store and the input method. There is a wide range of default [property editors available](../../backoffice/property-editors/built-in-umbraco-property-editors/) and you can [customize additional editors](../../../customizing/property-editors/).

Some editors require configuration where a configured editor is saved as a Data Type and can be reused for multiple properties and document types. These can be seen in the **Settings** section under **Data Types**.

* Go to the **Settings section**
* Expand **Document Types** by clicking the arrow to the left
* Select the "`Home`" Document Type.

{% hint style="info" %}
**Keyboard Shortcuts**

Keyboard shortcuts are available when you are working with the Document Type editor. To see which shortcuts are available, click **ALT + SHIFT + K**.
{% endhint %}

### Adding groups

Before we start adding properties to the Document Type we need to create a group to hold the property.

* Click **Add group** and name the group "`Content`".

<figure><img src="../../../.gitbook/assets/image (5).png" alt="Creating groups"><figcaption><p>Creating groups</p></figcaption></figure>

{% hint style="info" %}
_If you have multiple groups and/or properties you can order them with drag and drop or by entering a numeric sort order value. This is done by clicking **Reorder**._
{% endhint %}

To convert a group to a tab, see the [Convert a group to a tab](../adding-tabs.md#convert-a-group-to-a-tab) section in the [Using Tabs](../adding-tabs.md) article.

### Adding properties

Now that we have created a group we can start adding properties. Let's add a Rich Text editor to the Content group.

* Click the **Add property** link in the **Content** group. This opens the property settings dialog. Here you can set the metadata for each property (name, alias, description)
* **Choose** which Data Type/property editor to use, and add validation if needed.
* Give the property a **name.** The name will be shown to the editor to make it relevant and understandable. Notice the alias is automatically generated based on the name. We'll name this "`Body Text`".

![Adding a property](../images/addproperty.png)

#### Property Editors

* Clicking **Select Editor** will open the Select Editor dialog. Here, you can choose between all the available editors on the **Create a new Configuration** tab. This will create a new configuration or already configured editors in the **Available Configurations** tab.
* To make it easier to find what you need use the **search field** to filter by typing "`Rich`". Filtering will display configured properties first (under **Available configurations**) and all available editors under that.
* Select the **Rich Text editor** under **Create new**. This will let you configure the editor settings - the Rich Text editor for this property.

![Choosing the Rich Text editor](../images/selectEditor.png)

{% hint style="info" %}
The name of the Data Type is based on the name of the Document Type, the name of the property, and the property editor. Flor example: _Home - Body Text - Rich Text editor_.
{% endhint %}

* Let's **rename** it to "`Basic Rich Text editor`" and only select the most necessary options.
  * `bold`
  * `italic`
  * `alignLeft`
  * `alignCenter`
  * `link`
  * `umbMediaPicker`
* When you are happy with the settings click **Submit**.

{% hint style="info" %}
Selecting the **Mandatory** toggle makes the property mandatory and the content cannot be saved if no value is entered (in this case, the Richtext editor).

You have the option to add additional validation by selecting a predefined validation method under the **Custom validation** dropdown (such as email, number, or URL). Or by selecting a custom validation and adding a regular expression.
{% endhint %}

* **Save** the Document Type.
* If you go to the **Content section** and click on the `Home node` you will now see the `Content`group with the `Body Text` property.

#### Property descriptions

The description of the property is not necessary, but it´s a best practice as it guides the editor to use the property correctly. The property description supports some markdown and one custom collapse syntax:

<details>

<summary><strong>Bold</strong></summary>

You can make text in the description bold by wrapping it with `**`

```md
This is **bold**
```

</details>

<details>

<summary><strong>Italic</strong></summary>

You can make text in the description italic by wrapping it with `*`

```md
This is *italic*
```

</details>

<details>

<summary><strong>Links</strong></summary>

You can make links by using the syntax:

```md
[This is an absolute link](https://google.com)
[This is a relative link](/umbraco#/media)
```

**Note**: Links will always have the`target="_blank"` set. This is currently not configurable.

</details>

<details>

<summary><strong>Images</strong></summary>

You can embed images by using this syntax:

```md
![Image alt text](https://media.giphy.com/media/bezxCUK2D2TuBCJ7r5/giphy.gif)
```

</details>

<details>

<summary><strong>Collapsible description</strong></summary>

You can make the description collapsible by using this syntax:

```md
<details>
  <summary>This is displayed</summary>
  This is hidden.
</details>
```

</details>

Now if we put it all together we get something like this:

```md
This is **bold**
This is *italic*
[This is an absolute link](https://google.com)
[This is a relative link](/umbraco#/media)
--
![Image alt text](https://media.giphy.com/media/bezxCUK2D2TuBCJ7r5/giphy.gif)
```

![Makrdown description example](../../../../../14/umbraco-cms/fundamentals/data/images/md-description.gif)

## 5. Defining child nodes

Next up we'll create a text page Document Type that will be used for subpages on the site.

* Go back to the **Settings section**
* **Create** a new Document Type
* **Name** it "`Text Page`".
* Add a **group** called "`Content`"
* This time we'll add two properties:
  * First, make a property called "`Summary`" using the **Textarea** editor
  * Secondly, create a property called "`Body Text`" and reuse the **Rich Text Editor** Data Type.

### Creating child nodes

Before creating a Text Page in **Content** section, allow the Text Page Document Type to be created as a child node to the Home node.

* **Select** the "`Home`" Document Type
* Go to the **Structure** group.
* Click **Add child**
* **Select** "`Text Page`".

<figure><img src="../../../.gitbook/assets/image (8).png" alt="Allow Child page"><figcaption><p>Allow Child page</p></figcaption></figure>

* Go to the **Content** section
* Click the menu icon (•••) next to the "`Home`" node
* **Select** the "`Text page`" Document Type. We'll name the page "`About us`". We now have a basic content structure.

<figure><img src="../images/v8Screenshots/createAboutUs.PNG" alt=""><figcaption></figcaption></figure>

Document Types are flexible and can be used for defining pieces of reusable content or an entire page, to act as a container or repository.

## 6. Exporting/Importing the Document Type

You can also export document types from an already existing project/installation and import them into another project/installation.

* Go to the **Settings** section
* Click **...** next to the **Document type**
* Select **Export**. When you click on the **Export** button, the Document Type is saved as a \*.udt file.

![Exporting a Document Type](../images/v8Screenshots/export-document-type.png)

To import a Document Type:

* Go to the **Settings** section
* Click **...** next to the **Document type**
* Select **Import Document Type**
* Click on the **Import** button and browse to the Document Type you exported. The **Name** and **Alias** of the Document Type are displayed.
* Click **Import** to complete the process.

![Importing a Document Type](../images/import-document-type.png)

{% hint style="info" %}
1. If your Document Type contains compositions or inherits from another Document Type, then you need to export/import the Composition/Document Type too.
2. You cannot export/import document types on Umbraco Cloud.
{% endhint %}

## More information

* [Rendering Content](../../design/rendering-content.md)
* [Customizing Data Types](../data-types/)

## Related Services

* [ContentService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ContentService.html)
* [ContentTypeService](https://apidocs.umbraco.com/v14/csharp/api/Umbraco.Cms.Core.Services.ContentTypeService.html)

## Tutorials

* [Creating a basic website with Umbraco](../../../tutorials/creating-a-basic-website/)
