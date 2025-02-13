---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco UI Builder.
---

# Release Notes

In this section, we have summarized the changes to Umbraco UI Builder released in each version. Each version is presented with a link to the [UI Builder issue tracker](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](./upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco UI Builder 10 including all changes for this version.

#### [**10.0.5**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.5) **(February 13th 2025)**

* Added previously validated license resolver, to validate a license if a validation process was already executed successfully in the past 7 days.

#### [**10.0.4**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.4) **(March 18th 2024)**

* Fixed an issue where the database is getting disposed in a UIBuilder repository, causing an error when Forms tries to save the form submission after the workflow is complete [Umbraco.Forms.Issues#1179](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1179).

#### [**10.0.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.3) **(February 20th 2024)**

* Dependency version update for `Umbraco.Licenses`
* Version range update for `Microsoft.AspNetCore.Components.Web` [#89](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/89)

#### [**10.0.2**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.2) **(December 1st 2023)**

* Run server side validation on action settings dialog [#34](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/34).
* Saving a node does't close the editor [#57](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/57).
* Entity Picker used in Konstrukt editor has validation issues [#61](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/61).
* Angular error when adding a custom action in the ContainerMenu [#73](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/73).
* Not populating $scope.model.dataTypeKey, problems using Contentment Data Picker [#76](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/76).

#### [**10.0.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F10.0.1) **(November 1st 2023)**

* Null check text based filter clauses [#66](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/66).
* Allow setting an editor fields Data Type by Guid key [#67](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/67).
* Updated child entity creation routine to cast the parent id to the childs FK type, allowing conversion via Type Converters [#68](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/68).
* Updated entity service `FetchEntitiesByIds` to maintain the order of results based on the order of the IDs passed in [#70](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/70).

#### [**10.0.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues) **(October 25th 2023)**

* Initial product launch.

## Legacy release notes

You can find the release notes for **Konstrukt** in the [Change log file on GitHub](changelog-archive/changelog.md).
