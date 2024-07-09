# Umbraco Flavored Markdown

Umbraco Flavored Markdown (UFM) is the dialect of Markdown, that is used to support for property descriptions and advanced labels within the Umbraco CMS backoffice. These can be used with Block editors (Block Grid, Block List) and Collection View columns (in Grid and Table views).

{% hint style="info" %}
**What is Markdown?**
If you are unfamiliar with Markdown, you can read more about its philosophy and syntax on the Daring Fireball website.
<https://daringfireball.net/projects/markdown/syntax>
{% endhint %}

By using Markdown for labels means that as well as offering basic text formatting, it natively supports the use of HTML. This means that web components can be used to handle more complex label templating scenarios.

UFM is built on top of [GitHub Flavored Markdown](https://github.github.com/gfm/) and [CommonMark](https://spec.commonmark.org/) specifications. The implementation for Umbraco 14 has been developed as an extension to the [Marked library](https://marked.js.org/).


## Syntax

The essence of the UFM syntax is curly brackets with a marker prefix.

```
{<marker prefix> <contents> }
```

For clarity...

- The opening is `{` U+007B Left Curly Bracket
- The closing is `}` U+007D Right Curly Bracket
- The marker prefix is any valid Unicode character(s)
- The remaining contents inside the curly brackets can contain any Unicode, including whitespace

An example of this syntax to render a value of a property by its alias would be: `{= bodyText }`.

The curly brackets indicate that the UFM syntax should be processed. The `=` marker prefix indicates which UFM component should be rendered, and the `bodyText` contents is the parameter that is passed to that UFM component.

With this example, the syntax `{= bodyText }` would be processed and rendered as the following markup:

```
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

If you wish to develop your own custom UFM component, you can use the `ufmComponent` extension type:

```
{
	type: 'ufmComponent',
	alias: 'My.Markdown.CustomComponent',
	name: 'My Custom Markdown Component',
	api: () => import('./components/my-custom.component.js'),
	meta: {
		marker: '%',
	},
}
```

The corresponding JavaScript/TypeScript API would contain a method to render the custom label/markup.

```
export class MyCustomComponent implements UfmComponentBase {
	render(token: Tokens.Generic) {
		return `<ufm-custom-component text="${token.text}"></ufm-custom-component>`;
	}
}
```

Using the syntax `{% myCustomText }` would render the markup `<ufm-custom-component text="myCustomText">`. Then inside the `ufm-custom-component` component code, you can perform any logic to render your required markup.


## Post-processing and sanitization

When the markdown has been converted to HTML, the markup will be ran through post-processing sanitization to ensure security and consistency within the backoffice.

As of Umbraco 14, the [DOMPurify library](https://github.com/cure53/DOMPurify) is used to sanitize the markup and prevent XSS attacks.

The sanitizes markup will be...

- Valid HTML
- Anchor links will have their target set to `_blank`
- Only web components that have a prefix of `ufm-`, `umb-` or `uui-` will be allowed to render


## Using UFM in your own components

If you would like to render UFM within your own web components (within the Umbraco CMS backoffice). You can do so using the `umb-ufm-render` component:

```
<umb-ufm-render inline .markdown=${ myMarkdown } .value=${ myValue }></umb-ufm-render>
```

