#Custom markup
With Umbraco Forms it's possible to customize the outputted markup of a form. So you have complete control over what Forms will output.

##Customizing the default views
The way the razor macro works is that it uses some razor views to output the form (1 for each fieldtype, 1 for the scripts and 1 for the rest of the form). The views are available for edit so you can customize them to your needs.

The views can be found in the `~\Views\Partials\Forms\`

###Form.cshtml

This is the main view responsible for rendering the form markup.

Default contents of the view:

    @using Umbraco.Forms.Core
    @using Umbraco.Forms.Mvc.Models
    @using Umbraco.Forms.Mvc.BusinessLogic
    @using Umbraco.Forms.MVC.Extensions
    @using Umbraco.Web
    @using ClientDependency.Core.Mvc;

    @model Umbraco.Forms.Mvc.Models.FormViewModel
    @{
        Html.EnableClientValidation(true);
        Html.EnableUnobtrusiveJavaScript(true);
    }



    @if (Model.SubmitHandled)
    {
        if (Model.RenderMode == "full" || Model.RenderMode == "form")
        {
            <p class="contourMessageOnSubmit">@Html.Raw(Model.MessageOnSubmit)</p>
        }
    }
    else
    {
        if (Model.RenderMode == "full" || Model.RenderMode == "form")
        {

             <div id="contour_form_@{@Model.FormName.Replace(" ", "")}" class="contour @Model.CssClass">

                 @using (Html.BeginUmbracoForm<Umbraco.Forms.Web.Controllers.UmbracoFormsController>("HandleForm"))
                 {
                     @Html.HiddenFor(x => Model.FormId)
                     @Html.HiddenFor(x => Model.FormName)
                     @Html.HiddenFor(x => Model.RecordId)
                     @Html.HiddenFor(x => Model.PreviousClicked)

                     <input type="hidden" name="FormStep" value="@Model.FormStep" />

                     <div class="contourPage">
                
                         @if (string.IsNullOrEmpty(Model.CurrentPage.Caption) == false)
                         {
                             <h4 class="contourPageName">@Html.Raw(Model.CurrentPage.Caption)</h4>
                         }
                
                         @if (Model.ShowValidationSummary)
                         {
                             @Html.ValidationSummary(false)
                         }

                         @foreach (FieldsetViewModel fs in Model.CurrentPage.Fieldsets)
                         {
                             <fieldset class="contourFieldSet">
                                 @if (string.IsNullOrEmpty(fs.Caption) == false)
                                 {
                                     <legend>@Html.Raw(fs.Caption)</legend>
                                 }

                                 <div class="row-fluid">
                                     @foreach (var c in fs.Containers)
                                     {

                                         <div class="@("span" + c.Width) @("col-md-" + c.Width)">
                                             @foreach (FieldViewModel f in c.Fields)
                                             {
                                                 bool hidden = f.HasCondition && f.ConditionActionType == FieldConditionActionType.Show;

                                                 <div class="@f.CssClass" @{
                                                                              if (hidden)
                                                                              {
                                                                                  <text> style="display: none"</text>
                                                                              }
                                                                          }>
                                              
                                                     @if (!f.HideLabel)
                                                     {
                                                         <label for="@f.Id" class="fieldLabel">@Html.Raw(f.Caption) @if (f.ShowIndicator)
                                                                                                                    {
                                                                                                                        <span class="contourIndicator">@Model.Indicator</span>
                                                                                                                    }</label>
                                                     }
                                                     @if (!string.IsNullOrEmpty(f.ToolTip))
                                                     {
                                                         <span class="help-block">@f.ToolTip</span>
                                                     }
                                                
                                                     <div>
                                                         @Html.Partial(FieldViewResolver.GetFieldView(Model.FormId.ToString(), f.FieldTypeName, f.Caption), f)
                                                         @if (Model.ShowFieldValidaton)
                                                         {
                                                             @Html.ValidationMessage(f.Id)
                                                         }
                                                     </div>
                                                 </div>

                                             }

                                         </div>

                                     }  
                                 </div>

                             </fieldset>
                         }

                         <div style="display: none">
                             <input type="text" name="@Model.FormId.ToString().Replace("-", "")" />
                         </div>


                         <div class="contourNavigation row-fluid">
                             <div class="col-md-12">
                                 @if (Model.IsMultiPage)
                                 {
                                     if (!Model.IsFirstPage)
                                     {
                                         <input class="btn prev cancel" type="submit" value="@Model.PreviousCaption" name="__prev"/>
                                     }
                                     if (!Model.IsLastPage)
                                     {
                                         <input type="submit" class="btn next" value="@Model.NextCaption" name="next"/>
                                     }
                                     if (Model.IsLastPage)
                                     {
                                         <input type="submit" class="btn primary" value="@Model.SubmitCaption" name="submit"/>
                                     }
                                 }
                                 else
                                 {
                                     <input type="submit" class="btn primary" value="@Model.SubmitCaption" name="submit"/>
                                 }
                             </div>
                         </div>

                     </div>
                 }
             </div>

        }

        if (Model.RenderMode == "full" || Model.RenderMode == "script")
        {
            @Html.Partial(FormViewResolver.GetScriptView(Model.FormId), Model)

            foreach (var script in Model.CurrentPage.JavascriptFiles)
            {
                if (Model.UseClientDependency)
                {
                    Html.RequiresJs(script.Value);
                }
                else
                {
                    <script type="text/javascript" src="@Url.Content(script.Value)"></script>
                }
            }

            if (Model.CurrentPage.JavascriptCommands.Count > 0)
            {

                <script type="text/javascript">
                    @foreach (var cmd in Model.CurrentPage.JavascriptCommands)
                    {
                        <text>@Html.Raw(cmd)</text>
                    }
        
                </script>
            }

            foreach (var css in Model.CurrentPage.CssFiles)
            {
                if (Model.UseClientDependency)
                {
                    Html.RequiresCss(css.Value);
                }
                else
                {
                    <link rel="stylesheet" href="@Url.Content(css.Value)" />
                }
            }

        }
    }

The view is seperated in 2 parts, 1 is the actual form and the other part is what will be shown if the form is submitted.

This view can be customized, if you do so it will be customized for all your forms.

###Script.cshtml
This view renders the JavaScript that will take care of the conditional logic, custimization won't be needed here...

###FieldType.*.cshtml
The rest of the views start with FieldType. like FieldType.Textfield.cshtml and those will output the fields (so there is a view for each default fieldtype like textfield, textarea, checkbox...

Contents of the  FieldType.Textfield.cshtml view:

	@model Umbraco.Forms.Mvc.Models.FieldViewModel
	<input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.Value" maxlength="500"
	@{if(Model.Mandatory || Model.Validate){<text>data-val="true"</text>}}
	@{if (Model.Mandatory) {<text> data-val-required="@Model.RequiredErrorMessage"</text>}}
	@{if (Model.Validate) {<text> data-val-regex="@Model.InvalidErrorMessage" data-regex="@Model.Regex"</text>}}
	/>

By default the form makes uses of jquery validate and jquery validate unobtrosive that's why you see attribute like data-val and data-val-required again this can be customized but it's important to keep the id of the control to @Model.Id since that is used to match the value to the form field.
