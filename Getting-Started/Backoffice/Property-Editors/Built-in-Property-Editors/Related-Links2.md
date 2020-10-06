---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Related Links

`Returns: RelatedLinks`

Related Links allows an editor to add an array of links. These can either be internal Umbraco pages or external URLs.

:::note
This property has been replaced by [Multi URL Picker](Multi-Url-Picker) in Umbraco 8.
:::

## Data Type Definition Example

![Related Links Data Type Definition](images/Related-Links2-DataType.png)

## Content Example

![Media Picker Content](images/Related-Links2-Content.png)

## MVC View Example - [value converters enabled](../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

:::warning
The RelatedLinks do not work without **Umbraco.Web.Models**. Don't forget to use it.
:::

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
