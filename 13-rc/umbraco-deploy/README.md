---
description: Documentation on how to work with Umbraco Deploy RC.
---

# What is Umbraco Deploy?

Umbraco Deploy is a deployment tool that helps you with the process of transferring code and data between multiple environments. Deploy can be configured for many different setups and is great for both small setups as well as large and more complex infrastructures.

## Getting started with the Umbraco 13 RC

Below you will find the steps on how you can install the Umbraco Deploy 13 RC project using the Command Line.

### prerequisite

* [.NET 8.0.0.rc.2](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) installed

#### Install using Command Line

To install Umbraco Deploy 13 RC run the following in the command line:

* ```
  dotnet add package Umbraco.Deploy.OnPrem --version 13.0.0-rc1
  ```

## New and Updated articles

Below you will find a list of new and updated articles for the Umbraco 13 Release Candidate.

The list will be updated as more articles have been created and updated.

* Table of Contents:
  * [Configuration](deploy-settings.md)
  * [Release notes](release-notes.md)
* UPGRADING:
  * [Version Specific Upgrade Details](upgrades/version-specific.md)

### Breaking Changes

Some breaking changes have been introduced in the Umbraco 13 Release Candidate, you can find the list of breaking changes in the [Version Specific Upgrades](upgrades/version-specific.md#version-13) article.

{% embed url="https://www.youtube-nocookie.com/embed/Fqfc-UL4q5U" %}
Umbraco Deploy Overview
{% endembed %}

Umbraco Deploy is also the engine that runs behind the scenes on [Umbraco Cloud](https://docs.umbraco.com/umbraco-cloud/). Here it takes care of all the deployment processes of both code, schema, and content on projects.

With Umbraco Deploy you get to use the Umbraco Cloud Deployment technology outside of Umbraco Cloud to ease deployment between multiple Umbraco environments. This is done by connecting externally hosted Umbraco projects with a local instance of your Umbraco website.

In the Umbraco Deploy documentation can read all about how to set up and work with Umbraco Deploy.

You can find articles about how to set up Umbraco Deploy on a new or an existing website, and articles about the deployment workflow.
