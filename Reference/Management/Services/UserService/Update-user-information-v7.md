---
versionFrom: 7.0.0
---

# Update user information

### Getting the user
With the user service, we can programatically update the information of a backoffice user. We first need to get a reference to the user, which we can do in a few different ways - eg. by an email address:

```csharp
IUser user = us.GetByEmail("john-doe@xample.org");
```

You can see the [**Get a reference to a user** page](Get-a-reference-to-a-user.md) for other ways of looking up a user.

### Updating user properties
Once you have a reference to a user, we can start updating its properties - e.g. setting the name:

```csharp
// Set the name of the user
user.Name = "John Doe";
```

By setting the property, we only modify the user in memory, so we also need to call the `Save` method as well to persist the change to the database.

#### Setting the user avatar
Similar to the name, we can also set the avatar of the user. By default, Umbraco will use the Gravatar image based on the user's email address. You can however set a custom avatar instead.

If you upload a custom avatar through the backoffice, Umbraco will set a value like `UserAvatars/6708a49022a712eb7624c7b8aab811370526744b.jpg`. The virtual path of this file will then be `~/media/UserAvatars/6708a49022a712eb7624c7b8aab811370526744b.jpg`. To set the avatar the same way as Umbraco, you can then update the `Avatar` property with a value like (you must manually upload the avatar to the folder):

```csharp
// Set the avatar
user.Avatar = "UserAvatars/6708a49022a712eb7624c7b8aab811370526744b.jpg";
```

## Full example

```csharp
@using Umbraco.Core.Models.Membership
@using Umbraco.Core.Services
@inherits UmbracoViewPage

@{

	// Get a reference to the user service
	IUserService us = ApplicationContext.Services.UserService;

	// Get a reference to the user
	IUser user = us.GetByEmail("john-doe@xample.org");

	// Set the name of the user
	user.Name = "John Doe";

	// Set the avatar
	user.Avatar = "UserAvatars/6708a49022a712eb7624c7b8aab811370526744b.jpg";

	// Make sure to call "Save" so the changes is persisted to the database
	us.Save(user);

}
```
