---
versionFrom: 7.0.0
versionTo: 9.0.0
meta.Title: "Partial Views"
meta.Description: "Information on working with partial views in Umbraco"
verified-against: 9.3.1
updated-links: true
---

# Partial Views

A Partial View (`.cshtml` file) is a regular view which can be used multiple times in an application. A Partial View is used to break up large markup files into smaller components such as header, footer, navigation menu etc. It helps to reduce the duplication of code. A partial view renders a view within the parent view.

## Partial Views in the Backoffice

You can create and edit partial views in the **Partial Views** folder from the **Settings** section of the Backoffice.

![Creating a new partial view](images/creating-partial-view.png)

In the **Create** menu, there are three options available:

* New empty partial view
* New partial view from snippet
* Folder (for keeping the partial views organized)

## Creating a Partial View

To create a partial view, go to the **Settings** section in the Umbraco backoffice and right-click the **Partial Views** folder. Choose **Create**. Select **New empty partial view** and enter a partial view name and click the **Save** button. You will now see the partial view markup in the backoffice editor.

![Created partial view](images/created-partial-view.png)

By default, the partial view is saved in the `Views/Partials` folder in the solution.

## Creating a Partial View from Snippet

To create a partial view from snippet, go to the **Settings** section in the Umbraco backoffice and right-click the **Partial Views** folder. Choose **Create**. Select **New empty partial view from snippet**. Select the snippet you want to create a partial view for and enter a partial view name. The code snippet you selected is displayed in the backoffice editor. Click the **Save** button.

![Created partial view from snippet](images/created-partial-view-from-snippet.png)

By default, the partial view is saved in the `Views/Partials` folder in the solution.

## Creating a Folder

To create a folder, go to the **Settings** section in the Umbraco backoffice and right-click the **Partial Views** folder. Choose **Create**. Select **Folder**. Enter a folder name and click the **Create** button.

![Created folder](images/folder.png)

## Rendering a Partial View

To render the created partial view into any template, use the `[PartialAsync](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.rendering.htmlhelperpartialextensions.partialasync?view=aspnetcore-6.0)` helper method:

```csharp
@using Umbraco.Cms.Web.Common.PublishedModels;
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.HomePage>
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;
@{
	Layout = null;
}

@await Html.PartialAsync("Navigation")

<h1>Login</h1>

@await Html.PartialAsync("Login")
```

### Related Articles

* [Using MVC Partial Views in Umbraco](../../../Reference/Templating/Mvc/partial-views.md)
* [Creating an MVC Form using a Partial View](../../../Reference/Templating/Mvc/Forms/tutorial-partial-views.md)

### Video Materials

<iframe width="800" height="450" src="https://www.youtube.com/embed/RcYM_DJ-JnQ?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
