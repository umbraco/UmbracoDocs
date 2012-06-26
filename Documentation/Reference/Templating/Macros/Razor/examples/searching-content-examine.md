#Searching for content (using Examine)
<!-- Original author Jonas Eriksson -->
Ref [www.farmcode.org/.../...rful-Umbraco-Indexing.aspx](http://www.farmcode.org/post/2009/04/20/Umbraco-Examine-v4x-Powerful-Umbraco-Indexing.aspx#BasicSearch)

    @using Examine
    @using Examine.SearchCriteria
    @using UmbracoExamine
    
    @{    
      var searchString = "Find this";
      var searchProvider = ExamineManager.Instance.DefaultSearchProvider.Name;
      var searchResults = ExamineManager.Instance.SearchProviderCollection[searchProvider].Search(searchString, true);
    }
    <ul>
    @foreach (var c in searchResults)
    {
       <li><a href="@umbraco.library.NiceUrl(c.Id)">@c.Fields["nodeName"]</a></li>
    }
    </ul>


I did a simple performance test (with ?umbdebugshowtrace=1 time for "Loading IMacroEngine script [done]") on a site with just below 2000 nodes (average over 5 tries) :

Examine: 0.02 seconds

uQL + XPath: 0.08 seconds

uQuery + XPath: 0.11 seconds

uQuery + Nodefactory: 0.4 seconds