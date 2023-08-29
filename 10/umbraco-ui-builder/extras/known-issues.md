---
description: Known issues in Konstrukt, the backoffice UI builder for Umbraco.
---

# Known Issues

Konstrukt tries its best to mimic the content pipeline as closely as possible whilst sticking to public and supported APIs. This is in order to be able to use the full Data Type suite for editing properties. Unfortunately there are some features in the Umbraco Core that are locked away in internal methods and so does mean some features may not be fully supported. Bellow are a list of known issues to date.

## Property Editors

### Tags  

Whilst we have support for persisting the tags value, we don't currently have the ability to write these tags to the `cmsTags` DB table. Unfortunately this is all handled via a `tagsRepository` which is internal and so we currently can't save to it like core does.

### Multi Node Tree Picker

When using a Multi Node Tree Picker with an XPath filter, only filters starting with the `$root` placeholder will be valid as all other placeholders expect the property editor to be placed on a content node, with that node being used as context.

### RTE Macros

Macros in Rich Text Editors don't appear to work properly due to the preview mechanism. They will save and may run on the front end, but you'll get an error notification in the backoffice as it tries to render a preview.
