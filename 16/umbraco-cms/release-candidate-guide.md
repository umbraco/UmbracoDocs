---
description: >-
  Learn how to start testing the Release Candidate for the latest version of
  Umbraco CMS, and find information about new and updated documentation.
---

# Release Candidate Guide

The can be used to test your website and projects against the next major version of Umbraco CMS.

This article contains all the resources needed for you to start testing.

* [How to Test the Release Candidate](#test-the-release-candidate)
* [What Focus on When Testing](#what-to-focus-on-when-testing)
* [New and Updated Documentation](#new-and-updated-documentation)

{% hint style="info" %}
This document will be updated and expanded as more and more documentation are added throughout the release candidate phase.
{% endhint %}

## Test the Release Candidate

Ensure you meet the prerequisites and move on to the installation steps outlined below.

### Prerequisites

* The latest [.NET SDK 9.0.0](https://dotnet.microsoft.com/en-us/download/dotnet/9.0).

### Install the Release Candidate

The [release candidate is available on NuGet](https://www.nuget.org/packages/Umbraco.Cms/16.0.0-rc).

1. Install the Umbraco dotnet template for the Release Candidate.

```cmd
dotnet new install Umbraco.Templates::16.0.0-rc*
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

Read the [Release Candidate blog post](https://umbraco.com/) to learn more about notable features and changes added to the upcoming version.

The blog post will mention if there are any specific features or workflows that the Umbraco HQ team needs feedback on.

## New and updated documentation

Here is a list of all the articles that are new to this version or have been updated.

### New articles

* Coming soon...

### Updated articles

* Coming soon...
