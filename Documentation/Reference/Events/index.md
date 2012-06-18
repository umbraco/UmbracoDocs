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

