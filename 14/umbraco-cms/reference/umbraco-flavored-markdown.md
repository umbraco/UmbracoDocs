# Umbraco Flavored Markdown

{% hint style="info" %}
This article also addresses the Label Property Configuration. If you were looking for that content, you're in the right place.
{% endhint %}

Umbraco Flavored Markdown (UFM) is the dialect of Markdown, used to support property descriptions and advanced labels within the Umbraco CMS backoffice. These can be used with Block editors (Block Grid, Block List) and Collection View columns (in Grid and Table views).

{% hint style="info" %}
If you are not familiar with Markdown, you can read more about its philosophy and syntax on the [Daring Fireball website](https://daringfireball.net/projects/markdown/syntax).
{% endhint %}

Using Markdown for labels provides basic text formatting. It natively supports the use of HTML, enabling web components for complex label templating scenarios.

UFM is built on top of [GitHub Flavored Markdown](https://github.github.com/gfm/) and [CommonMark](https://spec.commonmark.org/) specifications. The implementation for Umbraco 14 has been developed as an extension to the [Marked library](https://marked.js.org/).

## Syntax

The essence of the UFM syntax is curly brackets with a marker prefix.

```markdown
{<marker prefix> <contents> }
```

For clarity...

- The opening is `{` U+007B Left Curly Bracket
- The closing is `}` U+007D Right Curly Bracket
- The marker prefix can be any valid Unicode character(s), including emojis
- The contents within the curly brackets can include any Unicode characters, including whitespace

An example of this syntax to render a value of a property by its alias is: `{= bodyText }`.

The curly brackets indicate that the UFM syntax should be processed. The `=` marker prefix indicates which UFM component should be rendered, and the `bodyText` contents are the parameter that is passed to that UFM component.

With this example, the syntax `{= bodyText }` would be processed and rendered as the following markup:

```js
<ufm-label-value alias="bodyText"></ufm-label-value>
```

The internal working of the `ufm-label-value` component would then be able to access the property's value using the [Context API](../extending/backoffice-setup/working-with-data/context-api).

## Available UFM components

As for Umbraco 14.1.0, the following UFM components are available to use.

| Name        | Marker | Example syntax    | Renders component                    |
| ----------- | ------ | ----------------- | ------------------------------------ |
| Label Value | `=`    | `{=bodyText}`     | `<ufm-label-value alias="bodyText">` |
| Localize    | `#`    | `{#general_name}` | `<umb-localize key="general_name">`  |

More UFM components will be available in upcoming Umbraco releases.

### Custom UFM components

If you wish to develop your own custom UFM component, you can use the `ufmComponent` extension type:

```json
{
  type: 'ufmComponent',
  alias: 'My.CustomUfmComponent',
  name: 'My Custom UFM Component',
  api: () => import('./components/my-custom.component.js'),
  meta: {
    marker: '%',
  },
}
```

The corresponding JavaScript/TypeScript API would contain a method to render the custom label/markup.

```js
import { UmbUfmComponentBase } from '@umbraco-cms/backoffice/ufm';
import type { UfmToken } from '@umbraco-cms/backoffice/ufm';

export class MyCustomUfmComponent extends UmbUfmComponentBase {
  render(token: UfmToken) {
    // You could do further regular expression/text processing,
    // then output your custom HTML markup.
    return `<ufm-custom-component text="${token.text}"></ufm-custom-component>`;
  }
}

export { MyCustomUfmComponent as api };
```

Using the syntax `{% myCustomText }` would render the markup `<ufm-custom-component text="myCustomText"></ufm-custom-component>`. Then inside the `ufm-custom-component` component code, you can perform any logic to render your required markup.

## Post-processing and sanitization

When the markdown has been converted to HTML, the markup will be run through post-processing sanitization to ensure security and consistency within the backoffice.

As of Umbraco 14, the [DOMPurify library](https://github.com/cure53/DOMPurify) is used to sanitize the markup and prevent Cross-site scripting (XSS) attacks.

The sanitized markup will be...

- Valid HTML
- Anchor links will have their target set to `_blank`
- Only web components that have a prefix of `ufm-`, `umb-` or `uui-` will be allowed to render

## Using UFM in your own components

If you would like to render UFM within your own web components in the Umbraco CMS backoffice, you can use the `umb-ufm-render` component:

```js
<umb-ufm-render inline .markdown=${ myMarkdown } .value=${ myValue }></umb-ufm-render>
```
