#Users, User types and permissions

## [Umbraco Membership provider](../MembershipProviders/index.md)

The Users are base on the asp.net membership provider.

## Create a login
If you use Webforms as render engine, you can use <asp:Login> (and related) controls to let the user login or logout.  You can interfere with the login control to [check a specific user property](logging-in-with-extra-check.md), if you want to.

##Create a new user

<!-- original from http://our.umbraco.org/wiki/reference/api-cheatsheet/users,-user-types-and-permissions -->

Users are profiles for writers, translators, editors and administrators with access to the either the back-end or canvas.

Add references to the following namespace at the top of your .cs file

    using umbraco.BusinessLogic;

Create a new user and allow access to the settings section

    //set the right user type ID (available in usertype tree in the backend)
    UserType ut = UserType.GetUserType(2);
    User.MakeNew("John Smith", "johnsmith", hashedpassword, ut);
    
    //Get the user from ID or login
    User u = new User("johnsmith");
    
    //Add email if required
    u.Email = "email@email.com";
    
    //Allow access to umbraco section
    u.addApplication("settings");
    u.Save(); 

More information about [password hashing](add-user-with-hashed-password.md).

##Managing UserTypes

User types are used for specifying a default set of permissions. 

For instance; a writer, by default, has access to the following actions: Create, Update, Edit In Canvas, Send to Publish.

Creating a new Usertype with the name "Censors"
 
    UserType ut = UserType.MakeNew("Censors","CAD", "censors");
    ut.Save();

The above sample sets the default permissions to "CAD". Each permission type is defined by a single character, so setting permissions to "CAD" would assign "Create", "Update" and "Delete" permissions for that user type.

The list below shows what permissions are available by default and their corresponding letter:

    F - Browse Name
    :  - Edit in Canvas
    C - Create
    5 - Send to translation
    4 - Translate
    Z - Audit Trail
    D - Delete
    M - Move
    O - Copy
    S - Sort
    R - Permissions
    P - Public Access
    K - Rollback
    A - Update
    U - Publish
    H - Send To Publish
    I - Manage Hostname