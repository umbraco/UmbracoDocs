# Retrieving content types

## Getting a single content type container

Content types can be added either at the root level, under another content type or under a content type container (or folders as they're called in the Umbraco backoffice). The approach for getting a single container is similar to getting a single content type, meaning that you can look up a container - either by it's numeric ID:

```C#
// Get a container by its numeric ID
EntityContainer container = contentTypeService.GetContentTypeContainer(1090);
```

or it's GUID conterpart:

```C#
// Declare the GUID ID
Guid guid = new Guid("d3b9cc9a-d471-4465-a89a-112c6bc1e5b4");

// Get a container by its GUID ID
EntityContainer container = contentTypeService.GetContentTypeContainer(guid);
```

## Getting a list of content type containers

In the same way as you can get the content types of a container, you can get the child containers of another container. This is done by calling the `GetContentTypeContainers` method with an array of numeric IDs:

```C#
// Declare the array of IDs to lookup
int[] ids = new[] {1090};

// Get the child containers via the content type service
IEnumerable<EntityContainer> containers = contentTypeService.GetContentTypeContainers(ids);
```

Also, if the array is empty, all containers will be returned:

```C#
// Declare the array of IDs to lookup
int[] ids = new int[0];

// Get all content type containers
IEnumerable<EntityContainer> containers = contentTypeService.GetContentTypeContainers(ids);
```
