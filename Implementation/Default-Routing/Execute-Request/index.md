# Executing an Umbraco request

_During the Umbraco request execution, an MVC Action is called which executes a Razor view to render content to the end-user_

## Using the Model

Whenever a content item is rendered on the front-end, it is based on a model of type `IPublishedContent`.
This model contains all of the information about the content item associated with the current request.

If you are working in a custom MVC Controller's action, a model of type `RenderModel` will be provided in the Action's method parameters.
This model contains an instance of `IPublishedContent` which you can use.

When you are working in a View of type `UmbracoTemplatePage` (which is the default view type), the Model provided to that view
will also be `RenderModel` which exposes `IPublishedContent`. For example, to render the current content model's name you could do:

    @Model.Content.Name

All Umbraco view page types inherit from `UmbracoViewPage<TModel>`. A neat trick is that if you want your view Model to simply be `IPublishedContent`
you can change your view type to `UmbracoViewPage<IPublishedContent>` and the view will still render without issue even though the controller
is passing it a model of type RenderModel.

## [IPublishedContent](../../../Reference/Querying/IPublishedContent/index.md)

IPublishedContent is the standard model used for all published content, media and members in Umbraco. It is a strongly typed model and is very flexible.

## [DynamicPublishedContent](../../../Reference/Querying/DynamicPublishedContent/index.md)

There's also a dynamic representation of `IPublishedContent` called `DynamicPublishedContent`. This is available on `UmbracoTemplatePage` as the property `@CurrentPage`.
Working with dynamics is simpler in some cases especially with regards to referencing property data. For example, to output your custom property 'markDown', you could just do:

	@CurrentPage.markDown

However, a dynamic object does not provide any intellisense and is compiled at runtime.

## [UmbracoHelper](../../../Reference/Querying/UmbracoHelper/index.md)

UmbracoHelper is the unified way to work with published content/media on your website. Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data.

## [MembershipHelper](../../../Reference/Querying/MemberShipHelper/index.md)

MembershipHelper is a general helper class for accessing ASP.NET membership data, as well as Umbraco Member data, which are stored in a format similar to Umbraco content and media.
