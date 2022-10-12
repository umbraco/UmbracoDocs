---
versionFrom: 10.0.0
meta.Title: "Block List Filters"
---

# Block List Filters

When working with the Block List list editor, [the editor experience is enhanced](../../../Fundamentals/Backoffice/Property-Editors/Built-in-Property-Editors/Block-List-Editor/index.md#editor-appearance) by defining a label for the appearance of the Block.

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

---

Prev: [Content Apps](../AjaxForms//index.md)
