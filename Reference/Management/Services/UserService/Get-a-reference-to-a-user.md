# Get a reference to a user

### Getting a single user
The user service contains a number of methods for looking up users. If you already know the ID of a user (eg. the root user has ID `0`), you can use the `GetUserById` method to get the reference to that user:

    // Get a reference to the user by an ID
    IUser user1 = us.GetUserById(0);
    
Alternative, you can look up a user by a username or email address instead:

    // Get a reference to the user by a username (which typically also will be the user's email address)
    IUser user2 = us.GetByUsername("john-doe@xample.org");

    // Get a reference to the user by an email address
    IUser user3 = us.GetByEmail("john-doe@xample.org");

The username of a user will typically also be the email address of the user. Historically this has been optional, but the default configuration of new Umbraco installations will use the email address as the username.

### Getting multiple users
In addition to just getting a single user, the user service also contains a `GetUsersById` method for getting multiple users at once:

    // Get multiple users at once by their IDs
    foreach (IUser user in us.GetUsersById(0, 1, 2)) {
        <pre>@user.Email</pre>
    }
    
## Full example

    @using Umbraco.Core.Models.Membership
    @using Umbraco.Core.Services
    @inherits UmbracoViewPage

    @{

        // Get a reference to the user service
        IUserService us = ApplicationContext.Current.Services.UserService;

        // Get a reference to the user by an ID
        IUser user1 = us.GetUserById(0);

        // Get a reference to the user by a username (which typically also will be the user's email address)
        IUser user2 = us.GetByUsername("john-doe@xample.org");

        // Get a reference to the user by an email address
        IUser user3 = us.GetByEmail("john-doe@xample.org");

        // Get multiple users at once by their IDs
        foreach (IUser user in us.GetUsersById(0, 1, 2)) {
            <pre>@user.Email</pre>
        }

    }
