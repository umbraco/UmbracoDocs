# Subscribing to events
Subscribing to events allows you to execute custom code on a  number of events both before and after the event occurs. All you need to follow this guide is an Umbraco installation with some content, e.g. the Fanoe starter kit.

### Subscribing to an event
Let's add a string of text to the log when a document is publish.

We'll start by adding a new class to the project. Call it *LogWhenPublished*. The events are found in the core services so add `using Umbraco.Core;` and then we need to inherit from the application event handler `: ApplicationEventHandler`

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Umbraco.Core;

    public class LogWhenPublished : ApplicationEventHandler
    {
        /// Here we'll subscribe to an event
    }

First thing to do in our *LogWhenPublished* class is to override `ApplicationStarted` and then subscribe to an event in `Umbraco.Core.Services.Contentservice.Published`.

    protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
    {
        Umbraco.Core.Services.ContentService.Published += ContentService_Published;
    }

To execute your custom code add the following (if you are using Visual Studio you can easily add the next bit of code by hitting tab twice after `+=` in the previous code block) :

    void ContentService_Published(Umbraco.Core.Publishing.IPublishingStrategy sender, Umbraco.Core.Events.PublishEventArgs<Umbraco.Core.Models.IContent> e)
    {
        // Your custom code goes here
    }

Let's check if it works by adding a message to the log when the event occurs. We'll use the LogHelper for this, so add `using Umbraco.Core.Logging;` and then :

    LogHelper.Info(typeof(LogWhenPublished), "Something has been published");

The entire class should look like this:

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Umbraco.Core;
    using Umbraco.Core.Logging;

    public class LogWhenPublished : ApplicationEventHandler
    {
        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            Umbraco.Core.Services.ContentService.Published += ContentService_Published;
        }

        void ContentService_Published(Umbraco.Core.Publishing.IPublishingStrategy sender, Umbraco.Core.Events.PublishEventArgs<Umbraco.Core.Models.IContent> e)
        {
            // LogHelper will write to tracelog.txt
            LogHelper.Info(typeof(LogWhenPublished), "Something has been published");
        }
    }

Go to the backoffice and publish a piece of content. Now open tracelog.txt located in `App-Data/Logs/`, scroll to the bottom of the document and there you should find the log entry.

![Message in tracelog.txt](images/log-message.png)

### Before and after
As you can see our custom code has been executed when we published a piece of content. Actually it executed after the item was published because we used the `Published` event. If you want to run code before publishing, use `Publishing`. The same goes for most other events so `Saving` : `Saved`, `Copying` : `Copied` and so forth.

### More information
- [Events Reference](../../../Reference/Events/)

### Umbraco TV
- [Chapter: Events](https://umbraco.tv/videos/umbraco-v7/developer/extending/events/)
