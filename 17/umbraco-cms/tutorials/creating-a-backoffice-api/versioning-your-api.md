---
description: Adding new versions of custom Management APIs
---

# Versioning your API

All APIs register as version 1.0 by default, which means their endpoints are routed under `/umbraco/management/api/v1/`.

As projects evolve, adding new versions of your APIs sometimes becomes necessary. Multiple versions of the same API can co-exist to retain backward compatibility.

APIs are versioned using attribute annotation:

- `[ApiVersion]` attributes on the API controllers.
- `[MapToApiVersion]` attributes on the API controller actions.

{% hint style="info" %}
It is recommended to annotate _all_ API controller actions, as well as the version 1.0 actions.
{% endhint %}

Using the API controller from the [Creating your own API article](./README.md) as an example, we can add version 2.0 implementations of select actions:

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

Version 2.0 of the "get" and "create" endpoints - `GetItemV2` and `CreateItemV2` respectively, are added with the code above. The rest of the endpoints remain version 1.0 only.

{% hint style="info" %}
The version 2.0 endpoints are routed under `/umbraco/management/api/v2/`.
{% endhint %}

In the example above, the version 2.0 actions are added to the same API controller as their version 1.0 counterparts. If you prefer, they can be added to a new API controller instead. This will leave you with separate API controllers, one for each version of the API. See the examples below:

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

With the version 1.0 actions added in a controller sampled above, the version 2.0 actions are added in a new controller, as shown below.

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
