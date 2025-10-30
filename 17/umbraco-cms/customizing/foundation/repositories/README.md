# Repositories
Repositories provide a structured way to manage data operations in the Backoffice. They abstract the data access layer, allowing for easier reuse and scalability.

Repositories create separation between domain logic and data access. By providing a known interface for data requests, we can reuse UI components across different domains. For example, we have a generic UX flow for deleting an entity. By supplying this flow with a repository that has a known interface for deletion, we can use the same UX flow to delete any entity. The same applies to Trees, Collections, Workspaces, and more.

Additionally repositories can utilize different data sources depending on the application's state. These sources may include:

* A REST API
* Offline storage
* A local cache
* Etc.

This abstraction ensures that consumers don’t need to worry about how to access data. The repository serves as the Backoffice’s entry point for requesting new data. As a result, we achieve a loosely coupled connection between consumers and data storage procedures, effectively hiding complex implementations.

* **Repository:** defines what data operations are available (get, add, update, delete).
* **Data Source:** defines how data is actually fetched or stored.

### Data flow with a repository <a href="#data-flow-with-a-repository" id="data-flow-with-a-repository"></a>

A repository must be instantiated where it is used. It should take an [UmbController](../../umbraco-controller/README.md) as part of the constructor. This ensures that any contexts consumed in the repository are scoped correctly.

A repository can be initialized directly from an element, but will often be instantiated in a [context](../../context-api/README.md), like the Workspace Context.

The data flow when using a repository can be illustrated as follows:

```text
(Data Source) -> Repository -> (Controller/Context) -> Element
```

### Using an existing Repository <a href="#using-a-repository" id="using-a-repository"></a>

Often, you will find that data is already available and observable in a [context](./contexts/README.md). In that case, subscribing to the context [state](./states.md) will be the right approach to take. This way, you will receive all runtime updates that occur to the data throughout the session.

When a context with the appropriate data state is not available, reaching for a repository will ensure access to the needed data no matter the current application state.

In the example below, we instantiate the `UmbDocumentItemRepository` directly in a custom element to request Document Item data by its unique key.

```typescript
import { LitElement} from '@umbraco-cms/backoffice/external/lit';
import { UmbElementMixin } from '@umbraco-cms/backoffice/element-api';
import { UmbDocumentItemRepository } from '@umbraco-cms/backoffice/document';

// Simplified element
class MyElement extends UmbElementMixin(LitElement) {
  ...
  #documentItemRepository = new UmbDocumentItemRepository(this);

  firstUpdated() {
    const { data, error } = await this.#documentItemRepository.requestItems(['some-unique-key', 'another-unique-key']);
    console.log('Response', data, error);
    // Render data in the element
  }
  ...
}
```

Alternatively, you can instantiate the repository in a [controller](..) or [context](../../context-api/README.md), store the data in a [state](../states.md), and then observe that state in your element. This is often the preferred approach as it allows for better separation of concerns and reusability across different components.

```typescript
import { UmbArrayState } from '@umbraco-cms/backoffice/observable-api';
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import { UmbDocumentItemRepository } from '@umbraco-cms/backoffice/document';

export class MyController extends UmbControllerBase {

  #items = new UmbArrayState<DocumentItemModel>([]);
  items = this.#items.asObservable();

  #documentItemRepository = new UmbDocumentItemRepository(this);

  constructor(host: UmbControllerHost) {
		super(host);
		this.#load();
	}

  async #load() {
    const { data, error } = await this.#documentItemRepository.requestItems(['some-unique-key', 'another-unique-key']);
    console.log('Response', data, error);
    this.#items.setValue(data ?? []);
    // The items state can now be observed by any element initializing this controller
  }
}
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
import { UmbRepositoryBase } from "@umbraco-cms/backoffice/repository";
import type { UmbTreeRepository } from "@umbraco-cms/backoffice/tree";

class MyTreeRepository extends UmbRepositoryBase implements UmbTreeRepository {
  // Implement repository methods here
}

const repositoryManifest = {
  type: "repository",
  alias: "My.Repository.EntityDetail",
  name: "My Entity Detail Repository",
  api: MyTreeRepository,
};

umbExtensionsRegistry.register(repositoryManifest);
```

