---
description: >-
  Members are used for registering and authentication external / frontend users
  of an Umbraco installation. This could be Forum members and Intranet members.
---

# Members

Members are used for registering and authenticating external users of an Umbraco installation (ie. forum members, intranet users and so forth).

This guide will explain how to define and create members in the backoffice. If you want to work with members using the service APIs, links can be found at the end of the document.

There is a default Member Type that can be used to create members. You can customize this to fit your needs or create your own Member Type from scratch.

## Creating a Member

Go to the **Members** section and click **Create**.

Members have a number of mandatory properties that need to be filled in before a member can be saved. Some of the properties are **Username**, **Email**, two **Password fields** and so on.

There are also a number of default properties which are stored in the database in the tables `Member` and`TwoFactorLogin`:

* `umbracoMemberFailedPasswordAttempts`
* `umbracoMemberApproved`
* `umbracoMemberLockedOut`
* `umbracoTwoFactorLogin`
* `umbracoMemberLastLockoutDate`
* `umbracoMemberLastLogin`
* `umbracoMemberLastPasswordChangeDate`

Once the Member is created and saved you can access it by expanding the Members tree and clicking **All Members** to get a collection. You can also view members of a specific type by selecting the member type in the Members tree.

## [Sensitive data](../../reference/security/sensitive-data-on-members.md)

Sensitive properties on a members data will not be displayed to backoffice users unless they have appropriate permissions. In order to see the values of the default properties in the **Member** tab you need to have the Sensitive data User Group. By having this group added to a user they will also have the option to mark member type properties as sensitive.

More information can be found under [security](../../reference/security/sensitive-data-on-members.md).

## Creating a Member Type

You can create your own Member Types and add tabs, groups and properties as you would with Document Types.

Go to the **Settings** section, click **...** next to **Member Types** and select **Create**. You will now be taken to the Member Type editor that is used to define and edit the Member Type. Name the new Member Type and click **Save**.

![Member Type Editor](images/member-type-composition.PNG)

Once created, the Member Type will have no properties, so you have the freedom to add your own properties or compositions.

### Assigning a Member Composition

When creating a Member Type you can assign compositions. Compositions allow you to inherit tabs and properties from existing member types instead of creating them from scratch.

For example on the member type that you have created, click on **Composition**. Then you can choose the existing **Member** type which then you will inherit its tabs, groups, and properties.

<figure><img src="images/member-type-composition-setting.PNG" alt=""><figcaption><p>Composition Member Type</p></figcaption></figure>

The default **Member** type has a **Membership** group which includes `umbracoMemberComments` property along with the other default properties. The other properties can be seen only in the **Member** tab when creating a member.

It is possible to add more groups and more properties to each of the Member Types you create, as well as the default Member Type.

## Creating Member Groups

Member Groups define roles for your members that can be used for role-based protection. A member can be in multiple groups.

![Creating a Member Group](images/Member-group1.PNG)

To create a new Member Group click the menu icon next to the **Member Groups** node in the Members section. Choose **Create**, name the group, and save the group.

### Assigning a Member Group

To assign a member to a specific group find the member you wish to assign and find the **Properties** group. Here you can see which groups the member is already part of. You can also add the member to more groups or remove the member from already assigned groups:

![Assigning a Member Group](images/assign-member-group1.PNG)

## Technical

As a developer you are able to leverage your website when you build on the Members section of Umbraco. The member's section is by default in the Umbraco backoffice, but you can still use it to implement some work on your front end. Members are created using ASP.NET Core Identity, so there are some provider settings that can be set in appsettings.json - here are the defaults:

```json
{
  "$schema": "appsettings-schema.json",  
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

## References

* Video: [Adding a member](https://www.youtube.com/watch?v=gdvfrqQcAGY)
* Video: [Member Type Properties](https://www.youtube.com/watch?v=E_es3x_H5oU)
* Video: [Role-Based Protection](https://www.youtube.com/watch?v=wVR9OBnaNZQ)

### Related Services

* [MemberService](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Services.MemberService.html)
* [MemberType Service](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Services.MemberTypeService.html)
* [MemberGroup Service](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Services.IMemberGroupService.html)
