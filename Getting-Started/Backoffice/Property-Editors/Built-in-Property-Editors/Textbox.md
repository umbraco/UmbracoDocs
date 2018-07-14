---
keywords: textbox property editors v7.6 version7.6
versionFrom: 7.6.0
---

# Textbox

`Returns: String`

Textbox is a simple HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 500 unless it's specifically changed to a lower amount.

## Data Type Definition Example

### Without a character limit

![Textbox Data Type Definition](images/textbox/7.6/textbox-setup.png)

### With a character limit

![Textbox Data Type Definition With a Character Limit](images/textbox/7.6/textbox-setup-limit.png)

## Settings

## Content Example:

### Without a character limit

![Textbox Content Example](images/textbox/7.6/textbox-content.png)

### With a character limit

![Textbox Content Example Without a Character Limit](images/textbox/7.6/textbox-content-limit.png)

## MVC View Example:

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
