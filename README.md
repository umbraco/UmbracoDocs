# Umbraco Documentation project
 [![made-with-Markdown](https://img.shields.io/badge/Made%20with-Markdown-1f425f.svg)](http://commonmark.org)

# Reading & using the docs
This is the documentation project for Umbraco. The scope of this project is to provide overviews of concepts, tutorials, example code, and links to API reference.

# What's in the documentation

## Getting started
[Getting started](Getting-Started/) is an introduction to Umbraco, containing explanations of basic concepts and short tutorials.

## Implementation
[Implementation](Implementation/) is an overview of Umbraco's structure and pipeline.

## Developers Reference
[Reference](Reference/index.md) is a collection of API references specifically for developers working with and extending Umbraco.

## Extending
[Extending](Extending/) is documentation on customizing and extending the backoffice.

## Tutorials
[Tutorials](Tutorials/) is a collection of the more extensive tutorials used in the documentation.

# Markdown conventions
The Umbraco Documentation uses Markdown for all of the documentation; please read about our [Markdown Conventions](Contribute/Markdown-Conventions/).

# Annotating a document

To add version information and extra keywords, [every document can be annotated using YAML](Contribute/Adding-Metadata/index.md).

# Multi version documentation
Every new version of Umbraco introduces new features. This means that every document might not work for your possibly older version.

Therefore we introduced 2 different mechanisms:
1. The [YAML metadata describing](Contribute/Adding-Metadata/index.md) `versionFrom` and `versionTo`.
2. The possibility [to add multiple files about the same topic](Contribute/File-Naming-Conventions/index.md).

# Previewing rendered output locally

There is an experimental project which supports rendering the documentation locally.

You can install the tool from [NuGet](https://www.nuget.org/packages/Umbraco.Docs.Preview.App/) by issuing the following command.

```bash
$ dotnet tool install --global Umbraco.Docs.Preview.App
```

Or check out the source at: [https://github.com/umbraco/UmbracoDocs.Preview](https://github.com/umbraco/UmbracoDocs.Preview).

Once installed, navigate to your local clone of the UmbracoDocs repository and run the command `umbracodocs`. This will start a local webserver that's listening on `http://localhost:5000` and `https://localhost:5001` by default (the actual URLs will be shown), which you can open in your browser to view the rendered documentation.

# Contributing [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/umbraco/UmbracoDocs/issues) [![GitHub contributors](https://img.shields.io/github/contributors/umbraco/UmbracoDocs.svg)](https://GitHub.com/umbraco/UmbracoDocsgraphs/contributors/)
We :heart: valuable contributions from everyone who is willing to help. It does not matter to us if it's something trivial like correcting spelling mistakes, raising an issue or writing a tutorial! Every little bit of help counts and it all helps make Umbraco easier to use, for everyone.
Otherwise, [bug reports](https://github.com/umbraco/UmbracoDocs/issues/), [bug fixes](https://github.com/umbraco/UmbracoDocs/pulls) and any feedback on Umbraco are always appreciated.
Look at the [Contributor Guidelines](CONTRIBUTING.md) to learn how you can get involved and help with the Umbraco Documentation.
## License [![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.md)
This library is released under the [MIT License](LICENSE.md).
