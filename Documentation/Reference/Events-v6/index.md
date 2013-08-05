#Using events#

Umbraco uses .Net events to allow you to hook into the workflow processes for the backoffice. For example you might want to execute some code every time a page is published. Events allow you to do that.

## Application Startup & event registration ##

Umbraco allows you to execute code during application startup. This is also the correct place to register for events for certain objects. See [Application Startup & event registration](application-startup.md) for full details.

## Events ##

Typically, the events available exist in pairs, with a "before" and "after" event. For example the ContentService class has the concept of publishing, and fires events when this occurs. In that case there is both a ContentService.Publishing and ContentService.Published event. 

Which one you want to use depends on what you want to achieve. If you want to be able to cancel the action, the you would use the "before" event, and use the eventargs to cancel it. See the sample handler further down. If you want to execute some code after the publishing has suceeded, then you would use the "after" event.

## ContentService events ##

See [ContentService Events](ContentService-Events.md) for a listing of the ContentService object events.
