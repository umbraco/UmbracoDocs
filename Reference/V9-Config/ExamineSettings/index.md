---
versionFrom: 9.0.0
versionTo: 10.0.0
meta.Title: "Umbraco Examine Settings"
meta.Description: "Information on the Examine settings section"
---

# Examine settings

Since the majority of Examine configuration takes place in code, this section is quite small containing only one setting to change, `LuceneDirectoryFactory`, this setting allows you to change the behaviour of the `ExamineIndexes` directory.

This section has a default value, and does not need to be configured, configuring Examine might look something like this:

```json
"Umbraco": {
  "CMS": {
    "Examine": {
      "LuceneDirectoryFactory": "Default"
    }
  }
}
```

This is how Examine is configured by default. There is three different types of Lucene directory factories:

* `Default` - The index will operate from the default location: `umbraco/Data/TEMP/ExamineIndexes`
* `SyncedTempFileSystemDirectoryFactory` - The index will operate on a local index created in the processes %temp% location and will replicate back to main storage in `umbraco/Data/TEMP/ExamineIndexes`
* `TempFileSystemDirectoryFactory` - The index will operate only in the processes %temp% directory location
