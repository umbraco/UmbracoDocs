#Creating an MVC form with custom html markup

**Applies to: Umbraco 4.10.0+**

_This tutorial will demonstrate how to create a form with custom html markup (not auto-scaffolded)_

##The View Model

The view model that will be used in this tutorial will be as follows:
	
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

##The Surface Controller

For this tutorial, the Surface controller that we will create will contain one action which is used to accept the POSTed values from the form. In this example, the action will:

*	Check if the model is valid - based on the validation attributes applied to the model above, we will not be performing any custom validation
*	If the model **is not valid**, return the currently rendered Umbraco page (do not redirect). By not redirecting the ViewData is preserved including the ModelState which contains the validation information.
*	If the model **is valid**, add a custom message to the TempData collection and then redirect to the currently rendered Umbraco page. A standard procedure for a web based for is to redirect if the POST is successful. This ensures that the POST cannot be accidentally re-submitted by accidentally pressing F5 (refresh) ... *unfortunately ASP.Net WebForms does not adhere to this rule by default but it 'should' be done in WebForms too.* 

<br/>

	public class BlogPostSurfaceController : Umbraco.Web.Mvc.SurfaceController
	{
		[HttpPost]
		public ActionResult CreateComment(CommentViewModel model)
		{    
		    //model not valid, do not save, but return current Umbraco page
		    if (!ModelState.IsValid)
			{
				//Perhaps you might want to add a custom message to the ViewBag
				//which will be available on the View when it renders (since we're not 
				//redirecting)	    	
		   		return CurrentUmbracoPage();
			}
				    
			//Add a message in TempData which will be available 
			//in the View after the redirect 
			TempData.Add("CustomMessage", "Your form was successfully submitted at " + DateTime.Now)
		
		    //redirect to current page to clear the form
		    return RedirectToCurrentUmbracoPage();		    
		}
	}

##Create a Partial View to render the form

The best way to render a form in MVC is to have a Partial View render the form with a strongly typed model. For this example, we'll create a partial view at location: *~/Views/Partials/BlogCommentForm.cshtml* with a strongly typed model of the model created previously. This example shows how to use the BeginUmbracoForm method with the strongly typed overload to specify which Surface controller and Action to POST to. Instead of having MVC auto-scaffold the form for us, we'll create the markup manually. 

	@model CommentViewModel

	@using(Html.BeginUmbracoForm<BlogPostSurfaceController>("CreateComment"))
	{
 	   <div class="editor-label">
	        @Html.LabelFor(x => Model.Name)
	    </div>
	    <div class="editor-field">
	        @Html.TextBoxFor(x => Model.Name)
	        @Html.ValidationMessageFor(x => Model.Name)
	    </div>
	 
	    <div class="editor-label">
	        @Html.LabelFor(x => Model.Email)
	    </div>
	    <div class="editor-field">
	        @Html.TextBoxFor(x => Model.Email)
	        @Html.ValidationMessageFor(x => Model.Email)
	    </div>
	    
	    <div class="editor-label">
	        @Html.LabelFor(x => Model.Comment)
	    </div>
	    <div class="editor-field">
	        @Html.TextAreaFor(x => Model.Comment)
	        @Html.ValidationMessageFor(x => Model.Comment)
	    </div>

		<input type="submit"/>
	}

There are numerous [HtmlHelper methods](http://msdn.microsoft.com/en-us/library/system.web.mvc.htmlhelper_methods(v=vs.108).aspx) that you can use to render a form. In the above we've used the strongly typed helper methods: `LabelFor`, `TextBoxFor`, `TextAreaFor` and `ValidationMessageFor`. 

##Render the Partial View

The last step is to render the partial view that we've just created in your Umbraco template's view:

	@Html.Partial("BlogCommentForm")

You could also pass in a pre-populated model to pre-populate the fields on the form. For example:

	@Html.Partial("BlogCommentForm", new CommentViewModel() { Name = "Some guy" })