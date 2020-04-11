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

Umbraco 8.6 introduce new easy way for extend/override that fields, which is called IUmbracoTreeSearcherFields. This service exposed hardcoded internal list of fields and allow for modification on them.

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
