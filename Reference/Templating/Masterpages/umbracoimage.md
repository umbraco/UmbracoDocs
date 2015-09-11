#Umbraco:image

**Applies to: Umbraco 4.11.0+**

The `umbraco:image` control enables you to easily add images from your content to your templates. The control is used as such:

	<umbraco:image runat="server" field="bannerImage" />

This will output an `<img/>` tag when the template renders:

	<img src="/media/19/imagename.jpg" />

The complete syntax for the control is this:

	<umbraco:image runat="server" field="{fieldName}" nodeid="{nodeId}" parameters="{urlParameters}" provider="{providername}" />

All other attributes, such as `width|height|class` will be passed through to the generated `<img/>` tag.

##Field
The `field` attribute defines which field of the current page will be used as the image. If the field contains a number, then a media item will be used to generate the url. If the field contains an image path (for example from the upload control), then that path is used directly.

##NodeId
If a `nodeid` is specified, then that node will be used to get the `field` from.

##Parameters
The `parameters` are provider specific. The default provider supports the upload datatypes thumbnails, and the Image Cropper datatypes crops.

<table>
	<tr>
		<th>Key</th>
		<th>Value</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>thumb</td>
		<td>int</td>
		<td>Specifiy the size of the thumb that you want to display. For example thumb=200.</td>
	</tr>
	<tr>
		<td>crop</td>
		<td>string</td>
		<td>Specify the name of the crop that you want to display. For example crop=small.</td>
	</tr>
</table>

###Example:

	<umbraco:Image runat="server" field="bannerImage" Parameters="crop=small" />

This generates:

	<img src="/media/19/myimage_small.jpg" />

##Provider
A custom provider can be created by implementing the `IImageUrlProvider` interface. An example would be an ImageGen provider which could be used like this:

	<umbraco:Image runat="server" field="bannerImage" Parameters="width=400&height=150" Provider="imageGen" />

