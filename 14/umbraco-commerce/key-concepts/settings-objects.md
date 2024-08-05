---
description: Strongly typed Settings objects in Umbraco Commerce.
---

# Settings Objects

There are places in Umbraco Commerce where you can use Settings Objects to pass configuration to a Provider, such as Discount Rule Providers, Reward Providers, and Payment Providers.

The settings objects have a number of responsibilities.

* **Typed Settings Model** - The type represents a strongly typed settings model the given Provider accepts. Any stored settings in the database will be deserialized to this type before being passed to the Provider for processing. This provides strongly typed access to the relevant configuration settings.
* **UI Scaffold** - The settings object defines metadata on its properties via an Attribute implementing `UmbracoCommerceSettingAttribute`, each Provider type has its own attribute type in case they require additional config, for example `DiscountRewardProviderSettingAttribute`, `DiscountRuleProviderSettingAttribute` or `PaymentProviderSettingAttribute`. The attributes are used to dynamically build the AngularJS-based UI for the given Provider configuration. See the [UI Scaffolding](settings-objects.md#ui-scaffolding) section below for more information on UI Scaffolding.
* **JavaScript Settings Model** - The settings object also defines the JavaScript settings model passed to the Provider editor UI, using either the settings Property name as the object property key, or using the `Key` property of the Setting Attribute declared on the given Property.

## UI Scaffolding

An important element of the Settings object is UI Scaffolding. UI Scaffolding is where Umbraco Commerce reads a series of Settings Attributes defined on your Settings object properties in order to dynamically build a User Interface for that Providers settings.

An example of a Discount Reward Settings Object might look something like this:

```csharp
public class MyDiscountRewardProviderSettings
{
    [DiscountRewardProviderSetting(
        EditorUiAlias = "Umb.PropertyEditorUi.DatePicker",
        EditorConfig = "[{ \"alias\":\"offsetTime\", \"value\":true }]")]
    public DateTime Date { get; set; }

    ...
}
```

Attributes define an optional `Key` parameter to override the default setting alias which would otherwise be the property name in camel case. An optional `EditorUiAlias` and `EdiutorConfig` options can also be defined to control the Umbraco property editor used to edit the given property. If no view is defined, one will attempt to be automatically chosen based on the property's value type.

Labels and descriptions for settings are controlled through [Localization](#localization) entries.

An example of a generated UI built from these properties would look something like this:

![Discount Rule UI](../media/discount\_rule\_ui.png)

### Default Values

To define default values for a settings object, you can assign a value to a property in your model and Umbraco Commerce will automatically fall back to that value if no explicit value is defined.

```csharp
public class MyDiscountRewardProviderSettings
{
    [DiscountRewardProviderSetting]
    public string Title { get; set; } = "Untitled";

    ...
}
```

### Localization

When displaying your settings in the backoffice UI, it is necessary to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

The format of the localization keys depends on the context. Refer to the specific feature's article for required localization keys.