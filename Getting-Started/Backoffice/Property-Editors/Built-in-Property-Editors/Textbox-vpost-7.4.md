---
keywords: textbox property editors v7.4 version7.4
versionFrom: 7.4.0
versionTo: 7.5.14
---

# Textbox

`Alias: Umbraco.Textbox`

`Returns: String`

Textbox is a simple HTML input control for text.

## Data Type Definition Example

![Textbox Data Type Definition](images/textbox/7/Textbox-DataType.png)

## Settings

## Content Example:

![Textbox Content Example](images/textbox/7/Textbox-Content.png)

## MVC View Example:

	@{
	   if (Model.Content.HasValue("pageTitle")){
	       <p>@(Model.Content.GetPropertyValue<string>("pageTitle"))</p>
	   }
	}


### Dynamic (Obsolete):

See [Common pitfalls](../../../../../reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.

	@{
	   if (CurrentPage.HasValue("pageTitle")){
	       <p>@CurrentPage.pageTitle</p>
	   }
	}
