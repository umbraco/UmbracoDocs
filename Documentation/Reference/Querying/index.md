#Querying
_Umbraco comes with several ways of querying, filtering and searching content, through the APIs: uQuery, DynamicNode and NodeFactory_ 

##[DynamicNode](DynamicNode/index.md)
DynamicNode provides a fast, dynamic way to query content which resides in the website cache. It can be used on Templates and Macros and accessable via the Model. DynamicNode extends this Model by exposing the properties of the current page as dynamic properties, and also adds [tree traversal and filtering methods](http://our.umbraco.org/projects/developer-tools/razor-dynamicnode-cheat-sheet).




##[uQuery](uQuery/index.md)
uQuery is similar to DynamicNode in that is adds tree traversal/filtering methods and acts as a wrapper to the website cache. uQuery extends the NodeFactory, Document, Media, Member and Relations apis and can be queried using LINQ.

The property accessor syntax is heavier, but is strongly typed, so there's intellisense.
