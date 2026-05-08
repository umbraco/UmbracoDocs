---
description: >-
  Providing a Context enables distant code to communicate with it, ideal way to
  incorporate central logic.
---

# Provide a Context

## Provide a Context API

The recommended approach is to base your Context API on the `UmbContextBase` class, which provides automatic context registration. The following example shows how it's used:

```typescript
import { UmbContextBase } from '@umbraco-cms/backoffice/class-api';

export class MyCustomContext extends UmbContextBase {
	constructor(host: UmbControllerHost) {
		super(host, MY_CUSTOM_CONTEXT);
	}
}

export const MY_CUSTOM_CONTEXT = new UmbContextToken<MyCustomContext, MyCustomContext>(
	'MyCustomContextUniqueAlias',
);
```

For a practical implementation example, see the [Extension Type Workspace Context](../../extending-overview/extension-types/workspaces/workspace-context.md) article.

You can provide a Context API from any Umbraco Element or Umbraco Controller:

```typescript
this.provideContext('myContextAlias', new MyContextApi());
```

Or provide it from a Controller using a `host` reference to the Controller Host (Umbraco Element/Controller):

```typescript
new UmbContextProviderController(host, 'myContextAlias', new MyContextApi());
```
