

# Members

Querying members intro

## Items
## GetMember(string or int)
Returns: `Member` or `null`

For a given id (supplied as a string or an int), returns the associated Member object or a null if it is not found. This method will supress any exceptions thrown by Umbraco when trying to create an invalid Member, if this occurs then a null is returned.

	Member member = uQuery.GetMember(2001);

	Member member = uQuery.GetMember("2001");


## Collections
### GetMembersByXPath(string)
Returns: `IEnumerable<Member>`

Builds an Xml document from the member data in the umbracoNode and cmsContentXml tables and returns a collection of members that match the supplied XPath expression.

For example, to get a particular member where the 'twitter' property value matches the string '@TwitterHandle':

	Member member = uQuery.GetMembersByXPath("//*[twitter = '@TwitterHande']").FirstOrDefault();


### GetMembersByCsv(string)
Returns: `IEnumerable<Member>`

Gets a collection of members fromt a CSV string of member Ids.

	IEnumerable<Member> members = uQuery.GetMembersByCsv("2001, 2002, 2003");


### GetMembersByXml(string)
Returns: `IEnumerable<Member>`

### GetMembersByType(string)
Returns: `IEnumerable<Member>`

### GetMembersByGroup(string)*
Returns: `IEnumerable<Member>`

## Properties
### HasProperty(string)
Returns: `bool`

### GetProperty&lt;T&gt;(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument`

### SetProperty(string, object)
Returns: `Member`