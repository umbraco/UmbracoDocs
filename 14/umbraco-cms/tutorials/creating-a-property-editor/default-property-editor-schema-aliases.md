---
description: An overview of the default Property Editor Schema aliases
---

# Default Property Editor Schema aliases

In the following section, you will find a list of the default Property Editor Schema aliases in Umbraco. We recommend you use one of these as `propertyEditorSchemaAlias` when defining a custom Property Editor in `umbraco-package.json`.

The chosen Property Editor Schema determines the resulting .NET runtime type of the stored Property Editor data. As this will ultimately be used when rendering the website, it is important to choose an appropriate Property Editor Schema.

| Property Editor Schema alias | .NET runtime type               |
|------------------------------|---------------------------------|
| Umbraco.Plain.DateTime       | `System.DateTime`               |
| Umbraco.Plain.Decimal        | `System.Decimal`                |
| Umbraco.Plain.Integer        | `System.Int32`                  |
| Umbraco.Plain.Json           | `System.Text.Json.JsonDocument` |
| Umbraco.Plain.String         | `System.String`                 |
| Umbraco.Plain.Time           | `System.TimeSpan`               |

{% hint style="info" %}
You can perform custom conversion of the stored Property Editor data by implementing your own [Property Value Converter](custom-value-conversion-for-rendering.md). In this case, the chosen Property Editor Schema determines the input data for the custom conversion.
{% endhint %}
