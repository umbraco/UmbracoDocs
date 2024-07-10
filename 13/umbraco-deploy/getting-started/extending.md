---
description: How to extend Umbraco Deploy to synchronize custom data
---

# Extending

Umbraco Deploy supports the deployment of CMS schema information and definitions from the HQ's Forms package, along with managed content and media. Additionally, it can be extended by package or custom solution developers. This allows the deployment of custom data, such as that stored in your own database tables.

As a package or solution developer, you can hook into the disk-based serialization and deployment. It is similar to that used for Umbraco Document Types and Data Types. It's also possible to provide the ability for editors to deploy custom data via the Backoffice. In the same way that Umbraco content and media can be queued for transfer and restored.

## Concepts and Examples

### Entities

_Entities_ are what you may be looking to transfer between two websites using Deploy. Within Umbraco, they are the Document Types, Data Type, documents etc. In a custom solution or a package, there may be representations of some other data that's being stored separately from Umbraco content. These can still be managed in the Backoffice using custom trees and editors.

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
In Deploy 9.5/10.1, to improve performance on deploy operations, we introduced a cache. This change required the addition of new methods to interfaces, allowing the passing in of a cache parameter. In order to introduce this without breaking changes, we created some new interfaces and base classes.

In the example below, if instead we inherited from `ServiceConnectorBase2`, which has a type parameter of `IServiceConnector2`, we would be able to implement `IArtifact? IServiceConnector2.GetArtifact(Udi udi, IContextCache contextCache)`. This would allow the connector to read and write to the cache and remove the use of the obsolete methods.

There's no harm in what is listed below though. It's only that the connectors won't be able to use the cache for any look-ups that are repeated in deploy operations. The obsolete methods won't be removed until Deploy 11. In that version we plan to return back to the original interface and class names. We also plan to introduce the new method overloads which will be a documented breaking change.
{% endhint %}

```csharp
[UdiDefinition("mypackage-example", UdiType.GuidUdi)]
public class ExampleServiceConnector : ServiceConnectorBase<ExampleArtifact, GuidUdi, ArtifactDeployState<ExampleArtifact, Example>>
{
    private readonly IExampleDataService _exampleDataService;

    public ExampleServiceConnector(IExampleDataService exampleDataService) => _exampleDataService = exampleDataService;

    public override ExampleArtifact GetArtifact(object o)
    {
        var entity = o as Example;
        if (entity == null)
        {
            throw new InvalidEntityTypeException($"Unexpected entity type \"{o.GetType().FullName}\".");
        }

        return GetArtifact(entity.GetUdi(), entity);
    }

    public override ExampleArtifact GetArtifact(GuidUdi udi)
    {
        EnsureType(udi);
        var entity = _exampleDataService.GetExampleById(udi.Guid);

        return GetArtifact(udi, entity);
    }

    private ExampleArtifact GetArtifact(GuidUdi udi, Example entity)
    {
        if (entity == null)
        {
            return null;
        }

        var dependencies = new ArtifactDependencyCollection();
        var artifact = Map(udi, entity, dependencies);
        artifact.Dependencies = dependencies;

        return artifact;
    }

    private ExampleArtifact Map(GuidUdi udi, Example entity, ICollection<ArtifactDependency> dependencies)
    {
        var artifact = new ExampleArtifact(udi);
        artifact.Description = example.Description;
        return artifact;
    }

    private string[] ValidOpenSelectors => new[]
    {
        DeploySelector.This,
        DeploySelector.ThisAndDescendants,
        DeploySelector.DescendantsOfThis
    };
    private const string OpenUdiName = "All Examples";

    public override void Explode(UdiRange range, List<Udi> udis)
    {
        EnsureType(range.Udi);

        if (range.Udi.IsRoot)
        {
            EnsureSelector(range, ValidOpenSelectors);
            udis.AddRange(_exampleDataService.GetExamples().Select(e => e.GetUdi()));
        }
        else
        {
            var entity = _exampleDataService.GetExampleById(((GuidUdi)range.Udi).Guid);
            if (entity == null)
            {
                return;
            }

            EnsureSelector(range.Selector, DeploySelector.This);
            udis.Add(entity.GetUdi());
        }
    }

    public override NamedUdiRange GetRange(string entityType, string sid, string selector)
    {
        if (sid == "-1")
        {
            EnsureSelector(selector, ValidOpenSelectors);
            return new NamedUdiRange(Udi.Create("mypackage-example"), OpenUdiName, selector);
        }

        if (!Guid.TryParse(sid, out Guid id))
        {
            throw new ArgumentException("Invalid identifier.", nameof(sid));
        }

        var entity = _exampleDataService.GetExampleById(id);
        if (entity == null)
        {
            throw new ArgumentException("Could not find an entity with the specified identifier.", nameof(sid));
        }

        return GetRange(entity, selector);
    }

    public override NamedUdiRange GetRange(GuidUdi udi, string selector)
    {
        EnsureType(udi);

        if (udi.IsRoot)
        {
            EnsureSelector(selector, ValidOpenSelectors);
            return new NamedUdiRange(udi, OpenUdiName, selector);
        }

        var entity = _exampleDataService.GetExampleById(udi.Guid);
        if (entity == null)
        {
            throw new ArgumentException("Could not find an entity with the specified identifier.", nameof(udi));
        }

        return GetRange(entity, selector);
    }

    private static NamedUdiRange GetRange(Example e, string selector) => new NamedUdiRange(e.GetUdi(), e.Name, selector);

    public override ArtifactDeployState<ExampleArtifact, Example> ProcessInit(ExampleArtifact art, IDeployContext context)
    {
        EnsureType(art.Udi);

        var entity = _exampleDataService.GetExampleById(art.Udi.Guid);

        return ArtifactDeployState.Create(art, entity, this, 1);
    }

    public override void Process(ArtifactDeployState<ExampleArtifact, Example> state, IDeployContext context, int pass)
    {
        switch (pass)
        {
            case 1:
                Pass1(state, context);
                state.NextPass = 2;
                break;
            default:
                state.NextPass = -1; // exit
                break;
        }
    }

    private void Pass1(ArtifactDeployState<ExampleArtifact, Example> state, IDeployContext context)
    {
        var artifact = state.Artifact;

        artifact.Udi.EnsureType("mypackage-example");

        var isNew = state.Entity == null;

        var entity = state.Entity ?? new Example { Id = artifact.Udi.Guid };

        entity.Name = artifact.Name;
        entity.Description = artifact.Description;

        if (isNew)
        {
            _exampleDataService.AddExample(entity);
        }
        else
        {
            _exampleDataService.UpdateExample(entity);
        }
    }
}
```

It's also necessary to provide an extension method to generate the appropriate identifier:

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

The following illustrative example considers a property editor that stores the integer ID of an media item. The integer ID of a media item is not consistent between environments, so we'll need to transform it. And we also want to ensure that the related media item itself is transferred as well as the integer ID reference.

```c#
using Umbraco.Cms.Core.Deploy;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core;
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

    public override string? ToArtifact(object? value, IPropertyType propertyType, ICollection<ArtifactDependency> dependencies, IContextCache contextCache)
    {
        var svalue = value as string;
        if (string.IsNullOrWhiteSpace(svalue))
        {
            return null;
        }

        if (!int.TryParse(svalue, out var intvalue))
        {
            return null;
        }

        Attempt<Guid> getKeyAttempt = _entityService.GetKey(intvalue, UmbracoObjectTypes.Media);

        if (getKeyAttempt.Success)
        {
            var udi = new GuidUdi(Constants.UdiEntityType.Media, getKeyAttempt.Result);
            dependencies.Add(new ArtifactDependency(udi, false, ArtifactDependencyMode.Exist));

            return udi.ToString();
        }
        else
        {
            _logger.LogDebug($"Couldn't convert integer value #{intvalue} to UDI");
        }

        return null;
    }

    public override object? FromArtifact(string? value, IPropertyType propertyType, object? currentValue, IContextCache contextCache)
    {
        if (string.IsNullOrWhiteSpace(value))
        {
            return null;
        }

        if (!UdiParser.TryParse(value, out GuidUdi? udi) || udi!.Guid == Guid.Empty)
        {
            return null;
        }

        Attempt<int> getIdAttempt = _entityService.GetId(udi.Guid, UmbracoObjectTypes.Media);

        if (!getIdAttempt.Success)
        {
            return null;
        }

        return getIdAttempt.Result.ToString();
    }
}
```

### Grid Cell Value Connector

The third and final type of connector is the grid cell value connector. These are responsible for converting values and tracking dependencies for grid editors.

Umbraco Deploy comes with connectors for the built-in editors such as for media and macros.

It's also possible to create your own, as in this example.

The following grid editor is an illustrative example for a rudimentary custom image picker. It contains a package mamifest file:

```json
{
    "gridEditors": [
        {
            "name": "TestImagePicker",
            "alias": "testImagePicker",
            "view": "/App_Plugins/TestGridEditor/editor.html",
            "icon": "icon-code"
        }
    ]
}
```

And an editor view:

```html
<div>
    <label>Enter The Integer Id Of An Image:</label>
    <input ng-model="control.value" type="number">
</div>
```

The value stored by the grid editor will be the integer Id of a media item.

When transferring this value to an upstream environment using Umbraco Deploy, these tasks are required:

* The integer Id needs to be converted to a Guid for transfer. Guids for content and media are the same across environments but integer Ids will differ.
* On creation in the upstream environment, the Guid value needs to be converted back to an integer for storage in the grid editor.
* A dependency on the selected media item needs to be tracked, such that it will be transferred to the upstream environment along with the changes to the grid content.

We can implement that via a grid cell value connector. The following code is for Umbraco Deploy 10.1. For earlier versions, or from Umbraco Deploy 11, the base class should be `GridCellValueConnectorBase`.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Deploy;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Services;
using Umbraco.Deploy.Core;

namespace Umbraco.Deploy.Infrastructure.Connectors.GridCellValueConnectors
{
    public class CustomMediaGridCellValueConnector : GridCellValueConnectorBase2
    {
        public CustomMediaGridCellValueConnector(IEntityService entityService, ILocalLinkParser localLinkParser)
            : base(entityService, localLinkParser)
        {
        }

        public override bool IsConnector(string view) => string.Equals(view, "/App_Plugins/TestGridEditor/editor.html", StringComparison.OrdinalIgnoreCase);
        public override string? GetValue(GridValue.GridControl control, ICollection<ArtifactDependency> dependencies, IContextCache contextCache)
        {
            var value = control.Value?.ToString();
            if (string.IsNullOrEmpty(value))
            {
                return null;
            }

            if (!int.TryParse(value, out var valueAsInt))
            {
                return null;
            }

            Udi? mediaUdi = GetUdi(valueAsInt, UmbracoObjectTypes.Media);
            if (mediaUdi == null)
            {
                return null;
            }
            dependencies.Add(new ArtifactDependency(mediaUdi, false, ArtifactDependencyMode.Exist));
            return mediaUdi.ToString();
        }
        public override void SetValue(GridValue.GridControl control, IContextCache contextCache)
        {
            var value = control.Value?.ToString();
            if (string.IsNullOrWhiteSpace(value))
            {
                return;
            }

            var guidUdi = UdiParser.Parse(value.ToString() ?? string.Empty) as GuidUdi;
            if (guidUdi == null)
            {
                return;
            }

            var mediaId = GetNodeId(guidUdi);
            if (!mediaId.HasValue)
            {
                return;
            }

            control.Value = mediaId.Value;
        }
    }
}
```

## Registration

With the artifact and connectors in place, the final step necessary is to register your entity for deployment.

Connectors do not need to be registered. The fact that they inherit from particular interfaces known to Umbraco Deploy is enough to ensure that they will be used.

### Custom Entity Types

If custom entity types are introduced that will be handled by Umbraco Deploy, they need to be registered with Umbraco to parse the UDI references.

This is done via the following code, which can be triggered from a Umbraco component or an `UmbracoApplicationStartingNotification` handler.

```
UdiParser.RegisterUdiType("mypackage-example", UdiType.GuidUdi);
```

### Disk Based Transfers

To deploy the entity as schema, via disk based representations held in `.uda` files, it's necessary to register the entity with the disk entity service. This is done in a component, where events are used to trigger a serialization of the entity to disk whenever one of them is saved.

```csharp
public class ExampleDataDeployComponent : IComponent
{
    private readonly IDiskEntityService _diskEntityService;
    private readonly IServiceConnectorFactory _serviceConnectorFactory;
    private readonly IExampleDataService _exampleDataService;

    public ExampleDataDeployComponent(
        IDiskEntityService diskEntityService,
        IServiceConnectorFactory serviceConnectorFactory,
        IExampleDataService exampleDataService)
        {
            _diskEntityService = diskEntityService;
            _serviceConnectorFactory = serviceConnectorFactory;
            _exampleDataService = exampleDataService;
        }

    public void Initialize()
    {
        _diskEntityService.RegisterDiskEntityType("mypackage-example");
        _exampleDataService.ExampleSaved += ExampleOnSaved;
    }

    private void ExampleOnSaved(object sender, ExampleEventArgs e)
    {
        var artifact = GetExampleArtifactFromEvent(e);
        _diskEntityService.WriteArtifacts(new[] { artifact });
    }

    private IArtifact GetExampleArtifactFromEvent(ExampleEventArgs e)
    {
        var udi = e.Example.GetUdi();
        return _serviceConnectorFactory.GetConnector(udi.EntityType).GetArtifact(e.Example);
    }

    public void Terminate()
    {
    }
}
```

#### Including Plugin Registered Disk Entities in the Schema Comparison Dashboard

In Umbraco Deploy 9.4 a schema comparison feature was added to the dashboard available under _Settings > Deploy_. This lists the Deploy managed entities held in Umbraco and shows a comparison with the data held in the `.uda` files on disk.

All core Umbraco entities, such as Document Types and Data Types, will be shown.

To include entities from plugins, they need to be registered using a method overload as shown above, that allows to provide additional detail, e.g.:

```csharp
_diskEntityService.RegisterDiskEntityType(
    "mypackage-example",
    "Examples",
    false,
    _exampleDataService.GetAll().Select(x => new DeployDiskRegisteredEntityTypeDetail.InstalledEntityDetail(x.GetUdi(), x.Name, x))));
```

The parameters are as follows:

* The system name of the entity type (as used in the `UdiDefinition` attribute).
* A human readable, pluralized name for display in the schema comparison dashboard user interface.
* A flag indicating whether the entity is an Umbraco one, which should be set to `false`.
* A function that returns all entities of the type installed in Umbraco, mapped to an object exposing the Udi and name of the entity.

### Backoffice Integrated Transfers

If the optimal deployment workflow for your entity is to have editors control the deployment operations, the transfer entity service should be used. This would be instead of registering with the disk entity service. The process is similar, but a bit more involved. There's a need to also register details of the tree being used for editing the entities. In more complex cases, we also need to be able to handle the situation where multiple entity types are managed within a single tree.

An introduction to this feature can be found in the second half of [this recorded session from Codegarden 2021](https://youtu.be/8bgZmlJ7ScI?t=938).

There's also a code sample, demonstrated in the video linked above, available [here](https://github.com/AndyButland/RaceData).

The following code shows the registration of an entity for Backoffice deployment, where we have the simplest case of a single tree for the entity.

```csharp
public class ExampleDataDeployComponent : IComponent
{
    private readonly ITransferEntityService _transferEntityService;
    private readonly IExampleDataService exampleDataService;

    public ExampleDataDeployComponent(
        ITransferEntityService transferEntityService,
        IExampleDataService exampleDataService)
    {
        _transferEntityService = transferEntityService;
        _exampleDataService = exampleDataService;
    }

    public void Initialize()
    {
        _transferEntityService.RegisterTransferEntityType(
            "mypackage-example",
            "Examples",
            new DeployRegisteredEntityTypeDetailOptions
            {
                SupportsQueueForTransfer = true,
                SupportsQueueForTransferOfDescendents = true,
                SupportsRestore = true,
                PermittedToRestore = true,
                SupportsPartialRestore = true,
            },
            false,
            "exampleTreeAlias",
            (string routePath, HttpContext httpContext) => true,
            (string nodeId, HttpContext httpContext) => true,
            (string nodeId, HttpContext httpContext, out Guid entityId) => Guid.TryParse(nodeId, out entityId),
            new DeployRegisteredEntityTypeDetail.RemoteTreeDetail(FormsTreeHelper.GetExampleTree, "example", "externalExampleTree"),
            entitiesGetter: () => _exampleDataService.Get());
    }

    public void Terminate()
    {
    }
}
```

The `RegisterTransferEntityType` method on the `ITransferEntityService` takes the following parameters:

* The name of the entity type, as configured in the `UdiDefinition` attribute associated with your custom service connector.
* A pluralized, human-readable name of the entity, which is used in the transfer queue visual presentation to users.
* A set of options, allowing configuration of whether different deploy operations like queue for transfer and partial restore are made available from the tree menu for the entity.
* A value indicating whether the entity is an Umbraco entity, queryable via the `IEntityService`. For custom solutions and packages, the value to use here is always `false`.
* The alias of the tree used for creating and editing the entity data.

We then have three functions, which are used to determine if the registered entity matches a specific node and tree alias. For trees managing single entities as we have here, we know that all nodes related to that tree alias will be for the registered entity. And that each node Id is the Guid identifier for the entity. Hence we can use the following function definitions:

* Return `true` for all route paths.
* Return `true` for all node Ids.
* Return `true` and parse the Guid identity value from the provided string.

For more complex cases we need the means to distinguish between entities. An example could be when a tree manages more than one entity type. Here we would need to identify whether the entity is being referenced by a particular route path or node ID. A common way to handle this is to prefix the GUID identifier with a different value for each entity. It can then be used to determine to which entity the value refers.

For example, as shown in the linked sample and video, we have entities for "Team" and "Rider", both managed in the same tree. When rendering the tree, a prefix of "team-" or "rider-" is added to the Guid identifier for the team or rider respectively. We then register the following functions, firstly for the team entity registration:

```csharp
_transferEntityService.RegisterTransferEntityType(
    ...
    "teams",
    (string routePath, HttpContext httpContext) => routePath.Contains($"/teamEdit/") || routePath.Contains($"/teamsOverview"),
    (string nodeId, HttpContext httpContext) => nodeId == "-1" || nodeId.StartsWith("team-"),
    (string nodeId, HttpContext httpContext, out Guid entityId) => Guid.TryParse(nodeId.Substring("team-".Length), out entityId);
```

And then for the rider:

```csharp
_transferEntityService.RegisterTransferEntityType(
    ...
    "teams",
    (string routePath) => routePath.Contains($"/riderEdit/"),
    (string nodeId) => nodeId.StartsWith("rider-"),
    (string nodeId, HttpContext httpContext, out Guid entityId) => Guid.TryParse(nodeId.Substring("rider-".Length), out entityId);
```

If access to services is required when parsing the entity ID, where the `HttpContext` is provided as a parameter, a service can be retrieved. For example:

```csharp
var localizationService = httpContext.RequestServices.GetRequiredService<ILocalizationService>();
```

The `remoteTree` optional parameter adds support for plugins to implement Deploy's "partial restore" feature. This gives the editor the option to select an item to restore, from a tree picker displaying details from a remote environment. The parameter is of type `DeployRegisteredEntityTypeDetail.RemoteTreeDetail` that defines three pieces of information:

* A function responsible for returning a level of a tree.
* The name of the entity (or entities) that can be restored from the remote tree.
* The remote tree alias.

An example function that returns a level of a remote tree may look like this:

```csharp
public static IEnumerable<RemoteTreeNode> GetExampleTree(string parentId, HttpContext httpContext)
{
    var exampleDataService = httpContext.RequestServices.GetRequiredService<IExampleDataService>();
    var items = exampleDataService.GetItems(parentId);
    return items
        .Select(x => new RemoteTreeNode
        {
            Id = x.Id,,
            Title = x.Name,
            Icon = "icon-box",
            ParentId = parentId,
            HasChildren = true,
        })
        .ToList();
}
```

Finally, the `entitiesGetter` parameter allows you to pass a function that will return all entities for the registered type. This is necessary to allow support for the "set signatures" operation available via the backoffice settings dashboard. By providing a function that returns the collection of entities, the triggered operation will be able to prepare the signature for each one.

To complete the setup for partial restore support, an external tree controller needs to be added, attributed to match the registered tree alias. Using a base class available in `Umbraco.Deploy.Forms.Tree`, this can look like the following:

```csharp
[Tree(DeployConstants.SectionAlias, "externalExampleTree", TreeUse = TreeUse.Dialog)]
public class ExternalDataSourcesTreeController : ExternalTreeControllerBase
{
    public ExternalDataSourcesTreeController(
        ILocalizedTextService localizedTextService,
        UmbracoApiControllerTypeCollection umbracoApiControllerTypeCollection,
        IEventAggregator eventAggregator,
        IExtractEnvironmentInfo environmentInfoExtractor,
        LinkGenerator linkGenerator,
        ILoggerFactory loggerFactory,
        IOptions<DeploySettings> deploySettings)
        : base(localizedTextService, umbracoApiControllerTypeCollection, eventAggregator, environmentInfoExtractor, linkGenerator, loggerFactory, deploySettings, "mypackage-example")
    {
    }
}
```

#### Client-Side Registration

Most features that are available for the deployment of Umbraco entities will also be accessible to entities defined in custom solutions or packages. The "Transfer Now" option available from "Save and Publish" or "Save" button for content/media is only available to custom entities if requested client-side.

You would do this in the custom AngularJS controller responsible for handling the edit operations on your entity. Inject the `pluginEntityService` and calling the `addInstantDeployButton` function as shown in the following stripped down sample (for the full code, see the sample data repository linked above):

```js
(function () {
    "use strict";

    function MyController($scope, $routeParams, myResource, formHelper, notificationsService, editorState, pluginEntityService) {

        var vm = this;

        vm.page = {};
        vm.entity = {};
        ...

        vm.page.defaultButton = {
            alias: "save",
            hotKey: "ctrl+s",
            hotKeyWhenHidden: true,
            labelKey: "buttons_save",
            letter: "S",
            handler: function () { vm.save(); }
        };
        vm.page.subButtons = [];

        function init() {

            ...

            if (!$routeParams.create) {

                myResource.getById($routeParams.id).then(function (entity) {

                    vm.entity = entity;

                    // Augment with additional details necessary for identifying the node for a deployment.
                    vm.entity.metaData = { treeAlias: $routeParams.tree };

                    ...
                });
            }

            pluginEntityService.addInstantDeployButton(vm.page.subButtons);
        }

        ...

        init();

    }

    angular.module("umbraco").controller("MyController", MyController);

})();
```

### Refreshing Signatures

Umbraco Deploy improves the efficiency of transfers by caching signatures of each artifacts in the database for each environment. The signature is a string based, hashed representation of the serialized artifact. When an update is made to an entity, this signature value should be refreshed.

Hooking this up can be achieved by applying code similar to the following, extending the `ExampleDataDeployComponent` shown above.

```csharp
public class ExampleDataDeployComponent : IComponent
{
    ...
    private readonly ISignatureService _signatureService;

    public ExampleDataDeployComponent(
    ...
    ISignatureService signatureService)
    {
        _signatureService = signatureService;
    }

    public void Initialize()
    {
        ...
        _signatureService.RegisterHandler<ExampleDataService, ExampleEventArgs>(nameof(IExampleDataService.ExampleSaved), (refresher, args) => refresher.SetSignature(GetExampleArtifactFromEvent(args)));
    }

    ...
}
```
