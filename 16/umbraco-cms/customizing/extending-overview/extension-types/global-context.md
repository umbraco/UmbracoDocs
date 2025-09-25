---
description: Establish the bond for extensions to communication between packages and across the application
---

# Global Context

Global Context extension types allow extension authors to extract out shared logic code and make it available across the entire backoffice. These contexts are kept alive through the entire backoffice session.

Global Contexts are useful when a package needs to share functionality with other package authors.

Extension authors should prefer to use other context types [Workspace Contexts](workspaces/workspace-context.md) over Global Contexts. Umbraco itself uses Global Contexts sparingly, for clipboard, current user, and icons.

## Registration of a Global Context

You can register a global context like so:

```json
{
    type: 'globalContext',
    alias: 'My.GlobalContext.Products',
    name: 'My Products Context',
    api: 'my-products.context.js',
}
```
