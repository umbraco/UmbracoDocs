---
description: Use localized text, so everyone can read your UI.
---

# Use Localizations

## Localize Element

The following example shows how you can display localized text with the `umb-localize` element:

```html
<button>
    <umb-localize key="dialog_myKey"></umb-localize>
</button>
```

### **Localize Controller**

In some situations, you need the localization as a variable that can be parsed.\
In this case, the Localization Controller can be used.

When using a **Umbraco Element** the **Localization Controller** is already initialized on the `localize` property.

```typescript
export class MyElement extends UmbElementMixin(LitElement) {
    render() {
        return html`<uui-button .label=${this.localize.term('title_name')}>
        </uui-button>`;
    }
}
```

If you are working from an Umbraco Controller, then you need to initialize the Localization Controller on your own:

```typescript
import { UmbBaseController } from '@umbraco-cms/backoffice/controller-pi';
import { UmbLocalizeController } from '@umbraco-cms/backoffice/localization-api';

export class MyController extends UmbBaseController {
    // Create a new instance of the controller and attach it to the element
    private localize = new UmbLocalizeController(this);
    
    sayHello() {
        console.log(this.localize.term('general_areyousure'))
    }
}
```
