---
description: Establish the bond for extensions to communication across the application
---

# Global Context

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A global context manages the logic code from your Lit Element controllers.

## Registration of a Global Context

You can register a global context like so:

```typescript
{
    type: 'globalContext',
    alias: 'My.GlobalContext.Products',
    name: 'My Products Context',
    api: 'my-products.context.js',
}
```
