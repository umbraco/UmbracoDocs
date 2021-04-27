---
versionFrom: 8.0.0
meta.Title: "Extending Umbraco Deploy"
meta.Description: "How to extend Umbraco Deploy to synchronize custom data"
---

# Extending Umbraco Deploy

Umbraco Deploy supports the deployment of CMS schema information, definitions from the HQ's Forms package, along with managed content and media.  In addition it can be extended by package or custom solution developers to allow the deployment of custom data, such as that stored in your own database tables.

Currently supported is the ability to hook into the disk based serialization and deployment - similar to that used for Umbraco document types and data types.  In a later release we plan to also support deployment of custom data via the backoffice - similar to how Umbraco content and media can be queued for transfer and restored.

## Concepts

### Entities

*Entities* are what you may be looking to transfer between two websites using Deploy.  Within Umbraco, they are the document types, data type, documents etc.  In a custom solution or a package, they may be representations of some other data that's being stored separately from Umbraco content, whilst still managed in the backoffice using custom trees and editors.

For the purposes of subsequent code samples, we'll consider an example entity as a POCO class with a few properties.  Note that the entity has no dependency on Umbraco or Umbraco Deploy; it can be constructed and managed however makes sense for the package or solution.  The only requirement is that it has an ID that will be consistent across the environments (normally a Guid) and a name.

```C#
    public class Example
    {
        public Guid Id { get; set; }

        public string Name { get; set; }        

        public string Description { get; set; }
    }
```

### Artifacts

Every entity Deploy works with, whether from Umbraco core or custom data, needs to have an *artifact* representation. You can consider an artifact as a container capable of knowing everything there is to know about a particular entity is defined. They are used as a transport object for communicating between Deploy environments.  

They can also be serialized to JSON representations.  These are visible in the .uda files seen on disk in the `/data/revisions/` folder for schema transfers and are also used when transferring content between different environments over HTTP requests.

Artifact classes must inherit from `DeployArtifactBase`.

The following example shows an artifact representing the entity and it's single property for transfer:

```C#
    public class ExampleArtifact : DeployArtifactBase<GuidUdi>
    {
        public ExampleArtifact(GuidUdi udi, IEnumerable<ArtifactDependency> dependencies = null)
            : base(udi, dependencies)
        { }

        public string Description { get; set; }
    }
```

#### Control Over Serialization

In most cases the default settings Umbraco Deploy uses for serialization will be appropriate.  For example, it ensures that culture specific values such as dates and decimal numbers are rendered using an invariant culture to ensure that any differences in regional settings between source and destination servers are not a concern.

If you do need more control, attributes can be applied to the artifact properties.

For example, to ensure a decimal value is serialized to a consistent number of decimal places you can use the following (where `RoundingDecimalJsonConverter` is found in the `Umbraco.Deploy.Serialization` namespace):

```C#
    [JsonConverter(typeof(RoundingDecimalJsonConverter), 2)]
    public decimal Amount { get; set; }
```

### Service Connectors

Service connectors are responsible for knowing how to handle the mapping between artifacts and entities. They know how to gather all the data required for the type of entity they correspond to, including figuring out what dependencies are needed (e.g. in Umbraco, how a document type will depend on a data type). They are responsible for packaging an entity as an artifact and for knowing how to extract an entity from an artifact and persist it in a destination site.

Service connectors inherit from `ServiceConnectorBase` and are constructed with the artifact and entity as generic type arguments.

The class is decorated with a `UdiDefinition` via which the name of the entity type is provided.  This needs to be unique across all entities so it's likely worth prefixing with something specific to your package or application.

The following example shows a service connector, responsible for handling the artifact shown above and it's related entity.  There are no dependencies to consider here.  More complex examples will involve collating the dependencies and potentially handling the extraction in more than one pass to ensure updates are made in the correct order.

Note that an illustrative data service is provided via dependency injection.  This will be whatever is appropriate for your solution to use for CRUD operations around reading and writing of entiries.

```C#
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

```C#
    public static GuidUdi GetUdi(this Example entity)
    {
        if (entity == null) throw new ArgumentNullException("entity");
        return new GuidUdi("mypackage-example", entity.Id).EnsureClosed();
    }
```

#### Handling Dependencies

In the same way that Umbraco entities often have dependencies on one another, this may also be the case for any custom data you are looking to deploy.  If so, you can add the necessary logic to your service connector to ensure dependencies are added, which will ensure Umbraco Deploy also ensures the appropriate dependencies are in place before initiating a transfer.

If the dependent entity is also deployable, it will be included in the transfer.  Or if not, the deployment will be blocked and the reason presented to the user.

In the following illustrative example, if deploying a representation of a "Person", we ensure their "Department" dependency is added, indicating that it must exist to allow the transfer.  We can also use `ArtifactDependencyMode.Exist` to ensure the dependent entity not only exists but also matches in all properties.

```C#
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

As well as dependencies at the level of entities, we can also have dependencies in the property values as well.  In Umbraco, an example of this is the multi-node tree picker property editor.  It contains references to other content items, that should also be deployed along with the content that hosts the property itself.

Examples of these can be found in the open-source Umbraco.Deploy.Contrib project, for which the source code can be found [here](https://github.com/umbraco/Umbraco.Deploy.Contrib/), and value connectors found in the `Umbraco.Deploy.Contrib.Connectors/ValueConnectors` folder.

## Registration

With the artifact and connectors in place, the final step necessary is to register your entity for deployment.

### Disk Based Transfers

In order to deploy the entity as schema, via disk based representations held in `.uda` files, it's necessary to register the entity with the disk entity service.  This can be done in a component, such as follows, where events are used to trigger a serialization of the enity to disk whenever one of them is saved.

```C#
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

### Backoffice Integrated Transfers

Work in progress.  Documentation will be updated once this feature is released.



