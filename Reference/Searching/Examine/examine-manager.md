# Examine Manager
_The Examine.ExamineManager is a singleton object which exposes all of the index and search providers which are registered in the configuration of the application. As with all singletons in Umbraco, we recommend reviewing the [Common Pitfalls & Anti-Patterns](../../Common-Pitfalls/index.md) page to ensure the correct usage._

Accessing the singleton can be done easily like:

	ExamineManager.Instance

This returns an active instance of the ExamineManager which exposes operations such as:

* Default index & search providers
* Full collection of index & search providers
* All indexing and searching methods
	
## Searching

Important to note that the `Search` methods on the ExamineManager will call the Search methods of the **default** search provider specified in config. If you want to search using a specified provider, you can retrieve it from the `SearchProviderCollection` (see example below).

You can access any of the searchers by their name, for example:

	var externalSearcher = ExamineManager.Instance.SearchProviderCollection["ExternalSearcher"];

For simple searching the method to use is:
	
	ISearchResults Search(string searchText, bool useWildcards);

An example using this method is below:

    using Examine.LuceneEngine.SearchCriteria;

	var query = Request.QueryString["query"];

    var searcher = Examine.ExamineManager.Instance.SearchProviderCollection["ExternalSearcher"];
    
    // the boolean parameter is whether to use wildcards when searching.
    var searchResults = searcher.Search(query, true).OrderByDescending("createDate");
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

To create custom search criteria for advanced searching for use with the Fluent API there are 4 methods available:

	ISearchCriteria CreateSearchCriteria();
	ISearchCriteria CreateSearchCriteria(BooleanOperation defaultOperation);
	ISearchCriteria CreateSearchCriteria(string type);
	ISearchCriteria CreateSearchCriteria(string type, BooleanOperation defaultOperation);

Once you've customized the criteria with the Fluent API you can pass that criteria in to this method to get results:

	ISearchResults Search(ISearchCriteria searchParameters);

## Indexing

When calling the index methods on the `ExamineManager` it will call the same methods on every Indexer that is registered. If for some reason you require to only call the index methods on a particular provider then you can access the provider by name, for example:

	var externalIndexer = ExamineManager.Instance.IndexProviderCollection["ExternalIndexer"];

The indexing methods available are:

	void DeleteFromIndex(string nodeId);
	void DeleteFromIndex(string nodeId, IEnumerable<BaseIndexProvider> providers);
	void IndexAll(string type);
	bool IndexExists();
	void RebuildIndex();
	void ReIndexNode(XElement node, string type);
	void ReIndexNode(XElement node, string type, IEnumerable<BaseIndexProvider> providers);