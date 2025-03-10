---
description: Known issues in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Known Issues

Umbraco UI Builder tries its best to mimic the content pipeline as closely as possible whilst sticking to public and supported APIs. This is so that the Data Type suite can be used fully for editing properties. There are some features in the Umbraco Core that are locked away in internal methods. This means that some features may not be fully supported. Below is a list of known issues to date.

## Property Editors

### Tags

Whilst we have support for persisting the tag's value, we don't currently have the ability to write these tags to the `cmsTags` DB table. This is all handled via a `tagsRepository` which is internal so we currently can't save to it as core does.

### Multi-Node Tree Picker

When using a Multi-Node Tree Picker with an XPath filter, only filters starting with the `$root` placeholder will be valid. This is because all other placeholders expect the property editor to be placed on a content node, with that node being used as context.

### RTE Macros

Macros in Rich Text Editors don't appear to work properly due to the preview mechanism. They save and run on the front end, but you'll get an error notification in the backoffice as it tries to render a preview.

### Block Editors

The Block Editors (Block List/Block Grid) are not supported due to an `undefined` error with `umbVariantContent` in the `$scope` chain.
