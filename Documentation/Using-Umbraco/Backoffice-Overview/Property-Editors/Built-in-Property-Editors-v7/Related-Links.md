#Related Links

`Returns: JArray`

Related Links allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.

##Data Type Definition Example

![Related Links Data Type Definition](images/Related-Links-DataType.jpg)

##Content Example 

![Media Picker Content](images/Related-Links-Content.jpg)

##MVC View Example

###Typed:

	@using Newtonsoft.Json.Linq
	@{
	    if (Model.Content.HasValue("relatedLinks"))
	    {
	        <ul>
	            @foreach (var item in Model.Content.GetPropertyValue<JArray>("relatedLinks"))
	            {
	                var linkUrl = (item.Value<bool>("isInternal")) ? Umbraco.NiceUrl(item.Value<int>("link")) : item.Value<string>("link");
	                var linkTarget = item.Value<bool>("newWindow") ? " target=\"_blank\"" : string.Empty;
	                <li><a href="@linkUrl" @Html.Raw(linkTarget)>@(item.Value<string>("caption"))</a></li>
	            }
	        </ul>
	    }           
	}   

###Dynamic:       
                       
	@{
	    if (CurrentPage.HasValue("relatedLinks"))
	    {
	        <ul>
	            @foreach (var item in CurrentPage.relatedLinks)
	            {
	                var linkUrl = (bool)item.isInternal ? Umbraco.NiceUrl((int)item.link) : item.link;
	                var linkTarget = (bool)item.newWindow ? " target=\"_blank\"" : string.Empty;
	                <li><a href="@linkUrl" @Html.Raw(linkTarget)>@item.caption</a></li>
	            }
	        </ul>
	    }        
	}    