---
description: >-
  This article will cover in detail how you can try out and test the Release
  Candidate (RC) of Umbraco Deploy version 12.
---

# Test the Release Candidate

## Prerequisites

* Umbraco 12 RC project

## Getting started with the RC

To get started working with the Umbraco Deploy release candidate, follow the steps below using the Command Line Interface (CLI):

1. Navigate your Umbraco project folder:
   * ```
     cd TheNameOfYourUmbracoProject
     ```
2. Install/Update Umbraco Deploy:
   * ```aspnet
     dotnet add package Umbraco.Deploy.OnPrem --version 12.0.0-rc1
     ```
3. Build the project by running the `dotnet build` command in the project folder
4. Run the project using the `dotnet run` command

This will boot the project and write the log to the console. The project is now running with Deploy installed.

{% hint style="info" %}
It is also possible to install the Umbraco Deploy RC using the NuGet Package Manager in Visual Studio.

Remember to enable **pre-releases**.
{% endhint %}

## How to provide feedback

If you find issues that are not already [reported](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aopen+is%3Aissue+label%3Aproject%2Fv12+), please report them on the Umbraco Deploy [GitHub tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/new?assignees=\&labels=\&projects=\&template=1\_Bug.md).
