#Masterpages

Umbraco (since version 4) uses [ASP.NET master pages](http://www.asp.net/web-forms/tutorials/master-pages), so if you are familiar with these you will find this a breeze.

When creating a new template via the backoffice, Umbraco simply generates a masterpage file that inherits from
"~/umbraco/masterpages/default.master", whilst storing the newly created template in 
"~/masterpages/[NAME_OF_TEMPLATE].master".

The database is also updated by adding a row to both the cmsTemplate and umbracoNode tables  - it is for this reason 
that your master pages have to be manually created via the backoffice first, after which the content of the 
master page files can be overwritten to update.

When linking to Umbraco pages within a master page you may use {localLink:nodeID}. This avoids hard coding file paths. 