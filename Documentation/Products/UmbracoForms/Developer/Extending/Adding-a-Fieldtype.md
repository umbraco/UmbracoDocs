# Adding a field type to Umbraco Forms #

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

To add a custom field type create a new class in your Visual Studio solution. Your class will need `using Umbraco.Forms.Core;` in the Using directives at the top and to inherit from `Umbraco.Forms.Core.FieldType`.

As an example, to create a new field type called CustomFormDataType, your class should contain the following information in it's constructor:

    public class CustomFormDataType : Umbraco.Forms.Core.FieldType
    	{
    		public CustomFormDataType()
    		{
    			// Provider
    			this.Id = new Guid("73c7e88f-5916-49de-b223-27f63bd57381"); // set a unique GUID here
    			this.Name = "CustomFormDataType";
    			this.Description = "Renders an html input";
    			this.Icon = "icon-autofill";
    			this.DataType = FieldDataType.String;
    			this.SortOrder = 10;
    		}
    	}


In this example a preview icon (autofill) is set for the form builder UI and the DataType is set so that the field will return a String (this can either be string, longstring, integer, datetime or boolean).

A back office field type angular view is also required in `App_Plugins\UmbracoForms\Common\FieldTypes\CustomFormDataType.html`. e.g. to create this use the standard textfield control as a starting point.

    <input type="text" tabindex="-1"
       class="input-block-level"
       style="max-width: 400px" />

Then add a view to the `Views\Partials\Forms\Fieldtypes\` directory which is used to render a control to web visitors.

    @model Umbraco.Forms.Mvc.Models.FieldViewModel
    <input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.Value" maxlength="500"
    @{if(Model.Mandatory || Model.Validate){<text>data-val="true"</text>}}
    @{if (Model.Mandatory) {<text> data-val-required="@Model.RequiredErrorMessage"</text>}}
    @{if (Model.Validate) {<text> data-val-regex="@Model.InvalidErrorMessage" data-regex="@Html.Raw(Model.Regex)"</text>}}

The view takes care of generating the UI control and setting its initial values.

On the view it is important to note that the id attribute is fetched from @Model.Id. You'll also see that we are using jQuery validate unobtrusive to perform client side validation so that's why we are adding the data* attributes.
