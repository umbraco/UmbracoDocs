# applications.config

The 'applications.config' file contains the configuration for the different [sections](../../../Extending/Section-Trees/sections.md) of the Umbraco Backoffice, sometimes referred to as applications. These sections are represented by icons in the navigation ribbon on the left hand side of the Umbraco Backoffice. 

When you first install Umbraco the following sections are available to be assigned to different users: 

Content, Media, Settings, Developer, Users, Members, Forms and Translation. 

The default configuration file will be similar to below:

    <applications>
      <add alias="content" name="Content" icon="traycontent" sortOrder="0" />
      <add alias="media" name="Media" icon="traymedia" sortOrder="1" />
      <add alias="settings" name="Settings" icon="traysettings" sortOrder="2" />
      <add alias="developer" name="Developer" icon="traydeveloper" sortOrder="3" />
      <add alias="users" name="Users" icon="trayuser" sortOrder="4" />
      <add alias="member" name="Members" icon="traymember" sortOrder="5" />
      <add alias="forms" name="Forms" icon="icon-umb-contour" sortOrder="6" />
      <add alias="translation" name="Translation" icon="traytranslation" sortOrder="7" />
    </applications>

The initial admin user will be able to see all of the sections configured in this file when Umbraco is first started, you can control which sections are available for other Umbraco Users, from within the User Management section. 

Removing the default sections from the applications.config file will remove them completely from your Umbraco installation, but beware this might take away key functionality from users.

There are four attributes required to configure a section in the applications.config file:

**alias** - This is the internal alias of the section, convention is for it to be lowercase with no spaces. This is used to pull the display name of the section out of the language config.

**name** - This is the name of the section, it can contain spaces and will be the displayed at the top of the tree when that section is open. 

**icon** - This is the [icon](https://nicbell.github.io/ucreate/icons.html) that will be used in Umbraco

**sortOrder** - Where the link is placed in the navigation, lower numbers will be at the top

Sections can be added directly to the config or via [code](../../../Extending/Section-Trees/sections.md). If a section has been added via code the config will be updated to reflect this.
