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

##Razor (DynamicNode) Example

	@if (Model.HasValue("pageContact"))
	{
	    var member = new umbraco.cms.businesslogic.member.Member(Model.pageContact);
	    //built in properties
		var nodeName = member.Text;   
	    var userName = member.LoginName;
	    var email = member.Email;
		//custom property
		var twitter = member.getProperty("twitter").Value;
	
	    <text>Name: </text> @nodeName 
	    <text>Username: </text> @userName<br />
	    <text>Email: </text> @email<br />	
	    <text>Twitter : </text> @twitter  
	}

##Razor (uQuery) Example

	@{
	  var member = uQuery.GetMember(uQuery.GetCurrentNode().GetProperty<int>("pageContact"));
	    if (member != null)
	      {
	        <text>Name: </text>@member.Text<br/>
	        <text>Username: </text>@member.LoginName<br/>
	        <text>Email: </text>@member.Email<br/>
	        <text>Twitter: </text>@(member.GetProperty<string>("twitter"))
	      }
	}
