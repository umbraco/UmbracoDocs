---
description: "Represents a Dictionary Item. A Dictionary Item is what you see in the Translation / Dictionary tree."
---

# DictionaryItem

Represents a Dictionary Item. A Dictionary Item is what you see in the Translation / Dictionary tree.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

```csharp
using Umbraco.Cms.Core.Models;
```

## Constructors

### new DictionaryItem(string itemKey)

Constructor for creating a new `DictionaryItem` object where the necessary parameter is the key of the `DictionaryItem` as a `string`.

### new DictionaryItem(Guid? parentId, string itemKey)

Constructor for creating a new `DictionaryItem` object where the necessary parameters are the parentKey as `Guid` and the key of the `DictionaryItem` as a `string`. Use this one if you want to create a `DictionaryItem` underneath another one.

## Properties

### .ItemKey

Gets or sets the Key for the Dictionary Item.

```csharp
// Create a DictionaryItem and return the key
var dictionaryItem = new DictionaryItem("your_key");
return dictionaryItem.ItemKey;
```

### .ParentId

Gets or Sets a `Guid?` of the Dictionary Item ParentId.

```csharp
// Create a DictionaryItem and return the parentId
DictionaryItem dictionaryItem = new DictionaryItem("your_key");
Guid? parentId = dictionaryItem.ParentId;
return parentId;
```

### .Translations

Gets or sets a `IEnumerable<IDictionaryTranslation>` of translations for the Dictionary Item.

```csharp
// Create a DictionaryItem and return the translations
var dictionaryItem = new DictionaryItem("your_key");
return dictionaryItem.Translations;
```
