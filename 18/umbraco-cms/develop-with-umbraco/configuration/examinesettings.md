---
description: "Information on the Examine settings section"
---

# Examine settings

The majority of Examine configuration takes place in code, so this section contains only a few settings.

The section has default values and doesn't need to be configured. Configuring Examine might look like this:

```json
"Umbraco": {
  "CMS": {
    "Examine": {
      "LuceneDirectoryFactory": "Default",
      "BackOfficeSearchMinimumMatchWithinWordLength": 3
    }
  }
}
```

## LuceneDirectoryFactory

This setting allows you to change the behavior of the `ExamineIndexes` directory. There are three different types of Lucene directory factories:

* `Default` - The index will operate from the default location: `umbraco/Data/TEMP/ExamineIndexes`
* `SyncedTempFileSystemDirectoryFactory` - The index will operate on a local index created in the processes %temp% location and will replicate back to main storage in `umbraco/Data/TEMP/ExamineIndexes`
* `TempFileSystemDirectoryFactory` - The index will operate only in the processes %temp% directory location

## BackOfficeSearchMinimumMatchWithinWordLength

Backoffice search matches a search word anywhere within a word in a node name, as well as at the start of a word. For example, searching for `4521` finds a media item named `Report ABC004521 2026`.

This setting is the minimum length a search word must have to be matched within a word. Shorter search words only match at the start of a word. The default value is `3`.

Set the value to `0` to only match search words at the start of a word.

Matching within a word is slower than matching at the start of a word, and the cost grows with the size of the index. One extra query clause is added for each language, as node names are indexed per culture. Consider raising the value, or setting it to `0`, if backoffice search is slow on a large site with many languages.

For more information on how backoffice search works, see the [Backoffice Search](../../extend-your-project/server-side-extensions/backoffice-search.md) article.
