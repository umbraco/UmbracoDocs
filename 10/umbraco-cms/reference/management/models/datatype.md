---
description: "A DataType is what you see in the backoffice in the Settings / DataTypes tree. The listed nodes are definitions of the DataTypes that are available to use on your PropertyTypes."
---

# DataType

A DataType is what you see in the backoffice in the Settings / DataTypes tree. The listed nodes are definitions of the DataTypes that are available to use on your PropertyTypes.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

```csharp
using Umbraco.Cms.Core.Models;
```

## Constructors

### new DataType(IDataEditor editor, IConfigurationEditorJsonSerializer serializer, int parentId = -1)

Constructor for creating a new `DataType` object where the necessary parameters are a `IDataEditor` and a `IConfigurationEditorJsonSerializer`. Optionally, the parentId can be added, if not provided the default value is -1, which means it will be created at root level.

## Properties

### .CreateDate

Gets or Sets a `DateTime` object, indicating then the given DataType was created.

### .CreatorId

Gets or Sets the Id of the `User` who created the DataType.

### .DatabaseType

Gets or Sets the DatabaseType as a `ValueStorageType` enum for which the DataType's value is saved as.

### .Id

Returns the unique `DataType` ID as an `Int`. The ID, derived from a database identity field, isn't safe for code references as they are moved across instances. Therefore it's recommended to use `Key` instead. 

### .Key

Returns the `Guid` assigned to the DataType during creation. This value is unique, and should never change, even if the DataType is moved between instances.

### .Level

Gets or Sets the given `DataType` level in the site hierarchy as an `Int`. DataType placed at the root of the site, will return 1, DataType right underneath will return 2, and so on.

### .Name

Gets or Sets the name of the `DataType` as a `String`.

### .ParentId

Gets or Sets the parent `DataType` Id as an `Int`.

### .Path

Gets or Sets the path of the `DataType` as a `String`. This string contains a comma separated list of the ancestor Ids including the current contents own id at the end of the string.

### .SortOrder

Returns the given `DataType` index, compared to sibling DataType.

### .Trashed

Returns a `Bool` indicating whether the given `DataType` is currently in the recycle bin.
