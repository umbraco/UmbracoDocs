# Content

Querying content can be done via [Nodes](Nodes.md) where the source data comes from the xml cache, which is fast (the current published version data) or via [Documents](Documents.md) where the data is retrieved from the database (slower, but the data represents the latest version whether it's published or not).

	using umbraco; // uQuery
	using umbraco.NodeFactory; // Nodes
	using umbraco.cms.Web.Document; // Documents

uQuery has a number of static methods to get collections of Nodes and Documents, as well as extension methods on the `umbraco.NodeFactory.Node` `umbraco.cms.businesslogic.Web.Document` objects.


##[Querying nodes in memory](Nodes.md)
Nodes are the cache representation of the specific published document version. It is read-only, but extremely fast as it never touches the database.

##[Querying documents in database](Documents.md)
Documents are persisted in the database, and provides read/write access to entire history of the document, as well as unpublished documents. 