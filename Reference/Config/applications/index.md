# applications.config

The 'applications.config' file contains the configuration for the sections, sometimes refered to as an application, you can see within Umbraco. These are the links visible on the left hand side of Umbraco when you log in. When you first install Umbraco the following sections will be avilable to you: Content, Media, Settings, Developer, Users, Members, Forms and Translation. 

The initial admin user will be able to see all the sections configured in this file when umbraco is first started but you are able to limit individual users to certain sections from the user management screens. You can also globably remove the default sections by removing them from the config but beware this might take away key functionality from users.

There are four attribues required for seach section listed in the config:

**alias** This is the internal alias of the section, convention is for it to be lowercase with no spaces. This is used to pull the display name of the section out of the language config.
**name** This is the name of the section, it can contain spaces and will be the displayed at the top of the tree when that section is open. 
**icon** This is the [icon](https://nicbell.github.io/ucreate/icons.html) that will be used in Umbraco
**sortOrder** Where the link is placed in the navigation, lower numbers will be at the top

Sections can be added directly to the config or via [code](/documentation/Extending/Section-Trees/sections). If a section has been added via code the config will be updated to reflect this.

