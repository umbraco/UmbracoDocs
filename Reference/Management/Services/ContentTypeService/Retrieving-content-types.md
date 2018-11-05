# Retrieving content types

## Getting a single content type

A given content type has a few different unique identifier that we can use to look it up via the content type service. For instance, if we know the numeric ID of the content type, we can look it up like this:

```C#
// Get a reference to the content type by its numeric ID
IContentType contentType = contentTypeService.GetContentType(1234);
```

As Umbraco is shifting to use GUIDs instead of numeric IDs, you can also lookup a content type if you already know its GUID ID:

```C#
// Declare the GUID ID
Guid guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");

// Get a reference to the content type by its GUID ID
IContentType contentType = contentTypeService.GetContentType(guid);
```

Finally, you can also look up a content type by its alias:

```C#
// Get a reference to the content type by its alias
IContentType contentType = contentTypeService.GetContentType("home");
```

## Getting a list of content types

As content types are stored in a hierarchical list with folders (containers), there is also multiple ways to can get content types. If you are looking for a flat list of all content types, you can use the `GetAllContentTypes` method:

```C#
// Get a collection of all content types
IEnumerable<IContentType> contentTypes = contentTypeService.GetAllContentTypes();
```

In the example above, the method was called without any parameters. The method also has two overloads, which lets you look up a collection fo content types by either specifying their numeric or GUID IDs:

```C#
// Get a collection of two specific content types by their numeric IDs
IEnumerable<IContentType> contentTypes = contentTypeService.GetAllContentTypes(1234, 1235);
```

```C#
// Get a collection of two specific content types by their GUIDs IDs
IEnumerable<IContentType> contentTypes = contentTypeService.GetAllContentTypes(new[] {
    new Guid("2b54088e-d355-4b9e-aa4b-5aec4b3f87eb"),
    new Guid("859c5916-19d8-4a72-9bd0-5641ad503aa9")
});
```

To get a list of all content types of a another content type (or container), you can instead use the `GetContentTypeChildren` method - either by specyfing the numeric ID of the folder:

```C#
// Get a collection of content types of a specific content type
IEnumerable<IContentType> contentTypes = contentTypeService.GetContentTypeChildren(1232);
```

or by the GUID ID of the folder:

```C#
// Get a collection of content types of a specific content type
IEnumerable<IContentType> contentTypes = contentTypeService.GetContentTypeChildren(new Guid("d3b9cc9a-d471-4465-a89a-112c6bc1e5b4"));
```
