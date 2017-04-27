#Umbraco 7.6 Breaking Changes

## Dependencies

### UrlRewriting.Net ([U4-9004](http://issues.umbraco.org/issue/U4-9004))

UrlRewriting was old, leaking memory, and slowing down website startup when dealing with more than a few rules. It's entirely replaced by the [IIS Url Rewrite](<https://www.iis.net/downloads/microsoft/url-rewrite>) extension.

### Json.Net ([U4-9499](http://issues.umbraco.org/issue/U4-9499))

Json.Net has been updated to version 10.0.0 to benefit from improvements in features, fixes and performances (see [release notes](https://github.com/JamesNK/Newtonsoft.Json/releases)). This *may* be a breaking change for people relying on one of the changed functionnality.

### Log4net ([U4-1324](http://issues.umbraco.org/issue/U4-1324))

For legacy reasons, up to version 7.5 Umbraco has used a custom build of an old (1.2.11) version of log4net that supported Medium Trust. However, Umbraco itself does not support Medium Trust anymore, and therefore log4net has been upgraded to the standard, latest build of log4net 2.0.8.

### ImageProcessor ([U4-8963](http://issues.umbraco.org/issue/U4-8963))

An optional parameter has been added to the `GetCropUrl` method in order to support the background color parameter. This breaks the method signature and therefore might require a recompile of user's code.

### HtmlAgilityPack ([U4-9655](http://issues.umbraco.org/issue/U4-9655))

The HtmlAgilityPack has been upgraded to version 1.4.9.5. The Umbraco upgrade process should take care of setting up the binding redirects appropriately.

## Core

### Membership Provider Encoding ([U4-6566](http://issues.umbraco.org/issue/U4-6566))

The membership provider `useLegacyEncoding` setting is now `false` by default, as the legacy password encoding has weaknesses.

This change only impacts new installs (no change for upgrades).

### Property Value Converters ([U4-7318](http://issues.umbraco.org/issue/U4-7318))

A large amount of property value converters contributed by the community have been merged in and are now the default value converters. These converters change the object types returned by `GetPropertyValue` for more convenient types.

For example, the `SliderValueConverter` returns a `decimal` or a `Range<decimal>` value that can directly be used in views, instead of the CSV string value that was previously returned.

This change only impacts new installs (no change for upgrades).

The new property value converters are controlled by an `umbracoSetting.config` setting: in section `settings/content`, setting `EnablePropertyValueConverters` needs to be present and `true` to activate them.

### Database ([U4-9201](http://issues.umbraco.org/issue/U4-9201))

Although Umbraco has been using a PetaPoco-managed `UmbracoDatabase` instance since version 7 came out, we realized that some of our legacy code still bypassed that mechanism and used parallel, out-of-band database connections, causing issues with transactions.

The legacy code has been refactored to rely on the `UmbracoDatabase` instance. However, because that database is disposed during `EndRequest`, code that run after it has been disposed may not work anymore, and should be updated to used either an `HttpModule` event that occurs before `EndRequest`, or the new `UmbracoModule.EndRequest` event.

More details are available on [issue 146](https://github.com/kipusoep/UrlTracker/issues/146) on the 301 Redirect Tracker GitHub issue tracker.

### Scopes ([U4-9406](http://issues.umbraco.org/issue/U4-9406))

Version 7.6 introduces the notion of *scopes*, which allow for wrapping multiple service-level operations in one single transaction. Although for various reasons the scopes API is partially public, scopes are not meant for public use at this stage and we need a few more releases to ensure that the APIs are stable.

Scopes *should not* change how Umbraco is functioning.

Introducing scopes means that some public APIs signatures are changing. Most of these changes target internal and/or non-breaking APIs (as per our [guidelines](https://our.umbraco.org/Documentation/Development-Guidelines/breaking-changes)) and therefore should have no impact on sites&mdash;but may break unit tests.

### Property Editors storing UDI instead of ID ([U4-9310](http://issues.umbraco.org/issue/U4-9310))

The property editors for pickers for content, media, members and related links have been updated to store UDI instead of node ID. Pickers in sites being upgraded have been marked as obsolete, but will continue to work as they always did.

New sites will have the obsolete pickers filtered out from the list of available property editors, but they can be enabled by a configuration flag.

### RTE Images attributes ([U4-6228](http://issues.umbraco.org/issue/U4-6228), [U4-6595](http://issues.umbraco.org/issue/U4-6595))

For a long time we had a "rel" attribute on an "img" tag when inserting into the RTE. This is invalid HTML markup. We worked around this by stripping this attribute using a Property Editor Value converter. Some developers relied on this attribute unfortunately so we didn't just change it to a "data-id" attribute which would have been valid. In 7.6 we are not storing INT ids in these attributes and instead storing UDI values so with this change we no longer use "rel" or "data-id" and instead there will be a "data-udi" attribute. This change should affect only a very small amount of people that were previously relying on the values from the "rel" attribute.

### Others

We are shipping with SignalR in the core at version 2.2.1, if you already have SignalR installed into your app and are using an older version there may be conflicts.