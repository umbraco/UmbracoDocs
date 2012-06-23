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
Returns: `<T>`

This generic method handles the null checks when getting a media property by alias, and then converts the stored property value into the return type `<T>` requested. It also takes into account bool values as stored as strings "0" and "1", and can also construct an XmlDocument from a string fragment. Here are some examples:

	Media media = uQuery.GetMediaByXPath("//Image").First();
	
	string altText = media.GetProperty<string>("altText");	
	XmlDocument xmlDocument = media.GetProperty<XmlDocument>("mntpCategories");


### GetImageCropperUrl
Returns: `string`

This helper method will parse the xml fragment stored by the the Image Cropper datatype and return the url for the specified crop alias, or an empty string if no url could be found.

	string url = uQuery.GetMediaByXPath("//*")
						.First()
						.GetImageCropperUrl("propertyAlias", "cropAlias");



### GetImageUrl()
Returns: `string`

This is a wrapper method to return the *umbracoFile* property if the current media item is an Image.

	string url = uQuery.GetMediaByType("Image")
						.First()
						.GetImageUrl();

### GetImageThumbnailUrl()
Returns: `string`

This is a wrapper method to return the url for the auto genereated thumbnail.

	string url = uQuery.GetMediaByType("Image")
						.First()
						.GetImageThumbnailUrl();


### SetProperty(string, object)
Returns: `Media`

