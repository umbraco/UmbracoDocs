---
description: Information about cache seeding
---

# Cache Seeding

Umbraco uses a lazy loaded cache, meaning content is loaded into the cache on an as-needed basis. Whenever a piece of content is shown on the website for the first time it first needs to be loaded into the cache.

Loading the content into the cache causes a delay. This delay is dependent on the latency between your server and your database, but is generally minimal.
For certain pages, like the front page, you may not want this delay to be there. The role of cache seeding is meant to solve this issue.

## How it works

Cache seeding is based on the concept of an `ISeedKeyProvider`. The role of the seed key provider is to specify what keys need to be seeded.

There are two types of seed key providers: an `IDocumentSeedKeyProvider` specifying which document should be seeded, and an `IMediaSeedKeyProvider` specifying which media should be seeded.

During startup, all the `ISeedKeyProviders` are run, and the keys they return are seeded into their respective caches, `IPublishedContentCache` for documents, and `IPublishedMediaCache` for media. Additionally, whenever a document or media is changed, the cache will immediately be updated with the changed content. This ensures that the content is always present in the cache.

Whenever a piece of content is changed, the seeded keys must be checked, to see if the updated content was seeded. Because of the need the check all seeded keys, Umbraco caches the keys themselves during startup. This means that if you have a dynamic seed key provider, any newly added content will not be considered seeded until the server restarts. For instance, when seeding by Document Type any new content using the specified Document Type will not be seeded until the server is restarted.

## Seed key providers

### Default implementations

By default, Umbraco ships with two seed key providers for documents, and one for media.

For documents, the `ContentTypeSeedKeyProvider` seeds all documents of the given Document Types specified in the `appSettings.json` file.

For documents and media, the `BreadthFirstKeyProvider` does a breadth-first traversal of the content and media tree respectively. This will seed N number of content specified in the `appSettings.json` file.

The default seed key provider configuration can be found in the [cache settings section.](../configuration/cache-settings.md).

### Custom seed key providers

It is also possible to implement custom seed key providers. These are run alongside the default seed key providers on startup.

The returned keys of all the seed key providers are unioned into a single set. This means there will be no duplicates.

As mentioned above the provided keys are cached. Only the keys returned at startup will be considered seeded until the server restarts and the provider is rerun.

For a specific example of implementing a custom seed key provider, see [Creating a Custom Seed Key Provider](../../extending/creating-custom-seed-key-provider.md).
