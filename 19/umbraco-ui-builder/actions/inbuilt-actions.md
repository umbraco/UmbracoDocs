---
description: A list of inbuilt actions that come with Umbraco UI Builder.
---

# Inbuilt Actions

Umbraco UI Builder provides different inbuilt actions that you can use right away.

## ExportEntityAction

**Namespace:** `Umbraco.UIBuilder.Infrastructure.Configuration.Actions`

Exports entity data to a Comma-Separated Values (CSV) file. It writes a column for each public property that holds a single value, and a row for each entity.

## ImportEntityAction

**Namespace:** `Umbraco.UIBuilder.Infrastructure.Configuration.Actions`

Imports data from a Comma-Separated Values (CSV) file. This action matches column headings with entity properties and maps row values to an entity.

Each row is saved on its own. A row that fails to save, or that a saving notification handler cancels, does not stop the other rows from being imported. A value that cannot be converted to the type of its property stops the whole import. When rows could not be imported, the action reports **Import partly completed**. The message gives the number of imported rows and the numbers of up to five rows that were not imported. Row numbers do not count the header row.

After the import runs from the collection menu, the list refreshes.

## Controlling CSV Columns

The import and export actions use CsvHelper 34. Both actions read and write public properties that hold a single value, such as text, numbers, dates, and enums.

Use these CsvHelper attributes on your entity properties to control the columns:

* `[CsvIgnore]` leaves a property out of the export and the import.
* `[CsvColumn("Column name")]` sets the column heading of a property.

Both attributes are in the `CsvHelper` namespace. The actions only read the column name from `[CsvColumn]`. Other CsvHelper attributes, such as `[CsvFormat]`, are not used.

{% code title="Customer.cs" %}
```csharp
using CsvHelper;

namespace MyProject.Models;

public class Customer
{
    public int Id { get; set; }

    [CsvColumn("Full name")]
    public string Name { get; set; } = string.Empty;

    [CsvIgnore]
    public string? InternalNotes { get; set; }
}
```
{% endcode %}

The import matches each column heading to the `[CsvColumn]` name of a property, or to the property name when the property has no `[CsvColumn]`. The match is case-sensitive.

{% hint style="warning" %}

From Umbraco UI Builder 19, the actions no longer read CsvHelper 31 attributes such as `[Ignore]`, `[Name]`, `[Index]`, and `[Format]`. CsvHelper 34 no longer has these attributes. Replace `[Ignore]` with `[CsvIgnore]`, and `[Name]` with `[CsvColumn]`.

Properties that hold nested objects or collections are no longer flattened into extra columns. They are left out of the export and the import.

{% endhint %}

## Where the Actions Appear in the Menu

The actions menu (**...**) groups its actions under headings. Umbraco UI Builder places its inbuilt actions in the matching Umbraco groups:

| Action | Menu group |
| --- | --- |
| Create | **Create** |
| Delete | **Structure** |
| Import and Export | **Import and export** |

Custom actions are not part of a group. They appear in the last block of the menu, below the Umbraco groups.

In the entity editor, the actions menu and the save button menu show actions in the order you add them in your configuration.
