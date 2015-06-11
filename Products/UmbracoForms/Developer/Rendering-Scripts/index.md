#Rendering Forms scripts where you want
Besides markup Forms will also output some JavaScript, by default this JavaScript is outputted just below the markup. If you wish to change this behaviour follow the next steps (like if all your js is rendered at the bottom of you page)

##Change the Forms partial view macro
First we'll need to tell the Forms partial macro (that is used to render forms) to only render the markup and not the scripts. Navigate to the developer section and open the > Partial View Macro File > Insert Umbraco Form

It should have the following contents 

	@inherits Umbraco.Web.Macros.PartialViewMacroPage
		
	@if (Model.MacroParameters["FormGuid"] != null)
	{
		var s = Model.MacroParameters["FormGuid"].ToString();
		var g = new Guid(s);
		
		Html.RenderAction("Render", "UmbracoForms", new {formId = g});
	}

Here we'll make a small change, in the RenderAction call we'll provide an additional argument mode = "form"

so go from

	Html.RenderAction("Render", "UmbracoForms", new {formId = g});	

to
	
	Html.RenderAction("Render", "UmbracoForms", new {formId = g, mode = "form"});

##Place the Render scripts macro on your template

Now we'll need to let Forms know where we want to output the script instead. So Navigate to the settings section and select  your template that should contain the scripts. There simply insert the *Render Umbraco Forms Scripts* macro.
