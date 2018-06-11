# DateTime

`Returns: DateTime`

Displays a calendar UI for selecting dates and time which is saved as a DateTime value.

## Data Type Definition Example

![Data Type Definition Example](images/Date-Time-With-Time-Data-Type.png)

The only setting that is available for manipulating the DateTime property is to set a format. By default the format shown in the backoffice will be `YYYY-MM-DD HH:mm:ss`.  But you can easily change this to something else. See [MomentJS.com](http://momentjs.com/) for the supported formats.

## Content Example 

![Content Example](images/Date-Time-With-Time-Content.png)

## MVC View Example - displays a datetime with time 

### Typed:

	@(Model.Content.GetPropertyValue<DateTime>("datePicker").ToString("dd MM yyyy HH:mm:ss"))

### Dynamic (Obsolete):

The below example is using Dynamic access content access, which is considered obsolete and is not recommended to use. However the example is included for historical reasons if for instance a developer has overtaken a project where this approach is being used. This approach will be obsolete when Umbraco 8 is released and therefore is best to use the strongly typed example listed above.

	@{
		@CurrentPage.datePicker.ToString("dd-MM-yyyy HH:mm:ss")
	}
