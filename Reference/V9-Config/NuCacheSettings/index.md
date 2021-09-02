---
versionFrom: 9.0.0
meta.Title: "Umbraco NuCache Settings"
meta.Description: "Information on the NuCache settings section"
state: complete
verified-against: beta-3
update-links: true
---

# NuCache Settings

This settings section allows you to specify the block size of the BTree used by NuCache. This is configured by default, so you don't need to configure this. However it is possible with something like: 

```json
"Umbraco": {
  "CMS": {
    "NuCache": {
      "BTreeBlockSize": 4096
    }
  }
}
```

This is how NuCache is configured by default. It is important to mention that the block size must be at least 512, and at most 65536 (64K)