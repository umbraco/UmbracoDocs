---
description: >-
  Learn how to start testing the Release Candidate for the latest version of
  Umbraco CMS, and find information about new and updated documentation.
---

# Release Candidate Guide

## How to test the Release Candidate

{% hint style="warning" %}
To install the Umbraco 15 Release Candidate you need the latest [.NET SDK 9.0.0](https://dotnet.microsoft.com/en-us/download/dotnet/9.0).
{% endhint %}

The[ release candidate is available on NuGet](https://www.nuget.org/packages/Umbraco.Cms/15.0.0-rc2).

1. Install the Umbraco dotnet template for the Release Candidate.

```
dotnet new install Umbraco.Templates::15.0.0-rc*
```

2. Create a new Umbraco project.

```
dotnet new umbraco -n MyCustomUmbracoProject
```

3. Navigate to the newly created folder.

```
cd MyCustomUmbracoProject
```

4. Build the project.

```
dotnet build
```

5. Run the project.

```
dotnet run
```

This will boot the project, and write the log to the console. The website is now running on your local machine and will be available on the ports written in the console.

{% hint style="info" %}
Alternatively, you can install and run the Umbraco project using your favorite IDE (Integrated Development Environment).
{% endhint %}

### What should you focus on when testing?

Read the [Release Candidate blog post](https://umbraco.com/blog/umbraco-15-release-candidate/) to learn more about notable features and changes added to the upcoming version.

The blog post will mention if there are any specific features or workflows that the Umbraco HQ team needs feedback on.

## New and updated documentation

Here is a list of all the articles that are new to this version or have been updated.

### New articles

* [Tutorial: Extending the Help Menu](tutorials/extending-the-help-menu.md)
* [Running Umbraco in Docker using Docker Compose](fundamentals/setup/install/running-umbraco-on-docker-locally.md)
* [Creating a Custom Seed Key Provider](extending/creating-custom-seed-key-provider.md)
* [Cache Settings](reference/configuration/cache-settings.md)
* [Cache Seeding](reference/cache/cache-seeding.md)

### Updated articles

* Changes made based on the removal of the UmbracoAPIController
  * [Common Pitfalls: Static references to scoped references](reference/common-pitfalls.md#static-references-to-scoped-instances-such-as-umbracohelper)
  * [Creating a custom database table](extending/database.md)
  * [Image Cropper](fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/image-cropper.md)
  * [UmbracoMapper](reference/mapping.md)
  * [Depencency Injection / IoC](reference/using-ioc.md)
  * [Working with Caching: Tags example](reference/cache/examples/tags.md)
  * [Unit Testing](implementation/unit-testing.md)
  * [Querying: ITagQuery](reference/querying/itagquery.md)
  * [UmbracoContext helper](reference/querying/umbraco-context.md)
  * [Block Grid](fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/block-editor/block-grid-editor.md)

* Replacing the deprecated GetAll() method
  * [Working with Caching: Tags example](reference/cache/examples/tags.md)
  * [Using Services: ContentTypeService](reference/management/using-services/contenttypeservice.md)
  * [Request Pipeline: IContentFinder](reference/routing/request-pipeline/icontentfinder.md)
