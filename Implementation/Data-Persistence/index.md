# Data Persistence (CRUD) in Umbraco

_The Umbraco Services layer is used to query and manipulate Umbraco stored in the database_

## Service Context

The `ServiceContext` is the gateway to all of Umbraco's core services. In most cases, the `ServiceContext` will be 
exposed as a property on all Umbraco base classes such as `SurfaceController`s, `UmbracoApiController`s, any Umbraco views, etc...
So for the majority of cases you can simply access the services by using this code (for example):

	Services.ContentService.Get(123);
	
If you are not working with an Umbraco base class and the ServiceContext is not exposed, you can access the ServiceContext via the 
`ApplicationContext`. Just like the ServiceContext, the ApplicationContext is exposed an all Umbraco base classes, but in the rare case
that you are not using an Umbraco base class, you can access the ApplicationContext via a singleton. For example:

	ApplicationContext.Current.Services.ContentService.Get(123);
	
## Services

There are quite a few different services exposed on the ServiceContext such as: ContentService, MediaService, MemberService, etc... 
There is a service for each type of data in Umbraco.

[See here For a full list of services available](../../Reference/Management/Services/)  
