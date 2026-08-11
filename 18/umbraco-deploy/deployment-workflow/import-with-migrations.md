---
description: How to import content and schema while migrating them into newer alternatives
---

# Import with migrations

As well as importing the content and schema directly, we also provide support for modifying the items as part of the process.

For example, you may have taken an export from an Umbraco 8 site, and are looking to import it into a newer major version. In this situation, most content and schema will carry over without issue. However, you may have some items that are no longer compatible. Usually this is due to a property editor - either a built-in Umbraco one or one provided by a package. These may no longer be available in the new version.

Often though there is a similar replacement. Using Deploy's import feature we can transform the exported content for the obsolete property into that used by the new one during the import. The migration to a content set compatible with the new versions can then be completed.

For example, we can migrate from a Nested Content property in Umbraco 8 to a Block List in Umbraco 13.

We provide the necessary migration hooks for this to happen, divided into two types - **artifact migrators** and **property migrators**.

## Artifact migrators

Artifact migrators work by transforming the serialized artifact of any imported artifact, via two interfaces:

- `IArtifactMigrator` - where the migration occurs at the artifact property level
- `IArtifactJsonMigrator` - where the migration occurs at the lower level of transforming the serialized JSON itself.

Implementations to handle common migrations of Data Types from obsoleted property editors are available:

- `ReplaceMediaPickerDataTypeArtifactMigrator` - migrates a Data Type from using the legacy Media Picker to the current version of this property editor
- `ReplaceNestedContentDataTypeArtifactMigrator` - migrates a Data Type based on the obsolete Nested Content property editor to the Block List
- `ReplaceGridDataTypeArtifactMigrator` - migrates a Data Type based on the legacy Grid layout into the Block Grid
- `ReplaceUnknownEditorDataTypeArtifactMigrator` - replaces any unknown editor alias with a label

We've also made available base implementations that you can use to build your own migrations. You may need to handle the transfer of information between other obsolete and replacement property editors that you have in your Umbraco application.

- `ArtifactMigratorBase<TArtifact>` - migrates the artifact of the specified type
- `DataTypeArtifactMigratorBase` - migrates Data Type artifacts
- `ReplaceDataTypeArtifactMigratorBase` - migrates a Data Type from one property editor to another
- `ArtifactJsonMigratorBase<TArtifact>` - migrates the JSON of the specified artifact type
- `ReplaceGridDataTypeArtifactMigratorBase` - migrates a Data Type based on the legacy Grid layout into the Block Grid

## Property migrators

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

## Registering migrators

Migrators will run if you have registered them, so you can enable only the ones needed for your solution.

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

## Import and migration flow

When an import is started, the following happens:

1. Artifact signatures are read from the import provider (using `IArtifactImportProvider.GetArtifactSignatures()`).
2. The artifact signatures are sorted based on dependencies with `Ordering` enabled (ensuring dependent items are processed in the correct order, like parent items before children and data types before document types).
3. For each artifact signature:
   1. Check whether the entity type is allowed to be imported.
   2. Publish an `ArtifactImportingNotification` (cancelling will skip importing the artifact).
4. Publish a `ValidateArtifactImportNotification`:
   - Deploy adds a default handler (`ValidateArtifactImportDependenciesNotificationHandler`) to validate whether all dependencies are either in the import or already present in the current environment. It emits warnings for missing content artifacts, missing or different artifact checksums and errors for missing schema artifacts.
   - The import fails on validation errors or 'soft' fails on warnings if the `WarningsAsErrors` import option is set.
5. Create a Deploy scope and context (containing the 'owner' user for auditing purposes and cultures to import, in case the user doesn't have edit permissions for all languages).
6. For each artifact signature:
   1. Create a (readonly) `Stream` for the artifact (using `IArtifactImportProvider.CreateArtifactReadStream(Udi)`).
   2. Deserialize the artifact into a generic JSON object (`JsonNode`).
   3. Parse the `__version` and `__type` properties and resolve the artifact type (using `IArtifactTypeResolver`).
   4. Migrate the JSON object (using `IArtifactJsonMigrator`).
   5. Deserialize the JSON object into the artifact type.
   6. Migrate the artifact (using `IArtifactMigrator`).
   7. Initialize artifact processing (using `IServiceConnector.ProcessInitAsync(...)`) and track deploy state with next passes.
7. For each next process pass (starting at the lowest initial next pass):
   1. Process artifact (using `IServiceConnector.ProcessAsync(...)`).
   2. During processing: service connectors for content, media and members migrate property type values if a property editor alias has changed (using `IPropertyTypeMigrator`).
   3. When no next pass is required (the deploy state returns -1 as next pass):
      1. Publish an `ArtifactImportedNotification`.
      2. Report the import process (using `IProgress.Report(...)`).
8. The Deploy scope is completed, causing all scoped notifications to be published to handlers implementing `IDistributedCacheNotificationHandler`) and completing the import.

## Details of Specific Migrations

Umbraco Deploy ships with migrators to handle the conversion of core property editors as they have changed, been removed or replaced between versions.

Open source migrators may be built by HQ or the community for property editors found in community packages. They will be made available for [use](https://www.nuget.org/packages/Umbraco.Deploy.Contrib) and [review](https://github.com/umbraco/Umbraco.Deploy.Contrib/tree/v17/dev/src/Umbraco.Deploy.Contrib/Migrators) via the `Umbraco.Deploy.Contrib` package.

### Grid to Block Grid

The Grid editor introduced in Umbraco 7 has been removed from Umbraco 14. Its functionality is replaced with the Block Grid.

With Deploy migrators we have support for migrating Data Type configuration and property data between these property editors.

Deploy adds the `ReplaceGridDataTypeArtifactMigrator` and `GridPropertyTypeMigrator` migrators by default, so using a custom migrator requires replacing the default ones:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Deploy.Infrastructure.Migrators;

internal sealed class DeployMigratorsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.DeployArtifactMigrators()
            .Replace<ReplaceGridDataTypeArtifactMigrator, CustomReplaceGridDataTypeArtifactMigrator>();

        builder.DeployPropertyTypeMigrators()
            .Replace<GridPropertyTypeMigrator, CustomGridPropertyTypeMigrator>();
    }
}
```

{% hint style="info" %}
The project you are importing into needs to know about any custom legacy Grid editor configurations to migrate to the Block Grid editor correctly. Make sure to either copy the `grid.editors.config.js` and `package.manifest` (containing grid editors) files or override the `GetGridEditors()` method of the artifact migrator to provide this.
{% endhint %}

These implementations make use of the following conventions to migrate the data:

- `ReplaceGridDataTypeArtifactMigrator`:
  - Grid layouts are migrated to an existing or new element type with an alias based on the layout name, prefixed with `gridLayout_` (this can be customized by overriding `MigrateGridTemplate()`);
  - Row configurations are migrated to an existing or new element type with an alias based on the row name, prefixed with `gridRow_` (this can be customized by overriding `MigrateGridLayout()`);
  - Similarly, grid editors are migrated to an existing or new element type with an alias based on the editor alias, prefixed with `gridEditor_` (this can be customized by overriding `MigrateGridEditor()`). The default editors used in version 13 are returned by `GetGridEditors()` and you can override this method to include your custom editors. Each migrated grid editor will have the following property types added to the element type:
    - The `media` grid editor is migrated to multiple properties: the `value` property contains the selected media item (using Media Picker v3), `altText` the alternate text (using a Textbox) and `caption` the caption (also using a Textbox);
    - The remaining grid editors create a single `value` property that uses the following editors:
      - `rte` - the default 'Rich Text Editor', falling back to the first `Umbraco.TinyMCE` editor.
      - `headline` - the default 'Textstring', falling back to the first `Umbraco.TextBox` editor.
      - `macro` and `embed` grid editors are converted into rich text editors.
      - `quote` or any other - use falling back to the first `Umbraco.TextArea` editor.
    - The block label is also updated for the built-in grid editors, ensuring a nice preview is available (the WYSIWYG style previews are incompatible between these editors, so the custom views are not migrated);
  - Grid settings config and styles are migrated to a new element type with a random alias, prefixed with `gridSettings_` (this can be customized by overriding `MigrateGridSettings()`). This is because the migration only has context about the Data Type configuration (not the actual Data Type) and multiple Data Type can potentially use the same configuration (for config and styles), so there's no predictable way to create a unique alias. The migrated settings element type will have the property types added for the config and styles:
    - Each config setting is migrated to a property with an alias based on the key, prefixed with `setting_` and added below a 'Settings' property group;
    - Similarly, each style is migrated to a property with an alias based on the key, prefixed with `style_` and added below a 'Styles' property group;
    - The following property editors are used for these properties based on the config/style view:
      - `radiobuttonlist` - a new 'Radio Button List' Data Type that uses the pre-values;
      - `multivalues` - a new 'Checkbox List' Data Type that uses the pre-values;
      - `textstring` - the default 'Textstring', falling back to the first `Umbraco.TextBox` editor.
      - `mediapicker` and `imagepicker` - the default 'Media Picker' (v3, single image), falling back to the first `Umbraco.MediaPicker3` editor.
      - `boolean` - the default 'Checkbox', falling back to the first `Umbraco.TrueFalse` editor.
      - `number` - the default 'Numeric', falling back to the first `Umbraco.Integer` editor.
      - `treepicker`, `treesource`, `textarea` or any other - the default 'Textarea', falling back to the first `Umbraco.TextArea` editor.
- `GridPropertyTypeMigrator`:
  - Gets the grid layout and row configuration element types based on the alias prefix/name convention used by the Data Type artifact migrator;
  - The grid editor values are migrated to the respective properties:
    - The `media` grid editor converts the value to a media item with crops (based on the UDI or media path), including the focal point (although this needs to be enabled on the Data Type), alternate text and caption;
    - All other values are converted to a text value or otherwise to a JSON string;
  - If a row or cell contains settings config or styles and the corresponding block has a settings element type configured, the settings config and styles are migrated to their respective properties in a similar way, based on the property editor alias:
    - `Umbraco.MediaPicker3` - removes `url('` from the beginning and `')` from the end of the value (commonly used as a modifier and added to the stored value), before trying to get the media item by a path.
    - All other values are returned as-is.

Given the flexibility of the grid editor and Block Grid you may want to take further control over the migration. You can do that by creating your own migrator classes, that make use of our provided base classes. You would then register your own migrators instead of the ones shipped with Umbraco Deploy in your composer.

The base classes provide the following functionality. Methods you should look to override to amend the default behavior have been noted above.

- `ReplaceGridDataTypeArtifactMigratorBase` - replaces the `Umbraco.Grid` Data Type editor alias with `Umbraco.BlockGrid` and migrates the configuration:
  - The number of columns is copied over.
  - Grid layouts, row configurations and grid editors are migrated to blocks:
    - If multiple grid layouts are configured or if at least one contains multiple sections or isn't the full width, each grid layout will be migrated to a 'layout block' (an element type without properties).
    - If multiple row configurations are configured or if at least one contains areas that don't allow all grid editors or has a maximum amount of items set, each row configuration is migrated to a block (this is also always done when there are multiple grid layouts, as each layout can configure allowed row configurations).
    - All grid editors are migrated to blocks (allowing a single grid editor to be migrated to multiple blocks to support DocTypeGridEditor, as that allows selecting different element types).
  - The settings config and styles are migrated to a single element type (even though each setting can define whether it's supported for rows and/or cells) and used on the blocks that are allowed.
  - Block groups are added for Layout and Content and used on the corresponding block types.
- `GridPropertyTypeMigratorBase` - migrates the property data from the `GridValue` into the `BlockValue` (using the `Umbraco.BlockGrid` layout):
  - The related Data Type is retrieved to get the configured blocks.
  - All grid control values are first migrated into their content blocks.
  - Settings config and styles for 'grid cells' are stored on the area within a row, but areas in the Block Grid can't have settings, so this is migrated into the first migrated grid control content block instead.
  - If a layout block can be found for the row configuration name, all grid controls are wrapped into that block.
  - Similarly, if a layout block can be found for the grid layout name, all items are wrapped into that block.
  - The JSON serialized `BlockValue` is returned.

### Migrating From Doc Type Grid Editor

[Doc Type Grid Editor](https://our.umbraco.com/packages/backoffice-extensions/doc-type-grid-editor/) was a community package commonly used with the legacy grid editor. If you are using this with Umbraco 7 and up, you can export and migrate into the Block Grid on Umbraco 13 or above.

Ensure you are running the latest version of `Umbraco.Deploy.Contrib` compatible with your Umbraco major version.

In your new project, register the following migrators to add support for the import from Doc Type Grid Editor grids:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Deploy.Infrastructure.Migrators;

internal sealed class DeployMigratorsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.DeployArtifactMigrators()
            .Append<ReplaceDocTypeGridEditorDataTypeArtifactMigrator>();

        builder.DeployPropertyTypeMigrators()
            .Append<DocTypeGridEditorPropertyTypeMigrator>();
    }
}
```

The migrators add the following behavior:

- `ReplaceDocTypeGridEditorDataTypeArtifactMigrator` extends `ReplaceGridDataTypeArtifactMigrator` and ensures any DocTypeGridEditor is migrated to blocks using the allowed element types. If the element types aren't found the default implementation will migrate to new element types.
- `DocTypeGridEditorPropertyTypeMigrator` extends `GridPropertyTypeMigrator` and ensures the Doc Type Grid Editor values are mapped one-to-one to the block item data.

{% hint style="info" %}
The artifact migrator adds the default DocTypeGridEditor configuration (with alias `docType`). This can be disabled by setting the `AddDefaultDocTypeGridEditor` property to `false` in a custom/inherited class. Similar to the base migrator, any custom DocTypeGridEditor configurations must be available to migrate to the Block Grid editor correctly.
{% endhint %}

### Migrating from Matryoshka

[Matryoshka](https://our.umbraco.com/packages/backoffice-extensions/matryoshka-tabs-for-umbraco-8/) was an Umbraco package that added tab support for document types in Umbraco. The feature was subsequently added to the product itself.

We provide a migrator for this package in `Umbraco.Deploy.Contrib`.

This adds support for migrating Matryoshka Group Separators into native property groups. It removes the Matryoshka Data Types during import and migrates the document, media and member types. Native property groups are also changed into tabs, similarly to how they were displayed with Matryoshka installed.

To use, you register the migrators:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Deploy.Infrastructure.Migrators;

internal sealed class DeployMigratorsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.DeployArtifactMigrators()
            .Append<ReplaceMatryoshkaArtifactMigrator>();
    }
}
```

## Source Code Example -  Nested Content to Block List

As described above, the nested content to block list migration will occur register the corresponding migrator with your application.

To help write your own migrations, we share the source code of an example that ships with Umbraco Deploy. This migration converts Nested Content to Block List.

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

