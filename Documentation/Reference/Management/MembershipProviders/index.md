#Membership providers

<!-- original from http://our.umbraco.org/wiki/how-tos/membership-providers -->

## Overview

Umbraco 4 changed the Umbraco membership model to use the ASP.NET Membership Provider model, meaning that all the abstract classes which are provided Out-Of-The-Box with ASP.NET are capable of accessing the Umbraco Member. There's plenty of good resources on MSDN (and other sites) for using ASP.NET Membership, a suggested starting point is here.

Umbraco 4.1 takes this a step further as most of the methods on the umbraco.cms.businesslogic.member.Member class (and MemberGroup class) are obsoleted to direct people into the ASP.NET Membership Provider model.

##Common Tasks
###Checking if someone is logged in
http://msdn.microsoft.com/en-us/library/system.security.principal.iidentity.isauthenticated.aspx

    bool isSomeoneLoggedIn = System.Web.HttpContext.Current.User.Identity.IsAuthenticated; 
###Accessing the current logged in Member
http://msdn.microsoft.com/en-us/library/system.web.security.membership.getuser.aspx

    var member = System.Web.Security.Membership.GetUser(); 
###Changing the Member Password
http://msdn.microsoft.com/en-us/library/system.web.security.membershipuser.changepassword.aspx

    var member = System.Web.Security.Membership.GetUser();
    member.ChangePassword(member.GetPassword(), "new-password"); 

Note: If passwordFormat="Hashed" and/or enablePasswordRetrieval="false" you will need to use ResetPassword() instead of GetPassword(). EnablePasswordReset must be set to "true":

    member.ChangePassword(member.ResetPassword(), "new-password"); 
If  RequiresQuestionAndAnswer="true" you will need to supply the answer as a parameter for both GetPassword and ResetPassword or a NotSupportedException will be thrown.

### Creating a new Member
http://msdn.microsoft.com/en-us/library/system.web.security.membership.createuser.aspx

    var member = System.Web.Security.Membership.CreateUser("username", "password"); //there are overloads if you want to provide emails and such 
###Access Roles (groups) for Current Member
http://msdn.microsoft.com/en-us/library/system.web.security.roles.getrolesforuser.aspx

    var roles = System.Web.Security.Roles.GetRolesForUser();  
###Added a Role to the Current Member
http://msdn.microsoft.com/en-us/library/system.web.security.roles.addusertorole.aspx

    System.Web.Security.Roles.AddUserToRole(System.Web.Security.Membership.GetUser().UserName, "new-role"); 
###Creating a new Role
http://msdn.microsoft.com/en-us/library/system.web.security.roles.createrole.aspx

    var role = System.Web.Security.Roles.CreateRole("new-role");
###Check if a user belongs to a Role
bool Roles.IsUserInRole(string roleName)
###Finding Members by their Email
http://msdn.microsoft.com/en-us/library/system.web.security.membership.findusersbyemail.aspx

    var members = System.Web.Security.Membership.FindUsersByEmail("email@example.com"); 
###Creating a Profile
msdn.microsoft.com/en-us/library/ms151825.aspx

    var profile = ProfileBase.Create(memberData.UserName); 
###Setting a Profile Property
http://msdn.microsoft.com/en-us/library/system.web.profile.profilebase.item.aspx

    profile["myCustomPropertyAlias"] = "some value";
    profile.Save();

Note: You must also define these properties in the web.config before you can address them in code

    <profile defaultProvider="UmbracoMemberProfileProvider" enabled="true">
      <providers>
        <clear />
        <add name="UmbracoMemberProfileProvider" type="umbraco.providers.members.UmbracoProfileProvider, umbraco.providers" />
      </providers>
      <properties>
        <clear />
        <add name="myCustomPropertyAlias" allowAnonymous="false" provider="UmbracoMemberProfileProvider" type="System.String" />
      </properties>
    </profile>