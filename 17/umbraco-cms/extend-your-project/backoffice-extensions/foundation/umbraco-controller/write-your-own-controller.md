---
description: Reuse functionality across components by writing it as a Controller.
---

# Write your own controller

To create a custom controller, implement the `UmbController` interface.

To ease the implementation, you can base your class on the `UmbControllerBase`:

{% code title="my-controller.ts" %}
```typescript
import { UmbControllerBase } from '@umbraco-cms/backoffice/class-api';

class MyController extends UmbControllerBase {
	
	override hostConnected() {
		super.hostConnected();
		// Your code for when the controller is connected.
		console.log('Your controller\'s Host element has been connected.')
	}
	override hostDisconnected() {
		super.hostDisconnected();
		// Your code for when the controller is disconnected.
		console.log('Your controller\'s Host element got disconnected.')
	}
	override destroy() {
		super.destroy();
		// Your code for when this controller gets destroyed. It will never be reconnected, so end all the operations of this controller here.
		console.log('Your controller has been destroyed.')
	}
}
```
{% endcode %}

Once this is done, your Controller can host other Controllers. You can also override the available lifecycle methods when needed. Overriding these methods is optional and should only be done if the controller must perform logic during those callbacks.
