#Upload field

`Returns: String`

The upload field allows documents or images to be uploaded to Umbraco. This does not add them to the media library, they are simply added to the document or media item data.

##Data Type Definition Example

![Upload Data Type Definition](images/Upload-DataType.jpg?raw=true)

##Settings

###Database datatype

This setting is maintained for legacy however it should generally be set to Nvarchar as the property editor stores the value as text.

###Thumbnail sizes

This setting allows you to define maximum pixel dimensions for generating resizes of the uploaded file. The setting should be semicolon separated for multiple resizes, e.g. 100;200;300, this would generate three resizes images. The resized images are named in the format `uploadedfile_thumb_xxx.jpg` where xxx represents the maximum pixel size specified in this setting. The resizes are saved in the same location as the main image.

##Content Example

![Upload Example](images/Upload-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@{		
	   if (Model.Content.HasValue("umbracoFile")){
	       <a href="@Model.Content.GetPropertyValue("umbracoFile")">Download file</a>
	   } 
	}

Example for getting a thumbnail resize of 200 pixels

	@{		
	   if (Model.Content.HasValue("umbracoFile")){
           int thumbnailSize = 200;
           if (Model.Content.GetPropertyValue<string>("umbracoFile").IndexOf(".") != -1){
               string[] uploadNamePath = Model.Content.GetPropertyValue<string>("umbracoFile").Split('.');
               string thumbnailNamePath = uploadNamePath[0] + "_thumb_" + thumbnailSize + "." + uploadNamePath[1];    
               <img src="@thumbnailNamePath" />     
           }
	   } 
	}


###Dynamic: 

	@{		
	   if (CurrentPage.HasValue("umbracoFile")){
 			<a href="@CurrentPage.umbracoFile">Download file</a>
	   } 
	}

Example for getting a thumbnail resize of 200 pixels

	@{		
	   if (CurrentPage.HasValue("umbracoFile")){
           var thumbnailSize = 200;
           if (CurrentPage.umbracoFile.IndexOf(".") != -1)
           {
               var uploadNamePath = CurrentPage.umbracoFile.Split('.');
               var thumbnailNamePath = uploadNamePath[0] + "_thumb_" + thumbnailSize + "." + uploadNamePath[1];    
               <img src="@thumbnailNamePath" />     
           }
	   } 
	}

##Razor Macro (DynamicNode) Example

	@{		
	   if (Model.HasValue("umbracoFile")){
	       <a href="@Model.umbracoFile">Download file</a>
	   } 
	}

Example for getting a thumbnail resize of 200 pixels

	@{		
	   if (Model.HasValue("umbracoFile")){
           var thumbnailSize = 200;
           if (Model.umbracoFile.IndexOf(".") != -1){
               var uploadNamePath = Model.umbracoFile.Split('.');
               var thumbnailNamePath = uploadNamePath[0] + "_thumb_" + thumbnailSize + "." + uploadNamePath[1];    
               <img src="@thumbnailNamePath" />     
           }
	   } 
	}

##XSLT Macro Example

	<xsl:if test="string-length($currentPage/umbracoFile) > 0">  
	  <a href="{$currentPage/umbracoFile}">
	    Download file
	  </a>
	</xsl:if>