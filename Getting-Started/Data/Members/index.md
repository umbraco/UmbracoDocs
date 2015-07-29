#Members
*Members are used for registering and authenticating external users of an Umbraco installation (ie. forum members, intranet users and so forth). Unlike with Document Types and Media Types everything is done in the Members section both defining and creating, and editing members. This guide will explain how to define and create members in the backoffice. If you want to work with members using the service APIs, links can be found at the end of document*

There is a default Member Type that can be used to create members. You can of course customize it to fit your needs or create your own from scratch.

##Creating a member
Go to __Members__ section, click the menu icon next to __Members__ in the member tree and select __Member__. Members have a number mandatory properties. So aside from filling out the name you will need to fill out  __Login__, __Email__ and __Password__ on the __Properties__ tab before the member can be saved.

There is also a number of default properties on the __Membership__ tab:

* umbracoMemberComments
* umbracoMemberFailedPasswordAttempts
* umbracoMemberApproved
* umbracoMemberLockedOut
* umbracoMemberLastLockOutDate
* umbracoMemberLastLogin
* umbracoMemberLastPasswordChangeDate
* umbracoMemberPassWordRetrievalAnswer
* umbracoMemberPasswordRetrivalQuestion

Once the member is created and saved you can access it by expanding the members tree and click __All Members__ to get a list view (with real time search) or select the member type to filter by, by selecting it in the Members tree.

##Creating a Member Type
You can create your own Member Types and add properties and tabs just as with Document Types. Let's say we have a where external users need to sign up and login to use certain features and we also have an intranet part of the site for employees. So we need two Member Types. We'll use the default Member Type for external users and create a new one for employees.

###Defining a Member Type
Go to the __Members__ section, click the menu icon next to __Member Types__ and select __Create__. Name the new Member Type "Intranet" and press __Create__.

This takes you to the Member Type editor. Aside from the default properties that come with a Member Type let's say we need a profile image to show when they are logged in, a job position dropdown and a we want to know their birthday as well. These are all new properties and we'll put them on a "Details" tab.

####Adding tabs
Go to the __Tabs__ tab and type "Details" in the __New tab__ field and click the __New tab__ button. The new tab will be shown under __Name and sort order__.

####Adding properties
//TODO: Fill this in

##Creating Member Groups
//TODO: Fill this in

###Assigning a Member Group
//TODO: Fill this in

##Related Services
* [MemberService](../../../Reference/Management-v6/Members/)
* [MemberType Serveice](../../../Reference/Management-v6/Members/)
* [MemberGroup Service](../../../Reference/Management-v6/Members/)

##More information
* [Customising Data Types](../Data-Types/)
* [Data Types](../../../Using-Umbraco/Backoffice-Overview/Data-Types/)
