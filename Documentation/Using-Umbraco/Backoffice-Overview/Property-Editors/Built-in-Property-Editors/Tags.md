#Tags

`Returns: Comma Separated String`

A textbox that allows you to use multiple tags on a docType. You can specify a Tag Group when creating new versions of this datatype so that you can use Tags on different sections of your site (i.e News, Article, Events).

##Settings

###Tag group

Specify the tag group for this data type. Tags can be retrieved by group.

##Data Type Definition Example

![Tags Data Type Definition](images/Tags-DataType.jpg?raw=true)

##Content Example 

![Related Links Content](images/Tags-Content.jpg?raw=true)

##MVC View Example

###Typed:

    @{
        if (Model.Content.HasValue("articleTags"))
        {
            <ul>
            @{ 
                String[] articleTags = Model.Content.GetPropertyValue<String>("articleTags").Split(','); 
                foreach (var item in articleTags)
                {                   
                    <li>@item</li>    
                } 
            }
            </ul>              
        }   
    }

###Dynamic: 

    @{
        if (CurrentPage.HasValue("articleTags")){
            <ul>
            @foreach (var tagItem in CurrentPage.articleTags.Split(','))
            {
                <li>@tagItem</li>
            }
            </ul>
        }   
    }     

##Razor Macro (DynamicNode) Example

	@{
	    if (Model.HasValue("articleTags")){
	        <ul>
	        @foreach (var tagItem in Model.articleTags.Split(','))
	        {
	            <li>@tagItem</li>
	        }
	        </ul>
	    } 
	}


##XSLT Macro Example

	<xsl:if test="string-length($currentPage/articleTags) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/articleTags,',')" />  
	  <ul>  
	  <xsl:for-each select="$items//value">
	    <li>
	      <xsl:value-of select="current()"/>
	    </li>
	  </xsl:for-each>
	  </ul>    
	</xsl:if>

##Tag Helper Library

The tag property editor comes with a helper library containing 7 public methods.

###Razor Macro (DynamicXml) Example

	@{
	    var rawTagXml = Tags.library.getAllTagsInGroup("News").Current.InnerXml;
	    var NewsGroupTags = new DynamicXml(rawTagXml);
	
	    if (NewsGroupTags.Any())
	    {
	        <ul>
	        @foreach (var tag in NewsGroupTags)
	        {
	            <li>@tag.InnerText</li>
	        }
	        </ul>
	    }      
	}

###XSLT Example

In /config/xsltExtensions.config add the following to register the library
`<ext assembly="umbraco.editorControls" type="umbraco.editorControls.tags.library" alias="TagsLib" />`

	<xsl:variable name="NewsGroupTags" select="TagsLib:getAllTagsInGroup('News')/tags"/>
	<xsl:if test="count($NewsGroupTags) > 0">  	
	  <ul>  
	    <xsl:for-each select="$NewsGroupTags/tag">
	      <li>
	        <xsl:value-of select="current()"/>
	      </li>
	    </xsl:for-each>
	  </ul>    
	</xsl:if>

##Further Resources

The [TagManager](http://our.umbraco.org/projects/developer-tools/tagmanager "TagManager Package") package can be very useful if you need to manage tags created by this property editor.
