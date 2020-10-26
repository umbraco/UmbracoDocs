---
versionFrom: 8.0.0
---

# File upload

`Alias: Umbraco.UploadField`

`Returns: string`

Adds an upload field, which allows documents or images to be uploaded to Umbraco.

## Data Type Definition Example

![Data Type Definition Example](images/definition-example.png)

## Content Example

![Content Example Empty](images/content-example-empty.png)
![Content Example](images/content-example.png)

In code, the property is a string, which references the location of the file. 

Example: `"/media/o01axaqu/guidelines-on-remote-working.pdf"`

## MVC View Example
### A link that would open a pdf-file
```csharp
<a href="@Model.MyFile">@Path.GetFileName(Model.MyFile)</a>
```
