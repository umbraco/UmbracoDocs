#Add User with hashed password
<!-- original from http://our.umbraco.org/wiki/reference/api-cheatsheet/users,-user-types-and-permissions/add-user-with-hashed-password -->

If you are using hashed passwords (default in Umbraco 4 and above) you must hash the password when adding a user via the Api

Add references to the following namespace at the top of your .cs file

    //Used to hash password
    using System.Security.Cryptography;
    using System.Text;
    
    //Used to add user
    using umbraco.BusinessLogic;

##Hash Password Function
  
The password is hashed with SHA1 and Base64 encoded before it is stored.  You can use the following function to create a new password hash. 
  
    string hashPassword(string password)
    {
	    HMACSHA1 hash = new HMACSHA1();
	    hash.Key = Encoding.Unicode.GetBytes(password);
	    
	    string encodedPassword =Convert.ToBase64String(hash.ComputeHash(Encoding.Unicode.GetBytes(password)));
	    return encodedPassword;
    }

###Create a new user with hashed password 

    //Add a user with hashed password, set the right user type ID (available in usertype tree in the backend)
    User u = User.MakeNew("Name", "username", hashPassword("password"), umbraco.BusinessLogic.UserType.GetUserType(2));
    
    //Add email if required
    u.Email = "email@emailcode.com";
    
    //Allow access to the Umbraco sections you want for this user
    u.addApplication("content");
    u.addApplication("media");
    u.addApplication("users");
    u.addApplication("settings");
    u.addApplication("developer");
    u.addApplication("member");
    
    u.Save(); //The new user id will be available as u.Id