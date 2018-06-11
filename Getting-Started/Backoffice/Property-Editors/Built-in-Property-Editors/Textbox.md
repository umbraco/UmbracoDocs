# Textbox

`Returns: String`

Textbox is a simple HTML input control for text

## Data Type Definition Example

![Textbox Data Type Definition](images/Textbox-DataType.png)

## Settings

## Content Example 

![Textbox Content Example](images/Textbox-Content.png)

## MVC View Example

	@{
	   if (Model.Content.HasValue("pageTitle")){
	       <p>@(Model.Content.GetPropertyValue<string>("pageTitle"))</p>
	   } 
	}


### Dynamic (Obsolete)
The below example is using Dynamic access content access, which is considered obsolete and is not recommended to use. However the example is included for historical reasons if for instance a developer has overtaken a project where this approach is being used. This approach will be obsolete when Umbraco 8 is released and therefore is best to use the strongly typed example listed above.
	
	@{       	
	   if (CurrentPage.HasValue("pageTitle")){	
	       <p>@CurrentPage.pageTitle</p>	
	   } 	       	
	}
