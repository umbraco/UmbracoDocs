---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Umbraco Type Finder Settings"
meta.Description: "Information on the type finder settings section"
---

# Type finder settings

The type finder settings allow you to specify assemblies that accept load exceptions when they are type scanned, for multiple assemblies separate them with a comma (`,`). To accept load exceptions for all assemblies use an asterisk (`*`), like so:

```json
"Umbraco": {
  "CMS": {
    "TypeFinder": {
      "AssembliesAcceptingLoadExceptions": "*"
    }
  }
}
```
