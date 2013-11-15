#UmbracoHelper

_UmbracoHelper is the unified way to work with published content/media on your website. Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data._   

UmbracoHelper also has a variety of helper methods that are useful when working in your views, controllers and webforms classes.

UmbracoHelper is also available from within [Partial View Macros](../../Templating/Macros/Partial-View-Macros/index.md) which is why Partial View Macro's are the recommended macro format (which work in both MVC and WebForms).

##How to reference UmbracoHelper?

Nearly all of Umbraco's base classes expose an intance of UmbracoHelper. If you are using MVC Views or Partial View Macros you can reference UmbracoHelper with the syntax: `@Umbraco`

If you are using SurfaceController's, RenderMvcController's, or any controller inheriting from UmbracoController, these all expose an UmbracoHelper via the `Umbraco` property. 

For WebApi, the base class `Umbraco.Web.WebApi.UmbracoApiController` exposes this property too.

If you are using WebForms and using controls you can inherit from : `Umbraco.Web.UI.Controls.UmbracoControl` or `Umbraco.Web.UI.Controls.UmbracoUserControl` both of which expose many handy Umbraco object including an UmbracoHelper via the `Umbraco` property.

For webservices and http handlers, these base classes expose UmbracoHelper via the `Umbraco` property: `Umbraco.Web.WebServices.UmbracoHttpHandler`, `Umbraco.Web.WebServices.UmbracoWebService` 

Lastly, if you need an UmbracoHelper in a custom class, service, view, etc... you can easily create one using this syntax:

	var umbracoHelper = new UmbracoHelper(UmbracoContext.Current);

##IPublishedContent

UmbracoHelper will expose all content in the form of `IPublishedContent`. To get a reference to the currently executing content item from the UmbracoHelper, use `UmbracoHelper.AssignedContentItem`

**Are you using [MVC](../../Templating/Mvc/index.md)?** UmbracoHelper will expose the currently executing page model as per above, but when using MVC this model is instantly available in your views via your [view's model](../../Templating/Mvc/views.md).

*More coming soon...*

##Working with content

*Coming soon....*

##Working with media

*Coming soon....* 
