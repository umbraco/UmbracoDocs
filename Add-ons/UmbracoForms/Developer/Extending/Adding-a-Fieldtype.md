# Adding a field type to Umbraco Forms #

*This builds on the "[adding a type to the provider model](Adding-a-Type.md)" chapter*

Add a new class to the visual studio solution and make it inherit from Umbraco.Forms.Core.FieldType and override the Editor property.

In the empty constructor add the following information:

	public Textfield() {
		//Provider
		this.Id = new Guid("D6A2C406-CF89-11DE-B075-55B055D89593 ");
		this.Name = "Textfield";
		this.Description = "Renders a html input";
		this.Icon = "icon-autofill";
        this.DataType = FieldDataType.String;
		this.SortOrder = 10;
	}

In the constructor we specify the standard provider information (remember to set the ID to a unique ID).

And then we set the field type specific information. In this case a preview Icon for the form builder UI and what kind of data it will return, this can either be string, longstring, integer, datetime or boolean.

Then we will start building the view

    @model Umbraco.Forms.Mvc.Models.FieldViewModel
    <input type="text" name="@Model.Name" id="@Model.Id" class="text" value="@Model.Value" maxlength="500"
    @{if(Model.Mandatory || Model.Validate){<text>data-val="true"</text>}}
    @{if (Model.Mandatory) {<text> data-val-required="@Model.RequiredErrorMessage"</text>}}
    @{if (Model.Validate) {<text> data-val-regex="@Model.InvalidErrorMessage" data-regex="@Html.Raw(Model.Regex)"</text>}}

The view simply takes care of generating the UI control and setting its value. Views are found in the `Views\Partials\Forms\Fieldtypes\` directory.

On the view it is important to note that the id attribute is fetched from @Model.Id. You'll also see that we are using jquery validate unobtrusive to perform client side validation so that's why we are adding the data* attributes.
