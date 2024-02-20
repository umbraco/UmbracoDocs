---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco UI
  Builder.
---

# Release Notes

In this section, we have summarized the changes to Umbraco UI Builder released in each version. Each version is presented with a link to the [UI Builder issue tracker](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco UI Builder 13 including all changes for this version.

#### [**13.1.0-rc1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.1.0) **(February 20th 2023)**

* Retrieve Child Collections

This feature addresses a **one-to-many** relationship context, where having a parent collection with child sub-collections, one might need to retrieve the child collections only, without fetching the details of the parent.

You can read more in [this](collections/retrieve-child-collections.md) section of the documentation.

* Related Collections

This feature provides support for managing **many-to-many** relationships by configuring main, related and junction entities.

You can read more in [this](collections/related-collections.md) section of the documentation.

* Implementation of an `UdiConverter`

When configuring a collection to use as foreign key a reference to an Umbraco entity, while having the foreign key represented as `Integer`, the UDI value of the entity cannot be converted from `String` to `Int`, and will default to 0. With this feature, based on the UDI value, we are retrieving and persisting the `Id` of the Umbraco entity.

An use case can be found [here](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/86).


#### [**13.0.3**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.3) **(February 20th 2023)**

* Dependency version update for `Umbraco.Licenses`

#### [13.0.2](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=label%3Arelease%2F13.0.2+is%3Aclosed) (January 26th 2024)

* Doesn't work after upgrading to 13.0.3 [#88](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/88)
* Dependency issue when installing UIBuilder alongside Umbraco Commerce in a v13 Umbraco website [#82](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/87)
* Dependency issue when installing UIBuilder alongside uSync in a v13 Umbraco website [#85](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/85)
* Fields in Sidebar are not included when creating item [#82](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/82)

#### [13.0.1](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=label%3Arelease%2F13.0.1+is%3Aclosed) (January 11th 2024)

* Fix built-in export/import actions errors [#84](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/84)
* Update list view `editorState` to support integration with `Contentment Data Types` [#83](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/83)

#### [13.0.0](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13+label%3Arelease%2F13.0.0) (December 13th 2023)

* Upgraded to run again Umbraco v13 and .NET 8
* Upgraded all 3rd party dependencies
* Nullable references

## Legacy release notes

You can find the release notes for **Konstrukt** in the [Change log file on Github](changelog-archive/changelog.md).
