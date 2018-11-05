# Using Umbraco's service APIs

_Whenever you need to modify an entity that Umbraco stores in the database, there is a service API available to help you. This means that you can create, update and delete any of the core Umbraco entities directly from your custom code._


## Accessing the Umbraco services
To use the service APIs you must first access them. This is done through what is known as the `ApplicationContext` which provides access to everything related to the Umbraco application.


### Access via Controller
If you are accessing Umbraco services inside your own controller class, you get access to all services through `Services` by inheriting from one of Umbraco's base controller classes:

    public class EventController : Umbraco.Web.Mvc.SurfaceController
    {
        public Action PerformAction()
        {
           var content = Services.ContentService.GetById(1234);
        }
    }

### Access via ApplicationEventHandler
If we for instance subscribe to the ApplicationStarted event we get access to the ApplicationContext, which then provides a `.Services` class through which all the available services can be used.

    public class EventHandler : Umbraco.Core.ApplicationEventHandler
    {
        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            var c = applicationContext.Services.ContentService.GetById(1234);
            applicationContext.Services.ContentService.Delete(c);
        }
    }

## Services available
There is full API coverage of all Umbraco core entities:

- [ConsentService](../../../Reference/Management/Services/ConsentService.md)
- [ContentService](../../../Reference/Management/Services/ContentService.md)
- [ApplicationTreeService](../../../Reference/Management/Services/TreeService.md)
- [DataTypeService](../../../Reference/Management/Services/DataTypeService.md)
- EntityService
- [FileService](../../../Reference/Management/Services/FileService.md)
- [LocalizationService](../../../Reference/Management/Services/LocalizationService.md)
- MacroService
- [MediaService](../../../Reference/Management/Services/MediaService.md)
- [MemberService](../../../Reference/Management/Services/MemberService.md)
- [MemberTypeService](../../../Reference/Management/Services/MemberTypeService.md)
- [MemberGroupService](../../../Reference/Management/Services/MemberGroupService.md)
- [ContentTypeService](../../../Reference/Management/Services/ContentTypeService.md)


### More information
- [Umbraco Services API reference](../../../Reference/Management/Services/)
- [Umbraco Events reference](../../../Reference/Events/)
- [Routes and controllers](../../../Reference/Routing/)

### Umbraco TV
- [Chapter: Content API](https://umbraco.tv/videos/umbraco-v7/developer/fundamentals/content-api/)
- [Chapter: Media API](https://umbraco.tv/videos/umbraco-v7/developer/fundamentals/media-api/)
- [Chapter: Member API](https://umbraco.tv/videos/umbraco-v7/developer/fundamentals/member-api/)
