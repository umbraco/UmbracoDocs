#Dropdown List

`Returns: String`

Displays a list of preset values. The value saved is a text value.

##Settings

###Prevalues
You can add, edit & delete the data prevalues rendered within the dropdown list.

##Data Type Definition Example

![Dropdown List Data Type Definition](images/Dropdown-List-DataType.png)

##Content Example 

![Downdown List Content](images/Dropdown-List-Content.png)

##MVC View Example to output selected value

###Typed:

    @if (Model.Content.HasValue("superHero"))
    {
        <p>@Model.Content.GetPropertyValue("superHero")</p>
    }

###Dynamic:     
                         
    @if (CurrentPage.HasValue("superHero"))
    {
        <p>@CurrentPage.superHero</p>
    }    

##MVC View Example list all nodes which have a certain item selected in the dropdown list

###Typed:

    @{
        var valueToMatch = "SuperMan";
        //Get the first node inside the root
        var firstTypedContentAtRoot = Umbraco.TypedContentAtRoot().FirstOrDefault();
        if (firstTypedContentAtRoot != null)
        {
            var articles = firstTypedContentAtRoot.Children.Where(x => x.HasValue("superHero") && x.GetPropertyValue<string>("superHero").ToLower().Contains(valueToMatch.ToLower()));
            if (articles.Any())
            {
                <p>Pages with @valueToMatch selected:</p>
                <ul>
                    @foreach (var page in articles)
                    {
                        <li><a href="@page.Url"> @page.Name</a></li>
                    }
                </ul>
            }
        }
    }

###Dynamic:                             

    @{
		var valueToMatch = "SuperMan";
        //Get the first node inside the root
        var firstContentAtRoot = Umbraco.ContentAtRoot().FirstOrDefault();
        if (firstContentAtRoot != null)
        {
            var articles = firstContentAtRoot.Children.Where("superHero.ToLower() == @0", valueToMatch.ToLower());
            if (articles.Any())
            {
                <p>Pages with @valueToMatch selected:</p>
                <ul>
                    @foreach (var page in articles)
                    {
                        <li><a href="@page.Url"> @page.Name</a></li>
                    }                      
                </ul>
            }
        }
    }

