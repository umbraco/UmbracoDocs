# Tree Repository

A tree repository is a specific type of repository designed to handle operations related to tree data structures. It provides methods to request tree roots, tree items, and their ancestors.

The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/interfaces/packages_core_tree.UmbTreeRepository.html)

```typescript
interface UmbTreeRepository {
  requestTreeRoot();
  requestTreeRootItems();
  requestTreeItemsOf();
  requestTreeItemAncestors();
}
```