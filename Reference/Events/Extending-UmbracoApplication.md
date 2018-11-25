## Binding to HttpApplication events

It is not necessary to override and replace the [UmbracoApplication](https://our.umbraco.com/apidocs/csharp/api/Umbraco.Web.UmbracoApplication.html).  If you consider changing the default `global.asax`, read on!

Umbraco allows you to bind directly to HttpApplication events which is very handy since normally you would require an HttpModule to bind to these types of events. 

The HttpApplication events are listed here: [https://msdn.microsoft.com/en-us/library/system.web.httpapplication_events.aspx](https://msdn.microsoft.com/en-us/library/system.web.httpapplication_events.aspx)

In order to bind to these events you need to first listen to the `UmbracoApplicationBase.ApplicationInit` event. Here is an example:

    using Umbraco.Core;
    using Umbraco.Core.Events;
    using Umbraco.Core.Logging;
    using Umbraco.Core.Models;
    using Umbraco.Core.Services;

    namespace MyProject.EventHandlers
    {
        public class RegisterEvents : ApplicationEventHandler
        {
            protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
            {
                //Listen for the ApplicationInit event which then allows us to bind to the
                //HttpApplication events.
                UmbracoApplicationBase.ApplicationInit += UmbracoApplicationBase_ApplicationInit;     
            }
            
            /// <summary>
            /// Bind to the events of the HttpApplication
            /// </summary>
            void UmbracoApplicationBase_ApplicationInit(object sender, EventArgs e)
            {
                var app = (HttpApplication) sender;
                app.PostRequestHandlerExecute += UmbracoApplication_PostRequestHandlerExecute;
            }

            /// <summary>
            /// At the end of a handled request do something... 
            /// </summary>            
            void UmbracoApplication_PostRequestHandlerExecute(object sender, EventArgs e)
            {
                //Do something...
            }
        }
    }

## Related Links
* [Troubleshooting Slow Startup](Troubleshooting-Slow-Startup.md)
* [More information about BootManager](Understanding-BootManagers.md) (EXPERT)
* [Adding startup logic and plugin on c# events](Application-Startup.md) (EXPERT)
