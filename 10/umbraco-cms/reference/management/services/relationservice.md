# RelationService

The `RelationService` is pretty awesome as it allows you to create relations between objects that would otherwise have no obvious connection.

[Browse the API documentation for IRelationService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IRelationService.html).

* **Namespace:** `Umbraco.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

## Getting the service

When you are using an Umbraco controller class (Such as `SurfaceController` or `RenderMvcController`) you have access to the `RelationService` through the `ServiceContext`:

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

### GetAllRelations(params int\[] ids)

Gets a collection of `Umbraco.Core.Models.Relation` objects. Optional array of integer ids to return relations for.

Returns `IEnumerable<IRelation>`.

### GetAllRelationsByRelationType(RelationType relationType)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their relation type.

Returns `IEnumerable<IRelation>`.

### GetAllRelationsByRelationType(int relationTypeId)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their relation type id.

Returns `IEnumerable<IRelation>`.

### GetAllRelationTypes(params int\[] ids)

Gets a collection of `Umbraco.Core.Models.Relation` objects. Optional array of integer ids to return relationtypes for.

Returns `IEnumerable<IRelationType>`.

### GetByChild(IUmbracoEntity child)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their child entity.

Returns `IEnumerable<IRelation>`.

### GetByChild(IUmbracoEntity child, string relationTypeAlias)

Gets a collection of `Umbraco.Core.Models.Relation` objects their child entity and relation type alias.

Returns `IEnumerable<IRelation>`.

### GetByChildId(int id)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their child id.

Returns `IEnumerable<IRelation>`.

### GetById(int id)

Gets a `Umbraco.Core.Models.Relation` object by its id.

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

{% hint style="info" %}
Using this method will get you all relations regards of it being a child or parent relation.
{% endhint %}

### GetByParentOrChildId(int id)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their parent or child id.

Returns `IEnumerable<IRelation>`.

{% hint style="info" %}
Using this method will get you all relations regards of it being a child or parent relation.
{% endhint %}

### GetByRelationTypeAlias(string relationTypeAlias)

Gets a collection of `Umbraco.Core.Models.Relation` objects by their relation type alias.

Returns `IEnumerable<IRelation>`.

### GetByRelationTypeId(int relationTypeId)

Gets a collection of `Umbraco.Core.Models.Relation` objects by the id of their relation type.

Returns `IEnumerable<IRelation>`.

### GetByRelationTypeName(string relationTypeName)

Gets a collection of `Umbraco.Core.Models.Relation` objects by the name of their relation type.

Returns `IEnumerable<IRelation>`.

### GetChildEntitiesFromRelations(IEnumerable relations)

Gets the child objects from a collection of `IRelation` as a collection of `Umbraco.Core.Models.Entities.IUmbracoEntity`.

Returns `IEnumerable<IUmbracoEntity>`.

### GetChildEntityFromRelation(IRelation relation)

Gets the child object from a relation as an `Umbraco.Core.Models.Entities.IUmbracoEntity` object.

Returns `IUmbracoEntity`.

### GetEntitiesFromRelation(IRelation relation)

Gets the parent and child objects from a relation as a `System.Tuple` with `Umbraco.Core.Models.Entities.IUmbracoEntity`.

Returns `Tuple<IUmbracoEntity, IUmbracoEntity>`.

### GetEntitiesFromRelations(IEnumerable relations)

Gets the parent and child objects from a collection of relations as a list of `Umbraco.Core.Models.Entities.IUmbracoEntity` objects.

Returns `IEnumerable<Tuple<IUmbracoEntity, IUmbracoEntity>>`.

### GetParentEntitiesFromRelations(IEnumerable relations)

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

### Automatically relate to root node

Odd example, I know.. but why not?

To perform the said task we need a component in which we can register to the `ContentService.Published` event:

([You can read more about composing Umbraco here](../../../../implementation/composing/index.md))

```csharp
using System.Linq;
using Umbraco.Core.Composing;
using Umbraco.Core.Events;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;

namespace Doccers.Core.Components
{
    public class RelationComponent : IComponent
    {
        private readonly IRelationService _relationService;

        public RelationComponent(IRelationService relationService)
        {
            _relationService = relationService;
        }

        public void Initialize()
        {
            ContentService.Published += ContentService_Published;
        }

        private void ContentService_Published(IContentService sender,
            ContentPublishedEventArgs e)
        {
            // Should never be null, to be honest.
            var home = sender.GetRootContent()?.FirstOrDefault();
            if (home == null) return;

            // Get the relation type by alias
            var relationType = _relationService.GetRelationTypeByAlias("homesick");
            if (relationType == null) return;

            foreach (var entity in e.PublishedEntities
                .Where(x => x.Id != home.Id))
            {
                // Check if they are already related
                if (!_relationService.AreRelated(home.Id, entity.Id))
                {
                    // If not then let us relate the current entity to home
                    _relationService.Relate(home.Id, entity.Id, relationType);
                }
            }
        }

        public void Terminate() {
          //unsubscribe during shutdown
          ContentService.Published -= ContentService_Published;
        }
    }
}
```

To have Umbraco recognize our component we need to register it in a composer:

```csharp
using Doccers.Core.Components;
using Umbraco.Core;
using Umbraco.Core.Composing;

namespace Doccers.Core.Composers
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class RelationComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Components().Append<RelationComponent>();
        }
    }
}
```

If I know `Save and Publish` my `Products` node I get the following result:

![Relations](images/relations.PNG)

Cool! Now let us try and fetch the data from an API.

```csharp
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Umbraco.Core.Services;
using Umbraco.Web.WebApi;

namespace Doccers.Core.Controllers.Http
{
    public class RelationsController : UmbracoApiController
    {
        private readonly IRelationService _relationService;

        public RelationsController(IRelationService relationService)
        {
            // Alternatively you could also access
            // the service via the service context:
            // _relationService = Services.RelationService;
            _relationService = relationService;
        }

        [HttpGet]
        public HttpResponseMessage GetByRelationTypeAlias(string alias)
        {
            var relationType = _relationService.GetRelationTypeByAlias(alias);
            if (relationType == null)
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    "Invalid relation type alias");

            var relations = _relationService.GetAllRelationsByRelationType(relationType.Id);
            var content = relations.Select(x => Umbraco.Content(x.ChildId))
                .Select(x => new Relation()
                {
                    Name = x.Name,
                    UpdateDate = x.UpdateDate
                });

            return Request.CreateResponse(HttpStatusCode.OK, content);
        }
    }
}
```

Notice the `x => new Relation()`? We need to make sure what we are returning can be serialized. Therefore the `Relation` class is:

```csharp
[DataContract(Name = "relation")]
public class Relation
{
    [DataMember(Name = "name")]
    public string Name { get; set; }

    [DataMember(Name = "updateDate")]
    public DateTime UpdateDate { get; set; }
}
```

Browsing `/umbraco/api/relations/getbyrelationtypealias?alias=homesick` now returns the following:

![Relations](images/relations-api.PNG)

{% hint style="info" %}
If you want to do something similar to this it is recommended that you wrap a caching layer around it, as the RelationService queries the database directly.
{% endhint %}
