# Extending the plugin

## Add a custom property value extractor
When a simple node-name-to-property-alias mapping does not suit your need, you can create your own property value extractor to... *extract* the value from the property yourself.

Most of the time, you just need to create a new implementation of `ISingleValuePropertyExtractor` ~~or rarely `IMultipleValuePropertyExtractor`~~.

This plugin uses [Collection Builder pattern](https://docs.umbraco.com/umbraco-cms/implementation/composing#example-modifying-collections) which is commonly used in Umbraco. You can use these two extension methods during application initialization to add your value extractors.

```c#
// IUmbracoBuilder builder;
builder.SingleValuePropertyExtractors()
    .Append<DefaultSingleValuePropertyExtractor>()
    .Append<DefaultGoogleAvailabilityValueExtractor>()
    .Append<DefaultMediaPickerPropertyValueExtractor>();

builder.MultipleValuePropertyExtractors()
    .Append<DefaultMultipleMediaPickerPropertyValueExtractor>();
```

Afterwards, your extractor name should show up in the dropdown under `Property And Node Mapping` section.
![property value extractor dropdown](./media/property-value-extractor-dropdown.png)