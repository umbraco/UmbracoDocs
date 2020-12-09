---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Developer Documentation

## [Packaging, Extraction and transferring](PackagingAndExtraction.md)
Overview of the different phases of a courier deployment, packaging changes, transferring them and extracting them on a target.

## [Data resolvers](DataResolvers.md)
In some cases, data must be modified to be transfer correctly, data resolvers helps developers to temporarily modify deployed data.

## [Events](Events.md)
Some events might be triggered on deployment, and overridden if necessary.

## [Included Resource resolvers](ResourceResolvers.md)
Courier includes a number of resource resolvers to modify deployed files as they are packaged and extracted.

## [Included Persistence Providers](PersistenceProviders.md)
A Persistence provider is the datalayer used by courier to store data in the database.

## [Included Repository Providers](../Configuration/RepositoryProviders.md)
A Repository is an API Courier can use to transfer data between locations.
