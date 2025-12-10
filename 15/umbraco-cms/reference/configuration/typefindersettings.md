---
description: Information on the type finder settings section
---

# Type finder settings

The type finder settings allows you to specify assemblies that accept load exceptions when they are type scanned. For multiple assemblies separate them with a comma (`,`). To accept load exceptions for all assemblies use an asterisk (`*`), like so:

Furthermore it is possible to add additional assemblies to the exclusion filter. Thereby these assemblies will be ignored by Umbraco. This can be useful depending on nuget packages that are not Umbraco packages.

```json
"Umbraco": {
  "CMS": {
    "TypeFinder": {
      "AssembliesAcceptingLoadExceptions": "*",
      "AdditionalAssemblyExclusionEntries": []
    }
  }
}
```
