#DynamicNode

##Library
The @Library class is of type RazorLibraryCore in the namespace umbraco.MacroEngines.Library. It contains a collection of useful methods for use in Razor templates.

###.Coalesce(params object[] args)
Takes the first non-null, non-DynamicNull property value and return the value of it.

	@Library.Coalesce(@Model.property1, @Model.property2, @Model.Name)

###.Concatenate(params object[] args)

Concatenate will just concatenate the parameters you pass in together as if you had gone @Model.property + @Model.property2 + @ Model.Name

	@Library.Concatenate(@Model.property1, @Model.property2, @Model.Name)

###.Join(string seperator, params object[] args)
Join does the same as concatenate except it takes a seperator as the first parameter.

	@Library.Join(",", @Model.property1, @Model.property2, @Model.Name)

###.NodeById(int Id)
Returns a single node as DynamicNode

Overloads:

	public dynamic NodeById(int Id)
	public dynamic NodeById(string Id)
	public dynamic NodeById(object Id)


###.NodesById(List<int> Ids)
Returns multiple nodes as DynamicNodeList

Overloads:

	public dynamic NodesById(List<int> Ids)
	public dynamic NodesById(List<object> Ids)
	public dynamic NodesById(List<int> Ids, DynamicBackingItemType ItemType)
	public dynamic NodesById(params object[] Ids)

###.MediaById(int Id)
Returns either a single DynamicMedia or a DynamicNodeList of DynamicMedia depending on the overload used
	
Overloads:

	public dynamic MediaById(int Id)
	public dynamic MediaById(string Id)
	public dynamic MediaById(object Id)
	public dynamic MediaById(List<object> Ids)
	public dynamic MediaById(List<int> Ids)
	public dynamic MediaById(params object[] Ids)


###.If(bool test, string valueIfTrue, string valueIfFalse)
Library.If is more syntactic sugar for Razor than anything. It wraps a simple ternary

	<strong>@{ @Model.booleanProperty ? "valueIfTrue" : "valueIfFalse" }</strong>
	//is equivilent to:
	<strong>@Library.If(@Model.booleanProperty, "valueIfTrue", "valueIfFalse")</strong>

Yes it's actually longer, but often when using embedded ternaries, e.g. inside an attribute value, you had to add extra brackets to get razor to parse the code properly.


###.ToDynamicXml(string xml)
@Library.ToDynamicXml  provides some methods to convert various types to DynamicXml. The overloads are as follows:

	public DynamicXml ToDynamicXml(string xml)
	public DynamicXml ToDynamicXml(XElement xElement)  
	public DynamicXml ToDynamicXml(XPathNodeIterator xpni)

These methods are pretty much self explainatory, but the XPathNodeIterator method will allow you to convert your old XSLT Extensions to be easily accessible within Razor.
This is intended as a stepping stone only, if you're writing a new interface, you should return it as a List<StronglyTypedObject>

###.Truncate(IHtmlString html, int length)
This method is used to take a string (or a block of HTML) and truncate it to a specific length.
It will optionally add an elipsis on the end for you (… ) and it is HTML Tag aware.

There are a number of overloads, but the most basic use case is this:

	@Library.Truncate(Model.rteContent,100)

This will return the content of rteContent, but only the first 100 characters. Characters that are tags (e.g. `<strong>`) will not be counted towards the 100, and a … will be added on the end.
If the truncation occurs in the middle of a tag, (e.g. there'd be no `</strong>`) the tag will still be closed.

Disclaimer: Truncate may not always correct close tags. Make sure you carefully test when using to make sure it works for your use case.

Here are the other overloads:

	public IHtmlString Truncate(IHtmlString html, int length)
	public IHtmlString Truncate(IHtmlString html, int length, bool addElipsis)
	public IHtmlString Truncate(IHtmlString html, int length, bool addElipsis, bool treatTagsAsContent)
	public IHtmlString Truncate(DynamicNull html, int length)
	public IHtmlString Truncate(DynamicNull html, int length, bool addElipsis)
	public IHtmlString Truncate(DynamicNull html, int length, bool addElipsis, bool treatTagsAsContent)
	public IHtmlString Truncate(string html, int length)
	public IHtmlString Truncate(string html, int length, bool addElipsis)
	public IHtmlString Truncate(string html, int length, bool addElipsis, bool treatTagsAsContent)

Rather than explaining each of the overloads, which would be boring for all of us, there are 3 input types, and for each of those, 3 overloads.
addElipsis controls whether the … will be added and "treatTagsAsContent" effectively disables the HTML tag parsing portion of this method.

###.StripHtml(IHtmlString html)
As the name suggests, this method will strip the HTML tags out of a block of HTML and return just the text. For example:

This is some text `<strong>` and this is some bold text`</strong>` in a sentence
Will become:
This is some text and this is some bold text in a sentence

This method will not deal with `<script>` or `<style>` tags properly, as they can have nested < and >.

Here are the overloads:

	public HtmlString StripHtml(IHtmlString html)
	public HtmlString StripHtml(DynamicNull html)
	public HtmlString StripHtml(string html)
	public HtmlString StripHtml(IHtmlString html, List<string> tags)
	public HtmlString StripHtml(DynamicNull html, List<string> tags)
	public HtmlString StripHtml(string html, List<string> tags)
	public HtmlString StripHtml(IHtmlString html, params string[] tags)
	public HtmlString StripHtml(DynamicNull html, params string[] tags)
	public HtmlString StripHtml(string html, params string[] tags)


These methods are fairly self explainatory, but the simple use case is this:

	@Library.StripHtml(Model.rteContent)

If you only wanted to strip specific tags, such as the dreaded `<pre>`, you could do this:

	@Library.StripHtml(Model.rteContent, "pre")

###.Search(string term, bool useWildCards = true, string searchProvider = null)

Coming soon....