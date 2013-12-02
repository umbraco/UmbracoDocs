#Multinode Treepicker

`Returns: ID or CSV`

##Settings


##Data Type Definition Example

![Multinode Treepicker Data Type Definition](images/Multinode-Treepicker-DataType.jpg)

##Content Example 

![Multinode Treepicker](images/Multinode-Treepicker-Content.jpg)

##MVC View Example

###Typed:

	@{
	    if (Model.Content.HasValue("banner"))
	    {
	        var bannerListValue = Model.Content.GetPropertyValue<string>("banner");
	        var bannerList = bannerListValue.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(int.Parse);
	        var bannerCollection = Umbraco.TypedContent(bannerList).Where(x => x != null);
	        foreach (var item in bannerCollection)
	        {
	            <p>@item.Name</p>
	        }
	    }
	}

###Dynamic:                              

	@{
	    var bannerList = CurrentPage.banner.ToString().Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
	    var bannerCollection = Umbraco.Content(bannerList);
	    foreach (var item in bannerCollection)
	    {
	        <p>@item.Name</p>
	    }
	}