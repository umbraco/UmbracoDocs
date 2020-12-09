---
versionFrom: 8.0.0
---

# IPublishedContent IsHelpers

The IsHelper methods are a set of extension methods for IPublishedContent to help perform quick conditional queries against IPublishedContent nodes in a collection.

IsHelper methods are ternary operators, however they work a little nicer in that they can be embedded in properties and quicker to write as you don't need so many brackets to make Razor understand them.

---

## How to use

An IsHelper can be invoked as a method of an `IPublishedContent`.

```csharp
@{
if(item.IsVisible())
{
<a href="@item.Url">@item.Name</a>
}
}
```

---

## IsHelper Methods

### IsComposedOf(string alias)

Test whether the content is of a content type composed of the given alias.

### IsAllowedTemplate(int templateId)

Test whether the specified `templateId` is an allowed template for the current node.

### IsAllowedTemplate(string templateAlias)

Test whether the specified `templateAlias` is an allowed template for the current node.

### .IsEqual(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is equal (by Id) to another node.

### .IsNotEqual(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is not equal (by Id) to another node.

### .IsDescendant(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is a descendant of another node.

### .IsDescendantOrSelf(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is the same as or a descendant of another node.

### .IsAncestor(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is an ancestor of another node.

### .IsAncestorOrSelf(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is the same as or an ancestor of another node.
