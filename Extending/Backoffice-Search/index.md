---
keywords: Backoffice Search
versionFrom: 8.6.0
meta.Title: "Backoffice Search"
meta.Description: "A guide to customization of Backoffice Search"
---

# Backoffice Search

The search facility of the Umbraco Backoffice allows the searching 'across sections' of different types of Umbraco entities, eg Content, Media, Members. However 'by default' only a small subset of standard fields are searched:

| Node Type    | Propagated Fields      |
| ------------ | ---------------------- |
| All Nodes    | Id, __NodeId and __Key |
| Media Nodes  | UmbracoFileFieldName   |
| Member Nodes | email, loginName       |
|              |                        |

However, a specific Umbraco implementation may have additional custom properties that it would be useful to be considered in a Backoffice Search, for example perhaps there is an 'Organisation Name' property on the Member Type, or the 'Main Body Text' property of a Content item. 

Umbraco 8.6 introduced a new way to extend/override the default fields by implementing `IUmbracoTreeSearcherFields`. This service exposes the list of default internal search fields for each section and allows modification of them.

## Adding custom properties to backoffice search

### All Node types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields,     IUmbracoTreeSearcherFields
{
    public List<string> GetBackOfficeFields()

    {
        var list = base.GetBackOfficeFields();
        list.Add("parentID");
        return list;
    }
}
```

### Documents types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields,     IInternalSearchConstants
{
    public List<string> GetBackOfficeDocumentFields()
    {
        var list = base.GetBackOfficeDocumentFields();
        list.Add("parentID");
        return list;
    }
}
```

### Media Types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields,     IUmbracoTreeSearcherFields
{
    public List<string> GetBackOfficeMediaFields()
    {
        var list = base.GetBackOfficeMediaFields();
        list.Add("parentID");
        return list;
    }
}
```

### Member Types

```csharp
public class CustomUmbracoTreeSearcherFields : UmbracoTreeSearcherFields,     IUmbracoTreeSearcherFields
{
    public List<string> GetBackOfficeMembersFields()
    {
        var list = base.GetBackOfficeMembersFields();
        list.Add("parentID");
        return list;
    }
}
```

## More advanced extensions

For further extensibility of the Umbraco Backoffice search implementation check [ISearchableTree](https://our.umbraco.com/Documentation/Extending/Section-Trees/Searchable-Trees/ "https://our.umbraco.com/Documentation/Extending/Section-Trees/Searchable-Trees/")
