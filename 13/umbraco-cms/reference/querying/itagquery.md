---
description: Working with tags in Umbraco
---

# ITagQuery

The `ITagQuery` interface is your primary way to work with tags in Umbraco. This interface allows you to get different tags, such as content tags and media tags. It also lets you retrieve content by tag, for instance, getting all content nodes with the "Umbraco" tag.

## How to reference ITagQuery

If you're using it in Views or Partial views you can inject `ITagQuery` using the `@inject` keyword, for example

```
@inject ITagQuery _tagQuery;
```

After this, you can use `_tagQuery` to access the `ITagQuery`.

If your site supports multiple languages, you must specify the desired language when using `ITagQuery`.

If you're using it in controllers, you can inject it into the constructor like so:

```csharp
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.PublishedCache;
using Umbraco.Cms.Web.Common.Controllers;

namespace UmbracoHelperDocs.Controllers;

[Route("tags/[action]")]
public class TagApiController : UmbracoApiController
{
 private readonly ITagQuery _tagQuery;

 public TagApiController(ITagQuery tagQuery)
 {
  _tagQuery = tagQuery;
 }

 public ActionResult<IEnumerable<string>> GetMediaTags()
 {
  return _tagQuery.GetAllMediaTags().Select(tag => tag.Text).ToList();
 }
}
```

{% hint style="warning" %}
`ITagQuery` is a scoped service, meaning that it should only be injected into scoped or transient services. For more information see the official [Microsoft Documentation](https://docs.microsoft.com/en-us/dotnet/core/extensions/dependency-injection#scoped)
{% endhint %}

## Examples

All examples are from a view using the injection shown above, but working with tags in controllers will be the same.

### GetAllContentTags(\[string tagGroup])

Get a collection of tags used by content items on the site. Optionally, you can pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
 var allContentTags = _tagQuery.GetAllContentTags();
 var newsContentTags = _tagQuery.GetAllContentTags("news");
}
```

### GetAllMediaTags(\[string tagGroup])

Get a collection of tags used by media items on the site. Optionally, you can pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
 var allMediaTags = _tagQuery.GetAllMediaTags();
 var newsMediaTags = _tagQuery.GetAllMediaTags("news");
}
```

### GetAllMemberTags(\[string tagGroup])

Get a collection of tags used by members on the site. Optionally, you can pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
 var allMemberTags = _tagQuery.GetAllMemberTags();
 var newsMemberTags = _tagQuery.GetAllMemberTags("news");
}
```

### GetAllTags(\[string tagGroup])

Get a collection of tags used on the site. Optionally, you can pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
 var allTags = _tagQuery.GetAllTags();
 var allNewsTags = _tagQuery.GetAllTags("news");
}
```

### GetContentByTag(string tag, \[string tagGroup])

Get a collection of IPublishedContent by tag, and you can optionally filter by tag group as well

```csharp
@{
 var taggedContent = _tagQuery.GetContentByTag("News");
}
```

### GetContentByTagGroup(string tagGroup)

Get a collection of IPublishedContent by tag group

```csharp
@{
 var taggedContent = _tagQuery.GetContentByTagGroup("BlogTags");
}
```

### GetMediaByTag(string tag, \[string tagGroup])

Get a collection of Media by tag, and you can optionally filter by tag group as well

```csharp
@{
 var taggedMedia = _tagQuery.GetMediaByTag("BlogTag");
}
```

### GetMediaByTagGroup(string tag, \[string tagGroup])

Get a collection of Media by tag group

```csharp
@{
 var mediaByTagGroup = _tagQuery.GetMediaByTagGroup("BlogTags");
}
```

### GetTagsForEntity(int contentId, \[string tagGroup])

Get a collection of tags by entity id (queries content, media and members), and you can optionally filter by tag group as well

```csharp
@{
 var tagsForEntity = _tagQuery.GetTagsForEntity(1234);
}
```

### GetTagsForProperty(int contentId, string propertyTypeAlias, \[string tagGroup])

Get a collection of tags assigned to a property of an entity (queries content, media and members). Optionally, you can filter by tag group as well

```csharp
@{
 var propertyTags = _tagQuery.GetTagsForProperty(1234, "propertyTypeAlias");
}
```
