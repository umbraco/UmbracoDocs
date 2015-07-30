#Members
*Members are used for registering and authenticating external users of an Umbraco installation (ie. forum members, intranet users and so forth). Unlike with Document Types and Media Types everything is done in the Members section both defining and creating, and editing members. This guide will explain how to define and create members in the backoffice. If you want to work with members using the service APIs, links can be found at the end of document*

There is a default Member Type that can be used to create members. You can of course customize it to fit your needs or create your own from scratch.

##Creating a member
Go to __Members__ section, click the menu icon next to __Members__ in the member tree and select __Member__. Members have a number mandatory properties. So aside from filling out the name you will need to fill out  __Login__, __Email__ and __Password__ on the __Properties__ tab before the member can be saved.

There is also a number of default properties on the __Membership__ tab:

- umbracoMemberComments
- umbracoMemberFailedPasswordAttempts
- umbracoMemberApproved
- umbracoMemberLockedOut
- umbracoMemberLastLockOutDate
- umbracoMemberLastLogin
- umbracoMemberLastPasswordChangeDate
- umbracoMemberPassWordRetrievalAnswer
- umbracoMemberPasswordRetrivalQuestion

Once the member is created and saved you can access it by expanding the members tree and click __All Members__ to get a list view (with real time search) or select the member type to filter by, by selecting it in the Members tree.

##Creating a Member Type
You can create your own Member Types and add properties and tabs just as with Document Types.

Go to the __Members__ section, click the menu icon next to __Member Types__ and select __Create__. Name the new Member Type and click the __Create__ button.

You are now taken to the Member Type editor that is used to define and edit the Memeber Type. It consists of three tabs: __Info__, __Generic Properties__ and __Tabs__.

###Info
![Members Info tab](images/Members-Info.jpg)
Shows basic information about the Member Type and settings for custom properties.

__Name:__ The name of the Member Type shown in the Member Type tree and when users create a new member.

__Alias:__ Used to Reference the Member Type in code.

__Icon:__ The icon is shown in the Members list view. If the are more than one Member Type choosing different icons will help identify members easily.

__Description:__ The description is shown when creating a new member.

__Property settings:__ If properties are added to the Member Type you can control frontend access to the property:

  - __Member can edit:__ A logged in member can edit this property.
  - __Show on profile:__ The property will show on the profile for member that is logged in.

###Generic Properties
![Genric properties tab](images/Members-Generic-Properties.jpg)
Create. edit and organize properties for this Member Type.

#####Adding properties
To add a property to the Member Type select __Click here to add new property__.

__Name:__ The name  of the property.

__Alias:__ Used to reference the property in your templates.

__Type:__ Selecting the type will decide the input method for this property. Ie *Richtext editor*, *Date Picker*, *Image Cropper* and so forth. You can edit or create new types in the __Developer Section__ under the __Data Type__ node.

__Tab:__ Place the property on a tab. Additional tabs can be created on the __Tabs__ tab. If the property is placed on the Generic Properties tab it will show on the Properties tab in the content view.

__Mandatory:__ Making the property mandatory means the content cannot be created/saved if the property has no value.

__Validation:__ Add a regular expression to validate the property upon save.

__Description:__ The description will be displayed below the property name when creating/editing the member. A good description is important to the editing experience.

#####Organizing properties
Organize properties with drag and drop. If multiple tabs exists it is possible to drag properties between the different tabs.

###Tabs
![Members Tabs tab](images/Members-Tabs.jpg)
A new tab is created by entering a name into the input field and pressing the __New tab__ button.

#####Name and sort order
Renaming a tab is done simply by changing the name in the input field and saving the Document Type. To change the order of tabs use the drag and drop handle to the left or enter a numeric value in the second input field. Tabs will be displayed from left (lowest value) to right (highest value) in the content section.

##Creating Member Groups
Member Groups defines roles for your members that can be used for role based protection. A member can be in multiple groups.

![Creating a Member Group](images/Member-Groups-Create.jpg)

To create a new Member Group click the menu icon next __Member Groups__ node in the Members section. Choose __Create__, name the group and save the group.

###Assigning a Member Group
To assign a member to a specific group find the member you wish to assign and go to the __Properties__ tab. Under the Member Group property there are two columns:

![Assigning a Member Group](images/Member-Groups-Assign.jpg)

__NOT A MEMBER OF GROUP(S):__ Lists all the groups that the member is not a part of. To assign a group to the member simply click it and it will move to the other column.

__NOT A MEMBER OF GROUP(S):__ Lists all the groups that the member is part of. To remove the member from a group simply click it and it will move to the other column.


##More information
- [Customizing Data Types](../Data-Types/)

##Related Services
- [MemberService](../../../Reference/Management/Services/MemberService.md)
- [MemberType Serveice](../../../Reference/Management/Services/MemberTypeService.md)
- [MemberGroup Service](../../../Reference/Management/Services/MemberGroupService.md)

##[Umbraco.TV](http://umbraco.tv)
- [Members chapter](http://umbraco.tv/videos/umbraco-v7/content-editor/administrative-content/members/what-is-a-member/)
- Member API chapter *(Coming soon)*
