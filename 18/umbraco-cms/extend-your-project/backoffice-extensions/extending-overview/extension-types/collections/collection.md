---
description: >-
  Learn how to register a Collection extension and implement a Collection
  Repository to provide data for Collection Views.
---

# Collection

A Collection is an extension type that registers under a unique alias and uses a **Collection Repository** to fetch items. **Collection Views** bind themselves to the collection via that alias to display the items.

## Manifest

Register a collection using the `collection` extension type. The `repositoryAlias` in `meta` must match the alias of a registered Collection Repository.

{% code title="umbraco-package.json" %}
```json
{
  "type": "collection",
  "kind": "default",
  "alias": "My.Collection",
  "name": "My Collection",
  "meta": {
    "repositoryAlias": "My.Collection.Repository"
  }
}
```
{% endcode %}

## Collection Repository

A Collection Repository fetches and returns the items displayed in the collection. It must implement the `UmbCollectionRepository` interface, which requires a single `requestCollection` method.

### Manifest

Register the repository as a separate extension. The `api` property points to the file that exports the repository class:

{% code title="umbraco-package.json" %}
```json
{
  "type": "repository",
  "alias": "My.Collection.Repository",
  "name": "My Collection Repository",
  "api": "/App_Plugins/my-collection/my-collection.repository.js"
}
```
{% endcode %}

### Item model

Define the shape of the items your repository returns by extending `UmbCollectionItemModel`. The property names you add here are what Collection Views use when rendering the items.

The base Collection Item Model that all items must satisfy is:

```typescript
export interface UmbCollectionItemModel {
  unique: string;
  entityType: string;
  name?: string;
  icon?: string;
}
```

{% code title="types.ts" %}
```typescript
import type { UmbCollectionItemModel } from '@umbraco-cms/backoffice/collection';

export interface MyCollectionItemModel extends UmbCollectionItemModel {
  status: string;
  creator: string;
}
```
{% endcode %}

### Implementation

Extend `UmbRepositoryBase` and implement `UmbCollectionRepository`. The `requestCollection` method receives a filter object with `skip` and `take` for pagination, and must return `{ data: { items, total } }`. For guidance on making HTTP requests to a server API, see [Fetching Data](../../../foundation/fetching-data/README.md):

{% code title="my-collection.repository.ts" %}
```typescript
import type { MyCollectionItemModel } from './types.js';
import { UmbRepositoryBase } from '@umbraco-cms/backoffice/repository';
import type { UmbCollectionRepository, UmbCollectionFilterModel } from '@umbraco-cms/backoffice/collection';

export class MyCollectionRepository
  extends UmbRepositoryBase
  implements UmbCollectionRepository<MyCollectionItemModel>
{
  async requestCollection(filter: UmbCollectionFilterModel) {
    const skip = filter.skip ?? 0;
    const take = filter.take ?? 10;

    // Replace this with a real API call.
    const allItems: MyCollectionItemModel[] = [
      {
        unique: 'b3e31e9c-7d66-4c99-a9e5-d9f2b1e2b22f',
        entityType: 'my-entity',
        name: 'Item One',
        status: 'Published',
        creator: 'Admin',
      },
      {
        unique: 'ac9b6e24-4b11-4dd6-8d4e-7c4f70e59f3c',
        entityType: 'my-entity',
        name: 'Item Two',
        status: 'Draft',
        creator: 'Editor',
      },
    ];

    const items = allItems.slice(skip, skip + take);

    return {
      data: {
        items,
        total: allItems.length,
      },
    };
  }
}

export { MyCollectionRepository as api };
```
{% endcode %}

The exported `api` alias lets the extension registry instantiate the class when the collection loads.

## Next steps

With a collection and repository registered, add a [Collection View](collection-view/README.md) to control how the items are displayed.
