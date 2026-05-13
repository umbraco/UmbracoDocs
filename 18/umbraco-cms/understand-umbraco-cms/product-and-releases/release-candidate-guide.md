---
description: >-
  Learn how to start testing the Release Candidate for the latest version of
  Umbraco CMS, and find information about new and updated documentation.
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

The [release candidate is available on NuGet](https://www.nuget.org/packages/Umbraco.Templates/18.0.0-beta).

1. Install the Umbraco dotnet template for the Release Candidate.

```cmd
dotnet new install Umbraco.Templates::18.0.0-beta
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

## New and updated documentation

Here is a list of all the new or updated articles in this version.

* [Version Specific Updates: Breaking Changes](../../get-started/upgrading-and-migrating/version-specific/README.md)
* [Date Time Property Editor](../../model-your-content/property-editors/built-in-umbraco-property-editors/date-time-editor/)
* [`UnattendedTelemetryLevel` Setting](../../get-started/installation/install-umbraco-with-templates.md) and [`UnattendedTelemetryLevel` in Unattended Install](../../get-started/installation/unattended-install.md)
* [`UnattendedTelemetryLevel` in the Configuration article](../../develop-with-umbraco/configuration/unattendedsettings.md#unattended-telemetry-level)
* [`GenerateVirtualProperties` option to disable virtual properties](../../develop-with-umbraco/configuration/modelsbuildersettings.md#generate-virtual-properties)
* [Removed the warning on `Microsoft.EntityFrameworkCore.Design` dependency conflicts](../../extend-your-project/tutorials/getting-started-with-entity-framework-core.md)
* [Kestrel `MaxRequestLength` updated to 50MB](../../develop-with-umbraco/configuration/maximumuploadsizesettings.md#using-kestrel)
* [Backoffice Signs](../../extend-your-project/backoffice-extensions/signs.md)
* [Flag Providers](../../extend-your-project/server-side-extensions/flag-providers.md)
* [Added `ComposeAfter` attribute to the composer used in the Examine sample](../../develop-with-umbraco/application-code/examine/indexing.md#creating-a-configureoptions-class)
* [Displaying the MiniProfiler](../../develop-with-umbraco/testing-and-debugging/README.md#displaying-the-miniprofiler)
* [Load Balancing the Backoffice](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/load-balancing-backoffice.md)
* [SignalR in a Backoffice Load Balanced Environment](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/signalr-in-backoffice-load-balanced-environment.md)
* [Distributed jobs settings](../../develop-with-umbraco/configuration/distributedjobssettings.md)
* [Background jobs when load balancing the backoffice](../../extend-your-project/server-side-extensions/scheduling.md#background-jobs-when-load-balancing-the-backoffice)
* [Property Editor Data Source](../../extend-your-project/backoffice-extensions/property-editors/composition/property-editor-data-source.md)
* [Picker Data Source Type](../../extend-your-project/backoffice-extensions/property-editors/property-editor-data-source-types/picker/)
* [Collection Data Source](../../extend-your-project/backoffice-extensions/property-editors/property-editor-data-source-types/picker/picker-collection-data-source.md)
* [Tree Data Source](../../extend-your-project/backoffice-extensions/property-editors/property-editor-data-source-types/picker/picker-tree-data-source.md)
* [Entity Data Picker](../../model-your-content/property-editors/built-in-umbraco-property-editors/entity-data-picker.md)
* [Kinds](../../extend-your-project/backoffice-extensions/extending-overview/extension-types/workspaces/workspace-action-menu-items.md#kinds)
* [Repositories](../../extend-your-project/backoffice-extensions/foundation/repositories/)
* [Collection Repository](../../extend-your-project/backoffice-extensions/foundation/repositories/repository-types/collection-repository.md)
* [Detail Repository](../../extend-your-project/backoffice-extensions/foundation/repositories/repository-types/detail-repository.md)
* [Item Repository](../../extend-your-project/backoffice-extensions/foundation/repositories/repository-types/item-repository.md)
* [Tree Repository](../../extend-your-project/backoffice-extensions/extending-overview/extension-types/tree/tree-repository.md)
* [Temporary File Storage](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/load-balancing-backoffice.md#temporary-file-storage)
* [Backoffice token cookie settings](../../develop-with-umbraco/configuration/securitysettings.md#backoffice-token-cookie-settings)

### Removed articles

* Editor Model Notifications
* Content Dashboard Settings

### Updated articles

* [Additional preview environments support](../../develop-with-umbraco/headless-and-apis/content-delivery-api/additional-preview-environments-support.md)
* [Outbound Pipeline](../../develop-with-umbraco/application-code/backend-and-custom-logic/routing/request-pipeline/outbound-pipeline.md)
* [Property Actions](../../extend-your-project/backoffice-extensions/property-editors/property-actions.md)
* [Confirm Dialog](../../extend-your-project/backoffice-extensions/utilities/modals/confirm-dialog.md)
