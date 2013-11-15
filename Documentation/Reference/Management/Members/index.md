#Members

_This section will soon be out of date as a new membership API is announced to come in Umbraco v6.2.  We advice you to keep an eye on the [new Management Api](../../Management-v6/)'s_

The `Member` object represents members, as it is stored in the database. 

 * **Namespace**: `umbraco.cms.businesslogic.member`
 * **assembly**: `cms.dll`

To use the Member api, you require references to the following dlls:

* cms.dll
* businesslogic.dll

To use the Member api, you will require the following usings:

	using umbraco.cms.businesslogic.media;
	using umbraco.BusinessLogic;

## Membership provider
Although you can do a lot with the member api, it is advices to use the membership provider syntax.  Things like login/logout are the same as any .Net website.

## Constructor

The Member constructor is used to retrive a Member object with a given Id or Guid, there are optional parameters, which allows one to control setup and version.

For all constructors, a null is returned if a Member is not found with the given id, guid or version.

## Events
The member api has a lot of events:

        public static event Member.AddingGroupEventHandler AfterAddGroup;
        public static event Member.AddingToCacheEventHandler AfterAddToCache;
        public static event Member.DeleteEventHandler AfterDelete;
        public static event Member.RemovingGroupEventHandler AfterRemoveGroup;
        public static event Member.SaveEventHandler AfterSave;
        public static event Member.AddingGroupEventHandler BeforeAddGroup;
        public static event Member.AddingToCacheEventHandler BeforeAddToCache;
        public static event Member.DeleteEventHandler BeforeDelete;
        public static event Member.RemovingGroupEventHandler BeforeRemoveGroup;
        public static event Member.SaveEventHandler BeforeSave;
        public static event Member.NewEventHandler New;

### Methods
If the methods of the ASP.net Membership provider or the ASP.net Roles provider are not enough, you can use the umbraco member methods.

 
