---
description: Introduces upgrades in Umbraco, describing what to consider when planning an upgrade.
---

# Upgrades in Umbraco

## What is involved in an upgrade

When upgrading to a new version of Umbraco, there are four key aspects of the migration to be aware of.

### Database schema and content

Firstly there's the update of your Umbraco database's schema and how the content is stored.  On occasion changes are necessary to support a new feature. This might be adding new tables or columns, or updating the stored data. This is something Umbraco takes care of for you. When Umbraco starts up and is running a newer version, the necessary changes will be detected and applied.

As a developer responsible for the Umbraco website, there's nothing specific you need to do here.  We will communicate key migrations that will happen on major version upgrades. As if you have a large site and significant amounts of data need to be updated, the migration could take some time to complete.

Minor or patch versions may contain schema and content updates too, but they won't be extensive.

### Supported features

Secondly you should review your use of property editors to ensure that they are available on the new version.  It's rare for these to be removed, but it can happen when better alternatives are available.  These are only removed in major versions and with plenty of notice on the [announcements repository](https://github.com/umbraco/Announcements). Property editors for retirement will also have been indicated as legacy on earlier versions.

### Project customizations

The third aspect is determining and verifying that your own code customizations are compatible with the new version. This includes C# server-side functionality, Razor templates and JavaScript backoffice extensions.

Extensive efforts are made to avoid breaking changes that would cause issues for these types of customization other than in a major version update.

### Third-party packages

Finally you should consider the packages you are using on your project. You will need to verify that the package will work with the new version of Umbraco. Or that a compatible upgrade of the package is available or planned.

As above, breaking changes that would prevent packages from working other than in a major version update are avoided.

### Considerations for major version upgrades

For the reasons described, projects always need to be considered case by case when upgrading to new versions.

Umbraco communicates about the breaking changes in release blog posts and on the documented [version specific upgrade details](./version-specific/README.md). There will be extended release candidate periods to ensure upgrades can be tested and to help package developers support new major versions.

Breaking changes are minimized but there will be cases when such updates are needed. How straightforward the upgrade will be depends on the breaking changes included in the major and whether your project(s) are impacted by them.

## Before you upgrade

The following lists a few things to be aware of before initiating an upgrade of your Umbraco CMS project.

* Sometimes, there are exceptions to general upgrade guidelines. These are listed in the [**version-specific guide**](version-specific/). Be sure to read this article before moving on.
* Ensure your setup meets the [requirements](../requirements.md) for the new versions you will be upgrading your project to.
* Things may go wrong for different reasons. Be sure to **always** keep a backup of both your site's files and the database. This way, you can always return to a version that you know works.
* Before upgrading to a new major version, check if the packages you're using are compatible with the version you're upgrading to. On the package's page on the [Umbraco Marketplace](https://marketplace.umbraco.com/), check the "Umbraco versions" field.

