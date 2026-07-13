---
description: How to secure access to Umbraco Forms data and functionality.
---

# Security

Umbraco Forms has a backoffice security model integrated with Umbraco users. Details are managed in the _Forms_ section of the backoffice, within a tree named _Security_.

## User-based permissions

Within the _Forms_ > _Security_ tree, each user with a backoffice account is listed. Clicking on a user allows each functional permission to be set:

* Manage Forms - user can create and edit form definitions
* View Entries - user can view the submitted entries
* Edit Entries - user can edit the submitted entries
* Delete entries - user can delete the submitted entries
* Manage Workflows - user can create and edit workflow items
* Manage Datasources - user can create and edit datasource definitions
* Manage Prevalue Sources - user can create and edit prevalue source definitions

For further control, each form is listed and the user can be granted or denied access to each as appropriate.

As new forms are created, users will automatically be granted access to them, unless the configuration setting `DefaultUserAccessToNewForms` has been set to a value of `Deny`.

## Start Folders

When form definitions are configured for storage in the database, it allows for the creation of folders to group forms within. It's also possible to define one or more start folders for a user. This is done in order to limit their access to a subset of the forms available.

If no start folders are selected, the user will be able to access all forms in the backoffice according to their permissions.

If a single start folder is selected, that will act as the root of the tree view of forms. The user will have access to all folders and forms below that selected folder.

If more than one start folder is selected, they will appear underneath the root of the tree view of forms. The user will have access to only those folders and their descendant folders and forms.

![Start folders](../.gitbook/assets/user-start-folders-v14.png)

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

### Migrating to user group-based permissions

In introducing the user group based permissions, we've taken care to ensure a migration path. This is available for those existing installations running on older versions of Umbraco Forms. In that situation, we'd recommend the following approach.

* Upgrade to Umbraco 9.3.
* At this stage nothing will have changed in terms of the permissions model in use.
* Set the `ManageSecurityWithUserGroups` configuration value to `true` and the `GrantAccessToNewFormsForUserGroups` as appropriate for your setup.
* Via the _Users > Form Security_ section, set the required permissions on each user group.
* Again at this point nothing will have changed with regard the effective permissions for each user, as they will currently all have an existing user permission record.
* Via _Users > Form Security > User permissions_, delete the permission records for each user.
* The effective permissions for each user will now be derived from their user groups.
* If you have any exceptions - where a particular user needs a particular combination of permissions that you can't or don't want to provide via the user groups - it's always possible to re-create a user permission record that will take precedence over the group based permissions.

![User group permissions](../.gitbook/assets/user-group-permissions.png)

## Handling Sensitive Data in Umbraco Forms

Marking fields and properties as sensitive will hide the data in those fields for backoffice users that are not privy to the data. Built-in features are available to help you secure sensitive information. For more information, see the [Sensitive data](https://docs.umbraco.com/umbraco-cms/reference/security/sensitive-data-on-members) article.

The following sections covers how to grant or deny access to sensitive data for specific users and how to mark form questions as sensitive.

### Assigning Users to the Sensitive Data Group

To allow users to view and handle sensitive data in Umbraco Forms, you must assign them to the _Sensitive Data_ user group:

1. Navigate to the **Users** section in the Umbraco Backoffice.
2. Select the user you want to grant access to.
3. Click **Choose** in the Groups field under the **Assign access** section.
4. Select **Sensitive Data** from the list of User Groups.
5. Click **Submit**.
6. Click **Save**.

![Assigning Users to the Sensitive Data Group](../.gitbook/assets/assign-sensitive-data-to-user.png)

### Marking Questions in Forms as Sensitive

Once the users are set up with the appropriate permissions, the next step is to identify which form fields should be marked as sensitive.

Marking a field as sensitive ensures that only authorized users in the Sensitive Data user group can access data from these fields.

To mark questions as sensitive, follow these steps:

1. Navigate to the **Forms** section in the Umbraco Backoffice.
2. Open the form you wish to configure (for example: Contact Form).
3. Click on the cogwheel icon next to the form field you want to secure.
4. Enable the **Sensitive data** setting for the field.

![Mark Question as Sensitive](../.gitbook/assets/mark-field-as-sensitive.png)

5. Click **Submit**.
6. Click **Save**.

![Sensitive Data on Field](../.gitbook/assets/sensitive-data-field.png)
