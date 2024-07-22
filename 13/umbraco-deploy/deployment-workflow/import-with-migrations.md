---
meta.Title: Import with migrations in Umbraco Deploy
description: How to import content and schema while migrating them into newer alternatives
---

# Import with migrations

As well as importing the content and schema directly, we also provide support for modifying the items as part of the process.

For example, you may have taken an export from an Umbraco 8 site, and are looking to import it into a newer major version. In this situation, most content and schema will carry over without issue. However, you may have some items that are no longer compatible. Usually this is due to a property editor - either a built-in Umbraco one or one provided by a package. These may no longer be available in the new version.

Often though there is a similar replacement. Using Deploy's import feature we can transform the exported content for the obsolete property into that used by the new one during the import. The migration to a content set compatible with the new versions can then be completed.

For example, we can migrate from a Nested Content property in Umbraco 8 to a Block List in Umbraco 13.

We provide the necessary migration hooks for this to happen, divided into two types - **artifact migrators** and **property migrators**.

### Artifact migrators

Artifact migrators work by transforming the serialized artifact of any imported artifact, via two interfaces:

- `IArtifactMigrator` - where the migration occurs at the artifact property level
- `IArtifactJsonMigrator` - where the migration occurs at the lower level of transforming the serialized JSON itself.

Implementations to handle common migrations of data types from obsoleted property editors are available:

- `ReplaceMediaPickerDataTypeArtifactMigrator` - migrates a Data Type from using the legacy Media Picker to the current version of this property editor
- `ReplaceNestedContentDataTypeArtifactMigrator` - migrates a Data Type based on the obsolete Nested Content property editor to the Block List
- `ReplaceGridDataTypeArtifactMigrator` - migrates a Data Type based on the legacy Grid layout into the Block Grid

We've also made available base implementations that you can use to build your own migrations. You may have a need to handle transfer of information between other obsolete and replacement property editors that you have in your Umbraco application.

- `ArtifactMigratorBase<TArtifact>` - migrates the artifact of the specified type
- `DataTypeArtifactMigratorBase` - migrates Data Type artifacts
- `ReplaceDataTypeArtifactMigratorBase` - migrates a Data Type from one property editor to another
- `ArtifactJsonMigratorBase<TArtifact>` - migrates the JSON of the specified artifact type
- `ReplaceGridDataTypeArtifactMigratorBase` - migrates a Data Type based on the legacy Grid layout into the Block Grid

### Property migrators

Property migrators work to transform the content property data itself. They are used in the Deploy content connectors (documents, media and members) when the property editor is changed during an import:

Again we have an interface:

- `IPropertyTypeMigrator`

Implementations for common migrations:

- `MediaPickerPropertyTypeMigrator`
- `NestedContentPropertyTypeMigrator`
- `GridPropertyTypeMigrator`

And a base type to help you build your own migrations:

- `PropertyTypeMigratorBase`
- `GridPropertyTypeMigratorBase`

{% hint style="info" %}
Property editor changes are determined by comparing the `PropertyEditorAliases` dictionary stored in the content artifact to the current Content Type/Data Type configuration. The dictionary contains editor aliases for each content property.
{% endhint %}

### Registering migrators

Migrators will run if you've registered them to, hence you can enable only the ones needed for your solution.

You can do this via a composer, as in the following example. Here we register two of the migrators shipped with Umbraco Deploy:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Deploy.Core.Migrators;
using Umbraco.Deploy.Infrastructure.Migrators;

internal class ArtifactMigratorsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.DeployArtifactMigrators()
            .Append<ReplaceNestedContentDataTypeArtifactMigrator>()
            .Append<ReplaceMediaPickerDataTypeArtifactMigrator>();

        builder.DeployPropertyTypeMigrators()
            .Append<NestedContentPropertyTypeMigrator>()
            .Append<MediaPickerPropertyTypeMigrator>();
    }
}
 ```

### A custom migration example - Nested Content to Block List

In order to help writing your own migrations, we share here the source code of an example that ships with Umbraco Deploy. This migration converts Nested Content to Block List.

First we have the artifact migrator that handles the conversion of the configuration stored with a datatype:

<details>
<summary><code>ReplaceNestedContentDataTypeArtifactMigrator.cs</code> (migrate Nested Content Data Type to Block List)</summary>

```csharp
using System.Globalization;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.PropertyEditors;
using Umbraco.Cms.Core.Serialization;
using Umbraco.Cms.Core.Services;
using Umbraco.Deploy.Infrastructure.Artifacts;

public class ReplaceNestedContentDataTypeArtifactMigrator : ReplaceDataTypeArtifactMigratorBase<NestedContentConfiguration, BlockListConfiguration>
{
    private readonly IContentTypeService _contentTypeService;

    public ReplaceNestedContentDataTypeArtifactMigrator(PropertyEditorCollection propertyEditors, IConfigurationEditorJsonSerializer configurationEditorJsonSerializer, IContentTypeService contentTypeService)
        : base(Constants.PropertyEditors.Aliases.NestedContent, Constants.PropertyEditors.Aliases.BlockList, propertyEditors, configurationEditorJsonSerializer)
        => _contentTypeService = contentTypeService;

    protected override BlockListConfiguration? MigrateConfiguration(NestedContentConfiguration configuration)
    {
        var blockListConfiguration = new BlockListConfiguration()
        {
            UseInlineEditingAsDefault = true // Similar to how Nested Content looks/works
        };

        if (configuration.MinItems > 0)
        {
            blockListConfiguration.ValidationLimit.Min = configuration.MinItems;
        }

        if (configuration.MaxItems > 0)
        {
            blockListConfiguration.ValidationLimit.Max = configuration.MaxItems;
        }

        if (configuration.ContentTypes is not null)
        {
            var blocks = new List<BlockListConfiguration.BlockConfiguration>();
            foreach (NestedContentConfiguration.ContentType nestedContentType in configuration.ContentTypes)
            {
                if (nestedContentType.Alias is not null &&
                    GetContentTypeKey(nestedContentType.Alias) is Guid contentTypeKey)
                {
                    blocks.Add(new BlockListConfiguration.BlockConfiguration()
                    {
                        Label = nestedContentType.Template,
                        ContentElementTypeKey = contentTypeKey
                    });
                }
            }

            blockListConfiguration.Blocks = blocks.ToArray();
        }

        if (blockListConfiguration.ValidationLimit.Min == 1 &&
            blockListConfiguration.ValidationLimit.Max == 1 &&
            blockListConfiguration.Blocks.Length == 1)
        {
            blockListConfiguration.UseSingleBlockMode = true;
        }

        return blockListConfiguration;
    }

    protected virtual Guid? GetContentTypeKey(string alias)
    {
        if (_contentTypeService.Get(alias) is IContentType contentTypeByAlias)
        {
            return contentTypeByAlias.Key;
        }

        // New content types are initially saved by Deploy with a custom postfix (to avoid duplicate aliases), so try to get the first matching item
        string aliasPrefix = alias + "__";
        foreach (IContentType contentType in _contentTypeService.GetAll())
        {
            if (contentType.Alias.StartsWith(aliasPrefix) &&
                int.TryParse(contentType.Alias[aliasPrefix.Length..], NumberStyles.HexNumber, null, out _))
            {
                return contentType.Key;
            }
        }

        return null;
    }
}
```

</details>

And secondly we have the property migrator that handles restructuring the content property data:

<details>
<summary><code>NestedContentPropertyTypeMigrator.cs</code> (migrate Nested Content property data to Block List)</summary>

```csharp
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Deploy;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Models.Blocks;
using Umbraco.Cms.Core.Services;
using Umbraco.Deploy.Core;
using Umbraco.Deploy.Core.Migrators;
using Umbraco.Deploy.Infrastructure.Extensions;

public class NestedContentPropertyTypeMigrator : PropertyTypeMigratorBase
{
    private readonly ILogger<NestedContentPropertyTypeMigrator> _logger;
    private readonly IContentTypeService _contentTypeService;

    public NestedContentPropertyTypeMigrator(ILogger<NestedContentPropertyTypeMigrator> logger, IContentTypeService contentTypeService)
        : base(Constants.PropertyEditors.Aliases.NestedContent, Constants.PropertyEditors.Aliases.BlockList)
    {
        _logger = logger;
        _contentTypeService = contentTypeService;
    }

    public override object? Migrate(IPropertyType propertyType, object? value, IDictionary<string, string> propertyEditorAliases, IContextCache contextCache)
    {
        if (value is not string stringValue || !stringValue.TryParseJson(out NestedContentItem[]? nestedContentItems) || nestedContentItems is null)
        {
            if (value is not null)
            {
                _logger.LogWarning("Skipping migration of Nested Content items ({PropertyTypeAlias}), because value could not be parsed: {Value}.", propertyType.Alias, value);
            }

            return null;
        }

        var layoutItems = new List<BlockListLayoutItem>();
        var contentData = new List<BlockItemData>();

        foreach (NestedContentItem nestedContentItem in nestedContentItems)
        {
            IContentType? contentType = contextCache.GetContentTypeByAlias(_contentTypeService, nestedContentItem.ContentTypeAlias);
            if (contentType is null)
            {
                _logger.LogWarning("Skipping migration of Nested Content item ({Id}), because content type does not exist: {ContentTypeAlias}.", nestedContentItem.Id, nestedContentItem.ContentTypeAlias);
                continue;
            }

            var udi = new GuidUdi(Constants.UdiEntityType.Element, nestedContentItem.Id);

            layoutItems.Add(new BlockListLayoutItem()
            {
                ContentUdi = udi
            });

            contentData.Add(new BlockItemData()
            {
                Udi = udi,
                ContentTypeKey = contentType.Key,
                RawPropertyValues = nestedContentItem.RawPropertyValues
            });
        }

        var blockValue = new BlockValue()
        {
            Layout = new Dictionary<string, JToken>()
            {
                { Constants.PropertyEditors.Aliases.BlockList, JToken.FromObject(layoutItems) }
            },
            ContentData = contentData
        };

        return JsonConvert.SerializeObject(blockValue, Formatting.None);
    }

    internal class NestedContentItem
    {
        [JsonProperty("key")]
        public Guid Id { get; set; } = Guid.NewGuid(); // Ensure a unique key is set, even if the JSON doesn't have one

        [JsonProperty("name")]
        public string? Name { get; set; }

        [JsonIgnore]
        public object? PropType { get; set; } // Ensure this property is ignored

        [JsonProperty("ncContentTypeAlias")]
        public string ContentTypeAlias { get; set; } = null!;

        [JsonExtensionData]
        public Dictionary<string, object?> RawPropertyValues { get; set; } = null!;
    }
}
```

</details>

Moving forward, other migrators may be built by HQ or the community for property editors found in community packages. We'll make them available for [use](https://www.nuget.org/packages/Umbraco.Deploy.Contrib) and [review](https://github.com/umbraco/Umbraco.Deploy.Contrib) via the `Umbraco.Deploy.Contrib` package.