#Hello World
_Goes through the code, required to display the current page's name, ID, URL and child pages_

##Getting values from the current page
Using Razor in an Umbraco Macro, the current page, is accessible through the `Model` keyword, as a `dynamic` object.

	@*Getting name*@
	<p>Hello @Model.Name</p>

	@*Getting url*@
	<p>My url is: <a href="@Model.Url">@Model.Url</a></p>

	@*Getting page id*@
	<p>My page id is: @Model.Id</p>

##Getting a collection of child pages of the current page.
All pages in Razor, contains a standard property called `Children`, this returns a `DynamicNodeList` containing all child pages, these can be iterated through 

	<ul>
		@foreach(var child in Model.Children){
			<li><a href="@child.Url">@child.Name</a></li>
		}
	</li>


