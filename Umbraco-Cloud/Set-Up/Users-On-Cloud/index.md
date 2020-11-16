---
meta.Title: "Users on Umbraco Cloud"
meta.Description: "An article explaining how Umbraco Users are working on Umbraco Cloud."
versionFrom: 7.0.0
---

# Users on Umbraco Cloud

On Umbraco Cloud, users work in almost the same way as on a normal installation of Umbraco. However, there are a few more settings available for the backoffice users on Umbraco Cloud.

In this article, we will show how users work, as well as explain the different settings for users on Umbraco Cloud.

## Adding users on Umbraco Cloud

There are two ways of adding a user to your backoffice on Umbraco Cloud.

You can add them as a [Team member](/Umbraco-Cloud/Set-Up/Team-Members/) from the project portal on Umbraco Cloud.

By default, when added to the project as a Team member, they will be added as users to the backoffice of all the environments as administrators.

Users can also be invited directly from the backoffice of your Umbraco Cloud project, from where you can give them different permissions.

Check out the [Users article](/Getting-Started/Data/Users/) for an in-depth explanation about Umbraco users in general.

:::note
Users are environment-specific on Umbraco Cloud. This means that they will not be transferred over when doing a deployment to the next environment - they will need to be added on the different environments on Umbraco Cloud.
:::

## User group permissions for transfers and restores

On Umbraco Cloud, it is possible to control which users have access to transferring and restoring content and media on your Umbraco Cloud project.

This can be done when creating a new User Group or when editing an existing group.

You have the option to decide whether a specific User Group has permission to do a restore, partial restore, or queue content for transfer to the next environment.

It is also possible to get Granular control on a per-node basis so that you can disable restore and transfer for specific content on your site. This can help avoid mistakes and ensure that the proper workflows are followed.

### Set up Permissions for transfers and restores

There are two ways that you can set up these permissions:

- Create a new User Group
- Edit an existing one

To create or edit a User Group, go to the User section of the backoffice.

1. Click on "Groups" in the right corner from, and here you are able to either create a new User Group or edit an existing one.

    ![User Groups](images/Users.png)

2. Click on "Create group" and scroll down and look under "Default permissions" here you can see three options:

    ![User Groups](images/default_permisions.png)

3. From here you can decide whether the users in the new User Group can restore, partially restore, or transfer content.

4. To edit an already existing User Group, go to the User Group you want to edit, e.g Editors or Writers, and set the permissions from there.

### Granular Permissions

As mentioned it is also possible to set Granular permissions for a specific content node on your Cloud project.

You can set the permission when you are creating or editing an existing User Group.

1. At the bottom of the User Group, you can add the setting for Granular permission for your content nodes.

    ![Granular permission](images/Granular.png)

2. When you click "Add", you can choose the content node which you want to set the Granular settings for.

    ![Granular content node](images/Granular_node.png)

3. When you have chosen the node that you want to set the settings for, you can then set the permissions for restore, partial restore, and queueing content for transfer.

    ![Granular permission](images/Granular_permission.png)
