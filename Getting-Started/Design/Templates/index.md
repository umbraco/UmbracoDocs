#Templates

_Templating in Umbraco builds on the concept of Razor Views from asp.net MVC - if you already know this, then you are ready to create your first template - if not, this is a quick and handy guide._

##Creating your first template
By default all document types should have a template attached - but in case you need an alternative template or a new one, you can create one:

Open the settings section inside the Umbraco backoffice and right-click the **templates** folder. then choose **create**. Enter a template name and click the create button. You will now see the default template markup in the backoffice template editor

![Created template](images/create-template.png)


##Allowing a template on a document type
To use a template on a document, you must first allow it on the content's type. Open the document type you want to use the template and check the template under "allowed templates"

![Allowing template](images/allow-template.png)


##Inheriting a master template
A template can inherit content from a master template by using the asp.net views Layout feature. Lets say we have a template called **masterview**, containing the following html:

    @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
    @{
        Layout = null;
    }
    <!DOCTYPE html>
    <html lang="en">
        <body>
    		<h1>Hello world</h1>
            @RenderBody()
        </body>
    </html>

We then create a new template called **textpage** and in the template editor, under the properties tab, sets its master template to the template called masterview:

![Inherit template](images/inherit-template.png)

This changes the `Layout`value in the template markup, so **textpage** looks like this:

    @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
    @{
        Layout = "MasterView.cshtml";
    }
    <p>My content</p>

When a page using the textpage template renders, the final html will be merged together replacing the `@renderBody()` placeholder and produce the following:

    @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
    @{
        Layout = null;
    }
    <!DOCTYPE html>
    <html lang="en">
        <body>
    		<h1>Hello world</h1>
            <p>My content</p>
        </body>
    </html>

##Injecting partial template
Another way to reuse html is to use partials - which are small reusable views which can be injected into another view.

Like templates, create a partial, by clicking "partial views" and selecting create - you can then optionally use a pre-made template.

![Create partial](images/create-partial.png)

the created partial can now be injected into any template by using the `@Html.Partial()` method like so:

    @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
    @{
        Layout = "MasterView.cshtml";
    }

    <h1>My new page</h1>
    @Html.Partial("a-new-view")

###Find More information:

- [Basic Razor syntax](basic-razor-syntax.md)
- [Rendering content](../Rendering-Content/)

###Tutorials
- [Creating a basic website with Umbraco](../../../Tutorials/Creating-Basic-Site/)

###[Umbraco.TV](http://umbraco.tv)
- [Templating chapter](http://umbraco.tv/videos/umbraco-v7/implementor/fundamentals/templating/introduction/)
