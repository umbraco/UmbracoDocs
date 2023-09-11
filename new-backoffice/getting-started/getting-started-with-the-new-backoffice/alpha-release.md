---
description: An overview of the prereleases of Umbraco 14.
---

# Prereleases

## Releases

All prereleases are available to install through MyGet.

Read more about how to work with prereleases and nightly builds on [Installing Preview Builds](../../fundamentals/setup/installation/installing-preview-builds.md).

### Preview001

The first prerelease of Umbraco 14 has been released and is available through [MyGet](https://www.myget.org/feed/umbracoprereleases/package/nuget/Umbraco.Templates). You can find instructions on how to install it by reading the article [Installing Preview Builds](../../fundamentals/setup/installation/installing-preview-builds.md).

#### Available features and functionality

* Dashboards
* Property Editors models, UI, and value converters
* Sections
* Workspace Views (formerly known as Content Apps)
* Backoffice API Controllers

### Preview002

The second prerelease of Umbraco 14 has been published and is available through [MyGet](https://www.myget.org/feed/umbracoprereleases/package/nuget/Umbraco.Templates). You can find instructions on how to install it by reading the article [Installing Preview Builds](../../fundamentals/setup/installation/installing-preview-builds.md).

#### Available features and functionality

* [Extension conditions](https://apidocs.umbraco.com/v14/ui/?path=/docs/guides-extending-the-backoffice-registration-conditions--docs)
* [Localization](https://apidocs.umbraco.com/v14/ui/?path=/docs/api-localization-intro--docs)
* .NET 8 Preview 6

#### Breaking changes since preview001

The new preview is running .NET 8 Preview 6 which may contain breaking changes on custom code.

Due to the nature of extension conditions, your custom extensions may no longer show up in the Backoffice until you migrate to conditions. You can read more about the[ changes in conditions on the Backoffice Library](https://apidocs.umbraco.com/v14/ui/?path=/docs/guides-extending-the-backoffice-registration-conditions--docs).

## Upcoming features

Some features are not complete yet but will land in upcoming alpha releases:

* Publish documents
* Server validation of data
* User permissions

## Caveats

### .NET

The Alpha version range ships with the latest preview release of .NET 8, which passes in our internal test suite, but some limitations may be imposed in the Software Development Kit (SDK) itself. [Read more on dot.net](https://dotnet.microsoft.com/en-us/download/dotnet/8.0).

### Website frontend

It will not be possible to build a complete end-to-end website using this prerelease version of Umbraco. You can expect to be able to build a website once the Release Candidate is available.
