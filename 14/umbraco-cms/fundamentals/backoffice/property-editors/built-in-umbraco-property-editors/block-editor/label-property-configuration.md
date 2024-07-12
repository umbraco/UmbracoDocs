# Configuring Block Editor Label Properties

{% hint style="warning" %}
Previous versions of Umbraco used AngularJS expressions and filters for advanced label rendering.

With the removal of AngularJS in Umbraco 14, this has been replaced using native web components. Advanced label rendering is done using [Umbraco Flavored Markdown](../../../../../reference/umbraco-flavored-markdown.md).
{% endhint %}

When configuring a block, the label property allows you to define a label for the appearance of the Block in the editor. The label can use Umbraco Flavored Markdown (UFM) syntax to display values of properties. Example: `My Block {= myPropertyAlias }` will be shown as: `My Block FooBar`.

## Special variables

Currently, in Umbraco 14.1, there is only support to render a block's content properties. For previous special variables, such as `$index`, `$contentTypeName`, `$settings`, etc. These will be expanded on in upcoming releases.

In the meantime, it is possible to create your own custom UFM components. (Please see the [Umbraco Flavored Markdown](../../../../../reference/umbraco-flavored-markdown.md) documentation on how to do this). From there, you would be able to consume the `UMB_BLOCK_ENTRY_CONTEXT` and be able to access the entire data of a block item.
