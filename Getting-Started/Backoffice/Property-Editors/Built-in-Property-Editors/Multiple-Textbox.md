#Repeatable textstrings

`Returns: array of strings`

The Repeatable textstrings property editor enables a content editor to make a list of text items. For best use with an unordered-list.

##Data Type Definition Example

![Repeatable textstringsData Type Definition](images/wip.png)

##Content Example 

![Repeatable textstrings Content](images/wip.png)

##MVC View Example

###Typed:
	
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

###Dynamic:                              

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
