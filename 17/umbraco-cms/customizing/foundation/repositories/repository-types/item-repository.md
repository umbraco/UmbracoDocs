# Item Repository

An item repository is a specific type of repository designed to handle operations related to multiple individual items. It provides methods to request multiple items based on unique identifiers.

The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_repository.UmbItemRepository.html)

```typescript
interface UmbItemRepository {
  requestItems();
}
```