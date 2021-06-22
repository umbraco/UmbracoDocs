---
versionFrom: 8.0.0
---

# Language

Represents a Template file.

* **Namespace:** `Umbraco.Core.Models`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

All samples in this document will require the following using statement:

    using Umbraco.Core.Models;

## Constructors

### new Template(string name, string alias)

Constructor for creating a new Template object where the necessary parameters are the name of the Template and the alias for the Template being created.

## Properties

### .Alias

Gets the Alias of the File, which is the name without the extension.

```csharp
var template = new Template("Page", "page");
return template.Alias;
```

### .IsMasterTemplate

Returns true if the template is used as a layout for other templates (i.e. it has 'children')

```csharp
var template = new Template("Page", "page");
return template.IsMasterTemplate;
```

### .MasterTemplateAlias

Returns the alias of the master template if one is set.

```csharp
var template = new Template("Page", "page");
return template.MasterTemplateAlias;
```

### .MasterTemplateId

Returns the id of the master template if one is set.

```csharp
var template = new Template("Page", "page");
return template.MasterTemplateId;
```

### .Name

Gets the Name of the File including extension.

```csharp
var template = new Template("Page", "page");
return template.Name;
```

## Methods

### .SetMasterTemplate(ITemplate masterTemplate)

Sets the master template of the template.

```csharp
// Create a new template
var template = new Template("Page", "page");
// Get a master template 
var masterTemplate = fileService.GetTemplate(1234);
// Set the master template to new created template
template.SetMasterTemplate(masterTemplate);
// Save the new template
fileService.SaveTemplate(template);
```
