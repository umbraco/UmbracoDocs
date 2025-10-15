---
description: Strongly typed Settings objects in Umbraco Commerce.
---

# Settings Objects

There are places in Umbraco Commerce where you can use Settings Objects to pass configuration to a Provider, such as Discount Rule Providers, Reward Providers, and Payment Providers.

The settings objects have a number of responsibilities.

* **Typed Settings Model** - The type represents a strongly typed settings model the given Provider accepts. Any stored settings in the database will be deserialized to this type before being passed to the Provider for processing. This provides strongly typed access to the relevant configuration settings.
* **UI Scaffold** - The settings object defines metadata on its properties via an Attribute implementing `UmbracoCommerceSettingAttribute`, each Provider type has its own attribute type in case they require additional config, for example `DiscountRewardProviderSettingAttribute`, `DiscountRuleProviderSettingAttribute` or `PaymentProviderSettingAttribute`. The attributes are used to dynamically build the AngularJS-based UI for the given Provider configuration. See the [UI Scaffolding](settings-objects.md#ui-scaffolding) section below for more information on UI Scaffolding.
* **JavaScript Settings Model** - The settings object also defines the JavaScript settings model passed to the Provider editor UI, using either the settings Property name as the object property key, or using the `key` property of the Setting Attribute declared on the given Property.

## UI Scaffolding

An important element of the Settings object is UI Scaffolding. UI Scaffolding is where Umbraco Commerce reads a series of Settings Attributes defined on your Settings object properties in order to dynamically build a User Interface for that Providers settings.

An example of a Discount Reward Settings Object might look something like this:

```csharp
public class MyDiscountRewardProviderSettings
{
    [DiscountRewardProviderSetting(Key = "nodeId",
        Name = "Product Node",
        Description = "The product to discount the price of",
        View = "contentpicker",
        Config = "{ startNodeId: -1, multiPicker: false, idType: 'udi' }")]
    public Udi NodeId { get; set; }

    ...
}
```

Attributes define a property `key`, `name`, `description` to display in the UI as well as an optional `view` and `config` option to define the Umbraco property editor to use to edit the given property. If no view is defined, one will attempt to automatically be chosen based on the properties value type.

An example of a generated UI built from these properties would look something like this:

![Discount Rule UI](../media/discount\_rule\_ui.png)

### Default Values

To define default values for a settings object, you can assign a value to a property in your model and Umbraco Commerce will automatically fall back to that value if no explicit value is defined.

```csharp
public class MyDiscountRewardProviderSettings
{
    [DiscountRewardProviderSetting(Key = "title", Name = "Title", Description = "A friendly title for this item"]
    public string Title { get; set; } = "Untitled";

    ...
}
```
