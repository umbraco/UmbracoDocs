---
description: "Information on the Examine settings section"
---

# Examine settings

Since the majority of Examine configuration takes place in code, this section is small and contains only one setting to change: `LuceneDirectoryFactory`. This setting allows you to change the behavior of the `ExamineIndexes` directory.

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
