# Media
Querying media intro

## Items
### GetMedia(string or int)
Returns: `Media` or `null`

## Collections
### GetMediaByXPath(string)
Returns: `IEnumerable<Media>`

(uses GetPublishedXml)

### GetMediaByCsv(string)
Returns: `IEnumerable<Media>`

### GetMediaByXml(string)
Returns: `IEnumerable<Media>`

Currently works with XML saved by Multi-Node Tree Picker (use GetNodesByXml for Content nodes) 

### GetMediaByName(string)
Returns: `IEnumerable<Media>`

### GetMediaByType(string)
Returns: `IEnumerable<Media>`

### Traversing

#### GetAncestorMedia()
Returns: `IEnumerable<Media>`

#### GetAncestorOfSelfMedia()
Returns: `IEnumerable<Media>`

#### GetDescendantMedia()
Returns: `IEnumerable<Media>`

#### GetDescendantOrSelfMedia()
Returns: `IEnumerable<Media>`

#### GetSiblingMedia()
Returns: `IEnumerable<Media>`

#### GetPrecedingSiblingMedia()*
Returns: `IEnumerable<Media>`

#### GetFollowingSiblingMedia()*
Returns: `IEnumerable<Media>`

#### GetChildMedia()
Returns: `IEnumerable<Media>`

## Properties
### HasProperty(string)
Returns: `bool`

### GetProperty<T>(string)
Returns: `bool` `int` `float` `decimal` `string` `DateTime` `XmlDocument`

### SetProperty(string, object)
Returns: `Media`

