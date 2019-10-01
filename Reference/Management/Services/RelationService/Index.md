---
versionFrom: 8.0.0
---

# RelationService

The `RelationService` is pretty awesome as it allows you to create relations between objects that would otherwise have no obvious connection.

[Browse the API documentation for RelationService](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Core.Services.IRelationService.html).

* **Namespace:** `Umbraco.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

## Getting the service

If you are using an Umbraco controller class (Such as `SurfaceController` or `RenderMvcController`) you have access to the `RelationService` through the `ServiceContext`:

```csharp
using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;

namespace Doccers.Core.Controllers
{
    public class HomeController : RenderMvcController
    {
        public ActionResult Home(ContentModel model)
        {
            var rs = Services.RelationService;

            return CurrentTemplate(model);
        }
    }
}
```

You can also use the `RelationService` in any other class by injecting its interface:

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core.Services;

namespace Doccers.Core.Components
{
    public class RelationComponent : IComponent
    {
        private readonly IRelationService _relationService;

        public RelationComponent(IRelationService relationService)
        {
            _relationService = relationService;
        }

        public void Initialize() { }

        public void Terminate() { }
    }
}
```

## Methods

### AreRelated(int parentId, int childId, string relationTypeAlias)

Checks if two items are related.

Returns `bool`.

### AreRelated(IUmbracoEntity parent, IUmbracoEntity child, string relationTypeAlias)

Checks if two items are related.

Returns `bool`.

### AreRelated(int parentId, int childId)

Checks if two items are related.

Returns `bool`.

### Delete(IRelation relation)

Deletes a relation.

Returns `void`.

### Delete(IRelationType relationType)

Deletes a relation type.

Returns `void`.

### DeleteRelationsOfType(IRelationType relationType)

Deletes relation of the specified relation type.

Returns `void`.

### GetAllRelations(params int[] ids)

Gets all relations.

Returns `IEnumerable<IRelation>`.

### GetAllRelationsByRelationType(RelationType relationType)

Gets all relations by relation type.

Returns `IEnumerable<IRelation>`.

### GetAllRelationsByRelationType(int relationTypeId)

Gets all relations by relation type.

Returns `IEnumerable<IRelation>`.

### GetAllRelationTypes(params int[] ids)

Gets all relation types.

Returns `IEnumerable<IRelationType>`.

### GetByChild(IUmbracoEntity child)

Gets all relations by their child entity.

Returns `IEnumerable<IRelation>`.

### GetByChild(IUmbracoEntity child, string relationTypeAlias)

Gets relations by their child entity and relation type.

Returns `IEnumerable<IRelation>`.

### GetByChildId(int id)

Gets relations by their child id.

Returns `IEnumerable<IRelation>`.

### GetById(int id)

Gets a relation by its id.

Returns `IRelation`.

### GetByParent(IUmbracoEntity parent, string relationTypeAlias)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their parent entity and relation type alias.

Returns `IEnumerable<IRelation>`.

### GetByParent(IUmbracoEntity parent)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their parent entity.

Returns `IEnumerable<IRelation>`.

### GetByParentId(int id)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their parent id.

Returns `IEnumerable<IRelation>`.

### GetByParentOrChildId(int id, string relationTypeAlias)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their parent or child id and relation type alias.

Returns `IEnumerable<IRelation>`.

:::note
Using this method will get you all relations regards of it being a child or parent relation.
:::

### GetByParentOrChildId(int id)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their parent or child id.

Returns `IEnumerable<IRelation>`.

:::note
Using this method will get you all relations regards of it being a child or parent relation.
:::

### GetByRelationTypeAlias(string relationTypeAlias)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their relation type alias.

Returns `IEnumerable<IRelation>`.

### GetByRelationTypeId(int relationTypeId)

Gets a collection of `Umbraco.Core.Models.Relation` objects by the id of their relation type.

Returns `IEnumerable<IRelation>`.

### GetByRelationTypeName(string relationTypeName)

Gets a collection of `Umbraco.Core.Models.Relation` objects by the name of their relation type.

Returns `IEnumerable<IRelation>`.

### GetChildEntitiesFromRelations(IEnumerable<IRelation> relations)

Gets the child objects from a collection of `IRelation` as a collection of `Umbraco.Core.Models.Entities.IUmbracoEntity`.

Returns `IEnumerable<IUmbracoEntity>`.

### GetChildEntityFromRelation(IRelation relation)

Gets the child object from a relation as an `Umbraco.Core.Models.Entities.IUmbracoEntity` object.

Returns `IUmbracoEntity`.

### GetEntitiesFromRelation(IRelation relation)

Gets the parent and child objects from a relation as a `System.Tuple` with `Umbraco.Core.Models.Entities.IUmbracoEntity`.

Returns `Tuple<IUmbracoEntity, IUmbracoEntity>`.

### GetEntitiesFromRelations(IEnumerable<IRelation> relations)

Gets the parent and child objects from a collection of relations as a list of `Umbraco.Core.Models.Entities.IUmbracoEntity` objects.

Returns `IEnumerable<Tuple<IUmbracoEntity, IUmbracoEntity>>`.

### GetParentEntitiesFromRelations(IEnumerable<IRelation> relations)

Gets the parent objects from a collection of relations as a collection of `Umbraco.Core.Models.Entities.IUmbracoEntity`.

Returns `IEnumerable<IUmbracoEntity>`.

### GetParentEntityFromRelation(IRelation relation)

Gets the parent object from a relation as an `Umbraco.Core.Models.Entities.IUmbracoEntity` object.

### GetRelationTypeByAlias(string alias)

Gets an relation by its alias.

Returns `IRelationType`.

### GetRelationTypeById(Guid id)

Gets a relation type by its Id

Returns `IRelationType`.

### GetRelationTypeById(int id)

Gets a relation type by its id.

Returns `IRelationType`.

### HasRelations(IRelationType relationType)

Checks if any relations exist for the specified relation type.

Returns `bool`.

### IsRelated(int id)

Checks if any relations exist for the specified id.

Returns `void`.

### Relate(int parentId, int childId, IRelationType relationType)

Relates two objects by their ids using the specified relation type.

Returns `IRelation`.

### Relate(IUmbracoEntity parent, IUmbracoEntity child, IRelationType relationType)

Relates two `IUmbracoEntity` objects using the specified relation type.

Returns `IRelation`.

### Relate(IUmbracoEntity parent, IUmbracoEntity child, string relationTypeAlias)

Relates two `IUmbracoEntity` objects using the specified relation type alias.

Returns `IRelation`.

### Relate(int parentId, int childId, string relationTypeAlias)

Relates two `IUmbracoEntity` objects using the specified relation type alias.

Returns `IRelation`.

### Save(IRelation relation)

Saves a relation.

Returns `Void`.

### Save(IRelationType relationType)

Saves a relation type.

Returns `Void`.

## Examples

Below you will examples using the `RelationService`.
