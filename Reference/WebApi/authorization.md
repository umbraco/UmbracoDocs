#Umbraco Api - Authorization

**Applies to: Umbraco 6.1.0+**	

_This section will describe how to secure your Umbraco Api controllers based on a users membership_ 

##Authorizing for the back office

###Inheriting from UmbracoAuthorizedApiController

Probably the easiest way to ensure your controller is secured for only back office users is to inherit from `Umbraco.Web.WebApi.UmbracoAuthorizedApiController`. This is essentially the same as applying the `UmbracoAuthorizeAttribute` to your controller (see below). We also expose the Umbraco user property `User UmbracoUser {get;}` on this base controller as well.

###Using UmbracoAuthorizeAttribute

To secure your controller based on back offce membership use the attribute: `Umbraco.Web.WebApi.UmbracoAuthorizeAttribute`. 

*It's important to note the namespace since we have another class called UmbracoAuthorizeAttribute in a different namespace that is used for MVC.*

This attribute has no parameters it simply ensures that a valid back office user is logged in.

**Examples:**

This will only allow a logged in back office user to to access the GetAllProducts action:

	public class ProductsApiController : UmbracoApiController
	{
	    [Umbraco.Web.WebApi.UmbracoAuthorize]
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}

##Using MemberAuthorizeAttribute

To secure your controller based on front-end membership use the attribute: `Umbraco.Web.WebApi.MemberAuthorizeAttribute`. 

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

	public class ProductsApiController : UmbracoApiController
	{
	    [Umbraco.Web.WebApi.MemberAuthorize(AllowType = "Retailers")]
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}

This will only allow member's with Ids 1, 10 and 20 to access any actions on the controller:

	[Umbraco.Web.WebApi.MemberAuthorize(AllowMembers = "1,10,20")]
	public class ProductsApiController : UmbracoApiController
	{	    
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}