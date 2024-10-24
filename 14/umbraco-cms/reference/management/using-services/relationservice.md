# Relation Service

The `RelationService` allows you to create relations between objects that would otherwise have no obvious connection.

Below you will find examples using `RelationService`.

## Automatically relate to root node

To perform the said task we need a Notification Handler:

[You can read more about composing Umbraco here](../../../implementation/composing.md)

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;

namespace Doccers.Core.Components;

public class ContentPublishedNotificationHandler(IContentService contentService, IRelationService relationService) : INotificationHandler<ContentPublishedNotification>
{
    public void Handle(ContentPublishedNotification notification)
    {
        var home = contentService.GetRootContent().FirstOrDefault();
        if (home == null) return;

        // Get the relation type by alias
        var relationType = relationService.GetRelationTypeByAlias("homesick");

        if (relationType == null) return;

        foreach (var entity in notification.PublishedEntities
                     .Where(x => x.Id != home.Id))
        {
            // Check if they are already related
            if (!relationService.AreRelated(home.Id, entity.Id))
            {
                // If not then let us relate the currenty entity to home
                relationService.Relate(home.Id, entity.Id, relationType);
            }
        }
    }
}
```

To have Umbraco recognize our Notification Handler we need to register it in a composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;

namespace Doccers.Core.Composers;

public class RelationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentPublishedNotification, ContentPublishedNotificationHandler>();
    }
}
```

If I know `Save and Publish` my `Products` node I get the following result:

![Relations](../../../../../10/umbraco-cms/reference/management/services/images/relations.PNG)

Now let us try and fetch the data from an API.

{% hint style="warning" %}
The example below uses UmbracoApiController which is obsolete in Umbraco 14 and will be removed in Umbraco 15.
{% endhint %}

```csharp
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Umbraco.Core.Services;
using Umbraco.Web.WebApi;

namespace Doccers.Core.Controllers.Http;

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

![Relations](../../../../../10/umbraco-cms/reference/management/services/images/relations-api.PNG)

{% hint style="info" %}

If you want to do something similar it is recommended that you wrap a caching layer around it, as the RelationService queries the database directly.

{% endhint %}
