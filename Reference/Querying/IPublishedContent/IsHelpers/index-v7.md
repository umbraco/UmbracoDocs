---
versionFrom: 7.0.0
---

# IPublishedContent IsHelpers

The IsHelper methods are a set of extension methods for IPublishedContent to help perform quick conditional queries against IPublishedContent nodes in a collection.

IsHelper methods all work the same, and have 3 overloads. They are ternary operators, but work a little nicer in that they can be embedded in properties and quicker to write as you don't need so many brackets to make Razor understand them.

The general use IsHelper is to allow you to dynamically inject class names and style attributes onto your HTML elements, based on their position within the collection you are iterating. You can use this for a variety of things such as alternating row colours or fixing the margin/padding on the first/last item etc.

---

## How to use

To use an IsHelper you need to be iterating over a collection of IPublishedContent.

```csharp
<ul>
@foreach(var item in CurrentPage.Children)
{
    <li class="@item.IsFirst("first","not-first")">@item.Name</li>
}
</ul>
```

IsHelpers work like ternary operators. The example above uses the `.IsFirst()` IsHelper method.
The first parameter is the value we want it to return if the condition returns `true`, and the second,
optional value, is the value we want to return if the condition evaluates to `false`. (If you omit the
second string argument, the returned value will be an empty string if the condition evaluates to `false`).

IsHelpers can also return boolean values:

```csharp
@if(item.IsFirst())
{
    <p>Extra info for this item</p>
}
```

---

## IsHelper Methods

### .IsFirst([string valueIfTrue][,string valueIfFalse])

Test if the current node is the first item in the collection.

### .IsNotFirst([string valueIfTrue][,string valueIfFalse])

Test if the current node is not the first item in the collection.

### .IsLast([string valueIfTrue][,string valueIfFalse])

Test if the current node is the last item in the collection.

### .IsNotLast([string valueIfTrue][,string valueIfFalse])

Test if the current node is not the last item in the collection.

### .IsPosition(int index[,string valueIfTrue][,string valueIfFalse])

Test if the current node is at the specified index (zero-based) in the collection.

### .IsNotPosition(int index[,string valueIfTrue][,string valueIfFalse])

Test if the current node is not at the specified index (zero-based) in the collection.

### .IsModZero(int modulus[,string valueIfTrue][,string valueIfFalse])

Test if the current node's position is evenly divisible by a given number.

### .IsNotModZero(int modulus[,string valueIfTrue][,string valueIfFalse])

Test if the current node's position is not evenly divisible by a given number.

### .IsEven([string valueIfTrue][,string valueIfFalse])

Test if the current node's position is even.

### .IsOdd([string valueIfTrue][,string valueIfFalse])

Test if the current node's position is odd.

### .IsEqual(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is equal (by Id) to another node.

### .IsDescendant(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is a descendant of another node.

### .IsDescendantOrSelf(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is the same as or a descendant of another node.

### .IsAncestor(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is an ancestor of another node.

### .IsAncestorOrSelf(IPublishedContent otherNode[,string valueIfTrue][,string valueIfFalse])

Test if the current node is the same as or an ancestor of another node.
