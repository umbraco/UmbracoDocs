#Image Cropper

`Returns: XML`

The Image Cropper property editor displays an editor to allow backoffice users to position pre-defined crops on uploaded image. The crops are saved to disk within the media item folder path if the save setting is checked.

##Settings

###Property alias
Defines the [Upload](Upload.md) property alias of the file onto which the cropper should be activated. On the default Image Media Type this is 'umbracoFile'.  This property must exist on either the Media type or Document type for the cropper to function.

###Save crop images
Defines if the generated crop images are saved to disk or created on demand, when checked the settings will offer the option to alter the output quality of cropped images, the field expects a numeric value between 0 - 100. E.g. 90 = 90% compared to original image quality. It is recommended that this is checked for performance.

###Show Label
Defines if the property name is displayed to the user when selecting the crops.

###Crops
This area allows you to define multiple crops which the backoffice user is presented to select on the media item.  There are controls on the right to allow you to rearrange the order (Up, Down) and remove crop definitions. You cannot edit crop definitions but you can delete and recreate with different settings using the same Name.

The following settings are used for a individual crop definition:

- Name - the name of the crop (this is important and used when outputting the crop)
- Target width - The width of the crop to save in pixels. If a value entered is greater than the original width the crop will still be saved and the output file will be scaled up causing loss of quality.
- Target height - The height of the crop to save in pixels. If a value entered is greater than the original height the crop will still be saved and the output file will be scaled up causing loss of quality.
- Default position - The default position of the crop marks when creating crops e.g. you may want to offset the crop so it is taken from the centre of the image.
- Keep aspect - When checked will maintain the aspect ratio of the image when creating crops and will crop based on the longest dimension.

When creating a crop definition you must click "Add" to add the definition to the list and then click the save button on the toolbar otherwise your crop definition will be lost.

##Data Type Definition Example

![Image Cropper Property Editor Definition](images/Image-Cropper-DataType.jpg?raw=true)

##Media Type Definition Example

The property alias which references the Image Cropper property editor will be output in the XML, in the example below this is "newsCrops".

![Image Cropper Property Editor Definition](images/Image-Cropper-MediaType.jpg?raw=true)

##Media Example

The crops defined for the Media Type are shown below the image, clicking on a crop selector shows the resizable area on top of the image and can be moved and resized. As shown below if the source image does not have the required size for a defined crop the crop selector goes red instead of green.

**Note:** When uploading a image into a Media Type or Document Type for the first time, the item needs to be reloaded before the crop selector can be shown, this can be done by clicking the item again in the tree or by clicking the save button twice.

![Image Cropper Property Editor Definition](images/Image-Cropper-Media.jpg?raw=true)

##XML Media Type Example

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

##XSLT Media Type Example

      <xsl:variable name="mediaItem" select="umbraco.library:GetMedia(1065, 0)"/>
      <xsl:if test="count($mediaItem/newsCrops/crops/crop) > 0">
        <img src="{$mediaItem/newsCrops/crops/crop[@name = 'thumbCrop']/@url}" />
      </xsl:if>

##Razor (DynamicMedia & DynamicXml) Media Type Example
    
    @{
      var mediaItem = Model.MediaById(1065);
      if (@mediaItem.newsCrops.Count() > 0)
      {
          <img src="@mediaItem.newsCrops.Find("@name", "thumbCrop").url" />      
      }
    }
