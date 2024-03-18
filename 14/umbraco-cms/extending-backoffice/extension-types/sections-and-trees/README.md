---
description: A guide to creating a section
---

# Section

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

<figure><img src="../../../.gitbook/assets/section.svg" alt=""><figcaption><p>Section</p></figcaption></figure>

**Manifest**

```typescript
// TODO: get interface
const section : ManifestSection = {
	"type": "section",
	"alias": "My.Section",
	"name": "My Section",
	"meta": {
		"label": "My Section",
		"pathname": "my-section"
	}
}
```

**Manifest with empty element**
Create a element with a default export and load the element like this:

```typescript
const section : ManifestSection = {
    "type": "section",
    "alias": "Empty.Section",
    "name" : 'Empty Section',
    element : () => import('./empty-section.element.js'),
    meta : {
        label : 'Foo',
        pathname : 'empty-section'
    }
}
```

**Default Element**

```typescript
// TODO: get interface
interface UmbSectionElement {}
```

### The Section Context <a href="#the-section-context" id="the-section-context"></a>

**Interface**

```typescript
// TODO: get interface
interface UmbSectionContext {}
```

### Examples of sections: <a href="#examples-of-sections" id="examples-of-sections"></a>

TODO: link to all [sections ](https://apidocs.umbraco.com/v14/ui/?path=/docs/umb-section-main--docs)in storybook. Can we somehow auto-generate this list?
