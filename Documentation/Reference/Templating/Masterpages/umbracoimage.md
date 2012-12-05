#Umbraco:image

The `umbraco:image` control enables you to easily add images from your content to your templates. The cotrols is used as such:

	<umbraco:image runat="server" field="bannerImage" />

This will output an <img/> tag when the template renders:

	<img src="/media/19/imagename.jpg" />

The complete syntax for the control is this:

	<umbraco:image runat="server" field="{fieldName}" nodeid="{nodeId}" parameters="{urlParameters}" provider="{providername}" />

##Field
The `field` attribute defines which field of the current page will be used as the image.

##NodeId
If a `nodeid` is specified, then that node will be used to get the `field` from.

##Parameters
Parameters are provider specific. The default provider 