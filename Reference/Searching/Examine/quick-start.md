# Quick start

**Applies to: Umbraco 4.11.5+**

_This guide will help you get setup quickly using Examine with minimal configuration options. Umbraco ships Examine with 2 internal indexes which should not be used for searching when returning results on a public website because it indexes content that has not been published yet. So to get started we need to create a new index._


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

In all of these examples we assume that the page that is being loaded has a query string in the Url called 'query', for example the URL might be: http://mysite.com/search?query=Hello which means we are searching for the term *Hello*

*NOTE*: Since this is a simple quick start tutorial, these examples will search against all published content in your Umbraco site. There are many different ways in which we can limit the search to only find content based on a certain criteria but that will be covered in more advanced tutorials.

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

### Web forms

We can use almost the same format as the above in our master pages if you are using webforms. However we're using the `ExamineManager` directly to do our search which returns an `ISearchResult`:

    <%if (!string.IsNullOrEmpty(Request.QueryString["query"])) { %>
        <ul>
            <%foreach (var result in Examine.ExamineManager.Instance.Search(Request.QueryString["query"], true)) { %>
                <li>
                    <a href="<%=umbraco.library.NiceUrl(result.Id) %>">
                        <%=result.Fields["nodeName"] %>
                    </a>
                </li>
            <%}%>
        </ul>
    <%}%>

### XSLT

Xslt requires a little bit of setup

1. Add the Examine xslt extensions to the xslt config in file ~/Config/XsltExtensions.config

		<ext assembly="UmbracoExamine" type="UmbracoExamine.XsltExtensions" alias="Examine" />

1. In your Xslt for your macro ensure to add the namespace:
	
		xmlns:Examine="urn:Examine"

1. And then ensure that you add "Examine" to the exclude-result-prefixes value, so the attribute might look something like:

		exclude-result-prefixes="Examine umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">

Now we can use the Examine xslt extensions in our xslt. This will render the exact same results as the above 3 examples:

  	<xsl:template match="/">
	    <xsl:if test="umbraco.library:Request('query') != ''">
	      <ul>
	        <xsl:for-each select="Examine:Search(umbraco.library:Request('query'))//node">
	          <li>
	            <a href="{umbraco.library:NiceUrl(@id)}">
	              <xsl:value-of select="./data[@alias='nodeName']"/>
	            </a>
	          </li>
	        </xsl:for-each>
	      </ul>
	    </xsl:if>
	  </xsl:template>






