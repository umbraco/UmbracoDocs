#Using Razor axes
_Covers how Razor axes are used to query and filter specific parts of the content tree_

##Axes available
Dynamic node has 3 different kinds of collectioens and 2 additional variations of these:

###.Children
Property containing all pages just below a given page.

	@forach(var child in Model.Children){
		<a href="@child.Url">@child.Name</a>
	}

###.Ancestors() and .AncestorsOrSelf()
Methods returning either all pages above (parents, grandparents and so on) a given page in the content tree, or all pages above the current page, and the page itself

	@forach(var ancestor in Model.Ancestors()){
		<a href="@ancestor.Url">@ancestor.Name</a>
	}

	@forach(var ancestor in Model.AncestorsOrSelf()){
		<a href="@ancestor.Url">@ancestor.Name</a>
	}

###.Descendants() and .DescendantsOrSelf()
Methods returning either all pages (children, grandchildren and so on) below a given page in the content tree, or all pages above the current page, and the page itself

	@forach(var ancestor in Model.Ancestors()){
		<a href="@ancestor.Url">@ancestor.Name</a>
	}

	@forach(var ancestor in Model.AncestorsOrSelf()){
		<a href="@ancestor.Url">@ancestor.Name</a>
	}
