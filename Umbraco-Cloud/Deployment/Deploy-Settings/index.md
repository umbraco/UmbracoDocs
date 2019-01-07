# Configurations for Deployments

The UmbracoDeploy.Settings.config file is by default empty, but there are some optional settins you can set in the file to ignore certain types of file, increase timeout limits, etc.

## ExcludedEntityTypes

This setting allows you to exclude a certain type of entity from being deployed. This is **not** recommended to set, but sometimes there may be issues with the way a custom media fileprovider works with your site and you will need to set it for media files, here is an example:

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
  <excludedEntityTypes>
    <add type="media-file" />
  </excludedEntityTypes>
</settings>
```

## RelationTypes

This setting allows you to manage how relations are deployed between environments. For this you need to specify an alias and a mode for each relationtype. The mode can be either:

- `Exclude` - This causes the relation to be excluded and not transfered on deployments.
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

This setting is used by package creators who want to have their custom editors work with Deploy. The packages should be creating this setting automatically. There is a community driven package that has value connectors for Deploy called [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib)

Here is how it can look:
```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
    <valueConnectors>
        <valueConnector alias="nuPickers.DotNetCheckBoxPicker" type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
        <valueConnector alias="nuPickers.DotNetDropDownPicker" type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
        <valueConnector alias="nuPickers.DotNetPrefetchListPicker" type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
        <valueConnector alias="nuPickers.DotNetTypeaheadListPicker" type="Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors" />
    </valueConnectors>
</settings>
```

## SessionTimeout, HttpClientTimeout, DatabaseCommandTimeout & SourceDeployTimeout

These timeout settings default to 8 minutes, but if you are transfering a lot of data you may need to increase it. All of these times are in *seconds*:

```xml
<?xml version="1.0" encoding="utf-8"?>
<settings xmlns="urn:umbracodeploy-settings">
   <deploy sessionTimeout="1200" sourceDeployTimeout="1200" httpClientTimeout="1200" databaseCommandTimeout="1200" />
</settings>
```