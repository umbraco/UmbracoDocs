# Executing an Umbraco request

_During the Umbraco request execution, an MVC Action is called which executes a Razor view to render content to the end-user_,

## Using the Model

Whenever a content item is rendered on the front-end, it is based on a model of type `IPublishedContent`. This model contains all of the information about the content item associated with the current request.

If you are working in a custom MVC Controller's action, a model of type `ContentModel` will be provided in the Action's method parameters. This model contains an instance of `IPublishedContent` which you can use.

When you are working in a View of type `UmbracoViewPage` (which is the default view type), the Model provided to that view will be `IPublishedContent`. For example, to render the current content model's name you could do:

```csharp
@Model.Name
```

All Umbraco view page types inherit from `UmbracoViewPage<TModel>`. A neat trick is that if you want your view Model to be `IPublishedContent` you can change your view type to `UmbracoViewPage` and the view will still render without issue even though the controller is passing it a model of type ContentModel.

## [IPublishedContent](../../reference/querying/ipublishedcontent/)

IPublishedContent is a strongly typed model used for all published content, media, and members. It is used to render content in your views for your website.

## [UmbracoHelper](../../reference/querying/umbracohelper.md)

UmbracoHelper is the unified way to work with published content/media on your website. Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data.

## [IMemberManager](../../reference/querying/imembermanager.md)

IMemberManager is an user manager interface for accessing member data in the form of IPublishedContent. IMemberManager has a variety of methods that are useful in views, controllers, and webforms classes.
