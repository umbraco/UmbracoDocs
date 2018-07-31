# Repeatable textstrings

`Alias: Umbraco.MultipleTextstring`

`Returns: array of strings`

The Repeatable textstrings property editor enables a content editor to make a list of text items. For best use with an unordered-list.

## Data Type Definition Example

![Repeatable textstrings Data Type Definition](images/Repeatable-Textstrings-DataType.png)

## Content Example 

![Repeatable textstrings Content](images/Repeatable-Textstrings-Content.png)

## MVC View Example

### Typed:
	
    @{
        if (Model.Content.GetPropertyValue<string[]>("keyFeatureList").Length > 0)
        {
            <ul>
                @foreach (var item in Model.Content.GetPropertyValue<string[]>("keyFeatureList"))
                {
                    <li>@item</li>
                }
            </ul>
        }
    }

### Dynamic (Obsolete):

See [Common pitfalls](https://our.umbraco.com/documentation/reference/Common-Pitfalls/#dynamics) for more information about why the dynamic approach is obsolete.

    @{
        if (CurrentPage.keyFeatureList.Length > 0)
        {
            <ul>
                @foreach (var item in CurrentPage.keyFeatureList)
                {
                    <li>@item</li>
                }
            </ul>
        }
    }
