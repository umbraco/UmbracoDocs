#Searching for content (using uQuery and XPath)
Search sample using XPath (old schema):

    @using uComponents.Core
    @using uComponents.Core.uQueryExtensions
    @{
      var searchString = "Find this";
      var searchResult = uQuery.GetNodesByXPath("//*[@nodeName='" + searchString + "' or contains(data[@alias='bodyText'],'" +  searchString + "') or contains(data[@alias='introduction'],'" +  searchString + "')]");
     }
    <h1>Search results</h1>
    <ul>
    @foreach(var c in searchResult)
    {
        <li><a href="@c.Url">@c.Name</a></li>
    }
    </ul>

Performance test:

Site 1, just below 2000 nodes, 0.11 seconds.