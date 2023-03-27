---
meta.Title: Creating Members in Umbraco
---

# Members

Members are used for registering and authenticating external users of an Umbraco installation (ie. forum members, intranet users and so forth).

This guide will explain how to define and create members in the backoffice. If you want to work with members using the service APIs, links can be found at the end of the document.

There is a default Member Type that can be used to create members. You can customize this to fit your needs or create your own Member Type from scratch.

## Creating a Member

Go to the **Members** section, right-click **Members** in the member tree, click **Create** and choose Member.

Members have a number of mandatory properties. So aside from filling out the name, you will need to fill out **Login**, **Email** and the two **Password fields** in the **Properties** group before a member can be saved.

There is also a number of default properties in the **Membership** group:

* `umbracoMemberComments`
* `umbracoMemberFailedPasswordAttempts`
* `umbracoMemberApproved`
* `umbracoMemberLockedOut`
* `umbracoMemberLastLockoutDate`
* `umbracoMemberLastLogin`
* `umbracoMemberLastPasswordChangeDate`

Once the Member is created and saved you can access it by expanding the Members tree and clicking **All Members** to get a list view. You can also view members of a specific type by selecting the member type in the Members tree.

## Creating a Member Type

You can create your own Member Types and add tabs, groups and properties as you would with Document Types.

Go to the **Settings** section, right-click **Member Types** and select **Create**. You will now be taken to the Member Type editor that is used to define and edit the Member Type. Name the new Member Type and click **Save**.

![Member Type Editor](images/Member-Type-Editor\_new.png)

You will see that the **Membership** group is added automatically to any Member Types you create. This group includes all the default Member Type properties listed above. The properties are locked, which means you cannot remove them, but you can still configure the settings for each property:

![Configure property settings](images/member-type-property-settings\_new.png)

It is possible to add more groups and more properties to each of the Member Types you create, as well as the default Member Type.

## Creating Member Groups

Member Groups define roles for your members that can be used for role-based protection. A member can be in multiple groups.

![Creating a Member Group](images/Member-group.png)

To create a new Member Group click the menu icon next to the **Member Groups** node in the Members section. Choose **Create**, name the group, and save the group.

### Assigning a Member Group

To assign a member to a specific group find the member you wish to assign and find the **Properties** group. Here you can see which groups the member is already part of, as well as add the member to more groups or remove the member from already assigned groups:

![Assigning a Member Group](images/assign-member-group.png)

## [Sensitive data](../../reference/security/sensitive-data-on-members.md)

You will have the option to mark member properties as sensitive. Sensitive properties on a members data will not be displayed to backoffice users unless they have appropriate permissions.

More information can be found under [security](../../reference/security/sensitive-data-on-members.md).

## Technical

As a developer you are able to leverage your website when you build on the Members section of Umbraco. Although the Members section is by default in the Umbraco backoffice, you will be able to implement some work on the front end of your website. Members are created using ASP.NET Core Identity, there are some provider settings that can be set in appsettings.json - here are the defaults:

```json
{
  "$schema": "./umbraco/config/appsettings-schema.json",  
  "Umbraco": {
    "CMS": {      
      "Security": {
        "AllowPasswordReset": true,
        "AuthCookieDomain": "(No default, but takes a string)",
        "AuthCookieName": "UMB_UCONTEXT",
        "KeepUserLoggedIn": false,
        "UsernameIsEmail": true,
        "HideDisabledUsersInBackoffice": false,
        "AllowedUserNameCharacters": "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+\\",
        "MemberPassword": {
          "RequiredLength": 10,
          "RequireNonLetterOrDigit": false,
          "RequireDigit": false,
          "RequireLowercase": false,
          "RequireUppercase": false,
          "MaxFailedAccessAttemptsBeforeLockout": 5,
          "HashAlgorithmType": "HMACSHA256"
        }
      }
    }
  }
}
```

You can find out more about the services methods in the reference section of the documentation by following the links below.

### More information

* [Customizing Data Types](data-types/)

### Related Services

* [MemberService](../../reference/management/services/memberservice.md)
* [MemberType Service](../../reference/management/services/membertypeservice.md)
* [MemberGroup Service](../../reference/management/services/membergroupservice.md)

### Video tutorials

{% embed url="https://www.youtube.com/playlist?ab_channel=UmbracoLearningBase&list=PLgX62vUaGZsHYlNtXGSolK5_Tg0AMkQBA" %}
Playlist: Members in Umbraco
{% endembed %}
