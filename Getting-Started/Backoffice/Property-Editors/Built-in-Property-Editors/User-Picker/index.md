---
versionFrom: 8.0.0
---

# User Picker

`Alias: Umbraco.UserPicker`

`Returns: IPublishedContent`

The user picker opens a panel to pick a specific user from the Users section. The value saved is of type IPublishedContent.

## Data Type Definition Example

![Media Picker Data Type Definition](images/User-Picker-DataType-v8.png)

## Content Example

![Member Picker Content](images/User-Picker-Content-v8.png)

## MVC View Example

Please note that getting the Value of the property will return the user ID - properties of the User can be accessed by referencing UserService.

### Typed

```csharp
@{
    var us = Services.UserService;
    var username = us.GetUserById(Model.Value<int>("userPicker")).Name;
}
    <p>This is the chosen person: @username</p>
    <p>This returns the id value of chosen person: @Model.Value("userPicker")</p>
}
```
