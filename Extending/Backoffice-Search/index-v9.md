---
v8-equivalent: "https://github.com/umbraco/UmbracoDocs/blob/main/Extending/Backoffice-Search/index.md"
versionFrom: 9.0.0
state: partial
updated-links: false
verified-against: alpha-3
---

# Backoffice Search

The search facility of the Umbraco Backoffice allows the searching 'across sections' of different types of Umbraco entities, eg Content, Media, Members. However 'by default' only a small subset of standard fields are searched:

| Node Type    | Propagated Fields      |
| ------------ | ---------------------- |
| All Nodes    | Id, __NodeId and __Key |
| Media Nodes  | UmbracoFileFieldName   |
| Member Nodes | email, loginName       |

However, a specific Umbraco implementation may have additional custom properties that it would be useful to be considered in a Backoffice Search, for example perhaps there is an 'Organisation Name' property on the Member Type, or the 'Main Body Text' property of a Content item.

## Adding custom properties to backoffice search

To add custom properties, it is required to register a custom implementation of `IUmbracoTreeSearcherFields`. We recommend to override the existing `UmbracoTreeSearcherFields`.

Your custom implementation needs to be registered in the container. E.g. in the `Startup.ConfigureServices` method or in a composer, as an alternative.

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
    ...

    services.AddUnique<IUmbracoTreeSearcherFields, CustomUmbracoTreeSearcherFields>();
}
```

or

```csharp
public class MyComposer : IUserComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
    builder.Services.AddUnique<IUmbracoTreeSearcherFields, CustomUmbracoTreeSearcherFields>();
    }
}
```

### All Node types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields, IUmbracoTreeSearcherFields
{
    public IEnumerable<string> GetBackOfficeFields()
    {
        return new List<string>(base.GetBackOfficeFields()) { "parentID" };
    }
}
```

### Documents types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields, IInternalSearchConstants
{
    public IEnumerable<string> GetBackOfficeDocumentFields()
    {
        return new List<string>(base.GetBackOfficeDocumentFields()) { "parentID" };
    }
}
```

### Media Types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields, IUmbracoTreeSearcherFields
{
    public IEnumerable<string> GetBackOfficeMediaFields()
    {
       return new List<string>(base.GetBackOfficeMediaFields()) { "parentID" };
    }
}
```

### Member Types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields,     IUmbracoTreeSearcherFields
{
    public IEnumerable<string> GetBackOfficeMembersFields()
    {
        return new List<string>(base.GetBackOfficeMembersFields()) { "parentID" };
    }
}
```

## More advanced extensions

For further extensibility of the Umbraco Backoffice search implementation check [ISearchableTree](https://our.umbraco.com/Documentation/Extending/Section-Trees/Searchable-Trees/ "https://our.umbraco.com/Documentation/Extending/Section-Trees/Searchable-Trees/")
