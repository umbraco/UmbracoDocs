---
description: How to secure access to Umbraco Forms data and functionality.
---

# Security

Umbraco Forms has a backoffice security model integrated with Umbraco users. Details are managed in the _Users_ section of the backoffice, within a tree named _Form Security_.

## User based permissions

Within the _Form Security_ tree, each user with a backoffice account is listed. Clicking on a user allows each functional permission to be set:

* _Manage forms_ - user can create and edit form definitions
* _View entries_ - user can view the submitted entries
* _Edit entries_ - user can edit the submitted entries
* _Manage datasources_ - user can create and edit datasource definitions
* _Manage prevalue sources_ - user can create and edit prevalue source definitions

For further control, each form is listed and the user can be granted or denied access to each as appropriate.

As new forms are created, users will automatically be granted access to them, unless the configuration setting `DefaultUserAccessToNewForms` has been set to a value of `Deny`.

## Start folders

When form definitions are configured for storage in the database, it allows for the creation of folders to group forms within. It's also possible to define one or more start folders for a user, in order to limit their access to a sub-set of the forms available.

If no start folders are selected, the user will be able to access all forms in the backoffice according to their permissions.

If a single start folder is selected, that will act as the root of the tree view of forms. The user will have access to all folders and forms below that selected folder.

If more than one start folder is selected, they will appear underneath the root of the tree view of forms. The user will have access to only those folders and their descendant folders and forms.

![Start folders](../../../10/umbraco-forms/developer/images/user-start-folders.png)

## User group based permissions

A new model was introduced allowing for the management of permissions at the level of user groups. Particularly for installations with a large number of users, we expect this to be a more useful setup and require less ongoing administration.

When user groups are involved in permissions, access to a particular resource or feature is determined by the following:

* If the user has a specific user permission set, it is used in preference to anything set on the user groups they are a part of.
* If the user doesn't have a specific user permission set, they are granted access if at least one of the user groups they are part of has access.

To enable the feature, it's necessary to update the `ManageSecurityWithUserGroups` configuration setting to `true`.

With that in place the _Form Security_ tree divides into three sub-trees:

* Under _Group Permissions_, each user group is listed and the same settings as described above for individual users can be set here.
* Under _User Permissions_, each user that has a specific user permission record is listed and can be managed. Records for users can be created or deleted via the tree's action menu.

As new forms are created, user groups with aliases listed in the `GrantAccessToNewFormsForUserGroups` configuration setting will be automatically given access. For example, with a value of `admin, editor`, the built-in Administrators and Editors groups would have access.

### Start folders for user groups

Start folders are enabled for User Groups. They work in a similar way as the group based permissions described above:

* If the user has a specific user permission set, it is used in preference to anything set on the user groups they are a part of.
  * This means if the user has no start folders defined and the groups they are part of do, they will have access to the root of the Forms tree and be able to access all folders and Forms.
* If the user doesn't have a specific user permission set, they are granted access to all the unique folders the groups they are part of have access to.
  * If they are part of any group that has access to the forms section, permission to manage forms and no start folders defined, they will have access to the root of the Forms tree and be able to access all folders and Forms.

### Migrating to user group based permissions

In introducing the user group based permissions we've taken care to ensure a migration path is available for those existing installations running on older versions of Umbraco Forms. In that situation, we'd recommend the following approach.

* Upgrade to Umbraco 9.3.
* At this stage nothing will have changed in terms of the permissions model in use.
* Set the `ManageSecurityWithUserGroups` configuration value to `true` and the `GrantAccessToNewFormsForUserGroups` as appropriate for your setup.
* Via the _Users > Form Security_ section, set the required permissions on each user group.
* Again at this point nothing will have changed with regard the effective permissions for each user, as they will currently all have an existing user permission record.
* Via _Users > Form Security > User permissions_, delete the permission records for each user.
* The effective permissions for each user will now be derived from their user groups.
* If you have any exceptions - where a particular user needs a particular combination of permissions that you can't or don't want to provide via the user groups - it's always possible to re-create a user permission record that will take precedence over the group based permissions.

![User group permissions](../../../10/umbraco-forms/developer/images/user-group-permissions.png)
