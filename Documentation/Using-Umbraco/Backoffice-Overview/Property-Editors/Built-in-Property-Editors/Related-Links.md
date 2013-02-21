#Related Links

`Returns: Xml`

This datatype allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.

##Data Type Definition Example

![Related Links Data Type Definition](images/Related-Links-DataType.jpg?raw=true)

##Content Example 

![Related Links Content](images/Related-Links-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@using Umbraco.Core.Dynamics;
	@{
        if(Model.Content.HasValue("relatedLinks")){
            DynamicXml relatedLinks = Model.Content.GetPropertyValue<DynamicXml>("relatedLinks");
            if (relatedLinks.Any()){
                <ul>
                @foreach (dynamic item in relatedLinks)
                {                   
                    var linkUrl = (item.type.Equals("internal")) ? @Umbraco.NiceUrl(int.Parse(item.link)) : item.link;                                     
                    var linkTarget = (item.newwindow.Equals("1")) ? " target=\"_blank\"" : String.Empty;
                    <li><a href="@linkUrl"@Html.Raw(linkTarget)>@item.title</a></li>                    
                }  
                </ul>             
            }
        }   
    }

###Dynamic: 

	@{
		if(CurrentPage.HasValue("relatedLinks") && CurrentPage.relatedLinks.Any()){
        	<ul>
            @foreach (var item in CurrentPage.relatedLinks){
            	var linkUrl = (item.type.Equals("internal")) ? @Umbraco.NiceUrl(int.Parse(item.link)) : item.link;                                     
                var linkTarget = (item.newwindow.Equals("1")) ? " target=\"_blank\"" : String.Empty;
                <li><a href="@linkUrl"@Html.Raw(linkTarget)>@item.title</a></li>    
            }   
            </ul>            
        }   
	}       

##Razor Macro (DynamicXml) Example

	@{
	    if (Model.HasValue("relatedLinks") && Model.relatedLinks.Any()){
	        <ul>
	        @foreach (var item in Model.relatedLinks){
	            var linkUrl = (item.type.Equals("internal")) ? umbraco.library.NiceUrl(int.Parse(item.link)) : item.link;                                     
	            var linkTarget = (item.newwindow.Equals("1")) ? " target=\"_blank\"" : String.Empty;
	            <li><a href="@linkUrl"@Html.Raw(linkTarget)>@item.title</a></li>
	        }
	        </ul>       
		}    
	}


##XSLT Macro Example

	<xsl:if test="count($currentPage/relatedLinks/links/link) > 0">
	    <ul>
	        <xsl:for-each select="$currentPage/relatedLinks/links/link">
	            <li><a>
	            <xsl:choose>
	              <xsl:when test="./@type = 'internal'">
	                <xsl:attribute name="href">
	                  <xsl:value-of select="umbraco.library:NiceUrl(./@link)"/>
	                </xsl:attribute>
	              </xsl:when>
	              <xsl:otherwise>
	                <xsl:attribute name="href">
	                  <xsl:value-of select="./@link"/>
	                </xsl:attribute>
	              </xsl:otherwise>
	            </xsl:choose>
	            <xsl:if test="./@newwindow = '1'">
	              <xsl:attribute name="target">_blank</xsl:attribute>
	            </xsl:if>
	            <xsl:value-of select="./@title"/>
	            </a></li>
	        </xsl:for-each>
	    </ul>
	</xsl:if>