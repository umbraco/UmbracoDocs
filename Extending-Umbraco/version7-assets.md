#Version 7 Server variables, URLs and Assets

_Describes how to deal with server variables and service URLs, along with how to work with custom JavaScript and CSS assets when creating custom sections, trees or property editors_

##Server Variables

In v7 once a user is authenticated a request is made to retreive the Server Variables collection from the server which creates a global dictionary object that is accessible in JavaScript. This dictionary contains information based on the current Umbraco environment for which the JavaScript and client side needs to know about. Information such as whether the application is running in debug mode, the service API URLs, or other non-sensitive global server side variables.

In JavaScript, the server variables dictionary can be accessed by:

	Umbraco.Sys.ServerVariables

This is not an angular service, it is simply a namespaced global variable. An example might be:

	Umbraco.Sys.ServerVariables.isDebuggingEnabled

which returns whether or not the application has the debug="true" setting in the web.config file.

It's also worth mentioning that the server variables collection when requested gets minified and then compressed so even though there might be quite a few values in there, the request size will be small.

###Adding your own

From version 7.0.2+ you can subscribe to an event if you need to add your data to the server variables collection:

	Umbraco.Web.UI.JavaScript.ServerVariablesParser.Parsing

A handler for this method could look like:

    private void Parsing(object sender, Dictionary<string, object> dictionary)
    {
		//add stuff to the dictionary, preferably under your own custom section such as:
        dictionary.Add("myPackage", new Dictionary<string, object>
            {
                {"mySetting1", "blah"},
                {"mySetting2", "another value"}
            });        
    } 

##URLs

A good rule of thumb about service URLs is to not hard code them if possible. One of the reasons why we don't hard code URLs is in case that routing has to change for some reason (i.e. [the breaking change for 7.0.2](http://umbraco.com/follow-us/blog-archive/2014/1/17/heads-up,-breaking-change-coming-in-702-and-62.aspx)). Another reason is if you want to keep compatibility with a legacy controller and introduce a new API version route (i.e. */umbraco/backoffice/api/myservice/v2/getstuff*). Generally a change like this would just mean changing a route in c# and if the JavaScript could automatically know the URL without being hard coded, it will 'just work'. 

### Using Server Variables

In the core we add a new server variable for every api controller's base URL. This allows us to to version some API routes and not others if required. The other reason we do this is because of the `umbRequestHelper` angular service that we've built which generates our URLs for us based on the server variables, for example this returns our service url for the ContentController's PostSort action:

	umbRequestHelper.getApiUrl("contentApiBaseUrl", "PostSort")  

This method looks in the "umbracoUrls" key for URLs in the server variables collection, for example: 

	Umbraco.Sys.ServerVariables.umbracoUrls.contentApiBaseUrl

The way that we add service URLs to the server variables collection in the core is by using strongly typed extension methods on the `UrlHelper`. This means that we have no magic strings that need changing in c# so refactoring is a breeze and we won't forget to update a hard coded string that we've forgotten about. These extension methods are public as well so you can use them too. For example, to generate the 'contentApiBaseUrl' to the server vars collection we use this code:

	Url.GetUmbracoApiServiceBaseUrl<ContentController>(controller => controller.PostSave(null))
    
For a full reference to our URL generation, you can see the source of the [BackOfficeController](https://github.com/umbraco/Umbraco-CMS/blob/7.0.2/src/Umbraco.Web/Editors/BackOfficeController.cs).

### UrlHelper

Because the `Umbraco.Web.UI.JavaScript.ServerVariablesParser.Parsing` event doesn't contain an instance of a UrlHelper to use, you'll have to create one which can be done with this code:

	if (HttpContext.Current == null) throw new InvalidOperationException("HttpContext is null");
	var urlHelper = new UrlHelper(new RequestContext(new HttpContextWrapper(HttpContext.Current), new RouteData()))


##Assets

coming soon...