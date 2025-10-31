# Detail Repository

A detail repository is a specific type of repository designed to handle operations related to individual entities. It provides methods to create, retrieve, update, and delete single entities.

The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_repository.UmbDetailRepository.html).

```typescript
interface UmbDetailRepository {
  createScaffold();
  create();
  requestByUnique();
  save();
  delete();
}
```