---
versionFrom: 8.0.0
---

# Configurations for Deployments

The UmbracoDeploy.Settings.config file is empty by default, but there are some optional settings you can set in the file to ignore certain types of file, increase timeout limits, etc.

## ExcludedEntityTypes

This setting allows you to exclude a certain type of entity from being deployed. This is **not** recommended to set, but sometimes there may be issues with the way a custom media fileprovider works with your site and you will need to set it for media files. Here is an example:

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
  <excludedEntityTypes>
    <add type="media-file" />
  </excludedEntityTypes>
</settings>
```

## RelationTypes

This setting allows you to manage how relations are deployed between environments. You will need to specify an alias and a mode for each relationtype. The mode can be either:

- `Exclude` - This causes the relation to be excluded and not transferred on deployments.
- `Weak` - This causes the relation to be deployed if both content items are found on the target environment.
- `Strong` - This requires the content item that is related is set as a dependency, so if anything is added as a relation it would also add it as a dependency.

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <relationTypes>
        <relationType alias="relateParentDocumentOnDelete" mode="Weak" />
        <relationType alias="relateShopItemOnCreate" mode="Exclude" />
    </relationTypes>
</settings>
```

## ValueConnectors

This setting is used by package creators who wants their custom editors to work with Deploy. The packages should be creating this setting automatically. There is a community driven package that has value connectors for Deploy called [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib).

Here is an example of how the setting can look:

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <valueConnectors>
        <valueConnector alias="nuPickers.DotNetCheckBoxPicker" 
                        type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
        <valueConnector alias="nuPickers.DotNetDropDownPicker" 
                        type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
        <valueConnector alias="nuPickers.DotNetPrefetchListPicker" 
                        type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
        <valueConnector alias="nuPickers.DotNetTypeaheadListPicker" 
                        type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
    </valueConnectors>
</settings>
```

## Timeout settings

Umbraco Deploy have a few built-in timeouts, which on larger sites might need to be modified. You will usually see these timeouts in the backoffice with an exception mentioning a timeout. It will be as part of a full restore or a full deploy of an entire site. In the normal workflow you should never hit these timeouts.

The defaults will cover most though. Changing the defaults by updating the `/Config/UmbracoDeploy.settings.config`. There are four settings available, which all uses the default timeout which currently is set for 8 minutes.

- `sessionTimeout`
- `sourceDeployTimeout`
- `httpClientTimeout`
- `databaseCommandTimeout`

These timeout settings default to 20 minutes, but if you are transferring a lot of data you may need to increase it. All of these times are in *seconds*:

:::note
It's important that these settings are added to both the source and target environments in order to work.
:::

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <deploy sessionTimeout="1800" sourceDeployTimeout="1800" httpClientTimeout="1800" databaseCommandTimeout="1800" />
</settings>
```

## Transfer Forms data as content

In order for Deploy to handle Forms data as content, you'll need to add the following setting to `UmbracoDeploy.Settings.config`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <forms transferFormsAsContent="true" />
</settings>
```

## ExportMemberGroups

This setting is to be defined and set to false only if you are using an external membership provider for your members. You will not want to export Member Groups that would no longer be managed by Umbraco but by an external membership provider.

Setting the `exportMemberGroups` to false will no longer export Member Groups to UDA entities on disk. By default if this setting is not present, its value will automatically be set to true as most sites use Umbraco's built-in membership provider and thus will want the membership groups exported.

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <deploy exportMemberGroups="false" />
</settings>
```
