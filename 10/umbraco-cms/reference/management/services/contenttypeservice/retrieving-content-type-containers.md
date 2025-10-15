# Retrieving content types

## Getting a single content type container

Content types can be added either at the root level, under another content type or under a content type container (or folders as they're called in the Umbraco backoffice). The approach for getting a single container is similar to getting a single content type, meaning that you can look up a container - either by its GUID:

```
// Declare the GUID ID
Guid guid = new Guid("d3b9cc9a-d471-4465-a89a-112c6bc1e5b4");

// Get a container by its GUID ID
EntityContainer container = _contentTypeService.GetContainer(guid);
```

or its numeric counterpart:

```
// Get a container by its numeric ID
EntityContainer container = _contentTypeService.GetContainer(1090);
```

## Getting a list of content type containers

In the same way as you can get the content types of a container, you can get the child containers of another container. This is done by calling the `GetContainers` method with an array of numeric IDs:

```
// Declare the array of IDs to lookup
int[] ids = new[] {1090};

// Get the child containers via the content type service
IEnumerable<EntityContainer> containers = _contentTypeService.GetContainers(ids);
```

Also, if the array is empty, all containers will be returned:

```
// Declare the array of IDs to lookup
int[] ids = new int[0];

// Get all content type containers
IEnumerable<EntityContainer> containers = _contentTypeService.GetContainers(ids);
```
