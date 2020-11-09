# Users on Umbraco Cloud

On Umbraco Cloud, users work almost identical as they do on a normal installation of Umbraco, however, you have a few more settings available for the backoffice users on Umbraco Cloud.

In this article, we will show how users work and the different settings on Umbraco Cloud.

## Adding users on Umbraco Cloud

There are two ways of adding a user to your backoffice on Umbraco Cloud.

You can add them as a [Team member](/Umbraco-Cloud/Set-Up/Team-Members/) from the project portal on Umbraco Cloud.

They will by default when added to the project as a team member be added to the backoffice as administrators.

users can also be invited directly from the backoffice of your Umbraco Cloud project where you can give them different user permissions.

Check out the [Users article](/Getting-Started/Data/Users/) for an in-depth explanation about Umbraco users in general.

:::note
users are environment-specific on Umbraco Cloud, this means that they will not be transferred over when doing a deployment to the next environment, this means that they will need to be added on the different environments on Umbraco Cloud.
:::

## User group permissions for transfers and restores

On Umbraco Cloud, it is possible to control which users have access to transferring and restoring content and media on your Umbraco Cloud project.

This can be done when creating a new User Group or when editing an existing group.

You have the option to decide whether a specific User Group has permission to do a restore, partial restore or if they can queue content for transfer to the next environment.

It is also possible to get Granular control on a per-node basis so that you can disable restore and transfer for specific content on your site. This can help avoid mistakes and ensure that the proper workflows are followed.

### Set up Permissions for transfers and restores

There are two ways that you can set up these permissions:

- Create a new User Group
- Edit an existing one

To create or edit a User Group, go to the User section of the backoffice.

In the right corner, you need to click on "Groups", from here you are able to either create a new User Group or edit an existing one.

![User Groups](images/Users.png)

Click on "Create group" and scroll down and look under "Default permissions" here you can see three options:

![User Groups](images/default_permisions.png)

You can decide whether the users in the new User Group can restore, partially restore, or transfer content.

To edit an already existing User Group, go to the User Group you want to edit, e.g Editors or Writers, and set the permissions from there.

### Granular Permissions

As mentioned it is also possible to set Granular permissions for a specific content node on your cloud project.

You can set the permission when you are creating or editing an existing user group.

In the bottom of the User Group, you can add the setting for Granular permission for your content nodes.

![Granular permission](images/Granular.png)

When you click "Add", you can choose which content node on your project that you want to set the Granular settings for.

![Granular content node](images/Granular_node.png)

When you have chosen the node that you want to set the settings for, you can then set the permissions for restore, partial restore, and queueing content for transfer.

![Granular permission](images/Granular_permission.png)
