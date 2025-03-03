---
description: A list of known limitations and issues in Umbraco UI Builder
---

# Known Issues

Umbraco UI Builder strives to closely mimic the content pipeline while adhering to public and supported APIs. This ensures full compatibility with the Data Type suite for property editing. However, some features in the Umbraco Core rely on internal methods, making full support for certain functionalities challenging. Below is a list of known issues.

## Property Editors

### Tags

While Umbraco UI Builder supports persisting tag values, it currently does not write these tags to the `cmsTags` database table. This functionality is managed by the internal `tagsRepository`, which is not publicly accessible, preventing direct saving in the same manner as Umbraco Core.
