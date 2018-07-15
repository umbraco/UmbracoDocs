---
keywords: textarea property editors v7.4 version7.4
versionFrom: 7.4.0
versionTo: 7.5.14
---

# Textarea

`Alias: Umbraco.TextboxMultiple`

`Returns: String`

Textarea is a simple HTML textarea control for multiple lines of text.

## Data Type Definition Example

![Textarea Data Type Definition](images/textarea/7/textarea-setup.png)


## Settings

## Content Example:

![Textarea Content Example](images/textarea/7/textarea-content.png)


## MVC View Example:

	@{
	   if (Model.Content.HasValue("description")){
	       <p>@(Model.Content.GetPropertyValue<string>("description"))</p>
	   }
	}
