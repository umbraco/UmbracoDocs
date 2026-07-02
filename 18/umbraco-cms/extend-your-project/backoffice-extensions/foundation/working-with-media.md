---
description: >-
  Display and fetch media in backoffice extensions using the media thumbnail component, the media
  repositories, and a media reference from a custom block view.
---

# Working with Media

Backoffice extensions often need to show or resolve a media item. You usually start with a media key, which is a GUID. From the key you either render the image or fetch the media data.

Reach for the ready-made components and repositories rather than building URLs by hand. They handle authentication, HMAC-signed URLs, lazy loading, and caching for you.

## Displaying a media item

The quickest way to show a media item is the `umb-media-thumbnail` component. The backoffice registers the component for you, so you pass the media key as the `unique` property.

{% code title="my-element.ts" %}
```typescript
// In your render method:
html`<umb-media-thumbnail .unique=${mediaKey} .width=${300} .height=${300}></umb-media-thumbnail>`;
```
{% endcode %}

The component requests a resized, cropped URL and renders the image. It falls back to an icon when the item has no image, such as a PDF.

The following properties control the result:

* `unique` — the media key (GUID).
* `width` and `height` — the target size in pixels.
* `mode` — the crop mode. Optional.
* `format` — the output format. Optional, as the server picks the best format by default.
* `loading` — `lazy` (the default) or `eager`.
* `alt` and `icon` — the alt text and the fallback icon.

### Showing the original image

Use `umb-media-image` when you need the original file without resizing or cropping.

```typescript
html`<umb-media-image .unique=${mediaKey}></umb-media-image>`;
```

Both components respect transparency. `umb-media-thumbnail` adds server-side cropping and a checkerboard background.

### Removing the checkerboard background

`umb-media-thumbnail` shows transparent areas over a checkerboard pattern. The pattern signals transparency while an editor manages media.

Remove the pattern with the `--umb-media-thumbnail-background` custom property when the thumbnail represents final content, such as a block in a grid.

```css
umb-media-thumbnail {
    --umb-media-thumbnail-background: none;
}
```

The property is a CSS custom property, so it inherits. You can set the property on any ancestor and every thumbnail underneath picks up the value.

## Showing media in a custom block view

A custom block view receives the block content as the `content` property. A Media Picker property holds an array of entries, and each entry has a `mediaKey` with the media GUID.

Read the property by its alias, then pass the first entry's `mediaKey` to a thumbnail.

{% code title="example-media-block-view.ts" %}
```typescript
import { html, customElement, property, nothing } from '@umbraco-cms/backoffice/external/lit';
import { UmbLitElement } from '@umbraco-cms/backoffice/lit-element';
import type { UmbBlockEditorCustomViewElement } from '@umbraco-cms/backoffice/block-custom-view';
import type { UmbBlockDataType } from '@umbraco-cms/backoffice/block';
import type { UmbMediaPickerPropertyValueEntry } from '@umbraco-cms/backoffice/media';

@customElement('example-media-block-view')
export class ExampleMediaBlockView extends UmbLitElement implements UmbBlockEditorCustomViewElement {
    @property({ attribute: false })
    content?: UmbBlockDataType;

    override render() {
        const image = (this.content?.image as Array<UmbMediaPickerPropertyValueEntry> | undefined)?.[0];

        return html`
            ${image
                ? html`<umb-media-thumbnail .unique=${image.mediaKey} .width=${150} .height=${150}></umb-media-thumbnail>`
                : nothing}
            <p>${this.content?.featureName}</p>
        `;
    }
}

export default ExampleMediaBlockView;
```
{% endcode %}

For the full custom view setup, see [Custom Views for Block List](../../tutorials/creating-custom-views-for-blocklist.md).

## Fetching a media item by key

When you need media data rather than only the image, use a media repository.

* `UmbMediaItemRepository` returns lightweight item data, such as the name, icon, and media type. Use the repository for lists and references.
* `UmbMediaDetailRepository` returns the full media item, including all property values.

```typescript
import { UmbMediaItemRepository } from '@umbraco-cms/backoffice/media';

const repository = new UmbMediaItemRepository(this);
const { data } = await repository.requestItems([mediaKey]);
const item = data?.[0];
```

Both repositories follow the standard patterns. See [Item Repository](repositories/repository-types/item-repository.md) and [Detail Repository](repositories/repository-types/detail-repository.md) for the shared API.

## Getting a media URL

To resolve a URL without rendering a component, call a repository directly.

### A resized or cropped URL

`UmbImagingRepository` returns absolute, ready-to-use URLs. The repository batches and caches requests.

```typescript
import { UmbImagingRepository } from '@umbraco-cms/backoffice/imaging';

const repository = new UmbImagingRepository(this);
const { data } = await repository.requestResizedItems([mediaKey], { width: 300, height: 300 });
const url = data?.[0]?.url;
```

### The original file URL

`UmbMediaUrlRepository` returns the URL of the original file.

```typescript
import { UmbMediaUrlRepository } from '@umbraco-cms/backoffice/media';

const repository = new UmbMediaUrlRepository(this);
const { data } = await repository.requestItems([mediaKey]);
const url = data?.[0]?.url;
```

## Choosing the right approach

| Goal | Use |
| --- | --- |
| Show a sized thumbnail | `umb-media-thumbnail` |
| Show the original image | `umb-media-image` |
| Get a resized or cropped URL | `UmbImagingRepository` |
| Get the original file URL | `UmbMediaUrlRepository` |
| Read the name, icon, or media type | `UmbMediaItemRepository` |
| Read all property values | `UmbMediaDetailRepository` |
