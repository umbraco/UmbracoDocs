#This section is waiting for content

Umbraco (since version 4) uses [ASP.NET master pages](http://www.asp.net/web-forms/tutorials/master-pages), so if you are familiar with these you will find this a breeze.

When creating a new template via the backoffice, Umbraco simply generates a masterpage file that inherits from
"~/umbraco/masterpages/default.master", whilst storing the newly created template in 
"~/masterpages/[NAME_OF_TEMPLATE].master".

The database is also updated by adding a row to both the cmsTemplate and umbracoNode tables  - it is for this reason 
that your master pages have to be manually created via the backoffice first, after which the content of the 
master page files can be overwritten to update.

When linking to Umbraco pages within a master page you may use {localLink:nodeID}. This avoids hard coding file paths.

###Progress
Consult the Umbraco 4 documentation trello board to see what we are currently working on.
[See the TrelloBoard here](https://trello.com/board/umbraco-4-documentation/4fdb02df8fc3ef067e809e95)

###Contribution
Umbraco is a community powered project and we welcome any contribution, big or small, even fixing a typo is a valuable contribution.
[See how to contribute](https://github.com/umbraco/Umbraco4Docs)



 