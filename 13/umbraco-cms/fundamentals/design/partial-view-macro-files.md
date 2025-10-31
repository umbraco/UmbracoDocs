---
description: Information on working with partial view macro files in Umbraco
---

{% hint style="warning" %}
Partial View Macro Files will be removed in the next version. Consider using Partial Views.
{% endhint %}

# Partial View Macro Files

A Macro is a reusable piece of functionality with some configuration options in the Backoffice. A Partial View Macro File (`.cshtml` file) is a specific file configuration that is associated with the Macro. A Partial View Macro File generates a Macro that can be inserted and rendered in the Grid and Rich Text Editor data types. Additionally, you can define parameter values and enable caching in Macros in the Backoffice. Partial View Macro Files are the recommended macro type to use in Umbraco.

## Partial View Macro Files in the Backoffice

You can create and edit Partial View Macro Files in the **Partial View Macro Files** folder from the **Settings** section of the Backoffice.

![Creating a new partial view macro file](images/creating-partial-view-macro-files.png)

In the **Create** menu, there are four options available:

* New partial view macro
* New partial view macro (without macro)
* New partial view macro from snippet
* Folder (for keeping the partial view macro files organized)

## Creating a Partial View Macro File

To create a Partial View Macro File, go to the **Settings** section in the Umbraco backoffice and right-click the **Partial View Macro Files** folder. Choose **Create**. Select **New partial view macro** and enter a Partial View Macro Filename. Enter the macro logic and click the **Save** button. You will now see the Partial View Macro File in the **Partial View Macro Files** folder. You also see the macro in the **Macros** folder in the Backoffice.

![Created partial view](images/created-partial-view-macro-file.png)

By default, the Partial View Macro File is saved in the `Views/MacroPartials` folder.

## Creating a Partial View Macro File (without macro)

To create a Partial View Macro File without a macro, go to the **Settings** section in the Umbraco backoffice. Click right on the **Partial View Macro Files** folder. Choose **Create**. Select **New partial view macro (without macro)** and enter a Partial View Macro Filename. Enter the macro logic and click the **Save** button. You will now see _only_ the Partial View Macro File in the **Partial View Macro Files** folder in the Backoffice.

![Created partial view](images/created-partial-view-macro-file-without-macro.png)

By default, the Partial View Macro File is saved in the `Views/MacroPartials` folder.

## Creating a Partial View Macro File from Snippet

To create a Partial View Macro File from the snippet, go to the **Settings** section in the Umbraco backoffice. Click right on the **Partial Views Macro Files** folder. Choose **Create**. Select **New empty partial view macro from snippet**. Select the snippet you want to create a partial view for and enter a Partial View Macro Filename. The code snippet you selected is displayed in the backoffice editor. Click the **Save** button. You will now see the Partial View Macro File in the **Partial View Macro Files** folder. You also see the macro in the **Macros** folder in the Backoffice.

![Created partial view from snippet](images/created-partial-view-macro-file-from-snippet.png)

By default, the partial view is saved in the `Views/MacroPartials` folder. Umbraco provides the following partial view macro snippets:

* Empty - Creates an empty partial view file.
* Breadcrumb - Creates a breadcrumb of parents using the `Ancestors()` method to generate links in an unordered HTML list. It displays the name of the current page without a link.
* Edit Profile - Creates a Member profile model that can be edited.
* Gallery - Displays a gallery of images from the Media section. It works with either a 'Single Media Picker' or a 'Multiple Media Picker' macro parameters.
* List Ancestors From Current Page - Displays a list of links to the parents of the current page using the `Ancestors()` method to generate links in an unordered HTML list. It displays the name of the current page without a link.
* List Child Pages From Changeable Source - Lists all the child pages under a specific page in the Content tree.
* List Child Pages From Current Page - Displays a list of links to the children of the current page using the `Children()` method to generate links in an unordered HTML list.
* List Child Pages Ordered By Date - Displays a list of links to the children of the current page using the `Children()` method to generate links in an unordered HTML list. The pages are sorted by the creation date in a descending order using the `OrderByDescending()` method.
* List Child Pages Ordered By Name - Displays a list of links to the children of the current page using the `Children()` method to generate links in an unordered HTML list. The pages are sorted by the page name using the `OrderBy()` method.
* List Child Pages With DocType - Displays only the children of a certain Document Type.
* List Descendants From Current Page - Displays a list of links for every page below the current page in an unordered HTML list.
* List Images From Media Picker - Displays a series of images from a media folder.
* Login - Displays a login form.
* Login Status - Displays the user name if the user is logged in.
* Multinode Tree-picker - Lists the items from a Multinode tree picker using the picker's default settings.
* Navigation - Displays a list of links of the pages under the top-most page in the Content tree. It also highlights the currently active page/section in the navigation menu.
* Register Member - Displays a Member registration form. It will only display the properties marked as **Member can edit** on the **Info** tab of the Member Type.
* Site Map - Displays a list of links of all the visible pages of the site using the `Traverse()` method to select and display the markup and links as nested unordered HTML lists.
* InsertUmbracoFormWithTheme - If a theme is provided as a macro parameter, Umbraco Forms will use the custom theme files.
* RenderUmbracoFormScripts - Renders your Umbraco Forms scripts. In many cases, you might prefer rendering your scripts at the bottom of the page as this generally improves site performance.

## Creating a Folder

To create a folder, go to the **Settings** section in the Umbraco backoffice and right-click the **Partial Views Macro Files** folder. Choose **Create** and select **Folder**. Enter a folder name and click the **Create** button.

![Created folder](images/folder.png)

## Rendering a Partial View Macro File

To render the created Partial View Macro File in any template, use the `RenderMacroAsync` method:

```csharp
@await Umbraco.RenderMacroAsync("InsertImages")
```

### Related Articles

* [Macros](../../reference/templating/macros/)
* [Managing Macros](../../reference/templating/macros/managing-macros.md)
* [Partial View Macros](../../reference/templating/macros/partial-view-macros.md)
* [Macro Parameter Editors](../../extending/macro-parameter-editors.md)
