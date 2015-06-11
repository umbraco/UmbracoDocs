#Creating an MVC form using a Child Action

**Applies to: Umbraco 4.10.0+**

_This tutorial will explain how to create a form using  a Child Action in Umbraco._

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

For this tutorial, the Surface controller that we will create will contain 2 actions, one which is used to accept the POSTed values from the form and the other is used to render the view containing the form. 

The Child Action will:

* Accept an integer Id as a parameter (representing a member)
* Lookup the member
* Create the CommentViewModel and fill the Name and Email properties with the member's information
* Render the view for the form

The HttpPost Action will:

*	Check if the model is valid - based on the validation attributes applied to the model above, we will not be performing any custom validation
*	If the model **is not valid**, return the currently rendered Umbraco page (do not redirect). By not redirecting the ViewData is preserved including the ModelState which contains the validation information *(See 'Other Considerations' below for mor info)*
*	If the model **is valid**, add a custom message to the TempData collection and then redirect to the currently rendered Umbraco page. A standard procedure for a web based for is to redirect if the POST is successful. This ensures that the POST cannot be accidentally re-submitted by accidentally pressing F5 (refresh) ... *unfortunately ASP.Net WebForms does not adhere to this rule by default but it 'should' be done in WebForms too.* 

<br/>

	public class BlogPostSurfaceController : Umbraco.Web.Mvc.SurfaceController
	{
		//Important to attribute your child action with ChildActionOnly
		//otherwise the action will become publicly routable (i.e. have
		//a publicly available Url) 
		[ChildActionOnly]
		public ActionResult ShowCommentForm(int memberId) 
		{
			var member = Membership.GetUser(memberId);
			var model = new CommentViewModel();
			if (member != null) 
			{
				model.Name = member.UserName;
				model.Email = member.Email;
			}
			return PartialView("BlogCommentForm", model);
		}

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

The best way to render a form in MVC is to have a Partial View render the form with a strongly typed model. For this example, we'll create a partial view at location: *~/Views/Partials/BlogCommentForm.cshtml* with a strongly typed model of the model created previously. This example shows how to use the BeginUmbracoForm method with the strongly typed overload to specify which Surface controller and Action to POST to. For brevity, this will auto-scaffold all of the fields for the model using `Html.EditorFor(x => Model)` but you could create the input fields separately if you need more granular control over the markup.

	@model CommentViewModel

	@using(Html.BeginUmbracoForm<BlogPostSurfaceController>("CreateComment"))
	{
		@Html.EditorFor(x => Model)
		<input type="submit"/>
	}

##Render the Child Action

The last step is to render the Child Action that we've just created in your Umbraco template's view:

	@Html.Action("ShowCommentForm", "BlogPostSurface", new { memberId = 1234 })

We pass in the action name and the controller name. Notice that we leave off the suffix "Controller" when calling this method so instead of referring to the class name BlogPostSurfaceController, we refer to its controller name which is the class name without the "Controller" suffix: *BlogPostSurface*. We'll pass in a member id parameter (value 1234 for brevity) which is done by sending the controller a custom route value which gets automatically bound to the action's parameter. 

You could also pass in an object as a parameter if you wanted, for this example we could change it to just pass in the currently logged in member object:

	@Html.Action("ShowCommentForm", "BlogPostSurface", new { member = Membership.GetUser() })

and then change your action to look like:

	[ChildActionOnly]
	public ActionResult ShowCommentForm(MembershipUser member) 
	{
		var model = new CommentViewModel();
		if (member != null) 
		{
			model.Name = member.UserName;
			model.Email = member.Email;
		}
		return PartialView("BlogCommentForm", model);
	}

##Action naming

When naming your actions you may be tempted to name them the same for rendering a form and handling the POST for the form. For example with the above you might want to do this:

	[ChildActionOnly]
	public ActionResult CommentForm(int memberId) 
	{
		...
	}

	[HttpPost]
	public ActionResult CommentForm(CommentViewModel model)
	{    
	    ...
	}

However this may cause unwanted side effects. If you don't do a redirect during the  HttpPost and instead `return CurrentUmbracoPage();`  MVC will end up trying to render the [HttpPost] action when rendering your Child Action which will cause problems (and YSODs). Full information is available in this issue: [http://issues.umbraco.org/issue/U4-1819](http://issues.umbraco.org/issue/U4-1819). The problem is due to MVC routing to the wrong action because there's still an HttpPost verb in the request.

If you really want to name your actions the same you can use a new attribute which will be available in Umbraco 4.11.6+, 6.0.3+ called [NotChildAction] which you'd have to use to attribute your HttpPost method as well, so you actions would look like:

	[ChildActionOnly]
	public ActionResult CommentForm(int memberId) 
	{
		...
	}

	[NotChildAction]
	[HttpPost]
	public ActionResult CommentForm(CommentViewModel model)
	{    
	    ...
	}

Otherwise, just name your actions differently.

##Accessing ViewData 

When you are adding any data to the ViewData collection in your [HttpPost] action, this ViewData gets set on the 'root' view context. Therefore in order to retreive the data in the ViewData collection from your ChildAction view, you'll need to access it by:

	@ParentActionViewContext.ViewData

This is due to the fact that you are rendering a ChildAction. This is exactly the same as what would happen when you create a normal MVC application. Whenever you POST to a controller, anything you do in that controller is done on a 'root' context.

In some cases you might actually be rendering a ChildAction from within a macro. In this case what is actually happening is that you are rendering a ChildAction within a ChildAction because macros that are rendered in MVC are rendered as ChildActions themselves. In this case you'd have to access your view data by:

	@ParentActionViewContext.ParentActionViewContext.ViewData

And of course if you decide you want to render a ChildAction that then renders a macro that then renders a ChildAction (and so on), this nesting becomes bigger.