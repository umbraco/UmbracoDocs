# Adding a field type to Umbraco Forms #

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

Add a new class to the Visual Studio solution with a using directive using `using Umbraco.Forms.Core;` and make it inherit from Umbraco.Forms.Core.FieldType with an override of the Editor property.

An example CustomFormDataType new data type should contain the following information in it's constructor (remember to set the Id to be a unique GUID):

    public class CustomFormDataType : Umbraco.Forms.Core.FieldType
    	{
    		public CustomFormDataType()
    		{
    			// Provider
    			this.Id = new Guid("73c7e88f-5916-49de-b223-27f63bd57381");
    			this.Name = "CustomFormDataType";
    			this.Description = "Renders an html input";
    			this.Icon = "icon-autofill";
    			this.DataType = FieldDataType.String;
    			this.SortOrder = 10;
    		}
    	}


And then we set the field type specific information. In this case a preview icon (autofill) for the form builder UI and what kind of data it will return, this can either be string, longstring, integer, datetime or boolean.

Add a back office field type angular view in `App_Plugins\UmbracoForms\Common\FieldTypes\CustomFormDataType.html`. e.g. copying the standard textfield control.

    <input type="text" tabindex="-1"
       class="input-block-level"
       style="max-width: 400px" />

Then add the view to the `Views\Partials\Forms\Fieldtypes\` directory which is used to render a control to web visitors.

    @model Umbraco.Forms.Mvc.Models.FieldViewModel
    <input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.Value" maxlength="500"
    @{if(Model.Mandatory || Model.Validate){<text>data-val="true"</text>}}
    @{if (Model.Mandatory) {<text> data-val-required="@Model.RequiredErrorMessage"</text>}}
    @{if (Model.Validate) {<text> data-val-regex="@Model.InvalidErrorMessage" data-regex="@Html.Raw(Model.Regex)"</text>}}

The view takes care of generating the UI control and setting its initial values.

On the view it is important to note that the id attribute is fetched from @Model.Id. You'll also see that we are using jQuery validate unobtrusive to perform client side validation so that's why we are adding the data* attributes.
