---
versionFrom: 8.0.0
meta.Title: "Extending Umbraco Deploy"
meta.Description: "How to extend Umbraco Deploy to synchronize custom data"
---

# Extending Umbraco Deploy

Umbraco Deploy supports the deployment of CMS schema information, definitions from the HQ's Forms package, and managed content and media.  In addition it can be extended by package or custom solution developers to allow the deployment of custom data, such as that stored in your own database tables.

## Concepts

### Entities

*Entities* are what you may be looking to transfer between two websites using Deploy.  Within Umbraco, they are the document types, data type, documents etc.  In a custom solution or a package, they maybe representations of some other data that's being stored separately from Umbraco content, whilst still managed in the back-office using custom trees and editors.

For the purposes of subsequent code samples, we'll consider an example entity as a POCO class with a few properties.  Note that the entity has no dependencies on Umbraco or Umbraco Deploy; it can be constructed and managed however makes sense for the package or solution.

```
    public class Example
    {
        public Guid Id { get; set; }

        public string Name { get; set; }        

        public string Description { get; set; }
    }
```

### Artifacts

Every entity Deploy work with, whether from Umbraco core or custom data, needs to have an *artifact* representation. You can consider an artifact acontainer capable of knowing everything there is to know about a particular entity is defined. They are used as a  transport object for communicating between Deploy environments.  They can also be serialized to JSON representations.  These are visible in the .uda files seen on disk in the `/data/revisions/` folder for schema transfers and are also used when transferring content between different environments over HTTP requests.

Artifact classes must inherit from `DeployArtifactBase`.

The following example shows an artifact representing the entity and it's single property for transfer:

```
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

If you do need more control, attributes can be applied to the artifacts properties.

For example, to ensure a decimal value is serialized to a consistent number of decimal places you can use (with the JSON converter found in the `Umbraco.Deploy.Serialization` namespace):

```
    [JsonConverter(typeof(RoundingDecimalJsonConverter), 2)]
    public decimal Amount { get; set; }
```

### Service Connectors

Service connectors are responsible for knowing how to handle the mapping between artifacts and entities. They know how to gather all the data needed for the type of entity they correspond to, including figuring out what dependencies are needed for a particular entity (e.g. in Umbraco, how a document type will depend on a data type). They are responsible for packaging an entity as an artifact and for knowing how to extract an entity from an artifact and persist it in a destination site.

Service connectors inherit from `ServiceConnectorBase` and constructed with the artifact and entity as generic type arguments.

The class is decorated with a `UdiDefinition` via which the name of the entity type is provided.  This needs to be unique across all entities so it's likely worth prefixing with something custom to your package or application.

The following example shows a service connector, responsible for handling the artifact shown above and it's related entity.  There are no dependencies to consider here.  More complex examples will involve collating the dependencies and potentially handling the extraction in more than one pass to ensure updates are made in the correct order.

Note that an illustrative data service is provided via dependency injection.  This will be whatever is appropriate for your solution to use for CRUD operations around reading and writing of entiries.

```
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
        };
        private const string OpenUdiName = "ALL EXAMPLES";

        public override void Explode(UdiRange range, List<Udi> udis)
        {
            EnsureType(range.Udi);

            foreach (var e in _exampleDataService.GetExamples())
            {
                udis.Add(e.GetUdi());
            }
        }

        public override NamedUdiRange GetRange(string entityType, string sid, string selector)
        {
            int id;
            if (!int.TryParse(sid, out id))
                throw new ArgumentException("Invalid identifier.", nameof(sid));

            if (id == -1)
            {
                EnsureSelector(selector, ValidOpenSelectors);
                return new NamedUdiRange(Udi.Create(AppConstants.UdiEntityTypes.Example), OpenUdiName, selector);
            }

            var e = _exampleDataService.GetExampleById(id);
            if (e == null)
            {
                throw new ArgumentException("Could not find an entity with the specified identifier.", nameof(sid));
            }

            return GetRange(e, selector);
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

            artifact.Udi.EnsureType(AppConstants.UdiEntityTypes.Example);

            var entity = state.Entity ?? new Entity { Id = artifact.Udi.Guid });

            entity.Name = artifact.Name;
            entity.Description = artifact.Description;

            _exampleDataService.SaveExample(entity);
        }
    }
```

It's also necessary to provide an extension method to generate the appropriate identifier:

```
    public static GuidUdi GetUdi(this Example entity)
    {
        if (entity == null) throw new ArgumentNullException("entity");
        return new GuidUdi("mypackage-example", entity.Id).EnsureClosed();
    }
```

### Value Connectors

TBC

### Registration

#### Disk Based Transfers

TBC

#### Back-Office Integrated Transfers

TBC



