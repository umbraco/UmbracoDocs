---
versionFrom: 8.0.0
meta.Title: "Umbraco events"
meta.Description: "Information on various backofice events in Umbraco"
---

# Using events

Umbraco uses .Net events to allow you to hook into the workflow processes for the backoffice. For example you might want to execute some code every time a page is published. Events allow you to do that.

## [Composing](../../Implementation/Composing)

Umbraco uses Composition and Components to allows you to execute code during startup. This is also the correct place to register for many other types of events including the ability to bind to HttpApplication events.

## Events

Typically, the events available exist in pairs, with a "before" and "after" event. For example the ContentService class has the concept of publishing, and fires events when this occurs. In that case there is both a ContentService.Publishing and ContentService.Published event.

Which one you want to use depends on what you want to achieve. If you want to be able to cancel the action, then you would use the "before" event, and use the event arguments to cancel it. See the sample handler further down. If you want to execute some code after the publishing has succeeded, then you would use the "after" event.

## Content and Media events

* See [ContentService Events](ContentService-Events.md) for a listing of the ContentService object events.
* See [MediaService Events](MediaService-Events.md) for a listing of the MediaService object events.
* See [MemberService Events](MemberService-Events/index.md) for a listing of the MemberService object events.

## Other events
* See [ContentTypeService Events](ContentTypeService-Events.md) for a listing of the ContentTypeService object events.
* See [DataTypeService Events](DataTypeService-Events.md) for a listing of the DataTypeService object events.
* See [FileService Events](FileService-Events.md) for a listing of the FileService object events.
* See [LocalizationService Events](LocalizationService-Events.md) for a listing of the LocalizationService object events.

## Tree events

* See [Tree Events](../../Extending/Section-Trees/trees.md) for a listing of the tree events.

## Editor Model events
See [EditorModelEventManager Events](EditorModel-Events/index.md) for a listing of the EditorModel events

:::tip
Useful for manipulating the model before it is sent to an editor in the backoffice - eg. perhaps to set a default value of a property on a new document.
:::
