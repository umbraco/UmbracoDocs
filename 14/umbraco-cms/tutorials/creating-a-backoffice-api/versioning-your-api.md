---
description: Adding new versions of custom Management APIs
---

# Versioning your API

All APIs register as version 1.0 by default, which means their endpoints are routed under `/umbraco/management/api/v1/`.

As projects evolve over time, it sometimes becomes necessary to add new versions of your APIs. To retain backwards compatability, multiple versions of the same API can co-exist.

APIs are versioned using attribute annotation:

- `[ApiVersion]` attributes on the API controllers.
- `[MapToApiVersion]` attributes on the API controller actions.

{% hint style="info" %}
It is recommended to annotate _all_ API controller actions, also the version 1.0 actions.
{% endhint %}

Using the API controller from the [Creating your own API article](./create-your-own-api.md) as an example, we can add version 2.0 implementations of select actions:

{% code title="MyItemApiController.cs" %}
```csharp
[ApiVersion("1.0")]
[ApiVersion("2.0")]
public class MyItemApiController : ManagementApiControllerBase
{
    [HttpGet]
    [MapToApiVersion("1.0")]
    public IActionResult GetAllItems(int skip = 0, int take = 10)
    {
        // ...
    }

    [HttpGet("{id:guid}")]
    [MapToApiVersion("1.0")]
    public IActionResult GetItem(Guid id)
    {
        // ...
    }

    [HttpPost]
    [MapToApiVersion("1.0")]
    public IActionResult CreateItem(string value)
    {
        // ...
    }

    [HttpPut("{id:guid}")]
    [MapToApiVersion("1.0")]
    public IActionResult UpdateItem(Guid id, string value)
    {
        // ...
    }

    [HttpDelete("{id:guid}")]
    [MapToApiVersion("1.0")]
    public IActionResult DeleteItem(Guid id)
    {
        // ...
    }

    [HttpGet("{id:guid}")]
    [MapToApiVersion("2.0")]
    public IActionResult GetItemV2(Guid id)
    {
        MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);

        return item is not null
            ? Ok(item)
            : OperationStatusResult(
                MyItemOperationStatus.NotFound,
                builder => NotFound(
                    builder
                        .WithTitle("The item was not found")
                        .WithDetail("The item with the given ID did not exist.")
                        .Build()
                )
            );
    }

    [HttpPost]
    [MapToApiVersion("2.0")]
    public IActionResult CreateItemV2(string value)
    {
        var newItem = new MyItem(value);
        AllItems.Add(newItem);
        return CreatedAtId<MyItemApiController>(
            ctrl => nameof(ctrl.GetItemV2),
            newItem.Id
        );
    }
}
```
{% endcode %}

Here we're adding version 2.0 of the "get" and "create" endpoints - `GetItemV2` and `CreateItemV2` respectively. The rest of the endpoints remain version 1.0 only.

{% hint style="info" %}
The version 2.0 endpoints are routed under `/umbraco/management/api/v2/`.
{% endhint %}

In the example above, the version 2.0 actions are added to the same API controller as their version 1.0 counterparts. If you prefer, they can just as well be added to a new API controller instead - like this:

{% code title="MyItemApiController.cs" %}
```csharp
[ApiVersion("1.0")]
public class MyItemApiController : ManagementApiControllerBase
{
    [HttpGet]
    [MapToApiVersion("1.0")]
    public IActionResult GetAllItems(int skip = 0, int take = 10)
    {
        // ...
    }

    [HttpGet("{id:guid}")]
    [MapToApiVersion("1.0")]
    public IActionResult GetItem(Guid id)
    {
        // ...
    }

    [HttpPost]
    [MapToApiVersion("1.0")]
    public IActionResult CreateItem(string value)
    {
        // ...
    }

    [HttpPut("{id:guid}")]
    [MapToApiVersion("1.0")]
    public IActionResult UpdateItem(Guid id, string value)
    {
        // ...
    }

    [HttpDelete("{id:guid}")]
    [MapToApiVersion("1.0")]
    public IActionResult DeleteItem(Guid id)
    {
        // ...
    }
}
```
{% endcode %}

..and:

{% code title="MyItemApiVersionTwoController.cs" %}
```csharp
[ApiVersion("2.0")]
public class MyItemApiVersionTwoController : ManagementApiControllerBase
{
    private static readonly List<MyItem> AllItems = Enumerable.Range(1, 100)
        .Select(i => new MyItem($"My V2 Item #{i}"))
        .ToList();

    [HttpGet("{id:guid}")]
    [MapToApiVersion("2.0")]
    public IActionResult GetItem(Guid id)
    {
        MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);

        return item is not null
            ? Ok(item)
            : OperationStatusResult(
                MyItemOperationStatus.NotFound,
                builder => NotFound(
                    builder
                        .WithTitle("The item was not found")
                        .WithDetail("The item with the given ID did not exist.")
                        .Build()
                )
            );
    }

    [HttpPost]
    [MapToApiVersion("2.0")]
    public IActionResult CreateItem(string value)
    {
        var newItem = new MyItem(value);
        AllItems.Add(newItem);
        return CreatedAtId<MyItemApiVersionTwoController>(
            ctrl => nameof(ctrl.GetItem),
            newItem.Id
        );
    }
}
```
{% endcode %}

{% hint style="warning" %}
While perhaps tempting, do _not_ name your API controller `V2` - e.g. `MyItemApiVersionV2`. Due to an upstream issue in the API versioning system, this will currently cause routing issues in certain scenarios.
{% endhint %}
