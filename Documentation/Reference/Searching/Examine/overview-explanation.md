# Overview & Explanation - "Examining Examine by Peter Gregory"

<small>Originally published on the Umbraco blog - [Examining Examine: Friday, September 16, 2011 by Peter Gregory](http://umbraco.com/follow-us/blog-archive/2011/9/16/examining-examine.aspx)</small>

When Umbraco Examine was released many developers including myself thought all my search woes were solved. I figured I would be able to just fire up Umbraco, configure examine and BAM! I would have a search engine that gave me exactly what I needed. But after giving it an initial go and trying it out, most developers left it alone and put it in the too hard basket as they did not understand what was going on under the surface or why their search results were not what they expected. What I want to try and achieve in this post is to demystify Umbraco Examine and provide a few tips I have picked up while working with it.

## What is Examine?
First, for those that don't know what I am on about let's just start by telling you what Examine is.  Examine is a provider based Indexer/Searcher API and wraps the Lucene.Net indexing/searching engine. Examine makes it super easy to work with Lucene indexes and allows you to query or index almost any content with very little effort. Lucene is SUPER fast and when managed correctly can allow you to open up super fast searching on absurd amounts of data.

## What is Umbraco Examine?
Umbraco Examine is the Umbraco implementation of Examine. Examine is not exclusive to Umbraco and can actually be used as a completely stand alone component on any project that needs a fast Index. Umbraco Examine is a combination of Umbraco, Examine and Lucene.Net and uses Umbraco as the data source for its Lucene index. Lucene has been a part of Umbraco from the early days and powers the back office search.

## The Basics of Examine
Out of the box Umbraco comes configured to index content and members in the back office for the back office or internal search engine that appears in the header. As Examine is configuration driven you can quickly modify or set up indexes and searchers. The best place to start is with an index set.

You configure an index set in the /config/examineIndex.config file. This file defines our indexes. As mentioned earlier, there are two internal default indexes configured in this file, and they are called "InternalIndexSet" and "InternalMemberIndexSet". Index sets are extremely easy to set up. The quickest way to get your index set up and running is with a single line of code.

	<IndexSet SetName="WebsiteIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/WebsiteIndexSet/">

Really, that is all you need.  You can actually leave out a majority of the configuration and Examine will revert to the default which is to index all your data and all your properties. But if you want a little more control you can use the full configuration options as shown below.

	<IndexSet SetName="WebsiteIndexSet" IndexPath="~/App_Data/TEMP/ExamineIndexes/WebsiteIndexSet/">
		<IndexAttributeFields>
			<add Name="id" />
			<add Name="nodeName" />
			<add Name="updateDate" />
			<add Name="writerName" />
			<add Name="path" />
			<add Name="nodeTypeAlias" />
			<add Name="parentID" />
		</IndexAttributeFields>
		<IndexUserFields>
			<add Name="bodyText"/>
			<add Name="metaDescription"/>
			<add Name="metaTitle"/>
		</IndexUserFields>
		<IncludeNodeTypes>
			<add Name="TextPage"/>
		</IncludeNodeTypes>
		<ExcludeNodeTypes>
		</ExcludeNodeTypes>
	</IndexSet>

Let's break it down.

**SetName** defines the name that we will use to reference this set in configuration and code later.

**IndexPath** defines where the actual index will reside.  The standard root location in Umbraco is in App_Data/TEMP/ExamineIndexes folder

**`<IndexAttributeFields>`**
This is where we define which of the standard properties (not user defined properties) we wish to index.

**`<IndexUserFields>`**
These are the properties that we have defined against our DocumentTypes that we want to index.  Use the property aliases.

**`<IncludeNodeTypes>` & `<ExcludeNodeTypes>`**
I like to think of these as the white list and the black list. Basically figure out if you have to include more or exclude more nodeTypes. Generally which ever one requires less configuration is the one that you should use but that is completely up to you and how much you like typing.

Just remember that creating errors in index configuration is easy if you make spelling mistakes.  You will know if you have made errors as your index will either not create or not include the features you expect.  We will look at how to check your index content later with Luke, a Java based tool that allows us to look into our index and run queries against the index directly.

So now we have defined our index, we actually now need to tell Examine what to do with this configuration.  In our next step we need to configure our Indexer and our Searcher.  This is done in the `/config/ExamineSettings.Config` file.

This file contains two main sections, `<ExamineIndexProviders>` and `<ExamineSearchProviders>`

**Setting Up your IndexProvider**
We will start out by creating our ExamineIndexProvider. As the name suggests this tells Examine how to manage our Index.  Again, contrary to what you may have been told you can actually leave out most of the optional configuration and simply specify your indexer in a single line of code.

	<add name="WebsiteIndexer" type="UmbracoExamine.UmbracoContentIndexer, UmbracoExamine"/>

But if we want more control we can define our Provider by creating the configuration as follows:

	<add name="WebsiteIndexer" type="UmbracoExamine.UmbracoContentIndexer, UmbracoExamine"
		dataService="UmbracoExamine.DataServices.UmbracoDataService, UmbracoExamine"
		supportUnpublished="false"
		supportProtected="false"
		analyzer="Lucene.Net.Analysis.Standard.StandardAnalyzer, Lucene.Net"
		enableDefaultEventHandler="true"/>

Let's look at each of the options.

**name**: This is the alias that we are going to give our indexer. You may notice above that we have given it the name WebsiteIndexer. If maintaining the naming conventions (Suffix of Indexer, Searcher, IndexSet) Examine will be able to wire up the parts easily and we can omit certain configuration elements. If however we decided that we wanted to call our indexer something else we would need to specify the indexSet attribute so that our indexer knows what it is wired up to.

**type**: Because we are indexing Umbraco Content we need to specify the type as being UmbracoExamine.UmbracoContentIndexer.

**dataService (optional)**: The type that this provider will instantiate in order to query Umbraco for the data that it requires. Generally this shouldn't need to change unless you want to use test data from a non-Umbraco source or you have very custom requirements.

**indexSet (optional)**: Explicitly specifies the index set to use. Generally this is wired up based on naming conventions.

**supportUnpublished (optional)**: As the name implies specifies whether or not you want to index unpublished content.

**supportProtected (optional)**: Set this to true if you want it to index your protected content.

**analyzer (optional)**: The Lucene.Net analyzer to use when storing data. There are a number of different analyzers available and they all do slightly different things. If you want a good overview of the different analyzers check out <http://www.aaron-powell.com/lucene-analyzer>

**enableDefaultEventHandler (optional)**:Will automatically listen for Umbraco events and index when required. If you are relying on the standard Umbraco events, setting this False could be a simple way of disabling indexing if required.

Now that Examine knows how to index our site. It should be reading the config and slamming your content into an index.

## Checking your Index
The easiest way to check that your config is correct is to first go and look in the IndexPath that you specified in your IndexSet.   You should see a set of folders and files. If you want to check the contents of the index you can do this using a tool named Luke which you can either download or launch from this page <http://www.getopt.org/luke/>.

Using Luke, you can open up your index and see its content. It should give you statistics on the elements, number of documents indexed etc. If however you don't see indexed items then it's likely you have either made a mistake in your indexSet configuration or it has not indexed yet. When you are finished with Luke it's important to close the index to get Luke to release its lock on the files.

Luke can also be used to run raw Lucene searches against your index. This can be helpful during development or to debug your queries. Later on in this document you will start to learn how these raw queries fit together.
Setting up your Search Provider

We have a provider for our indexing, now we need to set up our search provider.  We do this by adding a new provider in the `<ExamineSearchProviders>` section of the `ExamineSettings.config` file.  The simplest search provider element looks like this:

	<add name="WebsiteSearcher" type="UmbracoExamine.UmbracoExamineSearcher, UmbracoExamine" 	analyzer="Lucene.Net.Analysis.Standard.StandardAnalyzer, Lucene.Net"/>

Let's break it down, again.

**name**: This is the alias for our search provider.  Again if we stick to naming conventions we can omit the indexSet attribute as it is able to automatically determine this from its own name.

**type**: Because we are searching Umbraco content we specify the type as UmbracoExamine.UmbracoExamineSearcher as the type of search provider.

**analyzer (optional)**: Just like the indexer our search provider also needs to know what type of analyzer to use when searching the index. Make sure that your search is using the same analyzer as your indexer. Think of it as the language the indexer writes, the searcher needs to be able to read, just like if you write in English don't expect to be able to read French.

Awesome! Our configuration is now complete! Our site should now be indexing our content and has a way of accessing it via a search provider.  However, configuration is only part of the story... we now need to do some coding.

## Querying with Examine
So without further ado let's cut straight to the chase and focus on querying your indexes.  We are going to look first at the Fluent API which allows you to quickly create queries using an easy to learn chaining syntax, and then at building your own Raw Lucene queries for more complex scenarios.

## Fluent API
Examine contains a powerful fluent API that enables you to create searches by chaining up query conditions and then pass that chain to Examine to return results.  Let's look at formulating a query.
First we need to specify our search provider that we want to do the searching for us.

	var Searcher = ExamineManager.Instance.SearchProviderCollection["WebsiteSearcher"];

The alias "WebsiteSearcher" comes from the searcher that we have configured `ExamineSettings.config` file.

Next we want to create an instance of `ISearchCriteria` that we will use to build our search query.

	var searchCriteria = Searcher.CreateSearchCriteria();

Next we are going to chain up query. Lets look at one of the most common tasks you would be using examine for, which is to search a set of nodes for a particular word. We have a number of operators available to us to do this.  These are `Or()`, `And()`, `Not()` and `Equals()`. Lets look at the `Or()` operator.

	var query = searchCriteria.Field("nodeName","hello").Or().Field("metaTitle","hello").Compile();
	var searchResults = Searcher.Search(query);
	yourRepeater.DataSource = searchResults;
	yourRepeater.DataBind();

Now this is where things often go wrong for developers and why they often get a little frustrated. What they assume is that this query is going to return them results where either nodeName or metaTitle contain hello. But what actually happens with this query is that by default Examine reads this query as nodeName MUST contain hello or metaTitle SHOULD contain hello. So you will often get odd results or none at all.

So Examine feeds the query to Lucene as follows.

	+nodeName:hello metaTitle:hello

The + specifies that it MUST meet this rule.

Fortunately there is an easy way to fix this behaviour, by specifying the default operator for our search criteria to be BooleanOperation.Or.  The simplest way of explaining what this does is that without it the default operation that Examine uses in Lucene terms is MUST (or AND in Examine terms). Because of this default behaviour, it means that if you are unaware of it you will probably see some strange results. By passing in the default operator of OR (in Lucene terms SHOULD) you stop the default AND operation. To fix this change the creation of the instance of the ISearchCriteria to pass in a BooleanOperation.Or like this:

	var searchCriteria = Searcher.CreateSearchCriteria(BooleanOperation.Or);

Now when Examine passes the query to Lucene it will pass as this:

	nodeName:hello metaTitle:hello

Which in simple terms means give me anything where nodeName or metaTitle contain hello.  Much better.

So with this knowledge let's look at another example using the And() operator.

	var query = searchCriteria.Fields("nodeName","hello").And().Field("metaTitle",hello").Compile();

without passing the BooleanOperation.Or into our ISearchCriteria we would get the following for our Lucene query

	+nodeName:hello +metaTitle:hello

Which means give me results where nodeName MUST contain hello AND metaTitle MUST contain hello.

With the BooleanOperation.Or we would get this:

	nodeName:hello +metaTitle:hello

Which means give me results where nodeName SHOULD contain hello AND metaTitle MUST contain hello.

What if we want grouping?  Well with Examine you get GroupedAnd() and GroupedOr() which as you would expect mean we can group up fields to look in and pass in a query term. I'm going to assume that I am using the BooleanOperation.Or from now on so will only show the result that it gives using that default operator.

	var query = searchCriteria.GroupedOr(new string[] { "nodeName", "metaTitle"}, "hello").Compile();

This would give a Lucene query that looks like this:

	(nodeName:hello metaTitle:hello)

You can also pass in a group of query value.

	var query = searchCriteria.GroupedOr(new string[] { "nodeName", "metaTitle"}, new string[]{"hello", "goodbye"}).Compile();

this would end up being:

	(nodeName:hello metaTitle:goodbye)

I think you get the gist.

But wait, there's more! What if you want to start combining operators? You can! It's not called chaining for nothing...

	var query = searchCriteria.Field("nodeName","hello").And().GroupedOr(new string[] { "metaTitle", "metaDescription"}, new string[]{"hello", "goodbye"}).Compile();

This would end up being:

	nodeName:hello +(metaTitle:hello metaDescription:goodbye)

### Fuzzy
Sometimes users will query your site looking for a term that they could have misspelled or is very close. Fuzzy gives you the ability to get Lucene to look for terms that look like your term.  Eg mound could actually be sound.

	var query = searchCriteria.Fields("nodeName","hello".Fuzzy(0.8f)).Compile();

The optional value you pass into Fuzzy between 0 and 1 specifies how Fuzzy or how close the match is to the original. For instance a match of 0.5 will not return when a threshold of 0.8 is specified.

### Boosting
Sometime you want to give a field more relevance than others. Thankfully we can use the concept of Boosting. What this does is give a particular query a higher relevance. That means that you can for instance say that if the nodeName contains the query then Boost it because its more relevant than those that only contain the term in the body.

	var query = searchCriteria.Fields("nodeName","hello".Boost(8)).Or().Field("metaTitle","hello".Boost(5)).Compile();

If you're curious as to the Math of this, don't be. First rule of Lucene is never ask how the Math works.

### Power Searching with Raw Lucene Queries
Cool, we have learnt a lot. BUT the Fluent API can't do everything. Let's look at a complex example that is not achievable with the Fluent API. Let's say we want to do a search with a phrase, boost exact matches, find results that contain any of the parts of our search phrase. The Fluent API will not be able to do this. So this is where you need to know a little bit of Lucene query syntax.  Along the way I have been showing you what certain queries look like when we convert them from the fluent API to Lucene syntax. It's not as complex as it looks.

Let's say our query is for the following phrase: "paging in XSLT". Most times when you search with Examine you will unfortunately either get nothing back or get back only a few results that match exactly. To see why, let's look at how we might do this with Fluent and then look at the problem when it's converted:

	var query = searchCriteria.Fields("nodeName","paging in XSLT").Compile();

When this converts it looks like this:

	nodeName:"paging in XSLT"

The problem becomes apparent straight away as you can see it quotes the phrase which basically means the term is the whole phrase. What we want from Lucene is the following:

	nodeName:paging in XSLT

What this basically means is that field nodeName needs to contain either paging, in, or XLST.

So to achieve this we need to build our custom Lucene query and then pass it to Examine as a Raw query.

	var term = Request["q"];
	var luceneString = "nodeName:" + term;
	var query = searchCriteria.RawQuery(luceneString);

Cool, now our search is starting to perform more like how we want it to. Now what about making it boost matches containing all the terms higher? No worries.

	var luceneString = "nodeName:";
	luceneString += "(+" + term.Replace(" ", " +") + ")^5 ";
	luceneString += "nodeName:" + term;

The resultant query would look like this:

	nodeName:(+paging +in +XSLT)^5 nodeName:paging in XSLT

The ^5 is the equivalent of .Boost(5)

So as you can see, it can get pretty complex but also pretty powerful.  For more information I really suggest that you take the time to look through the official Lucene query syntax guide http://lucene.apache.org/java/2_4_0/queryparsersyntax.html as it will show you what can be used to achieve very complicated queries.

We haven't gone into the output of results but quickly here is what you could end up with in your codebehind using the above Raw query:

	var Searcher = ExamineManager.Instance.SearchProviderCollection["OurIndexSearcher"];
	var searchCriteria = Searcher.CreateSearchCriteria(BooleanOperation.Or);
	var term = Request["q"];
	var luceneString = "nodeName:";
	luceneString += "(+" + term.Replace(" ", " +") + ")^5 ";
	luceneString += "nodeName:" + term;
	var query = searchCriteria.RawQuery(luceneString);
	var searchResults = Searcher.Search(query).OrderByDescending(x => x.Score);
	yourRepeater.DataSource = searchResults;
	yourRepeater.DataBind();

And then in your code front the objects that you are iterating over are of type Examine.SearchResult. So to databind on those you would have syntax like the following:

	<%# ((Examine.SearchResult)Container.DataItem).Fields["nodeName"] %>

In conclusion Examine is awesome and with a little bit of information and a little patience to get to know it, you can be up and running with some very complex querying.

## Umbraco.TV
There are video tutorials on Umbraco.TV detailing how to set-up and use Examine search indexes.
<http://umbraco.com/help-and-support/video-tutorials/developing-with-umbraco/examine.aspx>
