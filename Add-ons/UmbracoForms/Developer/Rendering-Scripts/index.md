# Rendering Forms scripts where you want
Besides markup Forms will also output some JavaScript. By default this is rendered just below the markup. If you wish to change this behaviour (e.g. if all your JS is rendered at the bottom of your page) follow the next steps.

## Change the Forms partial view macro
First we'll need to tell the Forms partial macro (that is used to render forms) to only render the markup and not the scripts. Navigate to the Developer section and open the Partial View Macro File > Insert Umbraco Form

It should have the following contents 

	@inherits Umbraco.Web.Macros.PartialViewMacroPage
		
	@if (Model.MacroParameters["FormGuid"] != null)
	{
		var s = Model.MacroParameters["FormGuid"].ToString();
		var g = new Guid(s);
		
		var recordGuid = Guid.Empty;

    		if (string.IsNullOrEmpty(Request.QueryString["recordId"]) == false)
    		{
        		Guid.TryParse(Request.QueryString["recordId"], out recordGuid);
    		}
		Html.RenderAction("Render", "UmbracoForms", new {formId = g, recordId = recordGuid });	
	}

Here we'll make a small change: In the RenderAction call we'll provide an additional argument: `mode = "form"`

So change this:

	Html.RenderAction("Render", "UmbracoForms", new {formId = g, recordId = recordGuid });	

to this:
	
	Html.RenderAction("Render", "UmbracoForms", new {formId = g, recordId = recordGuid, mode = "form" });

## Place the Render Scripts macro on your template

Now we'll need to let Forms know where we want to output the script instead. So navigate to the Settings section and select the template that should contain the scripts. Insert the *Render Umbraco Forms Scripts* macro where you need the scripts rendered:

	@Umbraco.RenderMacro("FormsRenderScripts")
