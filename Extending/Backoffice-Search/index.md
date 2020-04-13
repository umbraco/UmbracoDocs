---
keywords: Backoffice Search
versionFrom: 8.6.0
meta.Title: "Backoffice Search"
meta.Description: "A guide to customization of Backoffice Search"
---

# Backoffice Search

Backoffice search is usefull tool, which support you in finding your content. Umbraco by default will allow you to search using only few fields: 

| Node Type    | Propagated Fields    |
| ------------ | -------------------- |
| All Nodes    | UmbracoFileFieldName |
| Media Nodes  | File path            |
| Member Nodes | email, loginName     |
|              |                      |


However, a specific Umbraco implementation may have additional custom properties that it would be useful to be considered in a Backoffice Search, for example perhaps there is an 'Organisation Name' property on the Member Type, or the 'Main Body Text' property of a Content item. 

Umbraco 8.6 introduced a new easy way to extend/override the default fields by implementing `IUmbracoTreeSearcherFields`. This service exposes the list of default internal search fields for each section and allows modification of them.

### Adding custom properties to backoffice search

#### All Node types

```
public class CustomInternalSearchConstants : InternalSearchConstants,     IInternalSearchConstants
{
    public List<string> GetBackOfficeFields()

    {
        var list = base.GetBackOfficeFields();
        list.Add("parentID");
        return list;
    }
}
```

#### Documents types

```
public class CustomInternalSearchConstants : InternalSearchConstants,     IInternalSearchConstants
{
    public List<string> GetBackOfficeDocumentFields()
    {
        var list = base.GetBackOfficeDocumentFields();
        list.Add("parentID");
        return list;
    }
}
```

#### Media Types

```
public class CustomInternalSearchConstants : InternalSearchConstants,     IInternalSearchConstants
{
    public List<string> GetBackOfficeMediaFields()
    {
        var list = base.GetBackOfficeMediaFields();
        list.Add("parentID");
        return list;
    }
}
```

#### Member Types

```
public class CustomInternalSearchConstants : InternalSearchConstants,     IInternalSearchConstants
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

To make more customization on back-office search check [ISearchableTree](https://our.umbraco.com/Documentation/Extending/Section-Trees/Searchable-Trees/ "https://our.umbraco.com/Documentation/Extending/Section-Trees/Searchable-Trees/")

