# Configuring Block Editor Label Properties

{% hint style="warning" %}
Previous versions of Umbraco used AngularJS expressions and filters for advanced label rendering.

With the removal of AngularJS in Umbraco 14, this has been replaced using native web components. Advanced label rendering is done using [Umbraco Flavored Markdown](../../../../../reference/umbraco-flavored-markdown.md).
{% endhint %}

When configuring a Block, the label property allows you to define a label for the appearance of the Block in the editor. The label can use Umbraco Flavored Markdown (UFM) syntax to display values of properties. Example: `My Block {=myPropertyAlias}` will be shown as: `My Block FooBar`.

## Special variables

Currently, Umbraco 14.1 only supports rendering a block's content properties. Special variables like `$index`, `$contentTypeName`, `$settings`, and so on will be expanded in upcoming releases.

In the meantime, you can create your own custom UFM components. For more information, see the [Umbraco Flavored Markdown](../../../../../reference/umbraco-flavored-markdown.md) article. From there, you will be able to consume the `UMB_BLOCK_ENTRY_CONTEXT` to access the entire data of a block item.
