#Using Umbraco's service APIs

_Whenever you need to modify an entity that Umbraco stores in the database - there is a service API available for it. this means that
you can create, update and delete any of the core Umbraco entities directly from your custom code._


##Accessing the Umbraco services.
To use the service APIs - you must first access them. This is done through what is know as `ApplicationContext` which provides access to everything related
to the Umbraco application.


###Access via Controller
If accessing umbraco services inside your own controller class - then by inheriting from one of Umbraco's base controller classes you get access to all services through `Services`:

    public class EventController : Umbraco.Web.Mvc.SurfaceController
    {
        public Action PerformAction()
        {
           var content = Services.ContentService.GetById(1234);
        }
    }

###Access via ApplicationEventHandler
If we for instance subscribe to the ApplicationStarted event - we get access to this context - which then provides a `.Services` class which contains all the
available services

    public class EventHandler : Umbraco.Core.ApplicationEventHandler
    {
        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            var c = applicationContext.Services.ContentService.GetById(1234);
            applicationContext.Services.ContentService.Delete(c);
        }
    }

##Services available
There is full api coverage of all Umbraco core entities:

- [ContentService](../../../Reference/Management/Services/ContentService)
- [ApplicationTreeService](../../../Reference/Management/Services/TreeService)
- [DataTypeService](../../../Reference/Management/Services/DataTypeService)
- EntityService
- [FileService](../../../Reference/Management/Services/FileService)
- [LocalizationService](../../../Reference/Management/Services/LocalizationService)
- MacroService
- [MediaService](../../../Reference/Management/Services/MediaService)
- [MemberService](../../../Reference/Management/Services/MemberService)
- [MemberTypeService](../../../Reference/Management/Services/MemberTypeService)
- [MemberGroupService](../../../Reference/Management/Services/MemberGroupService)
- [ContentTypeService](../../../Reference/Management/Services/ContentTypeService)


##More information
- [Umbraco Services API reference](../../../Reference/Management/Services/)
- [Umbraco Events reference](../../../Reference/Events/)
- [Routes and controllers](../../../Reference/Routing/)
