#Umbraco Api - Authorization

**Applies to: Umbraco 6.1.0+**	

_This section will describe how to secure your Umbraco Api controllers based on a users membership_ 

##Using MemberAuthorizeAttribute

The easiest way to secure your controllers and actions is to use the attribute: `Umbraco.Web.WebApi.MemberAuthorizeAttribute`. 

*It's important to note the namespace since we have another class called MemberAuthorizeAttribute in a different namespace that is used for MVC.*

There are 4 parameters that can be supplied to control how the authorization works:

	//Flag for whether to allow all site visitors or just authenticated members
	//This is the same as applying the [AllowAnonymous] attribute
	bool AllowAll

	//Comma delimited list of allowed member types
	string AllowType

	//Comma delimited list of allowed member groups
	string AllowGroup

	//Comma delimited list of allowed member Ids
	string AllowMembers

You can apply the attribute at the controller level or at the action level. 

**Examples:**

This will only allow logged in members of type "Retailers" to access the GetAllProducts action:

	public class LocalApiController : UmbracoApiController
	{
	    [Umbraco.Web.WebApi.MemberAuthorize(AllowType = "Retailers")]
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}

This will only allow member's with Ids 1, 10 and 20 to access any actions on the controller:

	[Umbraco.Web.WebApi.MemberAuthorize(AllowMembers = "1,10,20")]
	public class LocalApiController : UmbracoApiController
	{	    
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}