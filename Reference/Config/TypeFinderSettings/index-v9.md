---
versionFrom: 9.0.0
meta.Title: "Umbraco Type Finder Settings"
meta.Description: "Information on the type finder settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Type finder settings

The type finder settings allow you to specify assemblies that accep load exceptions when they are type scanned, for multiple assemblies seperate them with a comma (`,`). To accept load exceptions for all assemblies use an asterisk (`*`), like so:

```json
"Umbraco": {
  "CMS": {
    "TypeFinder": {
      "AssembliesAcceptingLoadExceptions": "*"
    }
  }
}
```