---
versionFrom: 7.0.0
versionRemoved: 8.99.99
---

# Migrating data types

When migrating content from Umbraco 7 to Umbraco 8, the data type 'pre-value' structure has changed.
In Umbraco 8, the term 'pre-values' no longer exist and instead it is referred to as `property editor configuration`.

In Umbraco 8 property editor configuration is a strongly typed object. There are plenty of examples in the [Umbraco-CMS codebase](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Web/PropertyEditors/ContentPickerConfiguration.cs).

This configuration is stored differently in Umbraco 8 than it was in Umbraco 7. In Umbraco 7, each pre-value property was stored as a different row in a different database table. This was hugely inefficient and so in Umbraco 8 this is simplified and property editor configuration is stored as the JSON serialized version of the strongly typed configuration object.

When upgrading from Umbraco 7 to Umbraco 8, Umbraco has no way of knowing how any custom property editors have intended to structure their configuration data. During the upgrade, Umbraco will convert the key/value pairs from the old pre-value database table into a serialized JSON version of those values. There's a reasonable chance that the end result of this data conversion is not compatible with the custom property editor.

There are 3 options that a developer can choose to do to work around this automatic data conversion:

## #1 Implement a custom `IPreValueMigrator`

This option will require you to create a custom C# migrator for each of your custom property editors that store custom configuration data and will require that you implement these migrators before you run the Umbraco 8 content migration.

To do this you will create an implementation of `IPreValueMigrator` or you can also inherit from the base class [`DefaultPreValueMigrator`](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Core/Migrations/Upgrade/V_8_0_0/DataTypes/DefaultPreValueMigrator.cs).

There are plenty of examples of this in the [Umbraco-CMS codebase](https://github.com/umbraco/Umbraco-CMS/tree/v8/dev/src/Umbraco.Core/Migrations/Upgrade/V_8_0_0/DataTypes).

Then you need to register them in a composer:

```cs
[RuntimeLevel(MinLevel = RuntimeLevel.Upgrade, MaxLevel = RuntimeLevel.Upgrade)] // only on upgrades
public class PreValueMigratorComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.WithCollectionBuilder<PreValueMigratorCollectionBuilder>()
            // Append all of the migrators required
            .Append<MyCustomPreValueMigrator>()
            .Append<AnotherPreValueMigrator>();
    }
}
```
When running the migrations and encountering a custom configuration, Umbraco will now utilize the registered PreValueMigrator when attempting to convert the old pre-values into the new JSON format.

## #2 Update your Angular configuration (pre-value) and property editor

This option means that you will choose to use the automatically converted JSON data format. In this case, it will mean updating your pre-value and property editors to use the new JSON configuration data. The converted data won't be much different than the original/intended data format so this might not be too much work.

## #3 Update the Angular configuration (pre-value) editor

This option means that the configuration/pre-value editor for your property editor will need to be updated to be able to transform the JSON converted data back into the data structure that you want to use. If this is done, then when the data type is saved again, the intended JSON data structure will be saved back to the database and your property editor should continue working.

This would require you to update all custom pre-value editors to transform the converted structures back to your intended data structure and re-save these data types.
