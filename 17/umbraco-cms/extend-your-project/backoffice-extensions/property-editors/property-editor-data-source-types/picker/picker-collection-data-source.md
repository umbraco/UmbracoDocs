## Picker Collection Data Source

The interface below is simplified for clarity and omits return types and arguments. See full interfaces in the [UI API Documentation](https://apidocs.umbraco.com/v17/ui-api/modules/packages_core_picker-data-source.html)

```typescript
interface UmbPickerPropertyEditorCollectionDataSource {
  requestCollection();
  requestItems();
  search?();
  setConfig?();
  getConfig?();
}
```

### Example
```typescript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';
import type { UmbCollectionFilterModel, UmbCollectionItemModel } from '@umbraco-cms/backoffice/collection';
import type {
	UmbPickerCollectionDataSource,
	UmbPickerSearchableDataSource,
} from '@umbraco-cms/backoffice/picker-data-source';
import type { UmbSearchRequestArgs } from '@umbraco-cms/backoffice/search';

interface ExampleCollectionItemModel extends UmbCollectionItemModel {
	isPickable: boolean;
}

export class MyCustomPickerCollectionPropertyEditorDataSource
	extends UmbControllerBase
	implements UmbPickerCollectionDataSource<ExampleCollectionItemModel>, UmbPickerSearchableDataSource
{
	collectionPickableFilter = (item: ExampleCollectionItemModel) => item.isPickable;

	async requestCollection(args: UmbCollectionFilterModel) {
		const data = {
			items: customItems,
			total: customItems.length,
		};

		return { data };
	}

	async requestItems(uniques: Array<string>) {
		const items = customItems.filter((x) => uniques.includes(x.unique));
		return { data: items };
	}

	async search(args: UmbSearchRequestArgs) {
		const items = customItems.filter((item) => item.name?.toLowerCase().includes(args.query.toLowerCase()));
		const total = items.length;

		const data = {
			items,
			total,
		};

		return { data };
	}
}

export { ExampleCustomPickerCollectionPropertyEditorDataSource as api };

const customItems: Array<ExampleCollectionItemModel> = [
	{
		unique: '1',
		entityType: 'example',
		name: 'Example 1',
		icon: 'icon-shape-triangle',
		isPickable: true,
	},
	{
		unique: '2',
		entityType: 'example',
		name: 'Example 2',
		icon: 'icon-shape-triangle',
		isPickable: false,
	},
	{
		unique: '3',
		entityType: 'example',
		name: 'Example 3',
		icon: 'icon-shape-triangle',
		isPickable: true,
	},
];

```