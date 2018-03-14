# Create a new user

The document illustrates how you can create a new backoffice user from a Razor view. 


### Getting a reference to the UserService
The first step is to get a reference to the `UserService`. This is useful, as we're using in multiple times, and therefore doesn't have to reference it through `ApplicationContext.Services.UserService` each time:

    // Get a reference to the user service
    IUserService us = ApplicationContext.Services.UserService;
    
If you're using something else than a Razor view, the approach for accessing the user service may be a little different. You can see the [parent page](./) for more examples.
    
### Creating the user
With the reference in place, we can now create the user:

    // Creates a new user
    IUser user = us.CreateUserWithIdentity("john-doe@xample.org", "john-doe@xample.org");
    
The `CreateUserWithIdentity` method takes two parameters - `username` and `email`. However in newer versions of Umbraco, it's considered best practice to also use the email address as the username. Calling `CreateUserWithIdentity` will create the user in the database, so it is not necessary to call the `Save` method for this (unless you further update the user as shown below).

### Setting a password
So far we have created the user, but we haven't yet set a password. We can do this through the `SavePassword` method, and Umbraco will then handle all the necessary password hashing for us:

    // Set a new password for the user
    us.SavePassword(user, "HelloWorld1234");
    
However in new Umbraco installations, the default user provider configuration (the `allowManuallyChangingPassword` setting is `false` by default) prevents us from setting a new password throug code. If we try to set a password anyways, the method will throw an exception of the type `System.NotSupportedException`, and with the following message:

> This provider does not support manually changing the password

In a similar way, if we try to set a password that isn't valid to the password requirements (eg. a minimum length of 10 characters), an exception of the type `System.Web.Security.MembershipPasswordException` will be thrown with the following message:

> Change password canceled due to password validation failure.

### Assigning the user to a user group
As of Umbraco 7.7 permissions aren't administered for the specific user group, but rather for the user group(s) that the user is a part of. So to add our new user to a user group, we first need to get a reference to the user via the `GetUserGroupByAlias` method, and then use the `AddGroup` method for adding the group to our user:

    // Get a reference to the default "Administrators" user group
    UserGroup adminUserGroup = (UserGroup) us.GetUserGroupByAlias("admin");

    // Add the user to the user group
    user.AddGroup(adminUserGroup);
    
To make sure that these changed are saved to the database, we must also make sure to call the `Save` method. The `GetUserGroupByAlias` method takes the alias of a user group - eg. `admin` for the default **Administrators** user group.

### Updating the user information
With the `CreateUserWithIdentity` method, we only specified the username and email address for the user, but not more information like the name of the user.

With the `IUser` instance we received from the `CreateUserWithIdentity` method, we can set the name of the user (as well as other desired information):

    // Set the name of the user
    user.Name = "John Doe";

Again, to make sure the changes are persisted to the database, we need to call the `Save` method.


## Full example

    @using Umbraco.Core.Models.Membership
    @using Umbraco.Core.Services
    @inherits UmbracoViewPage

    @{
    
        // Get a reference to the user service
        IUserService us = ApplicationContext.Services.UserService;
    
        // Creates a new user
        IUser user = us.CreateUserWithIdentity("john-doe@xample.org", "john-doe@xample.org");

        // Set a new password for the user
        us.SavePassword(user, "HelloWorld1234");

        // Get a reference to the default "Administrators" user group
        UserGroup adminUserGroup = (UserGroup) us.GetUserGroupByAlias("admin");

        // Add the user to the user group
        user.AddGroup(adminUserGroup);

        // Set the name of the user
        user.Name = "John Doe";

        // Make sure to call "Save" so the changes is persisted to the database
        us.Save(user);

    }
