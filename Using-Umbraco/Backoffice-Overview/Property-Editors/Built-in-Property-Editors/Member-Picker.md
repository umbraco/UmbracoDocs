#Member Picker

`Returns: Member ID`

Displays a simple select dropdown with all available members. A single member can be selected. The value saved is the member ID.

##Data Type Definition Example

![Media Picker Data Type Definition](images/Member-Picker-DataType.jpg?raw=true)

##Content Example 

![Memebr Picker Content](images/Member-Picker-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="number($currentPage/pageContact) > 0">  
	  <xsl:variable name="member" select="umbraco.library:GetMember($currentPage/pageContact)/node" />
	  <p>
	    Name: <xsl:value-of select="$member/@nodeName" /><br />
	    Login Name:<xsl:value-of select="$member/@loginName" /><br />
	    Email:<xsl:value-of select="$member/@email" />  
	  </p>
	</xsl:if>

##Razor (DynamicNode & Members API) Example

	@{
	  if (Model.HasValue("pageContact"))
	  {
	    var member = new umbraco.cms.businesslogic.member.Member(Model.pageContact);  
	    //member properties
	    <text>Name: </text>  @member.Text
	    <text>Username: </text> @member.LoginName<br />
	    <text>Email: </text> @member.Email<br />  
	    //custom properties
	    <text>Twitter : </text> @member.getProperty("twitter").Value
	  }
	}

##Razor (uQuery) Example

	@{
		var member = uQuery.GetMember(uQuery.GetCurrentNode().GetProperty<int>("pageContact"));
	    if (member != null)
	    {
	    	//member properties
	        <text>Name: </text>@member.Text<br/>
	        <text>Username: </text>@member.LoginName<br/>
	        <text>Email: </text>@member.Email<br/>
	        //custom properties
	        <text>Twitter: </text>@(member.GetProperty<string>("twitter"))
	     }
	}
