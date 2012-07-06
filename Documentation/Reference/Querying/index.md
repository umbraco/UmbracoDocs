#Querying
_Umbraco comes with several ways of querying, filtering and searching content, through the APIs: uQuery, DynamicNode and NodeFactory_ 

_DynamicNode provides a fast, dynamic way to query Content which resides in the website cache. uQuery has a broader api, which covers content, media, members and relations, but does not have the focused query and filtering DynamicNode has._

##[DynamicNode](DynamicNode/index.md)
DynamicNode is the dynamic access to all the data stored in your Umbraco website. Also known as the Model of your site.
Model represents the page, currently being rendered, and is usually referenced on Templates or Macros

##[uQuery](uQuery/index.md)
uQuery is an API giving read/write access to the content, media and member data, as well as extending the releations.
