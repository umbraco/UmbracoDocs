---
versionFrom: 8.0.0
---

# Member Picker

`Alias: Umbraco.MemberPicker`

`Returns: IPublishedContent`

The member picker opens a panel to pick a specific member from the member section. The value saved is of type IPublishedContent.

## Data Type Definition Example

![Media Picker Data Type Definition](images/Member-Picker-DataType-v8.png)

## Content Example

![Member Picker Content](images/Member-Picker-Content-v8.png)

## MVC View Example

### Typed

```csharp
@{
    if(Model.HasValue("author")){
        var member = Model.Author;
            @member.Name
    }
}
```
