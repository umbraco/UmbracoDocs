#UmbracoHelper

_UmbracoHelper is the unified way to work with published content/media on your website. Whether you are using MVC or WebForms you will be able to use UmbracoHelper to query/traverse Umbraco published data._   

UmbracoHelper also has a variety of helper methods that are useful when working in your views, controllers and webforms classes.

UmbracoHelper is also available from within [Partial View Macros](../../Templating/Macros/Partial-View-Macros/index.md) which is why Partial View Macros are the recommended macro format (which work in both MVC and WebForms).


##How to reference UmbracoHelper?

Nearly all of Umbraco's base classes expose an intance of UmbracoHelper. If you are using MVC Views or Partial View Macros you can reference UmbracoHelper with the syntax: `@Umbraco`

If you are using SurfaceControllers, RenderMvcControllers, or any controller inheriting from UmbracoController, these all expose an UmbracoHelper via the `Umbraco` property. 

For WebApi, the base class `Umbraco.Web.WebApi.UmbracoApiController` exposes this property too.

If you are using WebForms and using controls you can inherit from : `Umbraco.Web.UI.Controls.UmbracoControl` or `Umbraco.Web.UI.Controls.UmbracoUserControl` both of which expose many handy Umbraco object including an UmbracoHelper via the `Umbraco` property.

For webservices and http handlers, these base classes expose UmbracoHelper via the `Umbraco` property: `Umbraco.Web.WebServices.UmbracoHttpHandler`, `Umbraco.Web.WebServices.UmbracoWebService` 

Lastly, if you need an UmbracoHelper in a custom class, service, view, etc... you can easily create one using this syntax:

	var umbracoHelper = new Umbraco.Web.UmbracoHelper(Umbraco.Web.UmbracoContext.Current);

##IPublishedContent

UmbracoHelper will expose all content in the form of `IPublishedContent`. To get a reference to the currently executing content item from the UmbracoHelper, use `UmbracoHelper.AssignedContentItem`

**Are you using [MVC](../../Templating/Mvc/index.md)?** UmbracoHelper will expose the currently executing page model as per above, but when using MVC this model is instantly available in your views via your [view's model](../../Templating/Mvc/views.md).

All samples below represent how you work with `UmbracoHelper` in Razor, except for the `@` syntax, it is the exact same with your work with this helper inside controllers or UserControls.

##Working with Content

###.Content(int id);
Given a node ID, returns a `dynamic` object, representing a single `IPublishedContent` entity 

    @{
        var page = Umbraco.Content(1234);
    }
    
    <h3>@page.PropertyAlias</h3>
    
    @foreach (var child in page.Children) { 
        <a href="@child.Url">@child.Name</a>
    }
	
###.ContentAtRoot();
Returns a `dynamic` object, representing the root `IPublishedContent` entity

    @foreach (var child in Umbraco.ContentAtRoot().Children) { 
        <a href="@child.Url">@child.Name</a>
    }

###.ContentAtXPath(string xpath, params XPathVariable[] variables);
Queries the XML Cache for Content matching a given xpath query and returns a collection of dynamic objecs.
    
    @{
        var newsArticles = Umbraco.ContentAtXPath("//newsArticle");
    }

###.ContentQuery
Content query helper, which contains many helpful ways to find content. (description coming soon)

###.ContentSingleAtXPath(string xpath, params XPathVariable[] variables);
Queries the XML Cache for Content matching a given Xpath query, returns first match as a `dynamic` object.

    @{
        var newsArea = Umbraco.ContentSingleAtXPath("//newsArea");
    }
    
###.TypedContent(int id)
Given a node ID , returns a `IPublishedContent`

    @{
        var page = Umbraco.TypedContent(1234);
    }

    <h3>@page.GetPropertyValue<string>("propertyAlias") 
    </h3>

    @foreach (var child in page.Children) { 
        <a href="@child.Url">@child.Name</a>
    }


###.TypedContentAtRoot()
Returns the root `IPublishedContent` from the Content tree

    @foreach (var child in Umbraco.TypedContentAtRoot().Children) { 
        <a href="@child.Url">@child.Name</a>
    }


###.TypedContentAtXPath(string xpath)
Queries the XML Cache for Content matching a given xpath query and returns a collection of `IPublished` objecs.

    @{
        var newsArticles = Umbraco.TypedContentAtXPath("//newsArticle");
        var bd = newsArticles.First().GetPropertyValue("bodyText")
    }


###.TypedContentSingleAtXPath(string xpath)
Queries the XML Cache for Content matching a given Xpath query, returns first match as an `IPublished` object.

    @{
        var newsArticles = Umbraco.TypedContentAtXPath("//newsArticle");
        var bd = newsArticles.First().GetPropertyValue("bodyText")
    }


###Content helpers

###.Field(string field)
Given a property alias, it returns the value of that field from the Current Page.

    <h3>@Umbraco.Field("bodyText")</h3>


###.NiceUrl(int nodeId)
Returns a nicely formated URL, given a node ID. This is also available from `IPublishedContent.Url`

    <a href="@Umbraco.NiceUrl(1234)">My link</a>

###.NiceUrlWithDomain(int id)
Returns a nicely formated URL including its domain, given a node ID. This can be useful when linking between multiple sites with different domains on the same Umbraco installation.

    <a href="@Umbraco.NiceUrlWithDomain(1234)">My link</a>

  
##Working with  Media
###.Media(1234);
Given a node ID, returns a `dynamic` object, representing a single `IPublishedContent` Media entity 

    @{
        var media = Umbraco.Media(1234);
    }

    <h3>@media.PropertyAlias</h3>

    @foreach (var child in media.Children) { 
        <img src="@child.Url" alt="@child.Name">
    }
    //access a cropper on the umbracoFile property
    <img src="@media.GetCropUrl("umbracoFile", "banner") />


###.MediaAtRoot();
Returns a `dynamic` object, representing the root `IPublishedContent` entity in the Media tree.

    @foreach (var child in Umbraco.MediaAtRoot().Children) { 
        <img src="@child.Url" />
    }


###.TypedMedia(int id)
Given a node ID , returns a `IPublishedContent` Media entity

    @{
        var media = Umbraco.TypedMedia(1234);
        var image = media.Url;
        var height = media.GetPropertyValue<int>("umbracoHeight");
    }


###.TypedMediaAtRoot();
Returns the root `IPublishedContent` entity from the Media tree.

    @foreach (var child in Umbraco.TypedMediaAtRoot().Children) { 
        <img src="@child.Url" />
    }


##Working with Members

###.Member(1234);
Given a node ID, returns a `dynamic` object, representing a single `IPublishedContent` Member profile 

    @{
        var member = Umbraco.TypedMember(1234);
        var email = member.Email;
        var custom = member.MyCustomPropertyAlias
    }
    

###.TypedMember(1234);
Given a node ID , returns a `IPublishedContent` Member profile

    @{
        var member = Umbraco.TypedMember(1234);
    }

    <h1>@member.Name profile</h1>
    @foreach (var property in member.Properties) { 
        <label>@property.PropertyTypeAlias:</label> @property.GetValue<string>()
    }


###Member Helpers
###.MemberHasAccess(int nodeId, string path);
Returns a `Boolean` on whether the currently logged in member has access to the page given its ID and path. 
    
    @if(Umbraco.MemberHasAccess(CurrentPage.Id, CurrentPage.Path)){
        <h1>Welcome!</h1>
    }    

###.MemberIsLoggedOn()
Returns a `Boolean` on whether there is currently a member profile

    @if(Umbraco.MemberIsLoggedOn()){
        <h1>Welcome!</h1>
    }

###.IsProtected(int pageId, string path)
Returns a `Boolean` on whether a page with a given pageId and path has public access restrictions set.

    @foreach (var child in CurrentPage.Children) { 
        <h2>@child.Name</h2>
            @if(Umbraco.IsProtected(child.id, child.Path)){
                <blink>Members only</blink>
            }
    }


##Fetching misc data

###.GetDictionaryValue(string key);
Returns a `string` 

    <p>@Umbraco.GetDictionaryValue("createdOn"): @CurrentPage.CreateDate</p>

###.GetPreValueAsString(int prevalueId)
Returns a `string`

    <p>@Umbraco.GetPreValueAsString(CurrentPage.DropDownProperty)</p>

###.Search(string term, bool useWildCards, string searchProvider)
Given a search term, it by default searches the Umbraco search index for content matching the term. Wildcards are enabled by default, and searchProvider can optionally be set a different one.

Returns a collection of `dynamic` objects representin a `IPublishedContent` Entity. 

    @foreach(var result in Umbraco.Search("news",useWildCards:true)){
        <a href="@result.Url">@result.BodyText</a>
    }

Alternatively, you can use Examines `SearchCriteria` builder:

    @{
        var query = ExamineManager.Instance.CreateSearchCriteria()
                        .NodeName("news")
                        .Or()
                        .Field("bodyText", "horse")
                        .Compile();
    }

    @foreach(var result in Umbraco.Search(query)){
        <a href="@result.Url">@result.BodyText</a>
    }


###.TypedSearch(string term, bool useWildCards, string searchProvider)
Like .Search() but returns a collection of `IPublishedContent` objects, see sampel above.


##Templating Helpers

###.Coalesce(params object[]);
will take the first non-null value in the collection and return the value of it.

    
    Umbraco.Coalesce(CurrentPage.Summary, CurrentPage.MaybeThere, CurrentPage.Name);


###.Concatenate(params object[]);
Joins any number of int/string/objects into one string
    
    Umbraco.Concatenate("Hi my name is ", CurrentPage.Name, " how are you?");

###.CreateMd5Hash(string text);
Returns a MD5 hash of a given string

    Umbraco.CreateMd5Hash("my@email.com");

###.If(bool test, string valueIfTrue, string valueIfFalse)
If the test is true, the string `valueIfTrue` will be returned, otherwise the `valueIfFalse` will be returned.

    <h1 class="Umbraco.If(CurrentPage.Name == "News", "this-is-news", "textpage">@CurrentPage.Name</h1>

###.Join(string seperator, parmas object[] args)    
Joins any number of int/string/objects into one string and seperates them with the string seperator parameter.

    Umbraco.Join("; ", "Red", 112, CurrentPage.Name);

###.ReplaceLineBreaksForHtml(string text)
Given a non-html string, it replaces all line-breaks with `<br/>`

    @{
        var multiLine = @"helo
                            my
                        name is    
                            ";
    }

    @Umbraco.ReplaceLineBreaksForHtml(multiLine)

###.StripHtml(string html)
Strips all html tags from a given string, all contents of the tags will remain.

    Umbraco.StripHtml("<blink>Stop the blinking</blink>");

###.Truncate(string html, int length, bool addElipsis)
Truncates a string to a given length, can add a elipsis at the end (...). Method checks for open html tags, and makes sure to close them
    
    Umbraco.Truncate("I wish I was a tweet, atleast the get 140 chars", 10, true)

###.RenderMacro(string alias, object parameters)
Renders a macro in the current page content, given the macros alias, and parameters required by the macro.

    @Umbraco.RenderMacro("navigation", new {root="1083", header="Hello"})

###.RenderTemplate(int pageId, int? altTemplateId)
Renders a template, as if a page with the given pageID was requested, optionally with an alternative template ID passed in.

    @Umbraco.RenderTemplate(1234)
