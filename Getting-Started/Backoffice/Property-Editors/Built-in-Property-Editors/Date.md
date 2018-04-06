# DateTime

`Returns: DateTime`

Displays a calendar UI for selecting dates which are saved as a DateTime value.

## Data Type Definition Example

![Data Type Definition Example](images/DateTime-DataType.png)

The only setting that is available for manipulating the Date property is to set a format. By default the format of the output will be `YYYY-MM-DD`, but you can easily changes this to something else ( see [MomentJS.com](http://momentjs.com/) for the supported formats ).

## Content Example 

![Content Example](images/Date-Time-Content.png)

## MVC View Example - displays a datetime

### Typed:

	@(Model.Content.GetPropertyValue<DateTime>("datePicker").ToString("dd MM yyyy"))

### Dynamic: 

	@{
		@CurrentPage.datePicker.ToString("dd-MM-yyyy")
	}
