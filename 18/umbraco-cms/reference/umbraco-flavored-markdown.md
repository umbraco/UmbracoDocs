# Umbraco Flavored Markdown

{% hint style="info" %}
**Are you looking for Label Property Configuration?**\
With the removal of AngularJS, advanced label rendering is now handled using Umbraco Flavored Markdown.
{% endhint %}

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

* The opening token is `{` Left Curly Bracket
* The alias prefix can be any valid Unicode character(s), including emojis
* Followed by `:` Colon, (not part of the alias prefix itself)
* The contents within the curly brackets can include any Unicode characters, including whitespace
* The closing token is `}` Right Curly Bracket

An example of this syntax to render a value of a property by its alias is: `{umbValue: headline}`.

The curly brackets indicate that the UFM syntax should be processed. The `umbValue` alias prefix indicates which UFM component should be rendered, and the `headline` contents are the parameter that is passed to that UFM component.

With this example, the syntax `{umbValue: headline}` would be processed and rendered as the following markup:

```javascript
<ufm-label-value alias="headline"></ufm-label-value>
```

The internal working of the `ufm-label-value` component would then be able to access the property's value using the [Context API](../customizing/foundation/context-api/).

### Filters

In addition, a filter syntax can be applied to UFM contents. This can be useful for formatting or transforming a value without needing to develop your own custom UFM component.

The syntax for UFM filters uses a pipe character `|` (Vertical Line). Multiple filters may be applied, and the value from the previous filter is passed onto the next.

To display a rich-text value, stripping out the HTML markup and limiting it to the first 15 words could use the following filters:

```markdown
{umbValue: bodyText | stripHtml | wordLimit:15}
```

{% hint style="info" %}
Please note, using `umbValue` directly with a rich-text value will not display the contents. This is due to the complexity of the underlying data structure. The `stripHtml` filter has been designed to support the rich-text value.
Alternatively, you may use the UFM Expression syntax to access the raw rich-text value, like `${ bodyText.markup }`.
{% endhint %}

The following UFM filters are available to use.

| Name       | Alias       | Example syntax                         |
| ---------- | ----------- | -------------------------------------- |
| Bytes      | `bytes`     | `{umbValue: umbracoBytes \| bytes}`    |
| Fallback   | `fallback`  | `{umbValue: headline \| fallback:N/A}` |
| Lowercase  | `lowercase` | `{umbValue: headline \| lowercase}`    |
| Strip HTML | `stripHtml` | `{umbValue: bodyText \| stripHtml}`    |
| Title Case | `titleCase` | `{umbValue: headline \| titleCase}`    |
| Truncate   | `truncate`  | `{umbValue: intro \| truncate:30:...}` |
| Uppercase  | `uppercase` | `{umbValue: headline \| uppercase}`    |
| Word Limit | `wordLimit` | `{umbValue: intro \| wordLimit:15}`    |

{% hint style="info" %}
Starting from version 16.4, both the kebab-case (for example, `strip-html`, `title-case`,and `word-limit`) and the camelCase syntax (for example, `stripHtml`, `titleCase`, and `wordLimit`) are supported.

The kebab-case syntax is scheduled for removal in version 18, so it’s recommended to begin using the camelCase syntax going forward.
{% endhint %}

## UFM Expressions (JavaScript-like syntax)

UFM can also support JavaScript-like expressions to allow for basic logic within label templates and descriptions. This is especially useful for advanced label rendering, fallback values, and dynamic formatting without developing your own custom UFM components or filters.

### Syntax

Expressions are defined using the `${ ... }` syntax. This is different to the syntax outlined above. You can use standard JavaScript operators, function calls, and property access.

**Examples:**

```markdown
${ propertyAlias }                              // Renders a literal value
${ propertyAlias.length }                       // Property drilling
${ propertyAlias.length > 0 ? "Yes" : "No" }    // Conditionals
${ propertyAlias | uppercase }                  // Piped filters, as detailed above
${ propertyAlias.toUpperCase() }                // Native JavaScript functions
${ 1 + 2 }                                      // Expression evaluation/calculation; renders "3"
```

Expressions can reference property aliases, perform calculations, concatenate strings, and more.

### Supported operations

- Arithmetic (`+`, `-`, `*`, `/`)
- Logical (`&&`, `||`, `!`)
- Conditional (`? :`)
- Function calls (limited to safe native/built-in functions like `toUpperCase()`, `toLowerCase()`, etc.)
- Property access (`myProperty.length`)

### Sandboxed evaluation

All expressions are evaluated in a sandbox. Only safe operations and methods are allowed. Access to global objects, external APIs, or unsafe functions will be blocked. To extend expressions with your own functions, it is recommended to use the piped UFM Filter syntax.

## UFM components

### Available UFM components

The following UFM components are available to use.

* Label Value
* Localize
* Content Name
* Link Title

More UFM components will be available in upcoming Umbraco releases.

#### Label Value

The Label Value component will render the current value of a given property alias.

The alias prefix is `umbValue`. An example of the syntax is `{umbValue: headline}`, which would render the component as `<ufm-label-value alias="headline"></ufm-label-value>`.

For brevity and backwards-compatibility, the `=` marker prefix can be used, e.g. `{=headline}`.

#### Localize

The Localize component will render a localization for a given term key.

The alias prefix is `umbLocalize`. An example of the syntax is `{umbLocalize: general_name}`, which would render the component as `<ufm-localize alias="general_name"></ufm-localize>`.

Similarly, for brevity and backwards-compatibility, the `#` marker prefix can be used, e.g. `{#general_name}`.

#### Content Name

The Content Name component will render the name of a content item, (either Document, Media or Member), from the value of a given property alias. Multiple values will render the names as a comma-separated list.

The alias prefix is `umbContentName`. An example of the syntax is `{umbContentName: pickerAlias}`, which would render the component as `<ufm-content-name alias="pickerAlias"></ufm-content-name>`.

The Content Name component supports content-based pickers, such as the Document Picker, Content Picker (formerly known as Multinode Treepicker), and Member Picker. Support for the advanced Media Picker will be available in an upcoming Umbraco release.

#### Link Title

The Link Title component will render the title of a link from the value of a given Link Picker property editor. Multiple links will render the titles as a comma-separated list.

The alias prefix is `umbLink`. An example of the syntax is `{umbLink: pickerAlias}`, which would render the component as `<ufm-link alias="pickerAlias"></ufm-link>`.

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
import { Tokens } from '@umbraco-cms/backoffice/external/marked';
import { UmbUfmComponentBase } from '@umbraco-cms/backoffice/ufm';

export class MyCustomUfmComponentApi extends UmbUfmComponentBase {
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

* Valid HTML
* Anchor links will have their target set to `_blank`
* Only web components that have a prefix of `ufm-`, `umb-` or `uui-` will be allowed to render

## Rendering UFM in custom components

If you would like to render UFM within your own web components in the Umbraco CMS backoffice, you can use the `umb-ufm-render` component:

```js
<umb-ufm-render inline .markdown=${ myMarkdown } .value=${ myValue }></umb-ufm-render>
```
