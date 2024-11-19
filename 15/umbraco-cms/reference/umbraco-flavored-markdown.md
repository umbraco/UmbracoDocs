# Umbraco Flavored Markdown

Umbraco Flavored Markdown (UFM) is the dialect of Markdown, used to support property descriptions and advanced labels within the Umbraco CMS backoffice. These can be used with Block editors (Block Grid, Block List) and Collection View columns (in Grid and Table views).

{% hint style="info" %}
If you are not familiar with Markdown, you can read more about its philosophy and syntax on the [Daring Fireball website](https://daringfireball.net/projects/markdown/syntax).
{% endhint %}

Using Markdown for labels provides basic text formatting. It natively supports the use of HTML, enabling web components for complex label templating scenarios.

UFM is built on top of [GitHub Flavored Markdown](https://github.github.com/gfm/) and [CommonMark](https://spec.commonmark.org/) specifications. The implementation for Umbraco 14 has been developed as an extension to the [Marked library](https://marked.js.org/).

## Syntax

The essence of the UFM syntax is curly brackets with an alias prefix delimited with a colon.

```markdown
{<alias prefix>: <contents>}
```

For clarity...

- The opening token is `{` U+007B Left Curly Bracket
- The alias prefix can be any valid Unicode character(s), including emojis
- Followed by `:` U+003A Colon, (not part of the alias prefix itself)
- The contents within the curly brackets can include any Unicode characters, including whitespace
- The closing token is `}` U+007D Right Curly Bracket

An example of this syntax to render a value of a property by its alias is: `{umbValue: bodyText}`.

The curly brackets indicate that the UFM syntax should be processed. The `umbValue` alias prefix indicates which UFM component should be rendered, and the `bodyText` contents are the parameter that is passed to that UFM component.

With this example, the syntax `{umbValue: bodyText}` would be processed and rendered as the following markup:

```js
<ufm-label-value alias="bodyText"></ufm-label-value>
```

The internal working of the `ufm-label-value` component would then be able to access the property's value using the [Context API](../extending/backoffice-setup/working-with-data/context-api).


### Filters

In addition, a filter syntax can be applied to UFM contents. This can be useful for formatting or transforming a value without needing to develop your own custom UFM component.

The syntax for UFM filters uses a pipe character `|` (U+007C Vertical Line). Multiple filters may be applied, and the value from the previous filter is passed onto the next.

To display a rich text value, stripping out the HTML markup and limiting it to the first 15 words could use the following filters:

```markdown
{umbValue: bodyText | strip-html | word-limit:15}
```

A list of available UFM filters is detailed below.


## UFM components

### Available UFM components

The following UFM components are available to use.

- Label Value
- Localize
- Content Name

More UFM components will be available in upcoming Umbraco releases.


#### Label Value

The Label Value component will render the current value of a given property alias.

The alias prefix is `umbValue`. An example of the syntax is `{umbValue: bodyText}`, which would render the component as `<ufm-label-value alias="bodyText"></ufm-label-value>`.

For brevity and backwards-compatibility, the `=` marker prefix can be used, e.g. `{=bodyText}`.


#### Localize

The Localize component will render a localization for a given term key.

The alias prefix is `umbLocalize`. An example of the syntax is `{umbLocalize: general_name}`, which would render the component as `<ufm-localize alias="general_name"></ufm-localize>`.

Similarly, for brevity and backwards-compatibility, the `#` marker prefix can be used, e.g. `{#general_name}`.


#### Content Name

The Content Name component will render the name of a content item, (either Document, Media or Member), from the value of a given property alias. Multiple values will render the names as a comma-separated list.

The alias prefix is `umbContentName`  An example of the syntax is `{umbContentName: pickerAlias}`, which would render the component as `<ufm-content-name alias="pickerAlias"></ufm-content-name>`.

As of Umbraco 15.0.0, the Content Name component supports the content-based pickers, e.g. Document Picker, Content Picker (formerly known as Multinode Treepicker) and Member Picker. Support for the advanced Media Picker will be available in upcoming Umbraco release.


### Available UFM filters

The following UFM filters are available to use.

| Name       | Alias        | Example syntax                         |
| ---------- | ------------ | -------------------------------------- |
| Lowercase  | `lowercase`  | `{umbValue: headline | lowercase}`     |
| Strip HTML | `strip-html` | `{umbValue: bodyText | strip-html}`    |
| Title Case | `title-case` | `{umbValue: headline | title-case}`    |
| Truncate   | `truncate`   | `{umbValue: intro | truncate:30:...}`  |
| Uppercase  | `uppercase`  | `{umbValue: headline | uppercase}`     |
| Word Limit | `word-limit` | `{umbValue: intro | word-limit:15}`    |



### Custom UFM components

If you wish to develop your own custom UFM component, you can use the `ufmComponent` extension type:

```json
{
  type: 'ufmComponent',
  alias: 'My.CustomUfmComponent',
  name: 'My Custom UFM Component',
  api: () => import('./components/my-custom.component.js'),
  meta: {
    alias: 'myCustom'
  }
}
```

The corresponding JavaScript/TypeScript API would contain a method to render the custom label/markup.

```js
import { UmbUfmComponentBase } from '@umbraco-cms/backoffice/ufm';

export class MyCustomUfmComponentApi implements UmbUfmComponentBase {
  render(token: Tokens.Generic) {
    // You could do further regular expression/text processing here!
    return `<ufm-custom-component text="${token.text}"></ufm-custom-component>`;
  }
}

export { MyCustomUfmComponentApi as api };
```

Using the `{myCustom: myCustomText}` syntax would render the following markup: `<ufm-custom-component text="myCustomText"></ufm-custom-component>`. Inside the `ufm-custom-component` component code, you can perform any logic to render your required markup.


### Custom UFM filters

If you wish to develop custom UFM filter, you can use the `ufmFilter` extension type:

```json
{
  type: 'ufmFilter',
  alias: 'My.UfmFilter.Reverse',
  name: 'Reverse UFM Filter',
  api: () => import('./reverse.filter.js'),
  meta: {
    alias: 'reverse'
  }
}
```

The corresponding JavaScript/TypeScript API would contain a function to transform the value.

```js
import { UmbUfmFilterBase } from '@umbraco-cms/backoffice/ufm';

class UmbUfmReverseFilterApi extends UmbUfmFilterBase {
	filter(str?: string) {
		return str?.split("").reverse().join("");
	}
}

export { UmbUfmReverseFilterApi as api };
```

Using the `{umbValue: headline | reverse}` syntax where `headline` having a value of `Hello world` would be transformed to `dlrow olleH`.


## Post-processing and sanitization

When the markdown has been converted to HTML, the markup will be run through post-processing sanitization to ensure security and consistency within the backoffice.

As of Umbraco 14, the [DOMPurify library](https://github.com/cure53/DOMPurify) is used to sanitize the markup and prevent Cross-site scripting (XSS) attacks.

The sanitized markup will be...

- Valid HTML
- Anchor links will have their target set to `_blank`
- Only web components that have a prefix of `ufm-`, `umb-` or `uui-` will be allowed to render


## Rendering UFM in custom components

If you would like to render UFM within your own web components in the Umbraco CMS backoffice, you can use the `umb-ufm-render` component:

```js
<umb-ufm-render inline .markdown=${ myMarkdown } .value=${ myValue }></umb-ufm-render>
```
