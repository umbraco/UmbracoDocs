# Multi version documentation conventions

To support multi version documentation have introduce these conventions.

1) a file without a version postfix is about the current and most recent version
2) add a new file with a version postfix
3) add an optional `versionFrom` YAML attribute to the top of the file
4) add an optional `versionTo` YAML attribute to the top of the file

## file naming

Naming conventions for documentation files:

The current version of a documentation page will be the normal existing filename format eg `flexible.md` or `index.md`

When creating alternate versions of the documentation page that apply in different Umbraco versions, we will append to the filename portion a -v followed by information which explains roughly to which version the documentation applies.

### Example

Documentation that only applies to a single Umbraco version would be `flexible-v.7.7.7.md`.

But for documentation that applies to a range of versions, to make this as obvious as possible from the filename we will use vpost and vpre in the filename to indicate this eg:

`flexible-vpost-v7.6.md` would contain the documentation for after v7.6 but before the next documentation version
and `flexible-vpre-v7.3.md` would contain the documentation for versions before v7.3...

The `vpost` and `vpre` notations are not used to render to the user.

## Adding meta data

It is the YAML meta data in the document itself, that will be used as the point of truth for when a (semver) version applies from and to.
The YAML will be added to an examine index, along with the filename.

## Discovering other pages

Alternative pages for a documentation will be discovered by searching the examine index for other files beginning with the same name eg

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
