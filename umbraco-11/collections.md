# Collections

use `@Model` in a Template

```csharp
.Children
.Children<MyContentType>()
.Children<MyContentType>("da-dk")
.Children<MyContentType>(c => c.UpdateDate < DateTime.Now.AddMonths(-1))
.ChildrenForAllCultures

.Ancestors()
.Ancestors(0)
.Ancestors<MyContentType>()

.AncestorsOrSelf<MyContentType>() 

.Descendants()
.Descendants<MyContentType>()
.DescendantsOfType("myContentType")

.DescendantsOrSelf()
.DescendantsOrSelf<MycontentType>()

.Siblings()
.SiblingsAndSelf()
```

## Functions of Collections

```csharp
.Any
.Count
```
