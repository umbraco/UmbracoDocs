---
keywords: textbox property editors v7.6 version7.6
versionFrom: 7.6.0
---

# Textarea

`Alias: Umbraco.TextboxMultiple`

`Returns: String`

Textarea is a simple HTML textarea control for multiple lines of text. It can be configured to have a fixed character limit. By default there is no character limit unless it's specifically set to a specific value like 200 for instance.

## Data Type Definition Example

### Without a character limit

![Textarea Data Type Definition](images/textarea/7_6/textarea-setup.png)

### With a character limit

![Textarea Data Type Definition With a Character Limit](images/textarea/7_6/textarea-setup-limit.png)

## Settings

## Content Example:

### Without a character limit

![Textarea Content Example](images/textarea/7_6/textarea-content.png)

### With a character limit

![Textbox Content Example Without a Character Limit](images/textarea/7_6/textarea-content-limit.png)


## MVC View Example:

	@{
	   if (Model.Content.HasValue("description")){
	       <p>@(Model.Content.GetPropertyValue<string>("description"))</p>
	   }
	}
