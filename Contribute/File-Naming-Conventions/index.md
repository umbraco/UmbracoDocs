---
meta.Title: "Multi version documentation conventions"
meta.Description: "To support multi version documentation we work according to the conventions you can read about in this article."
---

# Multi version documentation conventions

To support multi version documentation we work according to the conventions you can read about in this article.

## File naming

Naming conventions for documentation files.

The current version of a documentation article will be the normal existing filename format e.g. `ContentService-Events.md` or `index.md`

When creating articles that apply in different Umbraco versions, append to the filename portion a `-v` followed by information which explains to which version it applies.

### Target a specific Umbraco version using file naming conventions

Target the correct Umbraco version when you're creating a new version of an existing article. This is done by using a specific set of file naming conventions when creating a new article.

In the table below are examples of how to name an article based on the Umbraco version you are targetting.

|Targetted version        |File name          |
|-------------------------|-------------------|
|Current major version    |`index.md`         |
|Umbraco 9                |`index-v9.md`      |
|Umbraco 7                |`index-v7.md`      |
|Umbraco 8.10             |`index-v8.10.md`   |

### Indicating ranges on file naming

Documentation that only applies to a single Umbraco version would be `index-v7.7.7.md`.

For documentation that applies to a range of versions, we will use `vpost` and `vpre` in the filename to indicate this, for instance:

* `index-vpost7.6.md` would contain documentation to be used after version 7.6 but before the next documentation version. 

* `index-vpre7.3.md` would contain the documentation for versions before version 7.3.

The `vpost` and `vpre` notations are not used to render to the user.

For Search Engine Optimization (SEO) reasons it is not necessary to change a file name when a feature becomes obsolete.

## Adding meta data

It is the [YAML metadata](../Adding-Metadata) that will be used as the "point of truth" for when a version applies from and to.
The YAML is added to an examine index, and is used for searching on a (major) version, or to show the information to the user.

For versioning we use 3 YAML attributes:

1. `versionFrom` to indicate the first version, including the version you're setting here
2. `versionTo` to indicate in which version the support ended, including the version you're setting here
3. `versionRemoved` to indicate in which version the feature described in the article was removed

:::note
If only a `versionFrom` is specified and not a `versionTo` the version will be open ended and apply to all newer versions.

If none of the version tags are specified, the article will default to `versionFrom: 7.0.0` and be open ended.
:::

## Discovering other pages

Alternate pages for documentation will be discovered by searching the examine index for other files beginning with the same name, e.g.

If we are on the page

    /Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/ContentService-Events.md

a search for any documents in the index beginning with

    /Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/ContentService-Events

will return

    /Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/ContentService-Events-vpre7.3.md

We will use the YAML for these files to display the alternate version options to the user.

When searching articles, there's a setting that indicates the 'current' major Umbraco version: only articles with no end version specified will be returned. However, we will explain in the search results that the user has searched the current documentation and present an option to 'search all versions'.

## Examples

On every document, the other versions will be linked to. These are some examples on how they will be referenced to:

file name                             | versionFrom  | versionTo | renders out
-------                               |:------------:|     -----:| ---
`index-v7.md`                         | 7.0.0        |           | 7.0.0 +
`index-vpre7.3.md`                   |              | 7.3.0     | pre 7.3.0
`index-vpost7.6.md`                  | 7.6.0        | 7.7.2     | 7.6.0 - 7.7.2
`index-v7.7.7.md`                     | 7.7.7        | 7.7.7     | 7.7.7 (only)
`index.md`                            |              |           | current
