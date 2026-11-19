---
description: >-
  Breaking changes introduced in Umbraco Deploy 19, with notes on what to update
  when upgrading.
---

# Breaking Changes Overview

Use the information below to learn about the breaking changes and common pitfalls when upgrading your project to Umbraco Deploy 19.

Use the [general upgrade guide](upgrades.md) to complete the upgrade of your project.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Preparation for Upgrade

Before running the upgrade, consider the following:

### Upgrade Umbraco CMS to version 19

Umbraco Deploy 19 requires Umbraco CMS 19 and runs on .NET 11. Upgrade the CMS in the same step, following the [Umbraco CMS Breaking Changes Overview](https://docs.umbraco.com/umbraco-cms/get-started/upgrading-and-migrating/version-specific).

### Upgrade all environments

Deploy 19 only transfers to and restores from environments that also run Deploy 19. Environments running Deploy 18 or earlier refuse to connect to Deploy 19 environments too.

Upgrade every environment of your project before you transfer or restore again. You can still import ZIP files exported from earlier versions of Deploy.

### Packages

Check that each package that extends Deploy has a release that supports Deploy 19. This includes [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) and the Deploy integrations of other Umbraco products.

### Check the Suspensions setting

Remove the `Examine`, `DocumentCache`, and `Signatures` values from the [`Suspensions`](../getting-started/deploy-settings.md#suspensions) setting. A setting that names one of these values stops the site from starting. For details, see [Suspension options removed](#suspension-options-removed).

### Check the Baseline secret

A `BaselineApiSecret` shorter than 64 bytes now fails the Deploy settings validation. Every Deploy operation then fails until you set a valid secret. Previously, Deploy used the project secret instead.

If `BaselineApiSecret` isn't set, the Child project still signs its requests with its project secret and logs a warning. For more information, see the [Baseline settings](../getting-started/deploy-settings.md#baseline-settings).

### Replace the Upstream setting

The obsolete `Upstream` project setting is removed and ignored without a warning. If you set it yourself, move the value to the [`BaselineUrl`](../getting-started/deploy-settings.md#baseline-settings) setting.

### Check your workspace URLs

Deploy only connects to environments on a configured workspace URL. It now also uses the configured URL instead of the URL another environment sends. Make sure every environment you transfer to or restore from is configured as a workspace, using the URL Deploy can reach it on.

### Update your UDA files after the upgrade

The Umbraco 19 upgrade changes some schema in the database, for example the configuration of Data Types. The `.uda` files written by Deploy 18 still hold the earlier format. A schema deployment reads `.uda` files without migrating them, so deploying these files can undo the changes made by the upgrade.

After upgrading your development environment:

1. Go to the **Health Check** dashboard in the **Settings** section.
2. Check the **Deploy** group.
3. Use **Migrate** on the **UDA file versions** health check to update the `.uda` files to Deploy 19.
4. Commit the updated `.uda` files and deploy them to your other environments.

Migrate isn't available in `ReadOnly` [disk mode](../getting-started/deploy-settings.md#disk-mode). Run it on a development environment and update the files in your build instead.

## Breaking changes

Umbraco Deploy 19 contains the following breaking changes.

### Umbraco CMS 19 and .NET 11

Deploy 19.0.0-rc1 has a minimum dependency on Umbraco CMS `19.0.0-rc1` and targets `net11.0`.

### Suspension options removed

Umbraco 19 replaces the Examine integration with Umbraco Search, which indexes changes when the operation completes. The CMS also no longer reads the document cache suspension. Deploy therefore no longer suspends indexing or the document cache during its operations.

The following `SuspensionOptions` values are removed:

* `Examine`
* `DocumentCache`
* `Signatures`, which had no effect since an earlier version.

The remaining values are `None`, `ScheduledPublishing`, and `All`. `All` now equals `ScheduledPublishing`.

Remove the removed values from the `Suspensions` setting in your configuration, and from any code that sets `DeploySettings.Suspensions`.

### Permission for editing shared content

Umbraco 19 controls editing of shared (invariant) property values with the **Allow editing shared content** user group permission. For details, see [User group permission for editing shared content](https://docs.umbraco.com/umbraco-cms/get-started/upgrading-and-migrating/version-specific#user-group-permission-for-editing-shared-content) in the CMS documentation.

A transfer limited to some cultures now includes the shared property values only when the user who starts it has this permission. The permission is checked on the source environment. Previously, access to the default language decided this.

Protected methods of the content service connectors that handle cultures take a new `includeInvariantForVariant` parameter. The overloads without this parameter are removed. Update any service connector that overrides these methods.

### Data Type and user group artifacts

Deploy migrates Data Type and user group artifacts from Deploy 18 and earlier to the Umbraco 19 format when importing them:

* Data Types move to the new property editors and configuration, matching the Umbraco 19 upgrade. This includes the single and multiple property editor variants, the minimum and maximum ranges, and the Block Grid areas.
* User groups with access to the **Settings** section get access to the **Library** section and all Document Blueprints.
* User groups get the **Allow editing shared content** permission following the earlier default language rule, or the `AllowEditInvariantFromNonDefault` setting.

When a `.uda` file written by Deploy 18 doesn't contain the new user group values, Deploy keeps the current values of the user group. The access granted by the Umbraco 19 upgrade isn't removed.

The checksums of templates, user groups, and content with schedules change once after the upgrade. Transfers and the schema comparison can show these items as changed until they're deployed or exported again.

### Template artifacts

The `Master` property of `TemplateArtifact` is renamed to `LayoutTemplate`. The `ArtifactDependencyModes.Template.Master` constant is renamed to `ArtifactDependencyModes.Template.LayoutTemplate`.

Deploy still reads the `Master` property from `.uda` files written by earlier versions.

### Entity type registration

Entity types are now registered by configuring `DeployEntityTypesOptions` in a composer. The following types and members are removed:

* `ITransferEntityService`, including `RegisterTransferEntityType()`.
* `IDiskEntityService.RegisterDiskEntityType()`.
* The static `DeployEntityTypes` class. Its `GetEntityTypes()` methods are now instance methods on `DeployEntityTypesOptions`.
* The `RemoteTreeDetail` parameter. Implement `ITreeServiceConnector` on the service connector instead, as described in the [Partial restore of remote items](../extending/extending.md#partial-restore-of-remote-items) section.

The registration no longer depends on the runtime level or the order of startup notifications. You don't need an `UmbracoApplicationStartingNotification` handler anymore.

In Deploy 18, you registered entity types in a notification handler:

{% code title="ExampleDeployStartingHandler.cs" %}

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;
using Umbraco.Deploy.Infrastructure.Disk;
using Umbraco.Deploy.Infrastructure.Transfer;

namespace MyPackage.Deploy;

public class ExampleDeployStartingHandler : INotificationHandler<UmbracoApplicationStartingNotification>
{
    private readonly IRuntimeState _runtimeState;
    private readonly ITransferEntityService _transferEntityService;
    private readonly IDiskEntityService _diskEntityService;

    public ExampleDeployStartingHandler(
        IRuntimeState runtimeState,
        ITransferEntityService transferEntityService,
        IDiskEntityService diskEntityService)
    {
        _runtimeState = runtimeState;
        _transferEntityService = transferEntityService;
        _diskEntityService = diskEntityService;
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
                SupportsRestore = true,
                PermittedToRestore = true,
                SupportsPartialRestore = true,
            });

        _diskEntityService.RegisterDiskEntityType("mypackage-setting");
    }
}
```

{% endcode %}

In Deploy 19, configure the options in a composer instead:

{% code title="ExampleDeployComposer.cs" %}

```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Deploy.Infrastructure;
using Umbraco.Deploy.Infrastructure.Transfer;

namespace MyPackage.Deploy;

public class ExampleDeployComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.Services.Configure<DeployEntityTypesOptions>(options => options
            .AddTransferEntityType(
                "mypackage-example",
                new DeployTransferEntityTypeOptions
                {
                    SupportsQueueForTransfer = true,
                    SupportsRestore = true,
                    PermittedToRestore = true,
                    SupportsPartialRestore = true,
                })
            .AddDiskEntityType("mypackage-setting"));
}
```

{% endcode %}

An entity type can be a transfer entity type or a disk entity type, but not both. Deploy validates this when it builds the options. Adding the same entity type twice to the same set throws an `InvalidOperationException`.

To read the registered entity types, inject `IOptionsMonitor<DeployEntityTypesOptions>` and read `CurrentValue` where you need it. Don't read the options during startup.

The following types are also renamed:

* `DeployRegisteredEntityTypeDetailOptions` is renamed to `DeployTransferEntityTypeOptions`. It's now a sealed record with init-only properties.
* In the backoffice client configuration, `registeredEntityOptions` is renamed to `transferEntityTypeOptions`.
* In `@umbraco-deploy/backoffice`, the `DeployRegisteredEntity` type is renamed to `DeployTransferEntityType`. The `getRegisteredEntity()` method of the Deploy context is renamed to `getTransferEntityType()`.

### BackOfficeOnly edition

With the [`Edition`](../getting-started/deploy-settings.md#edition) setting set to `BackOfficeOnly`, Deploy no longer reads or writes `.uda` files. All disk entity types, including the ones registered by packages, become transfer entity types.

Dictionary items and member groups now follow the `TransferDictionaryAsContent` and `TransferMemberGroupsAsContent` settings, as in the default edition. When these settings are off, they're available to queue for transfer, import, and export, but not to restore.

The import and export dialogs follow the same split. Schema is exported under **Content**, and a missing schema dependency on import is a warning instead of an error.

### Backoffice action groups

Umbraco 19 orders action menus by action groups. Deploy registers its own groups:

* `Deploy.EntityActionGroup.Deploy` holds the Deploy entity actions, such as **Compare** and **Partial Restore**.
* `Deploy.WorkspaceActionMenuItemGroup.Deploy` holds **Transfer now** in the menu next to **Save and publish**.

Packages that add Deploy actions can use these group aliases to show their actions together with the Deploy actions.

### Removed APIs

Deploy 19 removes the APIs that were marked as obsolete for removal in Deploy 19. Resolve the obsolete warnings in your code before you upgrade. The warning text names the replacement to use, if there is one.

The removed APIs include:

* The `Upstream` project setting. Use `BaselineUrl` instead.
* The obsolete constructors of the connector base classes and other public classes.
* The `BearerTokenAuthenticationMiddleware` class. Environment requests are authenticated with an ASP.NET Core authentication scheme.
* The obsolete members of `ContextCacheExtensions`.
* The `RemoteTreeEntity` class and the `DeployRemoteDocumentTreeRepository`, `DeployRemoteMediaTreeRepository`, and `DeployRemoteEntityTreeRepository` backoffice repositories.
* The `operation/trigger` and `tree/external/*` endpoints of the Deploy Management API.
* The `Udi` and `Id` properties of `PartialRestoreNodeModel`, the `Id` property of `TreeExportModel`, and the `nodeName` and `entityType` properties of `RemoteTreeDetailModel`.
* `IUmbracoEnvironment.CreateManifestAsync()`.
* `AmbigiousMatchException`. A duplicate service connector for an entity type now throws an `InvalidOperationException`.

### Other API changes

* `ISignatureService.GetSignature()` and `ISignatureService.GetSignatures()` no longer have default implementations. Custom implementations of `ISignatureService` must implement them.
* The date properties of `QueueItem`, `ContentSummaryModel`, `AddToQueueModel`, `DeployItem`, and `GetUdiRangeModel` change from `DateTime` to `DateTimeOffset`.
* The restore, partial restore, import, and disk read work items and their factories no longer take a `CacheRefresherCollection` parameter.
* Constructors that took an `IIndexRebuilder` no longer take this parameter.
* Public constructors that took the transfer entity service now take an `IOptionsMonitor<DeployEntityTypesOptions>` or `DeployEntityTypesOptions` parameter instead. `DictionaryItemConnector` takes an `IOptionsMonitor<DeploySettings>` parameter.

## Legacy version-specific upgrade notes

You can find the version-specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/upgrades/version-specific.md).
