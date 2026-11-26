---
description: How to support polymorphic outputs from custom Management APIs
---

# Polymorphic output in the Management API

For security reasons, the `System.Text.Json` serializer will not serialize types that are not explicitly referenced at compile time.

This can be a challenge when dealing with polymorphic API outputs. As a workaround, the Management API provides two options for enabling polymorphic outputs.

## Polymorphism by interface

This approach requires that all output models implement the same interface - for example:

{% code title="IMyItem.cs" %}
```csharp
public interface IMyItem
{
    Guid Id { get; }

    string Value { get; set; }
}
```
{% endcode %}

{% code title="MyItem.cs" %}
```csharp
public class MyItem(string value) : IMyItem
{
    public Guid Id { get; } = Guid.NewGuid();

    public string Value { get; set; } = value;
}
```
{% endcode %}

{% code title="MyOtherItem.cs" %}
```csharp
public class MyOtherItem(string value, int otherValue) : IMyItem
{
    public Guid Id { get; } = Guid.NewGuid();

    public string Value { get; set; } = value;

    public int OtherValue { get; } = otherValue;
}
```
{% endcode %}

The `ProducesResponseType` annotation on the endpoints must also be updated to use the interface:

{% code title="MyItemApiController.cs" %}
```csharp
...
[ProducesResponseType<PagedViewModel<IMyItem>>(StatusCodes.Status200OK)]
public IActionResult GetAllItems(int skip = 0, int take = 10)
...
[ProducesResponseType<IMyItem>(StatusCodes.Status200OK)]
public IActionResult GetItem(Guid id)
...
```
{% endcode %}

## Polymorphism by annotation

This approach requires that all output models implement a common base class. The base class will define all its derived types by annotation - for example:

{% code title="MyItemBase.cs" %}
```csharp
[JsonDerivedType(typeof(MyItem), nameof(MyItem))]
[JsonDerivedType(typeof(MyOtherItem), nameof(MyOtherItem))]
public abstract class MyItemBase(string value)
{
    public Guid Id { get; } = Guid.NewGuid();

    public string Value { get; set; } = value;
}
```
{% endcode %}

{% code title="MyItem.cs" %}
```csharp
public class MyItem(string value) : MyItemBase(value)
{
}

```
{% endcode %}

{% code title="MyOtherItem.cs" %}
```csharp
public class MyOtherItem(string value, int otherValue) : MyItemBase(value)
{
    public int OtherValue { get; } = otherValue;
}

```
{% endcode %}

The `ProducesResponseType` annotation on the endpoints must also be updated to use the base class:


{% code title="MyItemApiController.cs" %}
```csharp
...
[ProducesResponseType<PagedViewModel<MyItemBase>>(StatusCodes.Status200OK)]
public IActionResult GetAllItems(int skip = 0, int take = 10)
...
[ProducesResponseType<MyItemBase>(StatusCodes.Status200OK)]
public IActionResult GetItem(Guid id)
...
```
{% endcode %}
