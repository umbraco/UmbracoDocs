---
versionFrom: 8.0.0
---

# Member Group Picker

`Alias: Umbraco.MemberGroupPicker`

`Returns: string`

The member group picker opens a panel to pick one or more member groups from the member section. The value saved is of type string (comma separated ids).

## Data Type Definition Example

![Member Group Pciker Type Definition](images/Member-Group-Picker-DataType.png)

## Content Example

![Member Grouep Picker Content](images/Member-Group-Picker-Content.png)

## MVC View Example

### Without Modelsbuilder

```csharp
@if (Model.HasValue("memberGroup"))
{
    var memberGroup = Model.Value<string>("memberGroup"); 
    <p>@memberGroup</p>
}
```

### With Modelsbuilder

```csharp
@if (!string.IsNullOrEmpty(Model.MemberGroup))
{
    <p>@Model.MemberGroup</p>
}
```