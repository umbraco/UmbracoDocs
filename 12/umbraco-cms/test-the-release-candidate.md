---
description: Learn how to test the next major version of Umbraco CMS.
---

# Test the Release Candidate

This article will cover in detail how you can try out and test the Release Candidate (RC) of Umbraco 12.

## Prerequisites

* Follow the [requirements](fundamentals/setup/requirements.md) for running Umbraco CMS.

## Getting started with the RC

To get started working with the Umbraco release candidate, follow the steps below using the Command Line Interface (CLI)

1. Install the new Umbraco dotnet template:
   * ```aspnet
     dotnet new -i Umbraco.Templates::12.0.0-rc2
     ```
2. Create a new empty Umbraco project once the template is installed:
   * ```
     dotnet new umbraco -n MyCustomUmbracoSolution
     ```

You can open the solution in your favorite Integrated Development Environment (IDE).

It is also possible to continue using the CLI to run your project.

### Running the RC with the CLI

To run the project with the CLI, follow the steps below:

1. Navigate to the folder:
   * ```
     cd MyCustomUmbracoSolution
     ```
2. Build the project by running the `dotnet build` command in the project folder
3. Run the project using the `dotnet run` command

This will boot the project and write the log to the console. The website is now running on the Kestrel server and will be available on the ports written in the console.

## What to focus on for testing

Below you can see a list of features in the Umbraco 12-RC that we would like to get tested and receive feedback for.

* [Content Delivery API](broken-reference/)
* [Entity Framework Core Support](tutorials/getting-started-with-entity-framework-core.md)

## How to provide feedback

If you find issues that are not already [reported](https://github.com/umbraco/Umbraco-CMS/issues?q=is%3Aopen+is%3Aissue+label%3Aproject%2Fv12), please report them on the Umbraco CMS [GitHub tracker](https://github.com/umbraco/Umbraco-CMS/issues/new?assignees=\&labels=type%2Fbug\&projects=\&template=01\_bug\_report.yml).
