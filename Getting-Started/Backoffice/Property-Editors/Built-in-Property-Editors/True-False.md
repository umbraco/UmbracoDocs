# True/False

`Returns: Boolean`

True/False is a simple checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

## Data Type Definition Example

![True/False Data Type Definition](images/True-False-DataType-742.jpg)

The True/False property has a setting which allows you to set the default value of the checkbox, either checked (true) or unchecked (false). This property was added in Umbraco 7.4.2.

## Content Example 

![No Edit Content Example](images/True-False-Content.png)

## MVC View Example - displays a list of links to child pages that are not hidden

### Typed:

	@{
		foreach (IPublishedContent page in Model.Content.Children){
            if (!page.GetPropertyValue<bool>("umbracoNaviHide"))
            {
				<p>@page.Name</p>
			}
		}	
	}

### Dynamic (Obsolete):

See [Common pitfalls](https://our.umbraco.com/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.

	@{
		foreach (var page in CurrentPage.Children){
			if (!page.umbracoNaviHide){
				<p>@page.Name</p>
			}
		}	
	}
