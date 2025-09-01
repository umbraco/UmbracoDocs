---
description: >-
    Add auxiliary views to your own Umbraco packages, or to other areas of the Umbraco backoffice.
---

# Section View

Section View extensions serve as containers that can be integrated into custom Umbraco packages or extended to other
areas of the Umbraco backoffice, including the Content, Media, Settings, User, Member, or Translations sections. These
extensions can contain other Umbraco extensions, such as dashboards or web components, enabling package authors to
populate the section with virtually any content or custom interface they envision.

<figure><img src="../../../../.gitbook/assets/section-views.svg" alt=""><figcaption><p>Section View</p></figcaption></figure>

## Creating a custom Section View

Custom Section View extensions are straightforward to create. Extension authors register the Section View extension and
subsequently implement the content or interface they desire to display within the Section View.

### Registering Section View extensions

Extension authors have the option of registering custom Section View extensions using two methods: declarative
registration via manifests or imperative registration using TypeScript and [Backoffice Entry Points](../backoffice-entry-point.md). Both methods
are shown below.

#### Registering by manifest

{% tabs %}
{% tab title="Json" %}
Extensions authors can register the Section View extension using a JSON declaration in the `umbraco-package.json` file.

{% code title="umbraco-package.json" %}
```json
{
	"type": "sectionView",
	"alias": "My.SectionView",
	"name": "My Section View",
	"element": "/App_Plugins/<package_name>/my-section.element.js",
	"meta": {
		"label": "My View",
		"icon": "icon-add",
		"pathname": "my-view"
	},
	"conditions": [
		{
			"alias": "Umb.Condition.SectionAlias",
			"match": "My.Section"
		}
	]
}
```
{% endcode %}

Tip: We recommend using the absolute path, starting from the root of your Umbraco project, in the `element` property for
JSON declarations. TypeScript declarations are capable of employing relative paths.

{% endtab %}

{% tab title="TypeScript" %}
The manifest can also be written in TypeScript.

For this TypeScript example we used a [Backoffice Entry Point](../backoffice-entry-point.md) extension to register the manifests.

{% code title="my-section.element.ts" %}
```typescript
import { ManifestSectionView } from '@umbraco-cms/backoffice/section';

const sectionViews: Array<ManifestSectionView> = [
    {
        type: "sectionView",
        alias: "My.SectionView",
        name: "My Section View",
        element: () => import('./my-section.element.ts'),
        meta: {
            label: "My View",
            icon: "icon-add",
			pathname: "my-view",
        },
        conditions: [
            {
                alias: 'Umb.Condition.SectionAlias',
				match: 'My.Section',
            }
        ]
    }
]
```
{% endcode %}

{% endtab %}
{% endtabs %}

### Lit Element

Creating the Section View Element using a Lit Element.

{% code title="my-section.element.ts" %}
```typescript
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import { css, html, customElement, property } from '@umbraco-cms/backoffice/external/lit';

@customElement('my-sectionview-element')
export class MySectionViewElement extends UmbLitElement {

    override render() {
        return html`
            <uui-box headline="Sectionview Title goes here">
                Sectionview content goes here
            </uui-box>
        `
    }

    static override readonly styles = [
        css`
			:host {
				display: block;
                padding: 20px;
			}
		`,
    ];

}

export default MySectionViewElement;

declare global {
    interface HTMLElementTagNameMap {
        'my-sectionview-element': MySectionViewElement;
    }
}
```
{% endcode %}

## Adding Section Views to your own package

When developing a Section View extension for their own package, an extension author must create a Section extension to
host the Section View extension.

Guidelines on creating Section extensions can be found at [this link](./section.md).

To associate the Section View extension with the Section extension, authors must set the `match` property of the Section
Extension’s condition definition to the same value as the `alias` property of their desired Section extension. In the
provided example, this value is `NetworkServices.Section`.

{% code title="umbraco-package.json" %}
```json
[
    {
        "type": "section",
        "alias": "NetworkServices.Section",
        "name": "Network Services",
        "meta": {
            "label": "Network Services",
            "pathname": "network-services"
        }
    },
    {
        "type": "sectionView",
        "alias": "NetworkServices.Section.Overview",
        "name": "Network Services Overview",
        "element": "/App_Plugins/NetworkServices/overview-dashboard.js",
        "meta": {
            "label": "Overview",
            "icon": "icon-add",
            "pathname": "overview"
        },
        "conditions": [
            {
                "alias": "Umb.Condition.SectionAlias",
                "match": "NetworkServices.Section"
            }
        ]
    }
]
```
{% endcode %}

## Adding Section Views to somewhere else in the backoffice

The Umbraco backoffice architecture places a strong emphasis on composing. Extension authors can extend existing
sections, including those built by Umbraco and included in the core (such as Content, Media, and Settings), using
Section View extensions.

After an author has completed their Section View extension, they can control the placement of the extension using
conditions in the manifest definition.

The `match` property demonstrates how an extension author can incorporate a custom Section View within the Content
section.

{% code title="umbraco-package.json" %}
```json
{
	"type": "sectionView",
	"alias": "My.SectionView",
	"name": "My Section View",
	"element": "/App_Plugins/<package_name>/my-section.element.js",
	"meta": {
		"label": "My View",
		"icon": "icon-add",
		"pathname": "my-view"
	},
	"conditions": [
		{
			"alias": "Umb.Condition.SectionAlias",
			"match": "Umb.Section.Content"
		}
	]
}
```
{% endcode %}

Common Umbraco-provided section aliases:

| Section Aliases         |
|-------------------------|
| Umb.Section.Content     |
| Umb.Section.Media       |
| Umb.Section.Settings    |
| Umb.Section.Packages    |
| Umb.Section.Users       |
| Umb.Section.Members     |
| Umb.Section.Translation |

Section view extensions can also be made available within the Sidebar extensions in Umbraco-provided sections, along
with a custom sidebar composed by the extension author.
