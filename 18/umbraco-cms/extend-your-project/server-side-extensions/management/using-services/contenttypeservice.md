---
description: Examples on how to retrieve content types and content type containers using the ContentTypeService.
---

# Content Type Service

Learn how to work with Content Types through the Content Type Service.

## Getting a single content type

A given content type has a few different unique identifier that we can use to look it up via the content type service. For instance, if we know the GUID of the content type, we can look it up like this:

```csharp
// Declare the GUID ID
Guid guid = new Guid("796a8d5c-b7bb-46d9-bc57-ab834d0d1248");

// Get a reference to the content type by its GUID ID
IContentType contentType = _contentTypeService.Get(guid);
```

Although the use of a GUID is preferable, you can also use it's numeric ID:

```csharp
// Get a reference to the content type by its numeric ID
IContentType contentType = _contentTypeService.Get(1234);
```

Finally, you can also look up a content type by its alias:

```csharp
// Get a reference to the content type by its alias
IContentType contentType = _contentTypeService.Get("home");
```

## Getting a list of content types

As content types are stored in a hierarchical list with folders (containers), there is also multiple ways to can get content types. If you are looking for a flat list of all content types, you can use the `GetAll` method:

```csharp
// Get a collection of all content types
IEnumerable<IContentType> contentTypes = _contentTypeService.GetAll();
```

The service also have `GetMany`-methods to get a collection of content types by their GUIDs IDs or numeric IDs:
```csharp
// Get a collection of two specific content types by their GUIDs IDs
IEnumerable<IContentType> contentTypes = _contentTypeService.GetMany(new[] {
    new Guid("2b54088e-d355-4b9e-aa4b-5aec4b3f87eb"),
    new Guid("859c5916-19d8-4a72-9bd0-5641ad503aa9")
});
```

```csharp
// Get a collection of two specific content types by their numeric IDs
IEnumerable<IContentType> contentTypes = _contentTypeService.GetMany(1234, 1235);
```

To get a list of all Content Types of another content type, you can use the `GetChildren` method. This can be done by specifying the numeric ID or the GUID:

```csharp
// Get a collection of content types of a specific content type
IEnumerable<IContentType> contentTypes = _contentTypeService.GetChildren(1232);
```

```csharp
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

## Retrieving content type container

### Getting a single content type container

You can add content types in three different ways. At the root level, under another content type, or under a _container_ (which is a folder). To obtain a single container, the process is similar to obtaining a single content type. This means that you can search for a container either by its GUID:

```csharp
// Declare the GUID ID
Guid guid = new Guid("d3b9cc9a-d471-4465-a89a-112c6bc1e5b4");

// Get a container by its GUID ID
EntityContainer container = _contentTypeService.GetContainer(guid);
```

or its numeric counterpart:

```csharp
// Get a container by its numeric ID
EntityContainer container = _contentTypeService.GetContainer(1090);
```

### Getting a list of content type containers

In the same way as you can get the content types of a container, you can get the child containers of another container. This is done by calling the `GetContainers` method with an array of numeric IDs:

```csharp
// Declare the array of IDs to lookup
int[] ids = new[] {1090};

// Get the child containers via the content type service
IEnumerable<EntityContainer> containers = _contentTypeService.GetContainers(ids);
```

Also, if the array is empty, all containers will be returned:

```csharp
// Declare the array of IDs to lookup
int[] ids = new int[0];

// Get all content type containers
IEnumerable<EntityContainer> containers = _contentTypeService.GetContainers(ids);
```
