---
meta.Title: Block List Filters
---

# Block List Filters

When working with the Block List editor, [the editor experience is enhanced](https://docs.umbraco.com/umbraco-cms/fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/block-editor/block-list-editor#editor-appearance) by defining a label for the appearance of the Block.

These labels can contain AngularJS filters.

From Forms 10.2, a filter `umbFormsFormName` is available for use.

If you add a reference to a property containing a form to the block's label, it will render with the form's Id.

For example, assuming a property containing a picked form with an alias of `contactForm`:

```
{{contactForm}}
```

By using the filter as follows, the form's name will be displayed instead.

```
{{contactForm | umbFormsFormName}}
```
