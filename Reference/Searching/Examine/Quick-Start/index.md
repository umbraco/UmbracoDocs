---
versionFrom: 8.0.0
---

# Quick start

_This guide will help you get setup quickly using Examine with minimal configuration options. Umbraco ships Examine with 3 internal indexes which should not be used for searching when returning results on a public website because it indexes content that has not been published yet. It also ships with an external index that you can use to get up and running._

## Performing a simple search

:::note
In the coming examples the Umbraco Starter Kit has been used, this is because it gives some content to be searched upon quickly. Some of the examples may require setting up templates, etc if you are following on your own site.
:::

The starter kit comes with some templates and doc types and content nodes set up already, so let's just use some of those to set up a simple search system.

Let's make it possible to search on the /people page.

We do this by adding a search bar on the template page, so in the people.cshtml template we can add this at the top:

```csharp
...
</nav>
-->

<div>
    <form action="@Model.Url" method="get">
        <input type="text" placeholder="Search" id="query" name="query" />
        <button>Search</button>
    </form>
</div>  

<div class="employee-grid">
...
```

This will make a simple input field at the top of the page and make it redirect to the same page when submitted. Now let's set up the search query using Examine.

Below the form from before you can add this:

```csharp
<div>
    @{
        var searchTerm = string.Empty;

        searchTerm = string.IsNullOrEmpty(Request["query"]) 
            ? string.Empty 
            : Request["query"];

        if (searchTerm == string.Empty)
        {
            <p>Enter search term</p>
        }
        else
        {
            //perform the search
        }
    }
</div>
```

Here we are getting the request query from the form, and if the string is empty we ask them to submit a term, otherwise we will search.

To perform the search we will first need to get the index and the searcher, so within the else condition add this:

```csharp
else
{
    //perform the search
    //first we try to get the index, it is the ExternalIndex as we don't want to return unpublished things
    //it returns the index in the var index
    if(ExamineManager.Instance.TryGetIndex("ExternalIndex", out var index))
    {
        var searcher = index.GetSearcher();
        var results = searcher.CreateQuery("content").NodeTypeAlias("person").And().Field("nodeName", searchTerm).Execute();

        if (results.Any())
        {
            <ul>
                @foreach (var result in results)
                {
                    if (result.Id != null)
                    {
                        var node = Umbraco.Content(result.Id);
                        <li>
                            <a href="@node.Url">@node.Name</a>
                        </li>
                    }
                }
            </ul>
        }
        else
        {
            <p>No results found for query @searchTerm</p>
        }
    }

    return;
}
```