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

### Without Modelsbuilder
```csharp
@{
    if (Model.Value<string>("myFile").HasValue())
    {
        var myFile = Model.Value<string>("myFile");

        <a href="@myFile">@Path.GetFileName(myFile)</a>
    }

}
```
