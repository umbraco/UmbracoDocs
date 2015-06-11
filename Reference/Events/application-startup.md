#Application startup events & event registration#

In order to bind to certain events in the Umbraco application you need to make these registrations during application startup. Based on the Umbraco version you are using there are various ways to hook in to the application starting. The higher the version you are using the more robust this becomes.

*In all of the samples below, they show you how to setup an object to execute during Umbraco application startup so that you can subscribe to the Document.BeforePublish event.*

## Using ApplicationEventHandler to register events ##

**Applies to: Umbraco 6.1.0+**

The ApplicationEventHandler is a new robust way to hook in to the Umbraco application startup process. It is a base class so all you need to do is override the methods that you wish to handle. It is important to know the difference between each of the methods (information is below). Most of the time you will just want to execute code on the *ApplicationStarted* method.

Here's an example that does the same thing as the IApplicationEventHandler sample below.

    using Umbraco.Core;
    using umbraco.BusinessLogic;
    using umbraco.Cms.BusinessLogic;
    using umbraco.Cms.BusinessLogic.Web;

    namespace Umbraco.Extensions.EventHandlers
    {
        public class RegisterEvents : ApplicationEventHandler
        {
            protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
            {
                Document.BeforePublish += Document_BeforePublish;
            }
            
            private void Document_BeforePublish(Document sender, PublishEventArgs e)
            {
                //Do what you need to do. In this case logging to the Umbraco log
                Log.Add(LogTypes.Debug, sender.Id, "the document " + sender.Text + " is about to be published");

                //cancel the publishing if you want.
                e.Cancel = true;
            }
        }
    }

Unlike the older startup handlers (pre 6.1.0) the ApplicationEventHandler will ensure that these methods only execute if the applicaton is installed and the database is ready. This will prevent many errors from occuring especially if Umbraco is not installed yet.

The methods that can be overridden are:

* ApplicationInitialized
	* Executes after the ApplicationContext and plugin resolvers are created
* ApplicationStarting
	* Executes before resolution is frozen so that you are able to modify any plugin resolvers
* ApplicationStarted
	* Executes after resolution is frozen so you can get objects from the plugin resolvers. **This will be the most common method to put logic in** unless you require to do anything out of the ordinary.

If you want more control over execution you can override these properties:

* ExecuteWhenApplicationNotConfigured
	* By default this is false but if you want these methods to fire even when the application is not configured you can override this property and return true
* ExecuteWhenDatabaseNotConfigured
	* By default this is false but if you want these methods to fire even if the database is not installed/ready then you can overrride this property and return true

## Using IApplicationEventHandler to register events ##

**Applies to: Umbraco 4.10.0+**

*As of version 4.10.0 the use of ApplicationStartupHandler has been deprecated and you're encourage to move to implement IApplicationEventHandler instead.*

Here's an example that does the same thing as the ApplicationStartupHandler sample below. Remember that it's an interface so you have to implement all three methods, but you can leave the ones you're not using empty.

	using Umbraco.Core;
	using Umbraco.Web;
	using umbraco.BusinessLogic;
	using umbraco.Cms.Businesslogic;
	using umbraco.Cms.Businesslogic.Web;
	
	namespace Umbraco.Extensions.EventHandlers
	{
	    public class RegisterEvents : IApplicationEventHandler
	    {
	        public void OnApplicationInitialized(UmbracoApplication httpApplication, ApplicationContext applicationContext)
	        {            
	        }
	
	        public void OnApplicationStarting(UmbracoApplication httpApplication, ApplicationContext applicationContext)
	        {
	            Document.BeforePublish += Document_BeforePublish;
	        }
	
	        public void OnApplicationStarted(UmbracoApplication httpApplication, ApplicationContext applicationContext)
	        {
	        }
	
	        private void Document_BeforePublish(Document sender, PublishEventArgs e)
	        {
	            //Do what you need to do. In this case logging to the Umbraco log
	            Log.Add(LogTypes.Debug, sender.Id, "the document " + sender.Text + " is about to be published");
	
	            //cancel the publishing if you want.
	            e.Cancel = true;
	        }
	    }
	}

The above code does not have any error checking but you should put as much error checking in your event handlers as you can because in some cases the application may not be installed yet, or the database may not be setup, and if your code tries to access these features you will get exceptions.

## Using ApplicationStartupHandler to register events ##

**Applies to versions: Umbraco 4.8.0+**

Umbraco includes the ApplicationStartupHandler class which is used for registering your code in Umbraco automatically when Umbraco loads.

Remember to add the cms.dll, businesslogic.dll, umbraco.dll and interfaces.dll to your project.

Add references to the right namespaces at the top of your .cs file, and inherit the ApplicationStartupHandler and place the event code in the default class constructor.

	using umbraco.BusinessLogic;
	using umbraco.Cms.BusinessLogic;
	using umbraco.Cms.BusinessLogic.Web;
	
	namespace MyApp
	{
	    public class BeforePublishHandler : ApplicationStartupHandler
	    {
	
	        public BeforePublishHandler()
	        {
	            Document.BeforePublish += Document_BeforePublish;
	        }
	
	        private void Document_BeforePublish(Document sender, PublishEventArgs e)
	        {
	            //Do what you need to do. In this case logging to the Umbraco log
	            Log.Add(LogTypes.Debug, sender.Id, "the document " + sender.Text + " is about to be published");
	
	            //cancel the publishing if you want.
	            e.Cancel = true;
	        }
	    }
	}

The above code does not have any error checking but you should put as much error checking in your event handlers as you can because in some cases the application may not be installed yet, or the database may not be setup, and if your code tries to access these features you will get exceptions.

## Using ApplicationBase to register events ##

**Applies to versions before: Umbraco 4.8.0**

Umbraco includes the ApplicationBase class which is used for registering your code in Umbraco automatically when Umbraco loads.

Remember to add the cms.dll, businesslogic.dll, umbraco.dll and interfaces.dll to your project.

Add references to the right namespaces at the top of your .cs file, and inherit the ApplicationBase and place the event code in the default class constructor.

	using umbraco.BusinessLogic;
	using umbraco.Cms.BusinessLogic;
	using umbraco.Cms.BusinessLogic.Web;
	
	namespace MyApp
	{
	    public class BeforePublishHandler : ApplicationBase
	    {
	
	        public BeforePublishHandler()
	        {
	            Document.BeforePublish += Document_BeforePublish;
	        }
	
	        private void Document_BeforePublish(Document sender, PublishEventArgs e)
	        {
	            //Do what you need to do. In this case logging to the Umbraco log
	            Log.Add(LogTypes.Debug, sender.Id, "the document " + sender.Text + " is about to be published");
	
	            //cancel the publishing if you want.
	            e.Cancel = true;
	        }
	    }
	}

The above code does not have any error checking but you should put as much error checking in your event handlers as you can because in some cases the application may not be installed yet, or the database may not be setup, and if your code tries to access these features you will get exceptions.

