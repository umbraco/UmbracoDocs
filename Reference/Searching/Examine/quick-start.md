# Quick start

_This guide will help you get setup quickly using Examine with minimal configuration options. Umbraco ships Examine with 2 internal indexes which should not be used for searching when returning results on a public website because it indexes content that has not been published yet. It also ships with an external index that you can use to get up and running._

## Create an index

To create a searchable index we need to create 3 components: an **Indexer** a **Searcher** and an **Index Set**. Umbraco 7 ships with these three components ready to go, but you can use the below as a reference as you walk through your implementation.

1. Open ~/Config/ExamineSettings.config and add an *indexer* under the 'ExamineIndexProviders/providers' section (in this example it is named *ExternalIndexer*):

		<add name="ExternalIndexer" type="UmbracoExamine.UmbracoContentIndexer, UmbracoExamine"/>

1. In the same file (~/Config/ExamineSettings.config) add a *searcher* under the 'ExamineSearchProviders/providers' section (in this example it is named *ExternalSearcher*):

		<add name="ExternalSearcher" type="UmbracoExamine.UmbracoExamineSearcher, UmbracoExamine" />

1. In the same file we'll change the default search provider to the one we've created, set defaultProvider="**ExternalSearcher**"

1. Open ~/Config/ExamineIndex.config and add an *index set* (in this example it is named *ExternalIndexSet*):

		<IndexSet SetName="ExternalIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/External/" />

That's it, now we have a searchable index configured using Examine. Examine will detect that the index doesn't exist on the file system yet so the index will be rebuilt during application startup. Once that happens the index will automatically stay up to date with the data in Umbraco.

*NOTE*: If you intend to load-balance your website, you will need to update your Examine configuration. Further details on how this can be achieved can be found [here](../../../Getting-Started/Setup/Server-Setup/Load-Balancing/index.md), with guides for both traditional and flexible load balancing available.

### Naming conventions

It is important to note the naming conventions above. Your Indexer, Searcher and associated Index Set must all be named according to convention so that they match. With the above examples the naming conventions are:

**External**Indexer <br/>
**External**Searcher <br/>
**External**IndexSet <br/>

Notice that the prefix is all the same, this is a requirement. The suffixes must also match so that the *indexer* name is suffixed with **Indexer**, the *searcher* is suffixed with **Searcher** and the *index set* is suffixed with **IndexSet**.

## Searching

In all of these examples we assume that the page that is being loaded has a query string in the Url called 'query', for example the URL might be: https://mysite.com/search?query=Hello which means we are searching for the term *Hello*

*NOTE*: Since this is a simple quick start tutorial, these examples will search against all published content in your Umbraco site. There are many different ways in which we can limit the search to only find content based on a certain criteria.

### MVC

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

### ExamineManager

To complete more complex searches, we can use the ExamineManager and our custom search provider to expose further functionality, such as being able to handle misspellings, for example. There is an example using this available on the [ExamineManager](examine-manager.md) page.

### Fluent API

Examine offers a fluent search API which aims to make constructing complex searches simple. The underlying API is determined by the provider implementation, with Examine just exposing the appropriate methods. With the fluent API, we can introduce fuzzy-text search and boosting, which allows us to favour a search result if our search term is found in particular fields, including custom fields added to document types. 

    using Examine.LuceneEngine.SearchCriteria;
    
    var query = Request.QueryString["query"];
    var searcher = Examine.ExamineManager.Instance.SearchProviderCollection["ExternalSearcher"];

    var searchCriteria = searcher.CreateSearchCriteria(Examine.SearchCriteria.BooleanOperation.Or);
    var searchQuery = searchCriteria.Field("nodeName", query.Boost(5)).Or().Field("nodeName", query.Fuzzy()).And().OrderByDescending("createDate");
    var searchResults = searcher.Search(searchQuery.Compile());
    if(searchResults.Any())
    {
        <ul>
            @foreach (var result in searchResults)
            {
                <li>
                    <a href="@result.Url">@result.Name</a>
                </li>
            }
        </ul>
    }

### XSLT

The XSLT implementation of Examine has a few specific steps that you'll need to follow. They can be found as part of an [XSLT Example](xslt-example.md).

## Recommended resources
For more detailed examples of implementing search with Examine, the following resources can be extremely helpful

- [Examining Examine](overview-explanation.md) by Peter Gregory.
- [The worlds friendliest post on getting started with Examine](https://24days.in/umbraco-cms/2013/getting-started-with-examine/) (24 Days in Umbraco)
