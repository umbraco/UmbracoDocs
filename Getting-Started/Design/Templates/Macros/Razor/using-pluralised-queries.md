#Using Pluralised Queries
_Covers how you can do advanced query and traversal of nodes with a specific type_

##What is a pluralised query?
A pluralised query is shortcut to fetching the children of a specific type from a node. So it's a shorter syntax, but it's also much more expressive in regards to what is going on in the query. So instead of using the generic `Model.Children` property it is possible to say `Model.Textpages` or `Model.NewsAreas` to fetch all children with the document type Textpage or NewsArea respectively.

	//get all textpages
	foreach(var item in Model.Textpages){
		<p>@item.Name<p>	
	}

##Chaining
Chaining these queries together creates a expressive syntax for drilling down into your content tree

	//get all articles in the first news area
	foreach(var article in Model.NewsAreas.First().NewsArticles){
		<h1>@article.Name</a>
	}
	
	//goto the root of the site, then get the first FAQ area, and then all items in that area
	var faqArea = Model.AncestorOrSelf("HomePage").FaqAreas.First();
	
	foreach(var question in faqArea.Questions){
		<p>@question.Answer</p>
	}


##Casing
All queries have the first letter uppercased, and then follows the casing using on the document type.

##Rules for pluralisation of document type alias'
2 simple rules:

1. All types get an 's' at the end
2. Unless it ends with 'y' then its properly replaced with 'ie'

So if you fetch items of the type `Textpage` or `NewsArea` it will append an 's':

	@Model.Textpages
	
	@Model.NewsAreas
	
But if you query for items of type `Repository` it will remove the 'y' and append 'ies':

	@Model.Repositories

