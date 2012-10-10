#Creating Html Forms

**Applies to: Umbraco 4.10.0+**

_Creating an HTML form to submit data with MVC in Umbraco is very easy! You'll need to create a SurfaceController, a 'View Model' class and use a handy HtmlHelper extension method called BeginUmbracoForm._

##Creating a form - The View Model

First off we need to define the data that will be submitted, this is done by creating a 'View Model' class. Here's an example:
	
	public class CommentViewModel
	{
	    [Required]
	    public string Name { get; set; }
	
	    [Required]
	    public string Email { get; set; }
	
	    [Required]
	    [Display(Name = "Enter a comment")]
	    public string Comment { get; set; }
	}

This class defines the data that will be submitted and also defines how the data will be validated upon submission and conveniently for us MVC automatically wires up these validation attributes with the front-end so JavaScript validation will automagically occur.

##Creating the SurfaceController Action

Next up, we need to create an Action on a SurfaceController which accepts our submitted View Model. Here's an example (this is a locally declared controller):

	public class BlogPostSurfaceController : Umbraco.Web.Mvc.SurfaceController
	{
		[HttpPost]
		public ActionResult CreateComment(CommentViewModel model)
		{    
		    //model not valid, do not save, but return current umbraco page
		    if (!ModelState.IsValid)
			{
				//Perhaps you might want to add a custom message to the TempData or ViewBag
				//which will be available on the View when it renders (since we're not 
				//redirecting)	    	
		   		return CurrentUmbracoPage();
			}
		
		    //if validation passes perform whatever logic
		    //In this sample we keep it empty, but try setting a breakpoint to see what is posted here
			
			//Perhaps you might want to store some data in TempData which will be available 
			//in the View after the redirect below. An example might be to show a custom 'submit
			//successful' message on the View, for example:
			TempData.Add("CustomMessage", "Your form was successfully submitted at " + DateTime.Now)
		
		    //redirect to current page to clear the form
		    return RedirectToCurrentUmbracoPage();
		
		    //Or redirect to specific page
		    //return RedirectToUmbracoPage(12345)
		}
	}

##Using BeginUmbracoForm

Lastly we need to render the HTML form to ensure that it posts to the surface controller created. The easiest way to do this is to create a seperate PartialView to render your form with the model type declared as your ViewModel. There's a few overloads for the BeginUmbracoForm method, we'll start with the simplest one:

	@model CommentViewModel

	@using(Html.BeginUmbracoForm("CreateComment", "BlogPostSurface"))
	{
		@Html.EditorFor(x => Model)
		<input type="submit"/>
	}

The above code snippet is a PartialView to render the form. Because the Model for the view is the ViewModel we want to scaffold the form, we can just do an `@Html.EditorFor(x => Model)` to automatically create all of the input fields.

###Overloads

This lists the different overloads available for BeginUmbracoForm:

	//as seen in the above example
	BeginUmbracoForm(this HtmlHelper html, string action, string controllerName)
	
	//The next three are the same as above but allow you to specify additional route values and/or html attributes for the form tag	
	BeginUmbracoForm(this HtmlHelper html, string action, string controllerName, object additionalRouteVals)
	BeginUmbracoForm(this HtmlHelper html, string action, string controllerName, object additionalRouteVals, object htmlAttributes)	
	BeginUmbracoForm(this HtmlHelper html, string action, string controllerName, object additionalRouteVals, IDictionary<string, object> htmlAttributes)
	
	//Allows you to specify the action name and controller type either by a generic type or type object:
	BeginUmbracoForm(this HtmlHelper html, string action, Type surfaceType)
	BeginUmbracoForm<T>(this HtmlHelper html, string action)
	BeginUmbracoForm(this HtmlHelper html, string action, Type surfaceType, object additionalRouteVals)
	BeginUmbracoForm<T>(this HtmlHelper html, string action, object additionalRouteVals)
	BeginUmbracoForm(this HtmlHelper html, string action, Type surfaceType, object additionalRouteVals, object htmlAttributes)
	BeginUmbracoForm<T>(this HtmlHelper html, string action, object additionalRouteVals, object htmlAttributes)
	BeginUmbracoForm(this HtmlHelper html, string action, Type surfaceType, object additionalRouteVals, IDictionary<string, object> htmlAttributes)
	BeginUmbracoForm<T>(this HtmlHelper html, string action, object additionalRouteVals, IDictionary<string, object> htmlAttributes)
	
	//The following are only used for plugin based surface controllers. If you don't want to specify
	//the controller type, you can specify the area that the plugin SurfaceController is routed to
	BeginUmbracoForm(this HtmlHelper html, string action, string controllerName, string area)
	BeginUmbracoForm(this HtmlHelper html, string action, string controllerName, string area, object additionalRouteVals, IDictionary<string, object> htmlAttributes)