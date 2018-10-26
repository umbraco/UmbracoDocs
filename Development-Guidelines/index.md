# Development Guidelines

_All about working with the Umbraco codebase_

## [Coding and naming conventions](Coding-Standards/index.md)
The naming conventions used throughout the codebase including C#, JavaScript and CSS and how classes in C# and JavaScript should be created and used.

## [The solution and project structure](project-structure.md)
How the Visual Studio solution is put together, the functionality of each project and the end goal of the structure.

## [Working with the code](working-with-code.md)
Describes the process of creating new classes and where they should be stored in regards to namespaces and projects. Also describes how to deal with updating legacy code and how it should be updated.

## Unit testing

There are plenty of unit tests in the core of Umbraco both for C# found in Umbraco.Tests project and for JavaScript found in the Umbraco.Web.UI.Client project.

When submitting pull requests or working with the code we encourage all developers to make changes by writing unit tests, a PR will have a far higher chance of being pulled into the core quicker with passing unit tests.

## [Breaking changes](breaking-changes.md)
Defines what a breaking change is in regards to the Umbraco core codebase and describes how to deal with required breaking changes.
