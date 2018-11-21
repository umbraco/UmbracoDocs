# Understanding Umbraco the BootManager

After IIS started the W3 process, Umbraco will begin launching.  There is a bootstrapper for the `Umbraco Application` which initializes all objects.

The responsible objects for the startup are the [CoreBootManager](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.CoreBootManager.html) and [WebBootManager](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Web.WebBootManager.html) where the latter includes the Web portion of the application.

The boot managers initialize the [UmbracoApplication](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Web.UmbracoApplication.html) (the global.asax) object.  After it has initialized the UmbracoApplication, it will initialize the ApplicationContext.  

The bootmanager will initialize the ApplicationContext with: the database context, services context, profiling and logger. It will also register the Application Startup handlers which will execute later using the [ApplicationEventsResolver](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Core.ObjectResolution.ApplicationEventsResolver.html).

For those wondering: **Examine actually doesn't do anything on startup - 'if the indexes are built'**

### IBootManager (EXPERT)

In some (rare) cases you may be using a custom `IBootManager` which has the following methods: `Initialize`, `Startup`, `Complete`, this sequence of events and the logic that should be performed in these methods is exactly the same as the methods mentioned above in this order: 
* `Initialize` --> `ApplicationInitialized`
* `Startup` --> `ApplicationStarting`
* `Complete` --> `ApplicationStarted`

## Related Links
* [Troubleshooting Slow Startup](Troubleshooting-Slow-Startup.md)
* [Adding startup logic and plugin on c# events](Application-Startup.md) (EXPERT)
* [Overriding UmbracoApplication](Extending-UmbracoApplication.md) (EXPERT)
