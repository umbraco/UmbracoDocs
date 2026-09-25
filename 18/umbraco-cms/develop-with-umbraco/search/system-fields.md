---
description: >-
  A list of the system fields included in all content indexes
hidden: true
---

# System fields in content indexes

The following fields are explicitly indexed for all content.

| Field name          | Indexed as       | Notes                                                                        |
|---------------------|------------------|------------------------------------------------------------------------------|
| `Umb_ContentTypeId` | `Keyword`        | The ID (key) of the content type.                                            |
| `Umb_CreateDate`    | `DateTimeOffset` | The creation date of the content.                                            |
| `Umb_Id`            | `Keyword`        | The content ID (key).                                                        |
| `Umb_Level`         | `Integer`        | The content level in the tree.                                               |
| `Umb_Name`          | `Text`           | The name of the content. Indexed as highest relevance text.                  |
| `Umb_ObjectType`    | `Keyword`        | The content object type (for example "Document").                            |
| `Umb_ParentId`      | `Keyword`        | The ID (key) of the parent (if any).                                         |
| `Umb_PathIds`       | `Keyword`        | The IDs (keys) of all ancestors and the content itself.                      |
| `Umb_SortOrder`     | `Integer`        | The sort order of the content.                                               |
| `Umb_Tags`          | `Keyword`        | Accumulated collection of tags from all properties contained in the content. |
| `Umb_UpdateDate`    | `DateTimeOffset` | The last update date of the content.                                         |

System fields can be used like any other fields for searching. The system field names are defined in [`Constants.IndexFieldNames`](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Core/Constants-Indexes.cs).

{% code title="MySearchService.cs" %}
```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Search;
using Umbraco.Cms.Core.Search.Querying;
using Umbraco.Cms.Core.Search.Querying.Filtering;

namespace My.Site.Services;

public class MySearchService(ISearcher searcher)
{
    public async Task<SearchResult> FilterByNameAsync()
    {
        return await searcher.SearchAsync(
            indexAlias: Constants.IndexAliases.PublishedContent,
            filters:
            [
                new TextFilter(
                    FieldName: Constants.IndexFieldNames.Name,
                    Values: ["pink"],
                    Negate: false
                )
            ]
        );
    }
}
```
{% endcode %}
