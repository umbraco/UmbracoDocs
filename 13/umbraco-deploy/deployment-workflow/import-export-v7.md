---
meta.Title: Migrating from Umbraco 7
description: How to export content and schema from Umbraco 7 and import into a newer version
---

### Migrating from Umbraco 7

The import and export feature is available from Deploy 4.9 (which supports Umbraco 8), 10.3, 12.1 and 13.0. It's not been ported back to Umbraco 7, hence you can't trigger an export from there in the same way.

We can use this feature to help migrate from Umbraco 7 to a supported major version using additional logic added to the Deploy Contrib project.

#### Exporting Umbraco 7 content and schema

We can generate an export archive in the same format as used by the import/export feature by adding the [`Umbraco.Deploy.Contrib.Export` assembly](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-2.0.0-export) to your Umbraco 7 project. This archive can then be imported into a newer Umbraco version by configuring the legacy import migrators. You can also apply additional migrators to update obsolete data types and property data into newer equivalents.

This is possible via code, by temporarily applying a composer to an Umbraco 7 project to generate the export archive on start-up:


<details>
<summary><code>DeployExportApplicationHandler.cs</code> (export Umbraco 7 content and schema to ZIP archive)</summary>

```csharp
using System;
using System.Linq;
using System.Web.Hosting;
using Umbraco.Core;
using Umbraco.Deploy;
using UmbracoDeploy.Contrib.Export;

public class DeployExportApplicationHandler : ApplicationEventHandler
{
    protected override void ApplicationInitialized(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
    {
        // Set a default value connector that doesn't use object type prefixes
        DefaultValueConnector.SetDefault();

        // Run export after Deploy has started
        DeployComponent.Started += (sender, e) => DeployStarted();
    }

    protected void DeployStarted()
    {
        var udis = new[]
        {
            // Export all content
            Constants.UdiEntityType.Document,
            Constants.UdiEntityType.DocumentBlueprint,
            Constants.UdiEntityType.Media,
            // Export all forms data
            Constants.UdiEntityType.FormsForm,
            Constants.UdiEntityType.FormsDataSource,
            Constants.UdiEntityType.FormsPreValue
        }.Select(Udi.Create);

        var dependencyEntityTypes = new[]
        {
            // Include all related schema
            Constants.UdiEntityType.DataType,
            Constants.UdiEntityType.DataTypeContainer,
            Constants.UdiEntityType.DocumentType,
            Constants.UdiEntityType.DocumentTypeContainer,
            Constants.UdiEntityType.MediaType,
            Constants.UdiEntityType.MediaTypeContainer,
            Constants.UdiEntityType.MemberType,
            Constants.UdiEntityType.MemberGroup,
            Constants.UdiEntityType.Macro,
            Constants.UdiEntityType.DictionaryItem,
            Constants.UdiEntityType.Template,
            Constants.UdiEntityType.Language,
            // Include all related files
            Constants.UdiEntityType.MediaFile,
            Constants.UdiEntityType.MacroScript,
            Constants.UdiEntityType.PartialView,
            Constants.UdiEntityType.PartialViewMacro,
            Constants.UdiEntityType.Script,
            Constants.UdiEntityType.Stylesheet,
            Constants.UdiEntityType.UserControl,
            Constants.UdiEntityType.TemplateFile,
            Constants.UdiEntityType.Xslt
        };

        // Create export
        var zipArchiveFilePath = HostingEnvironment.MapPath("~/data/" + "export-" + Guid.NewGuid() + ".zip");
        ArtifactExportService.ExportArtifacts(udis, Constants.DeploySelector.ThisAndDescendants, zipArchiveFilePath, dependencyEntityTypes);
    }
}
```

</details>

#### Importing Umbraco 7 content and schema

To import this archive into a newer Umbraco project, you need to install either of these packages:

- `UmbracoDeploy.Contrib` 4.3 for Umbraco 8
- `Umbraco.Deploy.Contrib` for Umbraco 10.2, 12.1, 13.1 or later
Then you need to configure the legacy artifact type resolver and migratory.

Artifact type resolvers allow resolving changes in the type that's stored in the `__type` JSON property of the artifact. This is in case it moved to a different assembly or namespace (or got renamed) in a newer version. The legacy migrators handle the following changes:

- Moving the pre-values of data types to the configuration property;
- Moving the invariant release and expire dates of content to the (culture variant) schedule property;
- Moving the 'allowed at root' and 'allowed child content types' of content/media/member types to the permissions property;
- Migrating the Data Type configuration from pre-values to the correct configuration objects and new editor aliases for:
  - `Umbraco.CheckBoxList` (pre-values to value list)
  - `Umbraco.ColorPickerAlias` to `Umbraco.ColorPicker` (pre-values to value list)
  - `Umbraco.ContentPicker2` to `Umbraco.ContentPicker` (removes invalid start node ID)
  - `Umbraco.ContentPickerAlias` to `Umbraco.ContentPicker` (removes invalid start node ID)
  - `Umbraco.Date` to `Umbraco.DateTime`
  - `Umbraco.DropDown` to `Umbraco.DropDownListFlexible` (pre-values to value list, single item select)
  - `Umbraco.DropDownListFlexible` (pre-values to value list, defaults to multiple item select)
  - `Umbraco.DropdownlistMultiplePublishKeys` to `Umbraco.DropDownListFlexible` (pre-values to value list, defaults to multiple item select)
  - `Umbraco.DropdownlistPublishingKeys` to `Umbraco.DropDownListFlexible` (pre-values to value list, defaults to single item select)
  - `Umbraco.DropDownMultiple` to `Umbraco.DropDownListFlexible` (pre-values to value list, defaults to multiple item select)
  - `Umbraco.MediaPicker2` to `Umbraco.MediaPicker` (removes invalid start node ID, defaults to single item select)
  - `Umbraco.MediaPicker` (removes invalid start node ID)
  - `Umbraco.MemberPicker2` to `Umbraco.MemberPicker`
  - `Umbraco.MultiNodeTreePicker2` to `Umbraco.MultiNodeTreePicker` (removes invalid start node ID)
  - `Umbraco.MultiNodeTreePicker` (removes invalid start node ID)
  - `Umbraco.MultipleMediaPicker` to `Umbraco.MediaPicker` (removes invalid start node ID, defaults to multiple item select)
    - `Umbraco.NoEdit` to `Umbraco.Label`
  - `Umbraco.RadioButtonList` (pre-values to value list, change database type from integer to nvarchar)
  - `Umbraco.RelatedLinks2` to `Umbraco.MultiUrlPicker`
  - `Umbraco.RelatedLinks` to `Umbraco.MultiUrlPicker`
  - `Umbraco.Textbox` to `Umbraco.TextBox`
  - `Umbraco.TextboxMultiple` to `Umbraco.TextArea`
  - `Umbraco.TinyMCEv3` to `Umbraco.TinyMCE`
- Migrating pre-value property values for:
  - `Umbraco.CheckBoxList`
  - `Umbraco.DropDown.Flexible`
  - `Umbraco.RadioButtonList`

The following composer adds the required legacy artifact type resolver and migrators. It also adds a custom resolver that marks the specified document type alias `testElement` as element type. Element types are a concept added in Umbraco 8 and are required for document types that are used in Nested Content.

<details>
<summary><code>LegacyImportComposer.cs</code> (configure artifact type resolver and artifact migrators)</summary>

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Deploy.Contrib.Migrators.Legacy;

internal class LegacyImportComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.DeployArtifactTypeResolvers()
            .AddLegacyTypeResolver();

        builder.DeployArtifactMigrators()
            .AddLegacyMigrators()
            .Append<ElementTypeArtifactMigrator>();
    }

    private class ElementTypeArtifactMigrator : ElementTypeArtifactMigratorBase
    {
        public ElementTypeArtifactMigrator()
            : base("testElement")
        { }
    }
}
```

</details>

{% hint style="info" %}
It is recommended to first only import schema and schema files (by deselecting 'Content' and 'Content files' in the dialog), followed by a complete import of all content and schema. The order in which the artifacts are imported depends on the dependencies between them, so this ensures the schema is completely imported before any content is processed.
{% endhint %}

#### Obtaining Umbraco Deploy for Umbraco 7

Umbraco Deploy for Umbraco 7 is no longer supported and was only available on Umbraco Cloud. It was not released for use on-premise.

As such if you are looking to migrate from an Umbraco Cloud project running on Umbraco 7, you already have Umbraco Deploy installed.

If you have an Umbraco 7 on-premise website, you can use this guide to migrate from on-premise to Umbraco Cloud or to upgrade to a newer Deploy version on-premise. You will need to obtain and install Umbraco Deploy for Umbraco 7 into your project, solely to use the export feature.

The export feature can be used without a license.

{% hint style="info" %}

A license is required for the Umbraco project you are importing into - whether that's a license that comes as part of an Umbraco Cloud subscription, or an on-premise one.

{% endhint %}

Use this guide to migrate from on-premise to Umbraco Cloud or to upgrade to a newer Deploy version on-premise.

1. Download the required `dll` files for Umbraco Deploy for Umbraco 7 from the following links:

- [Umbraco Deploy v2.1.6](https://umbraconightlies.blob.core.windows.net/umbraco-deploy-release/UmbracoDeploy.v2.1.6.zip): Latest Deploy Version 2 release for Umbraco CMS Version 7 (officially for use on Cloud)
- [Umbraco Deploy Contrib v2.0.0](https://umbraconightlies.blob.core.windows.net/umbraco-deploy-contrib-release/UmbracoDeploy.Contrib.2.0.0.zip): Latest/only Deploy Contrib Version 2
- [Umbraco Deploy Export v2.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-2.0.0-export): For exporting all content/schema in Version 7

2. Install Umbraco Deploy with the Contrib and Export extensions.

- Install `Umbraco Deploy`, `Deploy.Contrib`, and `Deploy.Export` by copying the downloaded `.dll` files into your Umbraco 7 site.
- When copying the files over from `Umbraco Deploy` you should not overwrite the following files (if you already had Umbraco Deploy installed):

```csharp
 Config/UmbracoDeploy.config
 Config/UmbracoDeploy.Settings.config
```

- Run the project to make sure it runs without any errors

3. Update the `web.config` file with the required references for Umbraco Deploy:

{% code title="web.config" lineNumbers="true" %}

```xml
<?xml version="1.0"?> 
<configSections>
    <sectionGroup name="umbraco.deploy">
      <section name="environments" type="Umbraco.Deploy.Configuration.DeployEnvironmentsSection, Umbraco.Deploy" requirePermission="false" />
      <section name="settings" type="Umbraco.Deploy.Configuration.DeploySettingsSection, Umbraco.Deploy" requirePermission="false" />
    </sectionGroup>
  </configSections>
  <umbraco.deploy>
    <environments configSource="config\UmbracoDeploy.config" />
    <settings configSource="config\UmbracoDeploy.Settings.config" />
  </umbraco.deploy>
</configuration>
```

{% endcode %}

4. Export Content.

- **Export** your content, schema, and files to zip.