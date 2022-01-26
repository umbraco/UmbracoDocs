---
versionFrom: 9.0.0
meta.Title: "Umbraco Deploy settings"
meta.Description: "Various settings for Umbraco Deploy"
state: complete
verified-against: beta-1
---

# Configuration for Umbraco Deploy

All configuration for Umbraco Forms is held in the `appSettings.json` file found at the root of your Umbraco website.  If the configuration has been customized to use another source, then the same keys and values discussed in this article can be applied there.

The convention for Umbraco configuration is to have package based options stored as a child structure below the `Umbraco` element, and as a sibling of `CMS`.  Umbraco Deploy configuration follows this pattern, i.e.:

```json
{
  ...
  "Umbraco": {
    "CMS": {
        ...
    },
    "Deploy": {
        ...
    }
  }
}
```

There are some required settings but most configuration for Umbraco Deploy is optional. In other words, values have defaults that will be applied if no configuration is available for a particular key.

For illustration purposes, the following structure represents the full set of options for configuration of Umbraco Deploy, along with the default values. This will help when you need to provide a different setting to understand where it should be applied.

```json
{
  ...
  "Umbraco": {
    "Deploy": {
        "Settings": {
            "ApiKey": "<your API key here>",
            "DefaultTimeoutSeconds": 60,
            "ExcludedEntityTypes": [],
            "RelationTypes" : [],
            "ValueConnectors": [],
            "Edition": "Default",
            "SessionTimeout": "0.0:20:00",
            "SourceDeployTimeout": "0.0:20:00",
            "DatabaseCommandTimeout": "0.0:20:00",
            "EnableSignatureCacheReads": true,
            "HttpClientTimeout": "0.0:20:00",
            "IgnoreBrokenDependencies": false,
            "IgnoreBrokenDependenciesBehavior": "IgnoreForAll",
            "AcceptInvalidCertificates": false,
            "TransferFormsAsContent": true,
            "TransferDictionaryAsContent": false,
            "ExportMemberGroups": true,
        }
    }
  }
}
```

## ApiKey

The API key is a 10 character random string applied with the same value to all environments in order to authenticate HTTP requests between them.

## ExcludedEntityTypes

This setting allows you to exclude a certain type of entity from being deployed. This is **not** recommended to set, but sometimes there may be issues with the way a custom media fileprovider works with your site and you will need to set it for media files. Here is an example:

```json
"ExcludedEntityTypes": ['media-file'],
```

## RelationTypes

This setting allows you to manage how relations are deployed between environments. You will need to specify an alias and a mode for each relationtype. The mode can be either:

- `Exclude` - This causes the relation to be excluded and not transferred on deployments.
- `Weak` - This causes the relation to be deployed if both content items are found on the target environment.
- `Strong` - This requires the content item that is related is set as a dependency, so if anything is added as a relation it would also add it as a dependency.

```json
"RelationTypes": [
    {
        "Alias": "relateParentDocumentOnDelete",
        "Mode": "Weak",
    },
    {
        "Alias": "relateShopItemOnCreate",
        "Mode": "Exclude",
    }
],
```

## ValueConnectors

This setting is used by package creators who wants their custom editors to work with Deploy. The packages should be creating this setting automatically. There is a community driven package that has value connectors for Deploy called [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib).

Here is an example of how the setting can look:

```json
"ValueConnectors": [
    {
        "Alias": "nuPickers.DotNetCheckBoxPicker",
        "TypeName": "Umbraco.Deploy.Contrib.Connectors.ValueConnectors.NuPickersValueConnector,Umbraco.Deploy.Contrib.Connectors",
    }
],
```

## Timeout settings

Umbraco Deploy have a few built-in timeouts, which on larger sites might need to be modified. You will usually see these timeouts in the backoffice with an exception mentioning a timeout. It will be as part of a full restore or a full deploy of an entire site. In the normal workflow you should never hit these timeouts.

There are four settings available:

- `SessionTimeout`
- `SourceDeployTimeout`
- `HttpClientTimeout`
- `DatabaseCommandTimeout`

These timeout settings default to 20 minutes, but if you are transferring a lot of data you may need to increase it. All of these times are configured using [standard timepsan format strings](https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-timespan-format-strings):

:::note
It's important that these settings are added to both the source and target environments in order to work.
:::

## TransferFormsAsContent

In order for Deploy to handle Forms data as content, you'll to ensure the `TransferFormsAsContent` setting is set to `true`.  To transfer Forms data as schema, i.e. via .uda files committed to source control, use a value of `false`.

## TransferDictionaryAsContent

In a similar way, Deploy can be configured to allow for backoffice transfers of dictionary items instead of using files serialized to disk, by setting `TransferDictionaryAsContent` as `true`.

## ExportMemberGroups

This setting is to be defined and set to `false` only if you are using an external membership provider for your members. You will not want to export Member Groups that would no longer be managed by Umbraco but by an external membership provider.

Setting the `exportMemberGroups` to false will no longer export Member Groups to .uda files on disk. By default if this setting is not present, its value will automatically be set to true as most sites use Umbraco's built-in membership provider and thus will want the membership groups exported.

## IgnoreBrokenDependencies

When restoring or transferring content, Umbraco Deploy will make checks to ensure that any dependent content, media or other items are either present in the target environment, or can be deployed from the source environment.

For example, if you have a media picker on a content item, that references a media item that's been deleted or is in the recycle bin, you'll get an error and the deploy won't complete until the issue is resolved (by removing the reference to the deleted media item).

You can configure deploy to ignore these issues and proceed with the transfer operation without warning, by setting the value of this option to `true`.

## IgnoreBrokenDependenciesBehavior

For finer control of the above setting you can amend this value from the default of `All` to either `Transfer` or `Restore`.

For example, using the following settings, you will have an installation that ignores broken dependencies when restoring from an upstream environment.  It will however still prevent deployment and report any dependency issues when attempting a transfer to an upstream environment.

```json
    "IgnoreBrokenDependencies": true,
    "IgnoreBrokenDependenciesBehavior": "Restore",
```



