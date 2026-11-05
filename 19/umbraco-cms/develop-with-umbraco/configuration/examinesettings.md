---
description: "Information on the Examine settings section"
---

# Examine settings

Since the majority of Examine configuration takes place in code, this section is small and contains two settings: `LuceneDirectoryFactory` and `ZeroDowntimeIndexing`.

This section has a default value, and does not need to be configured, configuring Examine might look something like this:

```json
"Umbraco": {
  "CMS": {
    "Search": {
        "Examine": {
          "LuceneDirectoryFactory": "Default",
          "ZeroDowntimeIndexing": false
        }
    }
  }
}
```

## LuceneDirectoryFactory

This setting allows you to change the behavior of the `ExamineIndexes` directory.

This is how Examine is configured by default. There is three different types of Lucene directory factories:

* `Default` - The index will operate from the default location: `umbraco/Data/TEMP/ExamineIndexes`
* `SyncedTempFileSystemDirectoryFactory` - The index will operate on a local index created in the processes %temp% location and will replicate back to main storage in `umbraco/Data/TEMP/ExamineIndexes`
* `TempFileSystemDirectoryFactory` - The index will operate only in the processes %temp% directory location

## ZeroDowntimeIndexing

When set to `true`, search keeps working while an index is rebuilt. The default is `false`.

Each built-in index is stored as two physical indexes. One is active and serves searches. A rebuild writes to the other one.

When the rebuild completes, Umbraco checks the new index. If it is healthy, Umbraco switches searches to it and clears the old one. If it is empty or not healthy, Umbraco cancels the switch and logs a warning. The existing index keeps serving searches.

Umbraco reads this setting at startup. Restart the site after changing it.
