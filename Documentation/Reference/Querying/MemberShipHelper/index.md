#Membershiphelper

_MembershipHelper is a general helper class for access asp.net membership data, as well as Umbraco Member data, which are stored in a format similiar to Umbraco content and media_

`MembershipHelper` also has a variety of helper methods that are useful when working in your views, controllers and webforms classes.

`MembershipHelper` is also available from within [Partial View Macros](../../Templating/Macros/Partial-View-Macros/index.md) which is why Partial View Macros are the recommended macro format (which work in both MVC and WebForms).

##How to reference MembershipHelper?
When working in templating, this helper will automatically be there for you to use as `@Members` which means you conveniently in your templates easily can access member data:

	@Members.IsLoggedIn();
	@Members.GetCurrentMemberProfileModel();

If you need a `MembershipHelper` in a custom class, service, view, etc... you can easily create one using this syntax:

	var memberShipHelper = new Umbraco.Web.Security.MembershipHelper(Umbraco.Web.UmbracoContext.Current);

##ProfileModel and IPublishedContent 
When looking up Members, member data is returned as `IPublishedContent`, which is the same format used for Content and Media, so referencing member properties should
be the exact same api as with those.

When looking at the currently logged in Member, you will get a `ProfileModel` back, which contains the same data, by with additional methods and properties available
which are specific to members.


###.GetByEmail(string email)
Looks for a member with a given email, If found, returns a member profile as `IPublishedContent`

###.GetById(int id)
Looks for a member withe a given node ID, If found, returns a member profile as `IPublishedContent`

###.GetByProviderKey(object key)
looks for a member with a given provider key, If found, returns a member profile as `IPublishedContent`. Provider key, is the key, that
the membership provider responsible for the member has assigned the member as its primary key. 
Umbraco's default membership provider assigns a guid, alternative providers such as active directive likely uses another format.

###.GetByUsername(string username)
Looks for a member withe a given username, If found, returns a member profile as `IPublishedContent`

###.GetCurrentLoginStatus()
Gets the current members login status as a `LoginStatusModel`


###.GetCurrentMemberProfileModel()
Gets the current member profile as a `ProfileModel`


###.IsLoggedIn()
Returns a boolean whether there is a Member currently logged in.

###.Login(string username, string password)
Attempts to log in a member with the given username and password

###.IsMemberAuthorized(params)
Determines if a member is authorized, based on memberType, associated roles, and member ID.

###.IsUmbracoMembershipProviderActive()
Detects if the default Umbraco membership provider is in use.

###.RegisterMember(RegisterModel model)
Registers a new Member

###.UpdateMemberProfile(ProfileModel model)
Updates a current member profile

