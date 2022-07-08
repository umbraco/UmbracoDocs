---
versionFrom: 6.1.1
---

# RelationService

:::note
Applies to Umbraco 6.1.1 and newer
:::

The RelationService acts as a "gateway" to Umbraco data for operations which are related to Relations.

[Browse the API documentation for RelationService](https://our.umbraco.com/apidocs/v7/csharp/api/Umbraco.Core.Services.RelationService.html).

* **Namespace:** `Umbraco.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
```

## Getting the service

The RelationService is available through the `ApplicationContext`, or if you are using a `SurfaceController` or the `UmbracoUserControl` then the RelationService is available through a local `Services` property.

```csharp
Services.RelationService
```

Getting the service through the `ApplicationContext`:

```csharp
ApplicationContext.Current.Services.RelationService
```









## Samples

```csharp
public IENumerable<IPublishedContent> GetFavorites(int memberId)
{
    var rs = ApplicationContext.Current.Services.RelationService;
    var relType = rs.GetRelationTypeByAlias("memberFavorites");
    var favorites = new List<IPublishedContent>();

    if (memberId > 0)
    {
        var relations = rs.GetByParentId(memberId).Where(r => r.RelationType.Alias == "memberFavorites");

    foreach (var relation in relations)
    {
        favorites.Add(UmbracoContext.Current.ContentCache.GetById(relation.ChildId));
    }
    }

    return favorites;
}
```
















```csharp
public void SetFavorite(int memberId, int contentId) {
    var rs = ApplicationContext.Current.Services.RelationService;
    var areRelated = rs.AreRelated(memberId, contentId, "memberFavorites");

    if (!areRelated)
    {
        // create relation
        var relType = rs.GetRelationTypeByAlias("memberFavorites");
        var r = new Relation(memberId, contentId, relType);
        rs.Save(r);
    }
}
```




