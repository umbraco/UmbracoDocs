---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Automate.
---

# Release Notes

This section summarizes the changes to Umbraco Automate released in each version. Each version links to the full list of changes on GitHub, and individual items link to the pull request that made the change. The complete history is in the [Umbraco Automate changelog](https://github.com/umbraco/Umbraco.Automate/blob/v19/main/Umbraco.Automate/CHANGELOG.md).

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

## Release History

This section contains the release notes for Umbraco Automate 19, including all changes for this version.

### [19.0.0-rc1](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.5.1...Umbraco.Automate@19.0.0-rc1) (November 13th 2026)

The first release of Umbraco Automate for Umbraco CMS 19. It includes everything in Umbraco Automate 18.6.0, and the changes below. Umbraco Automate 19 needs Umbraco CMS 19.0.0-rc1 or later and .NET 11 [#502](https://github.com/umbraco/Umbraco.Automate/pull/502).

{% hint style="warning" %}

This release changes some existing behavior. Review these points before upgrading:

* **Find Content and Find Media use Umbraco Search.** Only the item name is searched. **Contains** no longer finds text in the middle of a word, so `press` doesn't find "Compress Archive". **Exact** matches the whole name, so `homepage` no longer finds "The Homepage". A search examines at most 2000 results, and items in the recycle bin are left out [#502](https://github.com/umbraco/Umbraco.Automate/pull/502). For more information, see [Find Content and Find Media](concepts/actions.md#find-content-and-find-media).
* **Publishing shared properties needs a permission.** On content that varies by culture, **Publish Content** only publishes shared properties when one of the service account's groups has **Allow editing shared content**. Without it, the step succeeds and writes a warning to its log [#502](https://github.com/umbraco/Umbraco.Automate/pull/502). For more information, see [Publishing Shared Properties](concepts/workspaces.md#publishing-shared-properties).
* **Some pickers must have a value.** **Create Content**, **Create Media**, **Move Content**, and **Move Media** steps with an empty required picker fail validation when you publish the automation [#502](https://github.com/umbraco/Umbraco.Automate/pull/502).

{% endhint %}

#### Removed configuration

`Umbraco:Automate:Enabled`, the `Umbraco:Automate:Governance` section, and `Umbraco:Automate:Scripting:StatementTimeout` are removed. They had no effect, so sites that still set them work the same [#502](https://github.com/umbraco/Umbraco.Automate/pull/502). For more information, see [Configuration](getting-started/configuration.md).

#### Breaking changes for extensions

These changes affect custom code that builds on Umbraco Automate:

* Custom implementations of these interfaces must implement members that had a default implementation before [#502](https://github.com/umbraco/Umbraco.Automate/pull/502), [#590](https://github.com/umbraco/Umbraco.Automate/pull/590):
  * `IAutomationRunService`: `GetStepRunDataAsync` and `GetTriggerDataAsync`.
  * `IAutomationActionAuthorizer`: `AuthorizeContentRootAsync`, `AuthorizeMediaRootAsync`, `AuthorizeContentParentAsync`, `AuthorizeMediaParentAsync`, and the Library element members.
  * `IOAuthCredentialsService`: `GetCredentialIdsNotModifiedSinceAsync`.
  * `IContentValueNormaliser`: `NormaliseProperties` and `ReadProperty` for `IPublishedElement`.
* Removed: the `NotifyEditorAction` constructor without an `IAutomationActionAuthorizer`, the `CatalogueMapDefinition` constructor without a logger, `AutomateOptions.Enabled`, `GovernanceOptions`, `ScriptingOptions.StatementTimeout`, and `ScriptExecutorOptions.StatementTimeout` [#502](https://github.com/umbraco/Umbraco.Automate/pull/502), [#590](https://github.com/umbraco/Umbraco.Automate/pull/590).
* Constructors changed: `PublishContentAction` takes `IUserService` and `PropertyEditorCollection`. `FindContentAction` and `FindMediaAction` take `ISearcherResolver` and `IEntityService` instead of `IExamineManager`, and `FindContentAction` also takes `ILanguageService` [#502](https://github.com/umbraco/Umbraco.Automate/pull/502).
* Dropdown settings use the `Umb.PropertyEditorUi.Dropdown.Single` editor, because `Umb.PropertyEditorUi.Dropdown` is always multi-select in Umbraco 19. The stored value doesn't change. Update dropdown settings in your own actions and triggers the same way [#502](https://github.com/umbraco/Umbraco.Automate/pull/502).
