# Collection Repository

A collection repository is a specific type of repository designed to handle operations related to collections of items. It provides methods to request collections of data in a filtered and paginated manner.

The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_collection.UmbCollectionRepository.html).

```typescript
interface UmbCollectionRepository {
  requestCollection();
}
```