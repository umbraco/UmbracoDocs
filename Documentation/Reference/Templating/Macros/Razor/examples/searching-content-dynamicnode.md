#Searching for content using DescendantsOrSelf()
<!-- original author Jonas Eriksson -->
Here's my search test using DescendantsOrSelf()

    @{
      Dictionary<string,object> values = new Dictionary<string,object>();
      values.Add("searchString", "Searching for");
      var foundNodes = Model.AncestorOrSelf().DescendantsOrSelf().Where("bodyText.ToLower().Contains(searchString) || header.ToLower().Contains(searchString)",values);
     }

    <h1>Search results</h1>
    <ul>
    @foreach (dynamic c in foundNodes)
    {
       <li><a href="@c.Url">@c.Name</a></li>
    }
    </ul>

It's a bit slower than the other techniques I tried (1.1 secs over 2000 nodes - and another .15 sec for each added property to search in). Using DescendantsOrSelf on a reasonable number of nodes (<100) is still very quick. But for full tree searches [Examine](searching-content-examine.md) or XPath would be the way to advice.