---
description: How to extend Umbraco Deploy to synchronize custom data.
---

# Extend Deploy

Umbraco Deploy supports the deployment of CMS schema information and definitions from Umbraco HQ's Forms package, along with managed content and media. Additionally, it can be extended by package or custom solution developers. This allows the deployment of custom data, such as that stored in your own database tables.

As a package or solution developer, you can hook into the disk-based serialization and deployment. It is similar to that used for Umbraco Document Types and Data Types. It's also possible to provide the ability for editors to deploy custom data via the Backoffice. In the same way that Umbraco content and media can be queued for transfer and restored.

## Concepts and Examples

### Entities

_Entities_ are what you may be looking to transfer between two websites using Deploy. Within Umbraco, they are for example the Document Types, Data Types and Documents (content). In a custom solution or a package, there may be representations of some other data that's being stored separately from Umbraco schema or content. These can still be managed in the Backoffice using custom trees and editors.

For the purposes of subsequent code samples, consider an example entity as a Plain Old Class Object (POCO) with a few properties.

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

Provide a `GetUdi()` extension method to generate the appropriate identifier for a specific ID, and ensure it's not an open/root Unique Document Identifier (UDI):

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

In the following illustrative example, if deploying a representation of a "Person", the "Department" dependency is added. This will indicate that it must exist to allow the transfer. You can also use `ArtifactDependencyMode.Match` to ensure the dependent entity not only exists but also matches in all properties.

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

As well as dependencies at the level of entities, there can also be dependencies in the property values as well. In Umbraco, an example of this is the multi-node tree picker property editor. It contains references to other content items, that should also be deployed along with the content that hosts the property itself.

Value connectors are used to track these dependencies and can also be used to transform property data as it is moved between environments.

The following illustrative example considers a property editor that stores the integer ID of a media item. The integer ID of a media item is not consistent between environments, so it needs to be transformed. The related media item itself must also be transferred, as well as the integer ID reference.

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

If custom entity types are introduced that will be handled by Umbraco Deploy, they need to be registered with Umbraco to parse the UDI references. Deploy registers the entity type declared by the `UdiDefinition` attribute of each public service connector. You don't need to call `UdiParser.RegisterUdiType` yourself.

Deploy also needs to know how each entity type is deployed. Add the entity type to `DeployEntityTypesOptions` in a composer, either as a disk entity type or as a transfer entity type. An entity type can't be both. Deploy validates this when it builds the options.

To read the registered entity types, inject `IOptionsMonitor<DeployEntityTypesOptions>` and read `CurrentValue` where you need it. Don't read the options during startup.

### Disk-Based Transfers

To deploy the entity as schema, via disk-based representations held in `.uda` files, add the entity type as a disk entity type. This is done in a composer.

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

Then create a composer that adds the disk entity type and registers the notification handler:

```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Deploy.Core;
using Umbraco.Deploy.Core.Connectors.ServiceConnectors;
using Umbraco.Deploy.Infrastructure;
using Umbraco.Deploy.Infrastructure.Disk;
using Umbraco.Deploy.Infrastructure.NotificationHandlers;

public class ExampleDataDeployComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Deploy the entity type as schema, using .uda files
        builder.Services.Configure<DeployEntityTypesOptions>(options => options.AddDiskEntityType("mypackage-example"));

        // Register the saved notification handler (handles disk artifacts and signatures)
        builder.AddNotificationAsyncHandler<ExampleSavedNotification, ExampleSavedDeployRefresherNotificationAsyncHandler>();
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

All core Umbraco entities, such as Document Types and Data Types, will be shown. Custom entities added with `AddDiskEntityType` are also included.

The entity type name is used to look up a localized display name via the `deploy_entityTypes_{entityType}` or `general_{entityType}` localization keys. If no translation is provided, the plain entity type is used as the display name.

### Backoffice Integrated Transfers

Your entity might be best deployed by editors in the backoffice. In that case, add the entity type as a transfer entity type instead of a disk entity type. The process is similar, but a bit more involved. There's a need to also register details of the tree being used for editing the entities. In more complex cases, you also need to be able to handle the situation where multiple entity types are managed within a single tree.

An introduction to this feature can be found in the second half of [this recorded session from Codegarden 2021](https://youtu.be/8bgZmlJ7ScI?t=938).

There's also a code sample, demonstrated in the video linked above, available at [GitHub](https://github.com/AndyButland/RaceData).

The following code adds an entity type for Backoffice deployment, showing the simplest case of a single tree for the entity. Add the entity type in a composer:

{% code title="ExampleTransferDeployComposer.cs" %}

```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Deploy.Infrastructure;
using Umbraco.Deploy.Infrastructure.Transfer;

public class ExampleTransferDeployComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<DeployEntityTypesOptions>(options => options.AddTransferEntityType(
            "mypackage-example",
            new DeployTransferEntityTypeOptions
            {
                SupportsQueueForTransfer = true,
                SupportsQueueForTransferOfDescendents = true,
                SupportsRestore = true,
                PermittedToRestore = true,
                SupportsPartialRestore = true,
            }));
}
```

{% endcode %}

The `AddTransferEntityType` method takes the following parameters:

* The name of the entity type, as configured in the `UdiDefinition` attribute associated with your custom service connector.
* A `DeployTransferEntityTypeOptions` record, configuring which deploy operations are available from the tree menu for the entity.

The options record has the following properties. All are `false` by default:

* `SupportsQueueForTransfer` - the entity can be queued for transfer from the backoffice.
* `SupportsQueueForTransferOfDescendents` - the descendants of the entity can be queued for transfer along with it.
* `SupportsRestore` - the entity can be selected for a full restore.
* `SupportsPartialRestore` - the entity can be selected for a partial restore. To show the items of the remote environment, implement `ITreeServiceConnector` as described in the [Partial restore of remote items](#partial-restore-of-remote-items) section.
* `SupportsImportExport` - the entity can be imported and exported from the backoffice.
* `SupportsExportOfDescendants` - the descendants of the entity can be exported along with it.
* `PermittedToRestore` - the entity is deployed during a restore, for example as a dependency.

Adding the same entity type twice as a transfer entity type throws an `InvalidOperationException`.

{% hint style="info" %}
The entity type name is used to look up a localized display name via the `deploy_entityTypes_{entityType}` or `general_{entityType}` localization keys. If no translation is provided, the plain entity type is used as the display name.

Client-side entity types are tracked separately. If your client-side entity type differs from the server-side entity type, you can use a `deployEntityTypeMapping` manifest to map between them.
{% endhint %}

The following `umbraco-package.json` example adds localized names for two entity types and maps the client-side entity types to them:

{% code title="umbraco-package.json" %}

```json
{
  "id": "Umbraco.Commerce.Deploy",
  "name": "Umbraco Commerce Deploy",
  "version": "19.0.0",
  "extensions": [
    {
      "type": "localization",
      "alias": "Uc.Deploy.Localization.En",
      "weight": -100,
      "name": "English",
      "meta": {
        "culture": "en",
        "localizations": {
          "deploy_entityTypes": {
            "umbraco-commerce-product-attribute": "Umbraco Commerce Product Attribute",
            "umbraco-commerce-product-attribute-preset": "Umbraco Commerce Product Attribute Preset"
          }
        }
      }
    },
    {
      "type": "deployEntityTypeMapping",
      "alias": "Uc.Deploy.EntityTypeMapping",
      "name": "Umbraco Commerce Deploy Entity Type Mapping",
      "entityTypes": {
        "uc:product-attribute": "umbraco-commerce-product-attribute",
        "uc:product-attributes": "umbraco-commerce-product-attribute",
        "uc:product-attribute-preset": "umbraco-commerce-product-attribute-preset",
        "uc:product-attribute-presets": "umbraco-commerce-product-attribute-preset"
      }
    }
  ]
}
```

{% endcode %}

#### Partial restore of remote items

When `SupportsPartialRestore` is enabled, editors can select an item to restore from a tree showing the items in a remote environment. To provide the items in this tree, implement the `ITreeServiceConnector` interface on your service connector.

The `GetTreeItemsAsync` method returns a page of `TreeItem` records, each containing the UDI, name, icon, whether it has children, and the parent UDI. The method takes the following parameters:

* `parentUdi` - the UDI of the parent to return the children for. A `null` value or a root UDI requests the items at the root of the tree.
* `filter` - the search term entered by the editor. When set, return the matching items from all levels below the parent as a flat list. Your implementation decides what to match, typically the name.
* `skip` and `take` - the paging values. Throw an `ArgumentOutOfRangeException` when `skip` is negative or `take` is zero or negative.

The following example adds the interface to the `ExampleServiceConnector` shown in the [Service Connectors](#service-connectors) section. The example entities are a flat list, so only the root has children:

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models;
using Umbraco.Deploy.Core.Connectors.ServiceConnectors;
using Umbraco.Deploy.Infrastructure.Connectors.ServiceConnectors;

[UdiDefinition("mypackage-example", UdiType.GuidUdi)]
public class ExampleServiceConnector : ServiceConnectorBase<ExampleArtifact, GuidUdi, Example>, ITreeServiceConnector
{
    // Constructor and other members omitted for brevity

    public async Task<PagedModel<TreeItem>> GetTreeItemsAsync(
        Udi? parentUdi = null,
        string? filter = null,
        int skip = 0,
        int take = int.MaxValue,
        CancellationToken cancellationToken = default)
    {
        ArgumentOutOfRangeException.ThrowIfNegative(skip);
        ArgumentOutOfRangeException.ThrowIfNegativeOrZero(take);

        if (parentUdi is { IsRoot: false })
        {
            return new PagedModel<TreeItem>();
        }

        var items = new List<TreeItem>();
        await foreach (var example in _exampleDataService.GetExamplesAsync(cancellationToken))
        {
            if (string.IsNullOrWhiteSpace(filter) || example.Name.Contains(filter, StringComparison.OrdinalIgnoreCase))
            {
                items.Add(new TreeItem(example.GetUdi(), example.Name, "icon-box", false, null));
            }
        }

        return new PagedModel<TreeItem>(
            items.Count,
            items.OrderBy(x => x.Name).Skip(skip).Take(take).ToList());
    }
}
```

For large data sets, filter and page the items in your data store instead of in memory.

Deploy calls the connector of the parent's entity type to list its children, so a tree can contain more than one entity type. Return an empty page when you don't recognize the parent, instead of returning the root items.

{% hint style="info" %}
If your service connector doesn't implement `ITreeServiceConnector`, Deploy lists the items using the `ExpandRangeAsync` and `GetArtifactAsync` methods of the connector. This tree is flat and doesn't show icons.
{% endhint %}

### Refreshing Signatures

Umbraco Deploy improves the efficiency of transfers by caching signatures of each artifact in the database for each environment. The signature is a string-based, hashed representation of the serialized artifact. When an update is made to an entity, this signature value should be refreshed.

When using the `EntitySavedDeployRefresherNotificationAsyncHandlerBase` as shown in the [Disk Based Transfers](extending.md#disk-based-transfers) section above, signature refreshing is handled automatically when `HandleSignatures` is set to `true` (the default).

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
