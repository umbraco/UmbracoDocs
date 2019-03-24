---
versionFrom: 8.0.0
---

# Subscribing to events
Subscribing to events allows you to execute custom code on a  number of events both before and after the event occurs. All you need to follow this guide is an Umbraco installation with some content, e.g. the the Umbraco starter kit.

### Subscribing to an event
Let's add a string of text to the log when a document is published. (The log is useful for debugging, different parts of the Umbraco codebase log key events, warnings and errors to The log)

We subscribe to events in Umbraco inside a Component, let's create one, add a new c# class to our project - call it *LogWhenPublishedComponent*. and use ': `IComponent` to identify our code as a Component. We'll need to add `using Umbraco.Core.Composing;` to the top of the .cs file and because the events that you can subscribe to in Umbraco are found in the core services namespace we'll also need to add a using statement for that too: `using Umbraco.Core;` . 

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using Umbraco.Core.Composing;

public class LogWhenPublishedComponent : IComponent
{
    /// Here we'll subscribe to an event
}
```
When you create a Component in Umbraco you need to implement two methods, one to run when Umbraco application is initialized and one to run when the Umbraco application terminates:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using Umbraco.Core.Composing;

public class LogWhenPublishedComponent : IComponent
{
     // initialize: runs once when Umbraco starts
        public void Initialize()
        {
            //do something as Umbraco starts up
            //for example subscribe to an event
        }

        // terminate: runs once when Umbraco stops
        public void Terminate()
        {
            // do something when Umbraco terminates
        }
}
```

It's in this Intialize() method where we will subscribe to our Published event `Umbraco.Core.Services.Contentservice.Published`.

```csharp
   public void Initialize()
        {
            //subscribe to content service published event
            Umbraco.Core.Services.ContentService.Published += ContentService_Published;
        }
```

This will tell Umbraco that a method called 'ContentService_Published' will subscribe to the publish event - but we haven't created that yet! (if you are using Visual Studio there is a shortcut key to add a stub for this method, in the above example after you have typed Umbraco.Core.Services.ContentService.Published press '+=' and then immediately press the 'tab key' twice... by magic the stub for handling the event with the correct signature will be added to your c# class) :

```csharp
   public void Initialize()
        {
            //subscribe to content service published event
            Umbraco.Core.Services.ContentService.Published += ContentService_Published;
        }

    void ContentService_Published(Umbraco.Core.Publishing.IPublishingStrategy sender, Umbraco.Core.Events.PublishEventArgs<Umbraco.Core.Models.IContent> e)
    {
        // the custom code to fire everytime content is published goes here!
    }
```

Let's check if this works by adding a message to the log every time the publish event occurs. 

We'll need to inject in the Umbraco Core Logging service into our Component, by adding the Umbraco.Core.Logging namespace and creating a 'constructor' for our component that allows Umbraco to inject in the service:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;

public class LogWhenPublishedComponent : IComponent
{
private readonly ILogger _logger;
    public LogWhenPublishedComponent(ILogger logger){
        _logger = logger;
    }
     
     // initialize: runs once when Umbraco starts
        public void Initialize()
        {
        ...
```
Now we can use the logger to send a message to the logs

```csharp
_logger.Info(typeof(LogWhenPublished), "Something has been published");
```

Finally we need to add our custom Component to the collection of Components that Umbraco is aware of, and we use another c# class to achieve that called a Composer, and there is a special base class called ComponentComposer that we can make use of:

```csharp
[RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class LogWhenPublishedComposer : ComponentComposer<LogWhenPublishedComponent>
    {
    // nothing to do here!
    }
```
The entire class should look like this:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;

[RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class LogWhenPublishedComposer : ComponentComposer<LogWhenPublishedComponent>
    {
    // nothing to do here!
    }

public class LogWhenPublishedComponent : IComponent
{
private readonly ILogger _logger;
    public LogWhenPublishedComponent(ILogger logger){
        _logger = logger;
    }
     // initialize: runs once when Umbraco starts
        public void Initialize()
        {
            //subscribe to content service published event
            Umbraco.Core.Services.ContentService.Published += ContentService_Published;
        }
        
        void ContentService_Published(Umbraco.Core.Publishing.IPublishingStrategy sender, Umbraco.Core.Events.PublishEventArgs<Umbraco.Core.Models.IContent> e)
    {
        // the custom code to fire everytime content is published goes here!
        _logger.Info(typeof(LogWhenPublished), "Something has been published");
    }

        // terminate: runs once when Umbraco stops
        public void Terminate()
        {
            // do something when Umbraco terminates
        }
}
```

Now go to the backoffice and publish a piece of content. switch to the Developer section and find the logviewer, if all is wired up correctly you should discover your custom publish log message entry.

![Message in tracelog.txt](images/log-message.png) - *Update this!*

### Before and after
As you can see our custom code has been executed when we published a piece of content. Actually it executed after the item was published because we used the `Published` event. If you want to run code before publishing, use `Publishing`. The same goes for most other events so `Saving` : `Saved`, `Copying` : `Copied` and so forth.

### More information
- [Events Reference](../../../Reference/Events/)
- [Components & Composing](../../../implementation/composing/)

