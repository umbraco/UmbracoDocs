---
meta.Title: "The Umbraco Backoffice"
meta.Description: "In this article you can learn more about the common terms and concepts that are used throughout the Umbraco Backoffice."
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Backoffice overview

In this article you can learn more about the common terms and concepts that are used throughout the Umbraco backoffice.

## [Login screen](Login)

When you go to the backoffice for the first time, you're presented with the login screen.

![Login screen](images/backoffice-login.png "The login screen has a greeting, username/password field and optionally a 'Forgotten password' link.")

[Read more about the login screen](Login).

## [Section](Sections)

A section in Umbraco is where you do specific tasks related to that section. For example Content, Settings and Users. You can navigate between the different sections of the backoffice by clicking the corresponding icon in the section menu.

![Sections](images/highlight-sections.png "The Section menu is the horizontal menu located on the top of the backoffice.")
*The __Section menu__ is the horizontal menu located on the top of the backoffice.*

[Read more about the section menu](Sections).

## [Tree](../../Extending/Section-Trees)

A tree is a hierarchical list of items related (and usually restricted) to a specific concept, like for example content or media.

You can expand trees by clicking the down arrow <img src="images/expand-node.png" style="margin:0;width:15px" title="Expand a node in a tree" /> to the left of the node or by double-clicking the node.

![Tree](images/highlight-tree.png "The content tree")
*The content tree*

[Read more about the Tree](../../Extending/Section-Trees)

## Node

A node is an item in a tree. The images and folders in the Media section are shown as nodes in the Media tree, pages and content in the Content tree and so forth.

## [Dashboards](../../Extending/Dashboards)

A dashboard is the main view you are presented with when entering a section within the backoffice. It can be used to show valuable information to the users of the system.

![Dashboard](images/highlight-dashboard.png "Default dashboard in the content section")
*Default dashboard in the content section*

 [Read more about Dashboards](../../Extending/Dashboards)

## Editor

An editor is what you use to edit different items within the backoffice. There are editors specific to editing stylesheets, there are editors for editing Macros and so forth.

## [Content](../Data/Defining-content)

Content is what you find in the Content section. Each item in the tree is called a **content node**.  Each content node in the content tree consists of different fields, and each of them are defined by a Document Type.

[Read more about Content](../Data/Defining-content)

## Document Type

Document Types define the types of content nodes that backoffice users can create in the content tree. Each Document Type contains different properties. Each property has a specific Data Type e.g. text or number.

### Properties

Every Document Type has properties. These are the fields that the content editor is allowed to edit for the content node.

### [Data Type](../Data/Data-Types/)

Each Document Type property has a Data Type which defines the type of input of that property. Data Types reference a Property Editor and are configured in the Umbraco backoffice in the Settings section. A Data Type can be something basic (textstring, number, true/false) or more complex (multi-node tree picker, image cropper, etc).

[Read more about Data Types](../Data/Data-Types/)

### [Property Editors](Property-Editors)

A property editor is the view used by Data Types to insert content into Umbraco. An example of a property editor is the *Textarea*. It's possible to have many Textarea Data Types with different settings that all use the Textarea property editor.

[Read more about Property Editors](Property-Editors)

## [Media](../Data/Creating-Media/)

Media items are used to store assets like images and video within the Media section and can be referenced from your content.

[Read more about Media](../Data/Creating-Media/)

### Media Types

Media Types are very similar to Document Types in Umbraco, except they are specifically for media items in the Media section.

Umbraco comes with 3 default Media Types: **File**, **Folder** and **Image**.

## [Members](../Data/Members/)

A member is someone who has access to signup, register and login into your **public website** and is not to be confused with Users.

[Read more about Members](../Data/Members/)

### Member Types

Similar to a Document Type and a Media Type. You are able to define custom properties to store on a member such as twitter username or website URL.

## [Templates](../Design/Templates/)

A Template is where you define the HTML markup of your website and also where you output the data from your content nodes.

[Read more about Templates](../Design/Templates/)

## Packages

A package is the Umbraco term for a module or plugin used to extend Umbraco. Packages can be found in the [Packages section of Our Umbraco](https://our.umbraco.com/projects/ "Projects on Our Umbraco"), and you can also install them directly from the Packages section in the Umbraco backoffice.

## [Macros](../../Reference/Templating/Macros/)

A macro is a reusable piece of functionality that you can reuse throughout your site. Macros can be configured with parameters and used on content nodes that has a Rich Text Editor, a Grid editor or a Macro Picker property.  You can define what macros are available for your editors to use. When an editor inserts a macro it will prompt them to fill out any of the defined parameters for the macro.

[Read more about Macros](../../Reference/Templating/Macros/)

### [Macro Parameter Editor](../../Extending/Macro-Parameter-Editors/)

A parameter editor defines the usage of a property editor for use as a parameter for Macros.

[Read more about the Macro Parameter Editor](../../Extending/Macro-Parameter-Editors/)

## Users

A user is someone who has access to the **Umbraco backoffice** and is not to be confused with Members. When Umbraco has been installed a user will automatically be generated with the login (email) and password entered during installation. Users can be created, edited and managed in the User section.

## [Content Templates](Content-Templates/)

Content Templates provide a blueprint for content nodes based on an existing node.
