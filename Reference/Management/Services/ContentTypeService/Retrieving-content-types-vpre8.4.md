---
versionFrom: 8.0.0
versionTo: 8.3.0
---

# Retrieving content types

## Getting a single content type

A given content type has a few different unique identifier that we can use to look it up via the content type service. For instance, if we know the numeric ID of the content type, we can look it up like this:

```C#
// Get a reference to the content type by its numeric ID
IContentType contentType = contentTypeService.Get(1234); 
```

As Umbraco is shifting to use GUIDs instead of numeric IDs, you can also lookup a content type if you already know its GUID ID:

```C#
// Declare the GUID ID
Guid guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");

// Get a reference to the content type by its GUID ID
IContentType contentType = contentTypeService.Get(guid);
```

Finally, you can also look up a content type by its alias:

```C#
// Get a reference to the content type by its alias
IContentType contentType = contentTypeService.Get("home");
```

## Getting a list of content types

As content types are stored in a hierarchical list with folders (containers), there is also multiple ways to can get content types. If you are looking for a flat list of all content types, you can use the `GetAll` method:

```C#
// Get a collection of all content types
IEnumerable<IContentType> contentTypes = contentTypeService.GetAll();
```

In the example above, the method was called without any parameters. The method also accept params, which lets you look up a collection of content types by either specifying their numeric IDs:

```C#
// Get a collection of two specific content types by their numeric IDs
IEnumerable<IContentType> contentTypes = contentTypeService.GetAll(1234, 1235);
```

To get a list of all content types of another content type, you can instead use the `GetChildren` method - either by specyfing the numeric ID of the folder:

```C#
// Get a collection of content types of a specific content type
IEnumerable<IContentType> contentTypes = contentTypeService.GetChildren(1232);
```

