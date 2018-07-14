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
	   if (Model.Content.HasValue("textarea")){
	       <p>@(Model.Content.Textarea</p>
	   }
	}
