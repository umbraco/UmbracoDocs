# Related Links

`Returns: RelatedLinks`

Related Links allows an editor to easily add an array of links. These can either be internal Umbraco pages or external URLs.

## Data Type Definition Example

![Related Links Data Type Definition](images/Related-Links2-DataType.png)

## Content Example 

![Media Picker Content](images/Related-Links2-Content.png)

## MVC View Example - [value converters enabled](../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed:

```c#
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