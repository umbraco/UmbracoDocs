---
versionFrom: 7.0.0
---

# (Obsolete) Related Links

### For the new version of this data type see: [Related-Links2](Related-Links2.md)

`Returns: RelatedLinks` if value converters are enabled (default)

`Returns: JArray` if value converters are disabled

Related Links allows an editor to add an array of links. These can either be internal Umbraco pages or external URLs.

## Data Type Definition Example

![Related Links Data Type Definition](images/Related-Links-DataType.jpg)

## Content Example

![Media Picker Content](images/Related-Links-Content.jpg)

## MVC View Example - [value converters enabled](../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed

```csharp
@using Umbraco.Web.Models
@{
    var typedRelatedLinksConverted = Model.Content.GetPropertyValue<RelatedLinks>("footerLinks");

    if (typedRelatedLinksConverted.Any())
    {
        <ul>
            @foreach (var item in typedRelatedLinksConverted)
            {
                var linkTarget = (item.NewWindow) ? "_blank" : null;
                <li><a href="@item.Link" target="@linkTarget">@item.Caption</a></li>
            }
        </ul>
    }
}
```

## MVC View Example - [value converters disabled](../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed

```csharp
@using Newtonsoft.Json.Linq
@{
    if (Model.Content.HasValue("relatedLinks") && Model.Content.GetPropertyValue<string>("relatedLinks").Length > 2)
    {
        <ul>
            @foreach (var item in Model.Content.GetPropertyValue<JArray>("relatedLinks"))
            {
                var linkUrl = (item.Value<bool>("isInternal")) ? Umbraco.NiceUrl(item.Value<int>("internal")) : item.Value<string>("link");
                var linkTarget = item.Value<bool>("newWindow") ? "_blank" : null;
                <li><a href="@linkUrl" target="@linkTarget">@(item.Value<string>("caption"))</a></li>
            }
        </ul>
    }
}
```

### Dynamic

```csharp
@{
    if (CurrentPage.HasValue("relatedLinks") && CurrentPage.relatedLinks.ToString().Length > 2)
    {
        <ul>
            @foreach (var item in CurrentPage.relatedLinks)
            {
                var linkUrl = (bool)item.isInternal ? Umbraco.NiceUrl(item.Value<int>("internal")) : item.link;
                var linkTarget = (bool)item.newWindow ? "_blank" : null;
                <li><a href="@linkUrl" target="@linkTarget">@item.caption</a></li>
            }
        </ul>
    }
}
```
