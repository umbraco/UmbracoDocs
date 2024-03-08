---
description: >-
  Append a secondary view for a Section, use it for additional features or
  information.
---

# Section View

{% hint style="warning" %}
This page is a work in progress.
{% endhint %}

<figure><img src="../../../.gitbook/assets/section-views.svg" alt=""><figcaption><p>Section View</p></figcaption></figure>

**Manifest**

```json
{
	"type": "sectionView",
	"alias": "My.SectionView",
	"name": "My Section View",
	"meta": {
		"sections": ["My.Section"],
		"label": "My View",
		"pathname": "/my-view"
	}
}
```
