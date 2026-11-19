# Block List Labels

When working with the Block List editor, [the editor experience is enhanced](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/block-editor/block-list-editor#editor-appearance) by defining a label for the appearance of the Block.

These labels can use [Umbraco Flavored Markdown (UFM)](https://docs.umbraco.com/umbraco-cms/reference/umbraco-flavored-markdown).

An option is available to display a form's name - `umbFormName`.

It should be rendered as follows, with a reference to the property alias on the block element that uses a form picker.

```
{umbFormName: <property-alias>}
```

If you add a reference to a property containing a form to the block's label, it will render with the form's Id.

For example, assuming a property containing a picked form with an alias of `contactForm`:

```
{=contactForm}
```

By using the markdown as follows, the form's name will be displayed instead.

```
{umbFormName: contactForm}
```
