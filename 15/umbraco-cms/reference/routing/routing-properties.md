---
description: Describes special property type aliases which can be used to customise routing
---

# Special Property Type aliases for routing

_There are a few special/reserved Umbraco Property Type aliases that can be used which can manipulate how the standard Umbraco routing pipeline works. You can add these Property Types to any Document Type and if values are assigned to these properties, Umbraco will adjust its routing accordingly. See below for full details._

## umbracoRedirect

Creating a property alias with this name and using a Content Picker property editor lets you create a 302 temporary redirect. This in effect means that when a user navigates to this node, they will be redirected away from it.

## umbracoInternalRedirectId

Add this property alias to your Document Type with a Content Picker property editor and Umbraco will load the selected page’s content transparently without performing any URL redirection. This essentially performs a rewrite.

## umbracoUrlName

This property when created as a text string lets you provide a different URL name to what is created by default by the name of the node. If you enter a value for this property and save/publish the content node you will see that its main URL is updated with a new path suffix.

## umbracoUrlAlias

This property when created as a text string lets you provide a comma separated list of alternate full URL paths for the node. For example, if your URL was /some-category/some-page/content-node, by adding an umbracoUrlAlias of "flowers", a user can navigate to the node by going to /flowers. The URL alias remains in the browser address bar as a 'mask' over the real URL. You can also specify paths like "flowers/roses/red".

## Filtering

[See Filtering Property Conventions](../querying/ipublishedcontent/collections.md#filtering-conventions)
