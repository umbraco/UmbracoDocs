#DateTime

`Returns: DateTime`

Displays a calendar UI for selecting dates, the value saved is a standard datetime value.

##Data Type Definition Example

![Data Type Definition Example](images/DateTime-DataType.png)

##Content Example 

![Content Example](images/Date-Time-Content.png)

##MVC View Example - displays a datetime

###Typed:

	@(Model.Content.GetPropertyValue<DateTime>("datePicker").ToString("dd MM yyyy"))

###Dynamic: 

	@{
		@CurrentPage.datePicker.ToString("dd-MM-yyyy")
	}