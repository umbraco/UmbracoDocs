

## Members

Querying members into

### Items
### GetMember(string or int)
Returns: `Member` or `null`

### Collections
#### GetMembersByXPath(string)
Returns: `IEnumerable<Member>`

(uses GetPublishedXml)

#### GetMembersByCsv(string)
Returns: `IEnumerable<Member>`

#### GetMembersByXml(string)
Returns: `IEnumerable<Member>`

#### GetMembersByType(string)
Returns: `IEnumerable<Member>`

#### GetMembersByGroup(string)*
Returns: `IEnumerable<Member>`

### Properties
#### HasProperty(string)
Returns: `bool`

#### GetProperty&lt;T&gt;(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument`

#### SetProperty(string, object)
Returns: `Member`