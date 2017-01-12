#Team members in the Portal and Umbraco Backoffice users
You can add team members to your projects from the Umbraco Cloud portal and these get automatically added as users in the backoffice of all environments for the project. The users will also be created in local clones of your development site. The same username and password is used to login in all parts of Umbraco Cloud - portal, backoffice, Kudu console.

![Add team member](images/add-team-member.jpg)
When adding a team member the default permission will be *Read*. If the *Admin* checkbox is ticked they will be given Admin rights to the project.

##Team member roles
Roles for each environment can be set on the *Edit Team* page available from the *Settings* dropdown.

* Admin: Has access to everything on a Project. An admin can Delete a project, and only admins can edit the Team (adding/removing other team members and changing permissions). An admin can deploy using Portal and has access to git.

* Write: A team member with Write permissions can do everything on a Project except Delete and edit Team. A user with Write permissions is able to Deploy through the Portal and they have access to Development and Staging environments and the git repositories

* Read: A team member with Read permissions can only view the Project in the Portal, and is not able to Deploy or change anything on the Project through the Portal.


## Team Member Permissions in the Umbraco Back Office 
By default all team members created through the Portal are created as admin users in the backoffice. This can be overwritten by adding custom rules to the CloudUsers.config file in the /config directory. 

To match a Team Member with a group of permissions in the CloudUsers.config file you'll need to either match by e-mail or by the User Type of the Team Member using the "match" or "matchEmail" attributes.

You can specify:

* UserType: The name of a Back Office User Type thus default permissions on Content Nodes
* Start Nodes for Content and Media: You'll need to add the Guid of the node.
* Language: The Culture Code for the back office user interface language
* Disable Umbraco Access: When this is set to false, the user cannot login to the back office. Useful if your editors are working in the staging environment (by using the deploy feature, they'll still be able to push content to live)
* Apps: Aliases of the Umbraco apps where the user should have access. You can specify "*" to give access to all apps.

        <PermissionGroups>
          <Group match="*">
            <UserType>Editor</UserType>
            <StartNodeContent>0319fe65-a558-45a1-bd88-f93429e1dc04</StartNodeContent>
            <StartNodeMedia>fc22bc00-54ee-52bf-b54c-92477dc95136</StartNodeMedia>
            <Language>da</Language>
            <DisableUmbracoAccess>true</DisableUmbracoAccess>
            <Apps>
              <App>Content</App>
              <App>Media</App>
            </Apps>
          </Group>
          <Group match="admin" matchEmail="@umbraco.">
            <UserType>Admin</UserType>
            <StartNodeContent></StartNodeContent>
            <StartNodeMedia></StartNodeMedia>
            <Language>en</Language>
            <DisableUmbracoAccess>false</DisableUmbracoAccess>
            <Apps>
              <App>*</App>
            </Apps>
          </Group>
        </PermissionGroups>
