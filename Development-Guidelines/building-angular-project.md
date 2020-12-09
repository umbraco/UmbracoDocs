---
versionFrom: 7.0.0
meta.Title: "Working with the backoffice UI AngularJs project"
meta.Description: "Guidelines for working with backoffice UI AngularJs project"
---

# Working with the backoffice UI AngularJs project

## Overview
Umbraco has a slightly unorthodox project structure, compared to a normal ASP.NET project. This is by design, a choice from the beginning to embrace a much larger group than the developers who know how to use Visual Studio.

As a result, the Umbraco UI is not a Visual Studio project, but a collection of folders and files, following certain conventions, and a small configuration file called `gulpfile` - we will get to the gulp part in a moment.

This means that anyone with a text editor can open the UI source, make changes and run the project, without having Visual Studio installed - we will get into how to do that in a moment as well.

The bottom line is the UI project has zero dependencies on ASP.NET or Windows. However, you will need Node.js installed, but don't worry we will get into that in a second.

## Building & Developing the project

For detail on building and working with the Umbraco source code, have a look at the [contribution guidelines](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/.github/CONTRIBUTING.md#building-umbraco-from-source-code) on the Umbraco CSM GitHub page.


## Conclusion
Having Umbraco UI as a separate project does indeed give us a bit more complexity when building and running from Visual Studio since 2 build systems are in play: npm and MSBuild.

However, the alternative would be to shove everything into the MSBuild process, making the entire thing inaccessible to a large number of frontend developers and with a clunkier and less up to date system.

So see it as an additional powerful tool in your arsenal, once you see the power, you don't want to go back.
