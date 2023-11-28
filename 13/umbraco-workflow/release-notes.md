# Release notes

In this section, we have summarized the changes to Umbraco Workflow released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](version-specific-upgrade-notes.md) article
{% endhint %}

## Release History

In this section, you can find the release notes for Umbraco Workflow 13. For earlier versions, refer to the version-specific documentation.

#### [13.0.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F13.0.0) (December 14th 2023)

* Compatibility with Umbraco 13
  * For full details of breaking changes refer to the [Version Specific Upgrade Notes](version-specific-upgrade-notes.md)
* **FEATURE** => Advanced Search dashboard. Refer to [Advanced Search dashboard](advanced-search/advanced-search-dashboard.md) for more details.
* Update to use package migrations to avoid startup exception when Workflow is installed as part of a new Umbraco installation [#48](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/48)
* Fixed issue with scheduled workflows on invariant content [#49](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/49)
