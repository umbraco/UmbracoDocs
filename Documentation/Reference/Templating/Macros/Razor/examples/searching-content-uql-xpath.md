#Searching for content (using uQl and XPath)

And the search sample with uQL - which is using compiled XPath and named parameters :

    @using umbraco.UQL
    @{
      var searchParam = new umbraco.UQL.Query.Parameter("searchString","Find this");
      var searchResult = QueryableNode.Query("//*[@isDoc and @nodeName=$searchString or contains(bodyText,$searchString) or contains(introduction,$searchString)]",searchParam);
     }
    <h1>Search results</h1>

    <ul>
    @foreach(var c in searchResult)
    {
      <li><a href="@c.ToUrl()">@c.Name</a></li>
    }
    </ul>

Performance:
Site 1, just below 2000 nodes : 0.08 s