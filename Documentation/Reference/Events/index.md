#Using events#

Umbraco uses .Net events to allow you to hook into the workflow processes for the backoffice. For example you might want to execute some code every time a page is published. Events allow you to do that.

[Document Events](Document-Events.md)

## Before and After events ##

Typically, the events available exist in pairs, with a Before and After event. For example the Document class has the concept of publishing, and fires events when this occurs. In that case there is both a Document.BeforePublish and Document.AfterPublish event. 

Which one you want to use depends on what you want to achieve. If you want to be able to cancel the action, the you would use the Before event, and use the eventargs to cancel it. See the sample handler further down. If you want to execute some code after the publishing has suceeded, then you would use the After event.

## Using ApplicationBase to register events ##

Umbraco includes the ApplicationBase class which is used for registering your code in umbraco automatically when umbraco loads.

This sample shows how to setup an ApplicationBase and make it subscribe to the before publishing events.

Remember to add the cms.dll, businesslogic.dll, umbraco.dll and interfaces.dll to your project.

Add references to the right namespaces at the top of your .cs file, and inherit the ApplicationBase and place the event code in the default class constructor.

	using umbraco.BusinessLogic;
	using umbraco.cms.businesslogic;
	using umbraco.cms.businesslogic.web;
	
	namespace MyApp
	{
	    public class BeforePublishHandler : ApplicationBase
	    {
	
	        public AppBase()
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


## Using IApplicationEventHandler to register events ##

**Applies to: Umbraco 4.10.0+**


As of version 4.10.0 the use of ApplicationBase has been deprecated and you're encourage to move to implemint IApplicationEventHandler instead.
Here's an example that does the same thing as the ApplicationBase sample above. Remember that it's an interface so you have to implement all three methods, but you can leave the ones you're not using empty.

	using Umbraco.Core;
	using Umbraco.Web;
	using umbraco.BusinessLogic;
	using umbraco.cms.businesslogic;
	using umbraco.cms.businesslogic.web;
	
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

