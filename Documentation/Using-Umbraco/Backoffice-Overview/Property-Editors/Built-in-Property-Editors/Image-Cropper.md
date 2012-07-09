#Image Cropper

`Returns: XML`

Used with Media Types only, the Image Cropper property editor displays an editor to allow backoffice users to position pre-defined image crops on media items. The crops are saved to disk within the media item folder path.

XML returned by Image Cropper is appended into the media item XML and returned by the `umbraco.library:GetMedia` function.

##Settings

###Property alias
Defines the [Upload](Upload.md) property alias of the file onto which the cropper should be activated. On the default Image Media Types this is 'umbracoFile'.

###Save crop images
Defines if the generated crop images are saved to disk or created on demand. It is recommended that this is checked for performance.

###Show Label
Defines if the property name is displayed to the user when selecting the crops.

###Crops
This area allows you define multiple crops which the backoffice user is presented to selected on the media item.  There are controls on the right to allow you to rearrange the order (Up, Down) and remove crop definitions.  You cannot edit crop definitions but you can delete and recreate with different settings using the same Name.

The following settings are used for a individual crop definition:

- Name - the name of the crop (this is important and used when outputting the crop)
- Target width
- Target height
- Default position
- Keep aspect

When creating a crop definition you must click add to add the definiton to the list and then click save on the toolbar otherwise your crop definition will be lost.

##Data Type Definition Example

![Image Cropper Property Editor Definition](images/Image-Cropper-DataType.jpg?raw=true)

##Media Type Definiton Example

![Image Cropper Property Editor Definition](images/Image-Cropper-MediaType.jpg?raw=true)

##Media Example

The crops defined for the Media Type are shown below the image, clicking on a crop selector shows the resizable area on top of the image and can be moved and resized. As shwon below if the source image does not have the required size for a defined crop the crop selector goes red instead of green.

**Note:** When uploading a image into a Media Type for the first time, the item needs to be reloaded before the crop selector can be shown, this can be done by clicking the item again in the tree or by clicking the save button twice.

![Image Cropper Property Editor Definition](images/Image-Cropper-Media.jpg?raw=true)

##XML Example

	<newsImage id="1065" version="b32f5be6-de98-4dbf-af00-b208e5c153f8" parentID="1063" level="2" writerID="0" nodeType="1062" template="0" sortOrder="1" createDate="2012-07-09T13:08:30" updateDate="2012-07-09T13:08:30" nodeName="News Image 1" urlName="newsimage1" writerName="admin" nodeTypeAlias="newsImage" path="-1,1063,1065">
		<umbracoFile>/media/193/tulips.jpg</umbracoFile>
		<umbracoWidth>500</umbracoWidth>
		<umbracoHeight>375</umbracoHeight>
		<umbracoBytes>183121</umbracoBytes>
		<umbracoExtension>jpg</umbracoExtension>
		<newsCrops>
			<crops date="2012-07-09T13:08:41">
				<crop name="thumbCrop" x="68" y="0" x2="443" y2="375" url="/media/193/tulips_thumbCrop.jpg"/>
				<crop name="mainCrop" x="62" y="0" x2="437" y2="375" url="/media/193/tulips_mainCrop.jpg"/>
			</crops>
		</newsCrops>
	</newsImage>

##XSLT Example

##Razor (DynamicNode) Example