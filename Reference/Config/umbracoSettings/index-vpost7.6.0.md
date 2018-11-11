---
versionFrom: 7.6.0
---

# New settings in 7.6

## `<loginBackgroundImage>`

You can specify your own background image for the login screen here. The image will automatically get an overlay to match backoffice colors. This path is relative to the ~/umbraco path. The default location is: /umbraco/assets/img/installer.jpg

    <loginBackgroundImage>../App_Plugins/Backgrounds/login.png</loginBackgroundImage>

## `<EnablePropertyValueConverters> `

Enables [value converters](../../../Extending/Property-Editors/value-converters.md) for all built in property editors so that they return strongly typed object, recommended for use with [Models Builder](../../templating/modelsbuilder/index.md)

On new installs this set to true. When you are upgrading from a lower version than 7.6.0 it is recommended to set this setting to false. More information can be found in the explanation of the [breaking changes in 7.6.0](../../../Getting-Started/Setup/Upgrading/760-breaking-changes#property-value-converters-u4-7318)

    <EnablePropertyValueConverters>true</EnablePropertyValueConverters>