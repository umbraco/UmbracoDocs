# Multi version documentation conventions

To support multi version documentation we work according to these conventions.

## File naming

Naming conventions for documentation files:

The current version of a documentation page will be the normal existing filename format e.g. `flexible.md` or `index.md`

When creating alternate versions of the documentation page that apply in different Umbraco versions, we will append to the filename portion a `-v` followed by information which explains roughly to which version the documentation applies.

### Indicating ranges on file naming

Documentation that only applies to a single Umbraco version would be `flexible-v.7.7.7.md`.

But for documentation that applies to a range of versions, to make this as obvious as possible from the filename we will use vpost and vpre in the filename to indicate this eg:

`flexible-vpost-7.6.md` would contain the documentation used after v7.6 but before the next documentation version
and `flexible-vpre-7.3.md` would contain the documentation for versions before v7.3.

The `vpost` and `vpre` notations are not used to render to the user.

For SEO reasons it is not necessary to change a file name when a feature becomes obsolete.  

## Adding meta data

It is the [YAML meta data](adding-metadata.md) in the document itself, that will be used as the point of truth for when a (semver) version applies from and to.
The YAML will be added to an examine index, along with the filename and is used later on for searching on (major) version.  Or to show the information to the user.

For versioning we use 2 YAML attributes:

1. optional `versionFrom` to indicate a start version
2. optional `versionTo` to indicate which version the support ended.

Only the current version of the document can have both `versionFrom` and `versionTo` missing.  Otherwise at least one of the should be filled in.

## Discovering other pages

Alternative pages for documentation will be discovered by searching the examine index for other files beginning with the same name e.g.

If we are on the page

    /Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/flexible.md

we will search for any documents in the index beginning with

     /Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/flexible

which will return

    /Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/flexible-vpre-v7.3.md etc

But we will use the YAML for these files to display the alternate versions options to the user.

When searching the documentation pages on Our, there is an app setting that indicates the 'current' major Umbraco version, only versions documentation that have no end version specified will be returned for this major version in the initial search. However, we will explain in the search results that the user has searched the current documentation and present an option to further 'search all versions'.

## Examples

On every document the other versions will be linked to. These are some examples on how they will be referenced to:

file name                       | versionFrom | versionTo | renders out
------- |:-------------:| -----:| ---        
`flexible-vpost-7.6.md`  | 7.6.0        | 7.7.2    | 7.6.0 - 7.7.2
`flexible-vpre-7.3.md`   |              | 7.3.0    | pre 7.3.0
`flexible.md`            |              |          | current
`flexible-v8.md`         | 8.0.0        |          | 8.0.0 +
`flexible-v7.7.7.md`     | 7.7.7        | 7.7.7    | 7.7.7 (only)
