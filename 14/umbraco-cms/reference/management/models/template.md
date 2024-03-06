---
description: "Represents a Template file."
---

# Template

Represents a Template file.

* **Namespace:** `Umbraco.Cms.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statements:

```csharp
using Umbraco.Cms.Core.Models;
```

## Constructors

### new Template(IShortStringHelper shortStringHelper, string name, string alias)

Constructor for creating a new Template object. The necessary parameters include a short String Helper as an `IShortStringHelper`. The name and alias of the Template must be provided as `string` values.

## Properties

### .Alias

Gets the Alias of the File, which is the name without the extension.

```csharp
var template = new Template(shortStringHelper, "Page", "page");
return template.Alias;
```

### .IsMasterTemplate

Returns true if the template is used as a layout for other templates (that is, it has 'children')

```csharp
var template = new Template(shortStringHelper,"Page", "page");
return template.IsMasterTemplate;
```

### .MasterTemplateAlias

Returns the alias of the master template if one is set.

```csharp
var template = new Template(shortStringHelper, "Page", "page");
return template.MasterTemplateAlias;
```

### .MasterTemplateId

Returns the id of the master template if one is set.

```csharp
var template = new Template(shortStringHelper, "Page", "page");
return template.MasterTemplateId;
```

### .Name

Gets the Name of the File including extension.

```csharp
var template = new Template(shortStringHelper, "Page", "page");
return template.Name;
```

## Methods

### .SetMasterTemplate(ITemplate masterTemplate)

Sets the master template of the template.

```csharp
// Create a new template
var template = new Template(shortStringHelper, "Page", "page");
// Get a master template 
var masterTemplate = fileService.GetTemplate(1234);
// Set the master template to new created template
template.SetMasterTemplate(masterTemplate);
// Save the new template
fileService.SaveTemplate(template);
```
