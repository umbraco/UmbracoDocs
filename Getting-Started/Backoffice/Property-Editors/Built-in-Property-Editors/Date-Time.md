# DateTime

`Returns: DateTime`

Displays a calendar UI for selecting dates and time which is saved as a DateTime value.

## Data Type Definition Example

![Data Type Definition Example](images/Date-Time-With-Time-Data-Type.png)

The only setting that is available for manipulating the DateTime property is to set a format. By default the format of the output will be `YYYY-MM-DD HH:mm:ss`, but you can easily changes this to something else ( see [MomentJS.com](http://momentjs.com/) for the supported formats ).

## Content Example 

![Content Example](images/Date-Time-With-Time-Content.png)

## MVC View Example - displays a datetime with time 

### Typed:

	@(Model.Content.GetPropertyValue<DateTime>("datePicker").ToString("dd MM yyyy HH:mm:ss"))

### Dynamic: 

	@{
		@CurrentPage.datePicker.ToString("dd-MM-yyyy HH:mm:ss")
	}
