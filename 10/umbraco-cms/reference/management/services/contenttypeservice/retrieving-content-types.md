# Retrieving content types

## Getting a single content type

A given content type has a few different unique identifier that we can use to look it up via the content type service. For instance, if we know the GUID of the content type, we can look it up like this:

```
// Declare the GUID ID
Guid guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");

// Get a reference to the content type by its GUID ID
IContentType contentType = _contentTypeService.Get(guid);
```

Although the use of a GUID is preferable, you can also use it's numeric ID:

```
// Get a reference to the content type by its numeric ID
IContentType contentType = _contentTypeService.Get(1234); 
```

Finally, you can also look up a content type by its alias:

```
// Get a reference to the content type by its alias
IContentType contentType = _contentTypeService.Get("home");
```

## Getting a list of content types

As content types are stored in a hierarchical list with folders (containers), there is also multiple ways to can get content types. If you are looking for a flat list of all content types, you can use the `GetAll` method:

```
// Get a collection of all content types
IEnumerable<IContentType> contentTypes = _contentTypeService.GetAll();
```

In the example above, the method was called without any parameters. The method also has two overloads, which lets you look up a collection fo content types by either specifying their GUID or numeric IDs:

```
// Get a collection of two specific content types by their GUIDs IDs
IEnumerable<IContentType> contentTypes = _contentTypeService.GetAll(new[] {
    new Guid("2b54088e-d355-4b9e-aa4b-5aec4b3f87eb"),
    new Guid("859c5916-19d8-4a72-9bd0-5641ad503aa9")
});
```

```
// Get a collection of two specific content types by their numeric IDs
IEnumerable<IContentType> contentTypes = _contentTypeService.GetAll(1234, 1235);
```

To get a list of all content types of another content type, you can instead use the `GetChildren` method - either by specifying the numeric ID or the GUID:

```
// Get a collection of content types of a specific content type
IEnumerable<IContentType> contentTypes = _contentTypeService.GetChildren(1232);
```

```
IEnumerable<IContentType> contentTypes = _contentTypeService.GetChildren(Guid.Parse("4f89dd28-d038-4209-aaa1-06109b7946a7"));
```

## Check whether a content type has children

In some cases it can be useful to check if a content type has children. The `HasChildren` method can be used to check whether a content type has children.

```csharp
// Check if there are children
bool hasChildren = _contentTypeService.HasChildren(Guid.Parse("2b54088e-d355-4b9e-aa4b-5aec4b3f87eb"));
```

Although the use of a GUID is preferable, you can also use it's numeric ID:

```csharp
// Check if there are children
bool hasChildren = _contentTypeService.HasChildren(1234);
```
