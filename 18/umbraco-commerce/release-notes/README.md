---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Commerce.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Commerce released in each version. Each version is presented with a link to the [Commerce issue tracker](https://github.com/umbraco/Umbraco.Commerce.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](../upgrading/version-specific-upgrades.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Commerce 18, including all changes for this version.

#### 18.0.0-rc1 (05th Jun 2026)

* Initial release candidate for Umbraco v18. 
  - 3 startup notification handlers are now async (INotificationAsyncHandler); sync Handle removed — override HandleAsync instead.
  - 7 public Swagger handler classes removed (CMS v18 dropped Swashbuckle); OpenAPI output is unchanged, customizations move to the Microsoft transformer APIs.
  - Obsolete Udi-based VariantEditorLayoutItem constructors removed.
