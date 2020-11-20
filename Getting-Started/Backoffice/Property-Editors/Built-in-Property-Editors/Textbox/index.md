---
versionFrom: 8.0.0
---

# Textbox

`Alias: Umbraco.Textbox`

`Returns: String`

Textbox is an HTML input control for text. It can be configured to have a fixed character limit. The default maximum amount of characters is 500 unless it's specifically changed to a lower amount.

## Data Type Definition Example

### Without a character limit

![Textbox Data Type Definition](images/Textbox-Setup-v8.png)

## Settings

## Content Example

### Without a character limit

![Textbox Content Example](images/Textbox-Content-v8.png)

### With a character limit

![Textbox Content Example Without a Character Limit](images/Textbox-Content-Limit-v8.png)

## MVC View Example


### Without Modelsbuilder

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.HasValue("pageTitle")){
        // Print the value of the field with alias 'pageTitle'
        <p>@(Model.Value("pageTitle"))</p>
    }
}
```

### With Modelsbuilder

```csharp
@{
    // Perform an null-check on the field with alias 'pageTitle'
    if (Model.PageTitle.HasValue())
    {
        // Print the value of the field with alias 'pageTitle'
        <p>@Model.PageTitle</p>
    }
}
```

## Add value

See the example below to see how a value can be added or changed programmatically. To update a value of a property editor you need the [Content Service](../../../../../Reference/Management/Services/ContentService/index.md).

```csharp
@{
    var contentService = Services.ContentService;

    var guid = new Guid("32e60db4-1283-4caa-9645-f2153f9888ef");

    var content = contentService.GetById(guid); // ID of your page
    content.SetValue("pageTitle", "Umbraco Demo");
	
    contentService.SaveAndPublish(content);
}
```

Although the use of a GUID is preferable, you can also use the numeric ID to get the page:

```csharp
@{
    var content = contentService.GetById(1234); 
}
```

If Modelsbuilder is enabled you can get the alias of the desired property without using a magic string:

```csharp
@{
    content.SetValue(Home.GetModelPropertyType(x => x.PageTitle).Alias, "Umbraco Demo");
}
```
