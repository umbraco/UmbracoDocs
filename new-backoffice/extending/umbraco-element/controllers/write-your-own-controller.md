---
description: Reuse functionality across components by writing it as a Controller
---

# Write your own Controller

A Controller must follow the interface of UmbController, to ease the implementation you can base your class on the `UmbController`:

```csharp
import { UmbController } from '@umbraco-cms/backoffice/controller-api';

class MyController extends UmbBaseController {
	
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
