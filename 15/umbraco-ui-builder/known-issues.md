---
description: Known issues in Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Known Issues

Umbraco UI Builder tries its best to mimic the content pipeline as closely as possible whilst sticking to public and supported APIs. This is so that the Data Type suite can be used fully for editing properties. There are some features in the Umbraco Core that are locked away in internal methods. This means that some features may not be fully supported. Below is a list of known issues to date.

## Property Editors

### Tags

Whilst we have support for persisting the tag's value, we don't currently have the ability to write these tags to the `cmsTags` DB table. This is all handled via a `tagsRepository` which is internal so we currently can't save to it as core does.
