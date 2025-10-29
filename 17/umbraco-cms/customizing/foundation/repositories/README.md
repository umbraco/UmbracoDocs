# Repositories
Repositories provide a structured way to manage data operations in the Backoffice. They abstract the data access layer, allowing for easier reuse and scalability.

Repositories create separation between domain logic and data access. By providing a known interface for data requests, we can reuse UI components across different domains. For example, we have a generic UX flow for deleting an entity. By supplying this flow with a repository that has a known interface for deletion, we can use the same UX flow to delete any entity.

Additionally repositories can utilize different data sources depending on the application's state. These sources may include:

* A REST API
* Offline storage
* A local cache
* Etc.

This abstraction ensures that consumers don’t need to worry about how to access data. The repository serves as the Backoffice’s entry point for requesting new data. As a result, we achieve a loosely coupled connection between consumers and data storage procedures, effectively hiding complex implementations.

**Repository:** defines what data operations are available (get, add, update, delete).
**Data Source:** defines how data is actually fetched or stored.

### Data flow with a repository <a href="#data-flow-with-a-repository" id="data-flow-with-a-repository"></a>

A repository must be instantiated where it is used. It should take an [UmbController](../../umbraco-controller/README.md) as part of the constructor. This ensures that any contexts consumed in the repository, like notifications or modals, are rendered in the correct context.

A repository can be initialized directly from an element, but will often be instantiated in a [context](../../context-api/README.md), like the Workspace Context.

```text
Element → (Context) → Repository → Data Source(s)
```

### Using an existing Repository <a href="#using-a-repository" id="using-a-repository"></a>

Often, you will find that data is already available and observable in a [context](./contexts/README.md), such as the Workspace Context. In that case, subscribing to the context [state](./states.md) will be the right approach to take. This way, you will receive all runtime updates that occur to the data throughout the session.

When a context with the appropriate data state is not available, reaching for a repository will ensure access to the needed information no matter the current application state.

```typescript
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { LitElement} from '@umbraco-cms/backoffice/external/lit';
import {UmbDocumentDetailRepository} from '@umbraco-cms/backoffice/document';

class MyElement extends UmbElementMixin(LitElement) {
  ...
  #documentRepository = new UmbDocumentDetailRepository(this);

  firstUpdated() {
    const { data, error } = await this.#documentRepository.requestByUnique('some-unique-key');
    console.log('The Document Data:', data);
  }
  ...
}

const documentRepository = new UmbDocumentDetailRepository(this);

```

### Register a custom Repository <a href="#register-a-custom-repository" id="register-a-custom-repository"></a>

By registering your repository in the [Extension Registry](../../extension-registry/README.md) you make it available to use in different extension kinds that requires a repository alias.

Some of the common repository interfaces are:
* [UmbDetailRepository](./repository-types/detail-repository.md) - for detail views of a single entity.
* [UmbCollectionRepository](./repository-types/collection-repository.md) - for collection views of multiple entities.
* [UmbTreeRepository](./repository-types/tree-repository.md) - for tree structures of entities.
* [UmbItemRepository](./repository-types/item-repository.md) - for item requests.

See the example below of how to register a custom repository:

```typescript
import { umbExtensionsRegistry } from "@umbraco-cms/backoffice/extension-registry";

interface MyEntityDetailModel {
  unique: string;
  entityType: string;
}

class MyEntityDetailRepository implements UmbDetailRepository<MyEntityDetailModel> {
  // Implement repository methods here
}

const repositoryManifest = {
  type: "repository",
  alias: "My.Repository.EntityDetail",
  name: "My Entity Detail Repository",
  api: MyRepository,
};

umbExtensionsRegistry.register(repositoryManifest);
```

