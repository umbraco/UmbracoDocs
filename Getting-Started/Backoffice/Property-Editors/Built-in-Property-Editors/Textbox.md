# Textbox

`Returns: String`

Textbox is a simple HTML input control for text

## Data Type Definition Example

![Textbox Data Type Definition](images/Textbox-DataType.png)

## Settings

## Content Example 

![Textbox Content Example](images/Textbox-Content.png)

## MVC View Example

### Typed:

	@{
	   if (Model.Content.HasValue("pageTitle")){
	       <p>@(Model.Content.GetPropertyValue<string>("pageTitle"))</p>
	   } 
	}

### Dynamic (Obsolete):

See [Common pitfalls](https://our.umbraco.org/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.

	@{       
	   if (CurrentPage.HasValue("pageTitle")){
	       <p>@CurrentPage.pageTitle</p>
	   } 	       
	}
