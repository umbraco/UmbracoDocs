---
description: How to extend Umbraco Deploy to synchronize custom data.
---

# Extending

Umbraco Deploy supports the deployment of CMS schema information and definitions from the HQ's Forms package, along with managed content and media. Additionally, it can be extended by package or custom solution developers. This allows the deployment of custom data, such as that stored in your own database tables.

As a package or solution developer, you can hook into the disk-based serialization and deployment. It is similar to that used for Umbraco Document Types and Data Types. It's also possible to provide the ability for editors to deploy custom data via the Backoffice. In the same way that Umbraco content and media can be queued for transfer and restored.

## Concepts and Examples

### Entities

_Entities_ are what you may be looking to transfer between two websites using Deploy. Within Umbraco, they are for example the Document Types, Data Types and Documents (content). In a custom solution or a package, there may be representations of some other data that's being stored separately from Umbraco schema or content. These can still be managed in the Backoffice using custom trees and editors.

For the purposes of subsequent code samples, we'll consider an example entity as a Plain Old Class Object (POCO) with a few properties.

{% hint style="info" %}
The entity has no dependency on Umbraco or Umbraco Deploy; it can be constructed and managed however makes sense for the package or solution. The only requirement is that it has an ID that will be consistent across the environments (normally a Guid) and a name.
{% endhint %}

```csharp
public class Example
{
    public Guid Id { get; set; }

    public string Name { get; set; }

    public string Description { get; set; }
}
```

### Artifacts

Every entity Deploy works with, whether from Umbraco core or custom data, needs to have an _artifact_ representation. You can consider an artifact as a container capable of knowing everything there is to know about a particular entity is defined. They are used as a transport object for communicating between Deploy environments.

They can also be serialized to JSON representations. These are visible in the .uda files seen on disk in the `/data/revisions/` folder for schema transfers. It is also used when transferring content between different environments over HTTP requests.

Artifact classes must inherit from `DeployArtifactBase`.

The following example shows an artifact representing the entity and it's single property for transfer:

```csharp
public class ExampleArtifact : DeployArtifactBase<GuidUdi>
{
    public ExampleArtifact(GuidUdi udi, IEnumerable<ArtifactDependency> dependencies = null)
        : base(udi, dependencies)
    { }

    public string Description { get; set; }
}
```

#### Control Over Serialization

In most cases the default settings Umbraco Deploy uses for serialization will be appropriate. For example, it ensures that culture specific values such as dates and decimal numbers are rendered using an invariant culture. This ensures that any differences in regional settings between source and destination servers are not a concern.

If you do need more control, attributes can be applied to the artifact properties.

For example, to ensure a decimal value is serialized to a consistent number of decimal places you can use the following. `RoundingDecimalJsonConverter` is found in the `Umbraco.Deploy.Serialization` namespace

```csharp
[JsonConverter(typeof(RoundingDecimalJsonConverter), 2)]
public decimal Amount { get; set; }
```

### Service Connectors

Service connectors are responsible for knowing how to handle the mapping between artifacts and entities. They know how to gather all the data required for the type of entity they correspond to, including figuring out what dependencies are needed. For example, in Umbraco, how a Document Type depends on a Data Type. They are responsible for packaging an entity as an artifact and for extracting an entity from an artifact and persisting it in a destination site.

Service connectors inherit from `ServiceConnectorBase` and are constructed with the artifact and entity as generic type arguments.

The class is decorated with a `UdiDefinition` via which the name of the entity type is provided. This needs to be unique across all entities so it's likely worth prefixing with something specific to your package or application.

The following example shows a service connector, responsible for handling the artifact shown above and it's related entity. There are no dependencies to consider here. More complex examples involve collating the dependencies and potentially handling extraction in more than one pass to ensure updates are made in the correct order.

An illustrative data service is provided via dependency injection. This will be whatever is appropriate for to use for Create, Read, Update and Delete (CRUD) operations around reading and writing of entities.

{% hint style="info" %}
Service connectors support a caching mechanism via the `IContextCache` parameter. This allows connectors to read from and write to a cache during deploy operations, improving performance when the same data is requested multiple times.

It's recommended to only cache frequent lookups, like validating whether a parent entity exists. Deploy provides extension methods in `Umbraco.Deploy.Core.ContextCacheExtensions` for frequently used CMS service calls. If the `IContextCache` parameter is not available, you can create an instance from the `IDeployContext` using `new DeployContextCache(deployContext)`.
{% endhint %}

```csharp
using System.Runtime.CompilerServices;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Deploy;
using Umbraco.Deploy.Core.Connectors.ServiceConnectors;
using Umbraco.Deploy.Infrastructure.Connectors.ServiceConnectors;

[UdiDefinition("mypackage-example", UdiType.GuidUdi)]
public class ExampleServiceConnector : ServiceConnectorBase<ExampleArtifact, GuidUdi, Example>
{
    private readonly IExampleDataService _exampleDataService;

    public ExampleServiceConnector(IExampleDataService exampleDataService)
        => _exampleDataService = exampleDataService;

    protected override string[] ValidOpenSelectors => new[]
    {
        DeploySelector.This,
        DeploySelector.ThisAndDescendants,
        DeploySelector.DescendantsOfThis
    };

    protected override string OpenUdiName => "All Examples";

    protected override int[] ProcessPasses => new[] { 1 };

    public override async Task<ExampleArtifact?> GetArtifactAsync(
        GuidUdi udi,
        IContextCache contextCache,
        CancellationToken cancellationToken = default)
    {
        var entity = await _exampleDataService.GetExampleByIdAsync(udi.Guid, cancellationToken);
        if (entity is null)
        {
            return null;
        }

        return CreateArtifact(udi, entity);
    }

    public override Task<ExampleArtifact> GetArtifactAsync(
        Example entity,
        IContextCache contextCache,
        CancellationToken cancellationToken = default)
    {
        var artifact = CreateArtifact(entity.GetUdi(), entity);

        return Task.FromResult(artifact);
    }

    private ExampleArtifact CreateArtifact(
        GuidUdi udi, 
        Example entity)
    {
        var dependencies = new ArtifactDependencyCollection();

        var artifact = new ExampleArtifact(udi)
        {
            Description = entity.Description
        };

        artifact.Dependencies = dependencies;

        return artifact;
    }

    public override async IAsyncEnumerable<GuidUdi> ExpandRangeAsync(
        UdiRange range,
        [EnumeratorCancellation] CancellationToken cancellationToken = default)
    {
        if (range.Udi.IsRoot)
        {
            await foreach (var example in _exampleDataService.GetExamplesAsync(cancellationToken))
            {
                yield return example.GetUdi();
            }
        }
        else
        {
            yield return (GuidUdi)range.Udi;
        }
    }

    public override async Task<NamedUdiRange> GetRangeAsync(
        string entityType,
        string sid,
        string selector,
        CancellationToken cancellationToken = default)
    {
        EnsureType(entityType);

        if (sid == "-1")
        {
            EnsureOpenSelector(selector);

            return new NamedUdiRange(Udi.Create("mypackage-example"), OpenUdiName, selector);
        }

        if (!Guid.TryParse(sid, out Guid id))
        {
            throw new ArgumentException("Invalid identifier.", nameof(sid));
        }

        var entity = await _exampleDataService.GetExampleByIdAsync(id, cancellationToken);
        if (entity == null)
        {
            throw new ArgumentException("Could not find an entity with the specified identifier.", nameof(sid));
        }

        return new NamedUdiRange(entity.GetUdi(), entity.Name, selector);
    }

    public override async Task<NamedUdiRange> GetRangeAsync(
        GuidUdi udi,
        string selector,
        CancellationToken cancellationToken = default)
    {
        if (udi.IsRoot)
        {
            return new NamedUdiRange(udi, OpenUdiName, selector);
        }

        var entity = await _exampleDataService.GetExampleByIdAsync(udi.Guid, cancellationToken);
        if (entity == null)
        {
            throw new ArgumentException("Could not find an entity with the specified identifier.", nameof(udi));
        }

        return new NamedUdiRange(udi, entity.Name, selector);
    }

    public override async Task<ArtifactDeployState<ExampleArtifact, Example>> ProcessInitAsync(
        ExampleArtifact artifact,
        IDeployContext context,
        CancellationToken cancellationToken = default)
    {
        var entity = await _exampleDataService.GetExampleByIdAsync(artifact.Udi.Guid, cancellationToken);

        return CreateInitState(artifact, entity);
    }

    public override async Task ProcessAsync(
        ArtifactDeployState<ExampleArtifact, Example> state,
        IDeployContext context,
        int pass,
        CancellationToken cancellationToken = default)
    {
        state.NextPass = GetNextPass(pass);

        var artifact = state.Artifact;
        var isNew = state.Entity == null;
        var entity = state.Entity ?? new Example { Id = artifact.Udi.Guid };

        entity.Name = artifact.Name;
        entity.Description = artifact.Description;

        if (isNew)
        {
            await _exampleDataService.AddExampleAsync(entity, cancellationToken);
        }
        else
        {
            await _exampleDataService.UpdateExampleAsync(entity, cancellationToken);
        }
    }
}
```

Provide a `GetUdi()` extension method to generate the appropriate identifier for a specific ID, and ensure it's not an open/root UDI:

```csharp
public static GuidUdi GetUdi(this Example entity)
{
    if (entity == null) throw new ArgumentNullException("entity");
    return new GuidUdi("mypackage-example", entity.Id).EnsureClosed();
}
```

#### Handling Dependencies

Umbraco entities often have dependencies on one another, this may also be the case for any custom data you are looking to deploy. If so, you can add the necessary logic to your service connector to ensure dependencies are added. This will ensure Umbraco Deploy also ensures the appropriate dependencies are in place before initiating a transfer.

If the dependent entity is also deployable, it will be included in the transfer. Or if not, the deployment will be blocked and the reason presented to the user.

In the following illustrative example, if deploying a representation of a "Person", we ensure their "Department" dependency is added. This will indicate that it must exist to allow the transfer. We can also use `ArtifactDependencyMode.Match` to ensure the dependent entity not only exists but also matches in all properties.

```csharp
private PersonArtifact Map(GuidUdi udi, Person person, ICollection<ArtifactDependency> dependencies)
{
    var artifact = new PersonArtifact(udi)
    {
        Alias = person.Name,
        Name = person.Name,
        DepartmentId = person.Department.Id,
    };

    // Department node must exist to deploy the person.
    dependencies.Add(new ArtifactDependency(person.Department.GetUdi(), true, ArtifactDependencyMode.Exist));

    return artifact;
}
```

### Value Connectors

As well as dependencies at the level of entities, we can also have dependencies in the property values as well. In Umbraco, an example of this is the multi-node tree picker property editor. It contains references to other content items, that should also be deployed along with the content that hosts the property itself.

Value connectors are used to track these dependencies and can also be used to transform property data as it is moved between environments.

The following illustrative example considers a property editor that stores the integer ID of a media item. The integer ID of a media item is not consistent between environments, so we'll need to transform it. And we also want to ensure that the related media item itself is transferred as well as the integer ID reference.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Deploy;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
using Microsoft.Extensions.Logging;
using Umbraco.Deploy.Core.Connectors.ValueConnectors;

namespace MyExtensions;

public class MyMediaPropertyValueConnector : ValueConnectorBase
{
    private readonly IEntityService _entityService;
    private readonly ILogger<MyMediaPropertyValueConnector> _logger;

    public MyMediaPropertyValueConnector(IEntityService entityService, ILogger<MyMediaPropertyValueConnector> logger)
    {
        _entityService = entityService;
        _logger = logger;
    }

    public override IEnumerable<string> PropertyEditorAliases => new[] { "MyMediaPropertyEditor" };

    public override Task<string?> ToArtifactAsync(
        object? value,
        IPropertyType propertyType,
        ICollection<ArtifactDependency> dependencies,
        IContextCache contextCache,
        CancellationToken cancellationToken = default)
    {
        var svalue = value as string;
        if (string.IsNullOrWhiteSpace(svalue))
        {
            return Task.FromResult<string?>(null);
        }

        if (!int.TryParse(svalue, out var intvalue))
        {
            return Task.FromResult<string?>(null);
        }

        Attempt<Guid> getKeyAttempt = _entityService.GetKey(intvalue, UmbracoObjectTypes.Media);
        if (getKeyAttempt.Success)
        {
            var udi = new GuidUdi(Constants.UdiEntityType.Media, getKeyAttempt.Result);
            dependencies.Add(new ArtifactDependency(udi, false, ArtifactDependencyMode.Exist));

            return Task.FromResult<string?>(udi.ToString());
        }

        _logger.LogDebug("Couldn't convert integer value #{IntValue} to UDI", intvalue);

        return Task.FromResult<string?>(null);
    }

    public override Task<object?> FromArtifactAsync(
        string? value,
        IPropertyType propertyType,
        object? currentValue,
        IContextCache contextCache,
        CancellationToken cancellationToken = default)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return Task.FromResult<object?>(null);
        }

        if (!UdiParser.TryParse(value, out GuidUdi? udi) || udi!.Guid == Guid.Empty)
        {
            return Task.FromResult<object?>(null);
        }

        Attempt<int> getIdAttempt = _entityService.GetId(udi.Guid, UmbracoObjectTypes.Media);
        if (!getIdAttempt.Success)
        {
            return Task.FromResult<object?>(null);
        }

        return Task.FromResult<object?>(getIdAttempt.Result.ToString());
    }
}
```

## Registration

With the artifact and connectors in place, the final step necessary is to register your entity for deployment.

Connectors do not need to be registered. The fact that they inherit from particular interfaces known to Umbraco Deploy is enough to ensure that they will be used.

### Custom Entity Types

If custom entity types are introduced that will be handled by Umbraco Deploy, they need to be registered with Umbraco to parse the UDI references. This is done by calling `UdiParser.RegisterUdiType` in a composer, as shown in the [Disk Based Transfers](#disk-based-transfers) section below.

### Disk-Based Transfers

To deploy the entity as schema, via disk-based representations held in `.uda` files, it's necessary to register the entity with the disk entity service. This is done in a composer.

Additionally, when an entity is saved, the disk artifact and signature cache should be updated. This is handled by implementing a notification handler that inherits from `EntitySavedDeployRefresherNotificationAsyncHandlerBase`.

First, create a custom notification for your entity that inherits from `SavedNotification<T>`:

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

public class ExampleSavedNotification : SavedNotification<Example>
{
    public ExampleSavedNotification(Example target, EventMessages messages)
        : base(target, messages)
    { }

    public ExampleSavedNotification(IEnumerable<Example> target, EventMessages messages)
        : base(target, messages)
    { }
}
```

Then create a composer that registers the UDI type and notification handlers:

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Deploy.Core;
using Umbraco.Deploy.Core.Connectors.ServiceConnectors;
using Umbraco.Deploy.Infrastructure.Disk;
using Umbraco.Deploy.Infrastructure.NotificationHandlers;

public class ExampleDataDeployComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Register the custom UDI type with Umbraco
        UdiParser.RegisterUdiType("mypackage-example", UdiType.GuidUdi);

        // Register the application starting handler (registers disk entity types)
        builder.AddNotificationHandler<UmbracoApplicationStartingNotification, ExampleDeployStartingHandler>();

        // Register the saved notification handler (handles disk artifacts and signatures)
        builder.AddNotificationAsyncHandler<ExampleSavedNotification, ExampleSavedDeployRefresherNotificationAsyncHandler>();
    }

    private sealed class ExampleDeployStartingHandler : INotificationHandler<UmbracoApplicationStartingNotification>
    {
        private readonly IRuntimeState _runtimeState;
        private readonly IDiskEntityService _diskEntityService;

        public ExampleDeployStartingHandler(IRuntimeState runtimeState, IDiskEntityService diskEntityService)
        {
            _runtimeState = runtimeState;
            _diskEntityService = diskEntityService;
        }

        public void Handle(UmbracoApplicationStartingNotification notification)
        {
            if (_runtimeState.Level != RuntimeLevel.Run)
            {
                return;
            }

            _diskEntityService.RegisterDiskEntityType("mypackage-example");
        }
    }

    private sealed class ExampleSavedDeployRefresherNotificationAsyncHandler
        : EntitySavedDeployRefresherNotificationAsyncHandlerBase<Example, ExampleSavedNotification>
    {
        public ExampleSavedDeployRefresherNotificationAsyncHandler(
            IServiceConnectorFactory serviceConnectorFactory,
            IDiskEntityService diskEntityService,
            ISignatureService signatureService)
            : base(serviceConnectorFactory, diskEntityService, signatureService)
        {
            HandleDiskArtifacts = true;
            HandleSignatures = true;
        }
    }
}
```

The `HandleDiskArtifacts` property controls whether the artifact is written to disk as a `.uda` file, and the `HandleSignatures` property controls whether the signature cache is updated. Both default to `true`.

Finally, ensure your data service publishes the notification when an entity is saved:

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Scoping;

public class ExampleDataService : IExampleDataService
{
    private readonly ICoreScopeProvider _scopeProvider;
    private readonly IEventMessagesFactory _eventMessagesFactory;

    public ExampleDataService(ICoreScopeProvider scopeProvider, IEventMessagesFactory eventMessagesFactory)
    {
        _scopeProvider = scopeProvider;
        _eventMessagesFactory = eventMessagesFactory;
    }

    public async Task SaveExampleAsync(Example example)
    {
        using (ICoreScope scope = _scopeProvider.CreateCoreScope())
        {
            // Save the entity to your data store
            // ...

            // Publish the saved notification
            var notification = new ExampleSavedNotification(example, _eventMessagesFactory.Get());
            await scope.Notifications.PublishAsync(notification);

            scope.Complete();
        }
    }
}
```

#### Including Plugin Registered Disk Entities in the Schema Comparison Dashboard

The schema comparison feature available under _Settings > Deploy_, compares Umbraco’s Deploy-managed entities with the data held in the `.uda` files on disk.

All core Umbraco entities, such as Document Types and Data Types, will be shown. Custom entities registered with `RegisterDiskEntityType` are also included.

The entity type name is used to look up a localized display name via the `deploy_entityTypes_{entityType}` or `general_{entityType}` localization keys. If no translation is provided, the plain entity type is used as the display name.

### Backoffice Integrated Transfers

If the optimal deployment workflow for your entity is to have editors control the deployment operations, the transfer entity service should be used. This would be instead of registering with the disk entity service. The process is similar, but a bit more involved. There's a need to also register details of the tree being used for editing the entities. In more complex cases, we also need to be able to handle the situation where multiple entity types are managed within a single tree.

An introduction to this feature can be found in the second half of [this recorded session from Codegarden 2021](https://youtu.be/8bgZmlJ7ScI?t=938).

There's also a code sample, demonstrated in the video linked above, available at [GitHub](https://github.com/AndyButland/RaceData).

The following code shows the registration of an entity for Backoffice deployment, where we have the simplest case of a single tree for the entity. Registration should be done in an `UmbracoApplicationStartingNotification` handler:

```csharp
using Microsoft.AspNetCore.Http;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Deploy;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Deploy.Infrastructure.Transfer;

public class ExampleTransferDeployStartingHandler : INotificationHandler<UmbracoApplicationStartingNotification>
{
    private readonly IRuntimeState _runtimeState;
    private readonly ITransferEntityService _transferEntityService;

    public ExampleTransferDeployStartingHandler(
        IRuntimeState runtimeState,
        ITransferEntityService transferEntityService)
    {
        _runtimeState = runtimeState;
        _transferEntityService = transferEntityService;
    }

    public void Handle(UmbracoApplicationStartingNotification notification)
    {
        if (_runtimeState.Level != RuntimeLevel.Run)
        {
            return;
        }

        _transferEntityService.RegisterTransferEntityType(
            "mypackage-example",
            new DeployRegisteredEntityTypeDetailOptions
            {
                SupportsQueueForTransfer = true,
                SupportsQueueForTransferOfDescendents = true,
                SupportsRestore = true,
                PermittedToRestore = true,
                SupportsPartialRestore = true,
            },
            (string nodeId, HttpContext httpContext, out UdiRange? udiRange) =>
            {
                if (Guid.TryParse(nodeId, out Guid entityId))
                {
                    udiRange = new UdiRange(new GuidUdi("mypackage-example", entityId), DeploySelector.This);
                    return true;
                }
                udiRange = null;
                return false;
            },
            new DeployTransferRegisteredEntityTypeDetail.RemoteTreeDetail(
                ExampleTreeHelper.GetExampleTree, "example", "mypackage-example"));
    }
}
```

The `RegisterTransferEntityType` method on the `ITransferEntityService` takes the following parameters:

* The name of the entity type, as configured in the `UdiDefinition` attribute associated with your custom service connector.
* A set of options, allowing configuration of whether different deploy operations like queue for transfer and partial restore are made available from the tree menu for the entity.
* An optional function (`TryParseUdiRangeFromNodeIdDelegate`) used to parse the UDI range from a string-based node ID. For a single entity, this will likely be parsing a GUID from a string. When you have more than one entity in a tree, you must distinguish which entity a particular node ID is for based on the ID. Hence, it's likely the node ID will need to have a prefix or similar that this function needs to parse to extract the GUID. A prefix could look like "product-[guid]" or "store-[guid]".
* An optional `RemoteTreeDetail` parameter that adds support for implementing Deploy's "partial restore" feature.

{% hint style="info" %}
The entity type name is used to look up a localized display name via the `deploy_entityTypes_{entityType}` or `general_{entityType}` localization keys. If no translation is provided, the plain entity type is used as the display name.

Client-side entity types are tracked separately. If your client-side entity type differs from the server-side entity type, you can use a `deployEntityTypeMapping` manifest to map between them. See the [Version-specific Upgrade Guide](../upgrades/version-specific.md) for an example.
{% endhint %}

The `remoteTree` optional parameter adds support for plugins to implement Deploy's "partial restore" feature. This gives the editor the option to select an item to restore from a tree picker displaying details from a remote environment. The parameter is of type `DeployTransferRegisteredEntityTypeDetail.RemoteTreeDetail` that defines three pieces of information:

* A function responsible for returning a level of a tree.
* The name of the entity (or entities) that can be restored from the remote tree.
* The remote tree alias.

An example function that returns a level of a remote tree may look like this:

```csharp
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Deploy.Core.Environments;

public static IEnumerable<RemoteTreeEntity> GetExampleTree(string parentId, string entityType, HttpContext httpContext)
{
    var exampleDataService = httpContext.RequestServices.GetRequiredService<IExampleDataService>();
    var items = exampleDataService.GetItems(parentId);
    return items
        .Select(x => new RemoteTreeEntity
        {
            Id = x.Id.ToString(),
            Title = x.Name,
            Icon = "icon-box",
            ParentId = parentId,
            HasChildren = true,
            EntityType = entityType,
        })
        .ToList();
}
```

{% hint style="info" %}
Umbraco Deploy provides the `ExternalEntityTreeController` to serve the external entity tree for partial restore. When you register an entity type with a `RemoteTreeDetail`, Deploy automatically handles retrieving the tree from the remote environment using the provided `TreeEntityGetter` function. No custom tree controller implementation is required.
{% endhint %}

### Refreshing Signatures

Umbraco Deploy improves the efficiency of transfers by caching signatures of each artifact in the database for each environment. The signature is a string-based, hashed representation of the serialized artifact. When an update is made to an entity, this signature value should be refreshed.

When using the `EntitySavedDeployRefresherNotificationAsyncHandlerBase` as shown in the [Disk Based Transfers](#disk-based-transfers) section above, signature refreshing is handled automatically when `HandleSignatures` is set to `true` (the default).

If you only need to refresh signatures without writing disk artifacts, you can set `HandleDiskArtifacts = false`. An example of this could be for content entities that are transferred via the backoffice rather than disk:

```csharp
private sealed class ExampleSavedDeployRefresherNotificationAsyncHandler
    : EntitySavedDeployRefresherNotificationAsyncHandlerBase<Example, ExampleSavedNotification>
{
    public ExampleSavedDeployRefresherNotificationAsyncHandler(
        IServiceConnectorFactory serviceConnectorFactory,
        IDiskEntityService diskEntityService,
        ISignatureService signatureService)
        : base(serviceConnectorFactory, diskEntityService, signatureService)
    {
        HandleDiskArtifacts = false;
        HandleSignatures = true;
    }
}
```
