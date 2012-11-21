#Media Picker

`Returns: Media ID`

The media picker opens a simple modal to pick a specific media item from the media tree. The value saved is the selected media ID. 

##Settings

###Show preview
If checked, the content editor is shown a thumbnail once the media item is selected.

![Media Picker Preview](images/Media-Picker-Preview.jpg?raw=true)

###Show advanced dialog
If checked, the content editor is able to view thumbnails of the images while selecting and also is able to upload new media directly within the picker.

![Media Picker Advanced Setting](images/Media-Picker-Advanced.jpg?raw=true)

##Data Type Definition Example

![Media Picker Data Type Definition](images/Media-Picker-DataType.jpg?raw=true)

##Content Example 

Standard Media Picker

![Media Picker Content](images/Media-Picker-Content-Standard.jpg?raw=true)

Media Picker with Show Advanced Dialog checked

![Media Picker Content](images/Media-Picker-Content.jpg?raw=true)

##MVC View Example

###Typed:
	@{
	    if(Model.Content.HasValue("mainImage")){
	        var mediaItem = Umbraco.TypedMedia(Model.Content.GetPropertyValue("mainImage")); 
	        <img src="@mediaItem.GetPropertyValue("umbracoFile")" alt="@mediaItem.GetPropertyValue("Name")"/>    
	    }   
	}

###Dynamic:                              
	@{      
	    if (CurrentPage.HasValue("mainImage")){                                         
		    var dynamicMediaItem = Umbraco.Media(CurrentPage.mainImage);
		    <img src="@dynamicMediaItem.umbracoFile" alt="@dynamicMediaItem.Name"/>
		}
	}

##Razor Macro (DynamicNode & DynamicMedia) Example
There are several different techniques you can use to retrieve the media from a media picker using DynamicNode & DynamicMedia, below are three examples.

      @{
        if (Model.HasValue("mainImage")){                                     
          //option 1                               
          <img src="@Model.Media("mainImage","umbracoFile")" width="@Model.Media("mainImage","umbracoWidth")" height="@Model.Media("mainImage","umbracoHeight")" />
          //option 2
          var selectedMedia2 = @Model.Media("mainImage");
          <img src="@selectedMedia2.umbracoFile" width="@selectedMedia2.umbracoWidth" height="@selectedMedia2.umbracoHeight" alt="@selectedMedia2.Name"/>
          //option 3          
          var selectedMedia3 = @Library.MediaById(Model.mainImage);
          <img src="@selectedMedia3.umbracoFile" width="@selectedMedia3.umbracoWidth" height="@selectedMedia3.umbracoHeight" alt="@selectedMedia3.Name"/>                       
        }
      }

##XSLT Macro Example

    <xsl:if test="number($currentPage/mainImage) > 0">
        <xsl:variable name="selectedMedia" select="umbraco.library:GetMedia($currentPage/mainImage, 0)" />
        <img src="{$selectedMedia/umbracoFile}" width="{$selectedMedia/umbracoWidth}" height="{$selectedMedia/umbracoHeight}" alt="{$selectedMedia/@nodeName}" />
    </xsl:if>