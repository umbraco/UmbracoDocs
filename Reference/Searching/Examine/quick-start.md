# Quick start

**Applies to: Umbraco 7+**

[TODO: check what indexes are provided out of the box] _This guide will help you get setup quickly using Examine with minimal configuration options. Umbraco ships Examine with 2 internal indexes which should not be used for searching when returning results on a public website because it indexes content that has not been published yet. So to get started we need to create a new index._

## Create an index

To create a searchable index we need to create 3 things: an **Indexer** a **Searcher** and an **Index Set**.

1. Open ~/Config/ExamineSettings.config and add an *indexer* under the 'ExamineIndexProviders/providers' section (in this example it is named *ExternalIndexer*):

		<add name="ExternalIndexer" type="UmbracoExamine.UmbracoContentIndexer, UmbracoExamine"/>

1. In the same file (~/Config/ExamineSettings.config) add a *searcher* under the 'ExamineSearchProviders/providers' section (in this example it is named *ExternalSearcher*):

		<add name="ExternalSearcher" type="UmbracoExamine.UmbracoExamineSearcher, UmbracoExamine" />

1. In the same file we'll change the default search provider to the one we've created, set defaultProvider="**ExternalSearcher**"

1. Open ~/Config/ExamineIndex.config and add an *index set* (in this example it is named *ExternalIndexSet*):

		<IndexSet SetName="ExternalIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/External/" />

Thats it, now we have a searchable index configured using Examine. Examine will detect that the index doesn't exist on the file system yet so the index will be rebuilt during application startup. Once that happens the index will automatically stay up to date with the data in Umbraco.

### Naming conventions

It is important to note the naming conventions above. Your Indexer, Searcher and associated Index Set must all be named according to convention so that they match. With the above examples the naming conventions are:

**External**Indexer <br/>
**External**Searcher <br/>
**External**IndexSet <br/>

Notice that the prefix is all the same, this is a requirement. The suffixes must also match so that the *indexer* name is suffixed with **Indexer**, the *searcher* is suffixed with **Searcher** and the *index set* is suffixed with **IndexSet**.

## Searching

In all of these examples we assume that the page that is being loaded has a query string in the Url called 'query', for example the URL might be: https://mysite.com/search?query=Hello which means we are searching for the term *Hello*

*NOTE*: Since this is a simple quick start tutorial, these examples will search against all published content in your Umbraco site. There are many different ways in which we can limit the search to only find content based on a certain criteria.

For more detailed examples of implementing search with Examine, you can read [Examining Examine](overview-explanation.md) by Peter Gregory.

### MVC

[TODO: check these methods still apply for both MVC and Razor]
In MVC we have a method called `TypedSearch` on the `UmbracoHelper` which will return a list of `IPublishedContent` objects.

    @if (!string.IsNullOrEmpty(Request.QueryString["query"]))    
    {
        <ul>
            @foreach (var result in Umbraco.TypedSearch(Request.QueryString["query"]))
            {
                <li>
                    <a href="@result.Url">@result.Name</a>
                </li>
            }
        </ul>
    }   

### Razor

In razor macros there's a `Search` method on the `DynamicNode` model which will return a `DynamicNodeList`:

    @if (!string.IsNullOrEmpty(Request.QueryString["query"]))    
    {
        <ul>
            @foreach (var result in Model.Search(Request.QueryString["query"]))
            {
                <li>
                    <a href="@result.Url">@result.Name</a>
                </li>
            }
        </ul>
    }