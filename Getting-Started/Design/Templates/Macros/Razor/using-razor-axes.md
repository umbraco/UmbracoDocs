#Using Razor axes
_Covers how Razor axes are used to query and filter specific parts of the content tree_

##Axes available
DynamicNode has 3 different kinds of collections and 2 additional variations of these:

###.Children
Property containing all pages just below a given page.

	@foreach(var child in Model.Children){
		<a href="@child.Url">@child.Name</a>
	}

###.Ancestors() and .AncestorsOrSelf()
Methods returning either all pages above (parents, grandparents and so on) a given page in the content tree, or all pages above the current page, and the page itself

	@foreach(var ancestor in Model.Ancestors()){
		<a href="@ancestor.Url">@ancestor.Name</a>
	}

	@foreach(var ancestor in Model.AncestorsOrSelf()){
		<a href="@ancestor.Url">@ancestor.Name</a>
	}

###.Descendants() and .DescendantsOrSelf()
Methods returning either all pages (children, grandchildren and so on) below a given page in the content tree, or all pages above the current page, and the page itself

	@foreach(var descendant in Model.Descendants()){
		<a href="@descendant.Url">@descendant.Name</a>
	}

	@foreach(var descendant in Model.DescendantsOrSelf()){
		<a href="@descendant.Url">@descendant.Name</a>
	}
