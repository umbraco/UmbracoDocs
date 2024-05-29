---
description: Reuse functionality across components by writing it as a Controller
---

# Write your own Controller

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A Controller must follow the interface of UmbController. To ease the implementation you can base your class on the `UmbControllerBase`:

```typescript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';

class MyController extends UmbControllerBase {
	
	hostConnected() {
		super.hostConnected();
		// Your code when the Host element is connected.
	}
	hostDisconnected() {
		super.hostDisconnected();
		// Your code when the Host element is disconnected.
	}
	destroy() {
		super.destroy();
		// Your code for when this controller gets destroyed.
	}
}
```
