---
description: >-
  Learn how to start testing a pre-release for the latest version of Umbraco
  CMS, and find information about new and updated documentation.
---

# Pre-Release Guide

The pre-release can be used to test your website and projects against the next major version of Umbraco CMS.

The first phase is a beta version, which is then followed by a Release Candidate.

This article contains all the resources needed for you to start testing.

* [How to Test the Pre-Release version](release-candidate-guide.md#test-the-pre-release-version)
* [New and Updated Documentation](release-candidate-guide.md#new-and-updated-documentation)

{% hint style="info" %}
This document will be updated and expanded as more and more documentation is added throughout the beta and release candidate phases.
{% endhint %}

## Test the Pre-Release version

Ensure you meet the prerequisites and move on to the installation steps outlined below.

### Prerequisites

* The latest [.NET SDK 10.0](https://dotnet.microsoft.com/en-us/download/dotnet/10.0).

### Install a Pre-Release Version

The [beta version is available on NuGet](https://www.nuget.org/packages/Umbraco.Templates/18.0.0-beta).

1. Install the Umbraco dotnet template for the beta.

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

This will boot the project and write the log to the console. The website is now running on your local machine and will be available on the ports written in the console.

{% hint style="info" %}
Alternatively, you can install and run the Umbraco project using your favorite IDE (Integrated Development Environment).
{% endhint %}

## New and updated documentation

Here is a list of all the new or updated articles in this version.

* [Version Specific Updates: Breaking Changes](../../get-started/upgrading-and-migrating/version-specific/)
* [Elements](../../model-your-content/content-types-and-structure/data/defining-content/elements.md)
* [Element Picker](../../model-your-content/property-editors/built-in-umbraco-property-editors/element-picker.md)

### Removed articles

* ILocalizationServices

### Updated articles

* Coming soon
