---
versionFrom: 8.0.0
versionRemoved: 9.0.0
---

# Binding to HttpApplication events

It is not necessary to override and replace the [UmbracoApplication](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.UmbracoApplication.html?q=UmbracoApplication).  If you consider changing the default `global.asax`, read on!

Umbraco allows you to bind directly to HttpApplication events. This is handy since normally you would require an HttpModule to bind to these types of events.

The HttpApplication events are listed here: [https://msdn.microsoft.com/en-us/library/system.web.httpapplication_events.aspx](https://msdn.microsoft.com/en-us/library/system.web.httpapplication_events.aspx)

In order to bind to these events you need to first listen to the `UmbracoApplicationBase.ApplicationInit` event. You can gain access to this in a custom `IComponent`. Here is an example:

```csharp
using System;
using System.Web;
using System.Web.SessionState;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Web;

namespace Umbraco8.Example
{
    public sealed class BindApplicationEventsExampleComponent : IComponent
    {
        private readonly ILogger _logger;

        public BindApplicationEventsExampleComponent(ILogger logger)
        {
            _logger = logger;
        }

        public void Initialize()
        {
            // bind to ApplicationInit - ie execute the application initialization for *each* application
            // it would be a mistake to try and bind to the current application events
            UmbracoApplicationBase.ApplicationInit += InitializeApplication;
        }

        public void Terminate()
        {
            // unbind on shutdown
            UmbracoApplicationBase.ApplicationInit -= InitializeApplication;
        }

        private void InitializeApplication(object sender, EventArgs args)
        {
            if (!(sender is HttpApplication app)) return;

            // NOTE: We do not unbind these events ... because you just can't do that for HttpApplication events, they will
            // be removed when the app dies.
            app.BeginRequest += BeginRequest;
            app.EndRequest += EndRequest;

            // and session start?
            var module = app.Modules["Session"] as SessionStateModule;
            if (module != null)
            {
                module.Start += this.Session_Start;
            }
        }

        private void BeginRequest(object sender, EventArgs e)
        {

        }

        private void EndRequest(object sender, EventArgs e)
        {

        }

        private void Session_Start(object sender, EventArgs e)
        {
            _logger.Info<BindApplicationEventsExampleComponent>("Session Started");

        }
    }

    public class ApplicationComposer : ComponentComposer<BindApplicationEventsExampleComponent>, IUserComposer
    {
        public override void Compose(Composition composition)
        {
            base.Compose(composition);
        }
    }
}
```

## Related Links

* [Troubleshooting Slow Startup](Troubleshooting-Slow-Startup.md)
* [More information about BootManager](Understanding-Bootmanagers.md) (EXPERT)
* [Adding startup logic and plugin on c# events](Application-Startup.md) (EXPERT)
