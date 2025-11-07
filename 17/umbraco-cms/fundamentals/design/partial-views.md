---
description: Information on working with partial views in Umbraco
---

# Partial Views

A Partial View (`.cshtml` file) is a regular view that can be used multiple times throughout your site. A Partial View is used to break up large markup files into smaller components such as header, footer, navigation menu, etc. It helps to reduce the duplication of code. A partial view renders a view within the parent view.

## Partial Views in the Backoffice

You can create and edit partial views in the **Partial Views** folder from the **Settings** section of the Backoffice.

![Creating a new partial view](templates/images/create-partial.png)

In the **Create** menu, there are three options available:

* New empty partial view
* New partial view from snippet
* Folder (for keeping the partial views organized)

## Creating a Partial View

To create a partial view:

1. Go to the **Settings** section in the Umbraco backoffice.
2. Click **...** next to the **Partial Views** folder.
3. Choose **Create**.
4. Select **New empty partial view**.
5. Enter a partial view name.
6. Click the **Save** button. You will now see the partial view markup in the backoffice editor.

<figure><img src="../../.gitbook/assets/image (23).png" alt="Created partial view"><figcaption><p>Created partial view</p></figcaption></figure>

By default, the partial views are saved in the `Views/Partials` folder in the solution.

![Partial View folder in the project directory](images/partial-views-in-directory.png)

## Creating a Partial View from Snippet

To create a partial view from the snippet:

1. Go to the **Settings** section in the Umbraco backoffice.
2. Click **...** next to the **Partial Views** folder.
3. Choose **Create**.
4. Select **New empty partial view from snippet**. 
5. Select the snippet you want to create a partial view for and enter a partial view name. The code snippet you selected is displayed in the backoffice editor.
6. Click the **Save** button.

<figure><img src="../../.gitbook/assets/image (25).png" alt=""><figcaption><p>Created partial view from snippet</p></figcaption></figure>

Umbraco provides the following partial view snippets:

* Empty - Creates an empty partial view file.
* Breadcrumb - Creates a breadcrumb of parents using the `Ancestors()` method to generate links in an unordered HTML list. It displays the name of the current page without a link.
* Edit Profile - Creates a Member profile model that can be edited.
* List Ancestors From Current Page - Displays a list of links to the parents of the current page using the `Ancestors()` method to generate links in an unordered HTML list. It displays the name of the current page without a link.
* List Child Pages From Current Page - Displays a list of links to the children of the current page using the `Children()` method to generate links in an unordered HTML list.
* List Child Pages Ordered By Date - Displays a list of links to the children of the current page using the `Children()` method to generate links in an unordered HTML list. The pages are sorted by the creation date in a descending order using the `OrderByDescending()` method.
* List Child Pages Ordered By Name - Displays a list of links to the children of the current page using the `Children()` method to generate links in an unordered HTML list. The pages are sorted by the page name using the `OrderBy()` method.
* List Child Pages With DocType - Displays only the children of a certain Document Type.
* List Descendants From Current Page - Displays a list of links for every page below the current page in an unordered HTML list.
* Login - Displays a login form.
* Login Status - Displays the user name if the user is logged in.
* Multinode Tree-picker - Lists the items from a Multinode tree picker using the picker's default settings.
* Navigation - Displays a list of links of the pages under the top-most page in the Content tree. It also highlights the currently active page/section in the navigation menu.
* Register Member - Displays a Member registration form. It will only display the properties marked as **Member can edit** on the **Info** tab of the Member Type.
* Site Map - Displays a list of links of all the visible pages of the site using the `Traverse()` method to select and display the markup and links as nested unordered HTML lists.

## Creating a Folder

To create a folder:

1. Go to the **Settings** section in the Umbraco backoffice.
2. Click **...** next to the **Partial Views** folder.
3. Choose **Create**.
4. Select **Folder**.
5. Enter a folder name.
6. Click the **Create** button.

<div align="center">

<figure><img src="../../.gitbook/assets/image (27).png" alt="Created folder"><figcaption><p>Created folder</p></figcaption></figure>

</div>

## Rendering a Partial View

To render the created partial view into any template, use any of these helper methods: `@Html.PartialAsync`, `@Html.Partial()`, or `@Html.RenderPartial()`

```csharp
@using Umbraco.Cms.Web.Common.PublishedModels;
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@{
	Layout = null;
}

@await Html.PartialAsync("Login")

@Html.Partial("Login")

@{
 Html.RenderPartial("Login");   
}
```

### Related Articles

* [Using MVC Partial Views in Umbraco](../../reference/templating/mvc/partial-views.md)

### Video Materials

{% embed url="https://www.youtube.com/watch?ab_channel=UmbracoLearningBase&v=RcYM_DJ-JnQ" %}
Getting started with Umbraco: Partial Views
{% endembed %}
