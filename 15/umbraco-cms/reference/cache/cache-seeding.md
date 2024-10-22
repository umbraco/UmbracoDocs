---
description: Information about cache seeding
---

# Cache Seeding

From version 15 and onwards Umbraco uses a lazy loaded cache, this means content is loaded into the cache on an as-needed basis
that is whenever a piece of content is shown on the website for the first time it first needs to be loaded into the cache.

Loading the content into the cache causes a delay. This delay is dependent on the latency between your server and your database, but is generally minimal.
However, for certain pages, for instance the front page, you may not want this delay to be there, the role of cache seeding is to solve this issue.

## How it works

Cache seeding is based upon the concept of a `ISeedKeyProvider`, the role of the seed key provider, is to specify what keys needs to be seeded.
There's two types of seed key providers, a `IDocumentSeedKeyProvider` which specifies which document should be seeded, and a `IMediaSeedKeyProvider` which specifies which media should be seeded.

During startup all the `ISeedKeyProviders` are run, and the keys they return are seeded into their respective caches, `IPublishedContentCache` for documents, and `IPublishedMediaCache` for media.
Additionally, whenever a document or media is then later changed, the cache will be updated with the changed content immediately, ensuring the content is always present in the cache.
However, here it's important to note, that this means that whenever a piece of content is changed, Umbraco needs to go through the seeded keys to see if it's a piece of seeded content that was updated.
Because of the need the check all seeded keys, Umbraco caches the keys themselves during startup. This means that if you have a dynamic seed key provider, any newly added content won't be considered seeded until the server restarts,
for instance when seeding by Document Type any new content using the specified Document Type won't be seeded until a server restart.

## Seed key providers

### Default implementations

By default, Umbraco ships with two seed key providers for documents, and a single one for media.

For documents there is the `ContentTypeSeedKeyProvider` this seeds all documents of the given Document Types specified through app settings.

For both documents and media there is the `BreadthFirstKeyProvider` this provider does a breadth first traversal of the content and media tree respectively, seeding N number of content specified in the app settings.

Configuration for the default seed key providers can be found in the [cache settings section.](../configuration/cache-settings.md)

### Custom seed key providers

It's also possible to implement your own seed key providers, these are run alongside the default seed key providers on startup.
The returned keys are of all the seed key providers are unioned into a single set, this means that there will be no duplicates, so you don't need to worry consider this.
However, as mentioned above the provided keys are cached, meaning that only the keys returned at startup will be considered seeded until the server restarts and the provider is run again.

For a specific example of how to implement a custom seed key provider, see [Creating a Custom Seed Key Provider](../extending/creating-custom-seed-key-provider.md).
