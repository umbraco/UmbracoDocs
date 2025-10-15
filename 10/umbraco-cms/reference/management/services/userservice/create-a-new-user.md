---
description: "This will show you how to create a new user using the UserService in Umbraco."
---

# Creating a user

If you want to create a new user, you'd use ASP.NET identity APIs like it is used in core.

### Assigning the user to a user group

Permissions aren't administered for the specific user, but rather for the user group(s) that the user is a part of. So to add our new user to a user group, we first need to get a reference to the user via the `GetUserGroupByAlias` method, and then use the `AddGroup` method for adding the group to our user:

```csharp
// Get a reference to the default "Administrators" user group
UserGroup adminUserGroup = (UserGroup) us.GetUserGroupByAlias("admin");

// Add the user to the user group
user.AddGroup(adminUserGroup);
```

To make sure that these changed are saved to the database, we must also make sure to call the `Save` method. The `GetUserGroupByAlias` method takes the alias of a user group - eg. `admin` for the default **Administrators** user group.
