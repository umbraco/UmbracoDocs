---
description: >-
  Learn how to start testing the Release Candidate for the latest version of
  Umbraco CMS, and find information about new and updated documentation.
hidden: true
---

# Release Candidate Guide

The RC can be used to test your website and projects against the next major version of Umbraco CMS.

This article contains all the resources needed for you to start testing.

* [How to Test the Release Candidate](release-candidate-guide.md#test-the-release-candidate)
* [What to Focus on When Testing](release-candidate-guide.md#what-to-focus-on-when-testing)
* [New and Updated Documentation](release-candidate-guide.md#new-and-updated-documentation)

{% hint style="info" %}
This document will be updated and expanded as more and more documentation are added throughout the release candidate phase.
{% endhint %}

## Test the Release Candidate

Ensure you meet the prerequisites and move on to the installation steps outlined below.

### Prerequisites

* The latest [.NET SDK 10.0](https://dotnet.microsoft.com/en-us/download/dotnet/10.0).

### Install the Release Candidate

The [release candidate is available on NuGet](https://www.nuget.org/packages/Umbraco.Templates/17.0.0-beta).

1. Install the Umbraco dotnet template for the Release Candidate.

```cmd
dotnet new install Umbraco.Templates::17.0.0-beta
```

2. Create a new Umbraco project.

```cmd
dotnet new umbraco -n MyCustomUmbracoProject
```

3. Navigate to the newly created folder.

```cmd
cd MyCustomUmbracoProject
```

4. Build and run the project.

```cmd
dotnet build
dotnet run
```

This will boot the project, and write the log to the console. The website is now running on your local machine and will be available on the ports written in the console.

{% hint style="info" %}
Alternatively, you can install and run the Umbraco project using your favorite IDE (Integrated Development Environment).
{% endhint %}

## What to focus on when testing

Read the [Release Candidate blog post](https://umbraco.com/blog/umbraco-17-beta-is-out/) to learn more about notable features and changes added to the upcoming version.

The blog post will mention if there are any specific features or workflows that the Umbraco HQ team needs feedback on.

## New and updated documentation

Here is a list of all the new or updated articles in this version.

* [Version Specific Updates: Breaking Changes](fundamentals/setup/upgrading/version-specific/#umbraco-17)
* [Date Time Property Editor](fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/date-time-editor/)
* [`UnattendedTelemetryLevel` Setting](fundamentals/setup/install/install-umbraco-with-templates.md) and [`UnattendedTelemetryLevel` in Unattended Install](fundamentals/setup/install/unattended-install.md)
* [`UnattendedTelemetryLevel` in the Configuration article](reference/configuration/unattendedsettings.md#unattended-telemetry-level)
* [`GenerateVirtualProperties` option to disable virtual properties](reference/configuration/modelsbuildersettings.md#generate-virtual-properties)
* [Removed the warning on `Microsoft.EntityFrameworkCore.Design` dependency conflicts](tutorials/getting-started-with-entity-framework-core.md)
* [Kestrel `MaxRequestLength` updated to 50MB](reference/configuration/maximumuploadsizesettings.md#using-kestrel)
* [Backoffice Signs](customizing/signs.md)
* [Flag Providers](extending/flag-providers.md)
* [Added `ComposeAfter` attribute to the composer used in the Examine sample](reference/searching/examine/indexing.md#creating-a-configureoptions-class)
* [Displaying the MiniProfiler](fundamentals/code/debugging/#displaying-the-miniprofiler)
* [Load Balancing the Backoffice](fundamentals/setup/server-setup/load-balancing/load-balancing-backoffice.md)
* [SignalR in a Backoffice Load Balanced Environment](fundamentals/setup/server-setup/load-balancing/signalR-in-backoffice-load-balanced-environment.md)
* [Distributed jobs settings](reference/configuration/distributedjobssettings.md)
* [Background jobs when load balancing the backoffice](reference/scheduling.md#background-jobs-when-load-balancing-the-backoffice)
* [Property Editor Data Source](customizing/property-editors/composition/property-editor-data-source.md)
* [Picker Data Source Type](customizing/property-editors/data-source-types/picker/)
* [Collection Data Source](customizing/property-editors/data-source-types/picker/picker-collection-data-source.md)
* [Tree Data Source](customizing/property-editors/data-source-types/picker/picker-tree-data-source.md)
* [Entity Data Picker](fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/entity-data-picker.md)
* [Kinds](customizing/extending-overview/extension-types/workspaces/workspace-action-menu-items.md#kinds)
* [Repositories](customizing/foundation/repositories/)
* [Collection Repository](customizing/foundation/repositories/repository-types/collection-repository.md)
* [Detail Repository](customizing/foundation/repositories/repository-types/detail-repository.md)
* [Item Repository](customizing/foundation/repositories/repository-types/item-repository.md)
* [Tree Repository](/broken/pages/yMlx6WISE7QKjbGs3R2z)
* [Temporary File Storage](fundamentals/setup/server-setup/load-balancing/load-balancing-backoffice.md#temporary-file-storage)
* [Backoffice token cookie settings](reference/configuration/securitysettings.md#backoffice-token-cookie-settings)

### Removed articles

* Editor Model Notifications
* Content Dashboard Settings

### Updated articles

* [Additional preview environments support](reference/content-delivery-api/additional-preview-environments-support.md)
* [Outbound Pipeline](reference/routing/request-pipeline/outbound-pipeline.md)
* [Property Actions](customizing/property-editors/property-actions.md)
* [Confirm Dialog](customizing/extending-overview/extension-types/modals/confirm-dialog.md)
