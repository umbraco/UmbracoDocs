#Umbraco Api - Routing & Urls

**Applies to: Umbraco 6.1.0+**

_This section will describe how Umbraco Api controllers are routed and how to retreive their URLs_ 

##Routing

Just like Surface Controllers in Umbraco, when you inherit from the base class `Umbraco.Web.WebApi.UmbracoApiController` we will auto-route this controller so you don't have to worry about routing at all. 

All locally declared Umbraco api controllers will be routed under the url path of:

~/Umbraco/Api/[YourControllerName]

All plugin based Umbraco api controlleres will be routed under the url path of:

~/Umbraco/[YourAreaName]/[YourControllerName]

##Urls

We've added some handy UrlHelper extension methods so you can easily retreive the Url of your Umbraco Api controllers. The extension methods are found in the class: `Umbraco.Web.UrlHelperExtensions` so you'll need to ensure you have the namespace `Umbraco.Web` imported. 

The method overloads are:

	string GetUmbracoApiService<T>(string actionName)
	string GetUmbracoApiService(string actionName, Type apiControllerType)
	string GetUmbracoApiService(string actionName, string controllerName)
	string GetUmbracoApiService(string actionName, string controllerName, string area)

The easiest way to retreive a Url is to use your controller's type. Example:

	@Url.GetUmbracoApiService<ProductsApiController>("GetAllProducts")

Generally a UrlHelper instance will be available on most base classes like Controllers and Views but In some cases you might need to create a UrlHelper instance manually. Here's an example of a way to do that:

	var requestContext = HttpContext.Current.Request.RequestContext;
    var urlHelper = new System.Web.Mvc.UrlHelper(requestContext);
    var apiControllerUrl = urlHelper.GetUmbracoApiService("GetAllProducts");

