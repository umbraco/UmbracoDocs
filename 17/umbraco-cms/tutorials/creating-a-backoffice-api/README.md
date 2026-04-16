# Creating a backoffice API

In this article, you will learn how to create your own API in the Umbraco backoffice. This is a great way to extend the functionality of the Umbraco backoffice and create custom endpoints for your use.

The end result for this article is to create a custom API called "My item API" in the Management API found at `/umbraco/swagger/`.

{% hint style="info" %}
The Umbraco Backoffice API is also known as the Management API. Thus, a Backoffice API Controller is often referred to as a Management API Controller.
{% endhint %}

## Creating the class

To create a custom API, you need to create a class that inherits from `Umbraco.Cms.Api.Management.Controllers.ManagementApiControllerBase`.

The `ManagementApiControllerBase` serves as the foundation for your custom API class. It provides essential functionalities and utilities required for managing APIs within the Umbraco backoffice environment.

We also use the `VersionedApiBackOfficeRoute` attribute to define the route for our API. This attribute takes a string parameter that defines the route for the API. This route will be appended to the base route for the backoffice API.

{% code title="MyItemApiController.cs" %}
```csharp
[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : ManagementApiControllerBase
{
}
```
{% endcode %}

## Retrieving all items

Now that we have our class set up, we can add an action to get all items. We will use the `HttpGet` attribute to define the `HTTP` method and route for the action.

The `AllItems` field is an in-memory list of items to simulate the use of a repository. We use the `skip` & `take` parameters here, so users of this endpoint can implement paging. We also use the `PagedViewModel` to return the given items (10 by default), and then the total number of items.

{% code title="MyItemApiController.cs" %}
```csharp
[HttpGet]
public IActionResult GetAllItems(int skip = 0, int take = 10)
    => Ok(
        new PagedViewModel<MyItem>
        {
            Items = AllItems.Skip(skip).Take(take),
            Total = AllItems.Count
        }
    );
```
{% endcode %}

AllItems is a local list:

{% code title="MyItemApiController.cs" %}
```csharp
private static readonly List<MyItem> AllItems = Enumerable.Range(1, 100)
        .Select(i => new MyItem($"My Item #{i}"))
        .ToList();
```
{% endcode %}

The model for `MyItem` is a basic class with an `Id` and a `Value` property.

{% code title="MyItem.cs" %}
```csharp
public class MyItem(string value)
{
    public Guid Id { get; } = Guid.NewGuid();

    public string Value { get; set; } = value;
}
```
{% endcode %}

## Retrieving a single item

We can now create some logic to return a response based on the `ID`. The route parameter `{id:guid}` specifies that the `id` parameter should be a `GUID`. Here we're creating a local in-memory list of items and returning the item with the matching `ID`.

To note here is the use of the `OperationStatusResult` method. This method allows you to return a response with a status code and a body. This is useful for returning error responses with additional information.

The method also needs an `enum` operationStatus, as it will be attached to the response. This is a basic example, however, this `OperationStatus` would be returned from your service layer, based on the error in the service layer method.

{% code title="MyItemApiController.cs" %}
```csharp
[HttpGet("{id:guid}")]
public IActionResult GetItem(Guid id)
{
    MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);

    return item is not null
        ? Ok(item)
        : OperationStatusResult(
            MyItemOperationStatus.NotFound,
            builder => NotFound(
                builder
                    .WithTitle("That thing wasn't there")
                    .WithDetail("Maybe look for something else?")
                    .Build()
            )
        );
}
```
{% endcode %}

{% code title="MyItemOperationStatus.cs" %}
```csharp
public enum MyItemOperationStatus
{
    NotFound,
    InvalidValue,
    DuplicateValue
}
```
{% endcode %}

## Creating a new item

We can now add an action to create a new item. We use the `HttpPost` attribute to define the `HTTP` method and route for the action. Here we can see some validation logic.

If the value does not start with "New", we return a `BadRequest` response with an error message. This highlights why we use the `OperationStatusResult` method. We can return a detailed response.

We also use `CreatedAtId<MyItemApiController>`, a helper method to create a response with a `201 Created` status code and a `Location` header.

{% code title="MyItemApiController.cs" %}
```csharp
[HttpPost]
public IActionResult CreateItem(string value)
{
    if (value.StartsWith("New") is false)
    {
        return OperationStatusResult(
            MyItemOperationStatus.InvalidValue,
            builder => BadRequest(
                builder
                    .WithTitle("That was invalid")
                    .Build()
            )
        );
    }

    if (AllItems.Any(item => item.Value.InvariantEquals(value)))
    {
        return OperationStatusResult(
            MyItemOperationStatus.DuplicateValue,
            builder => BadRequest(
                builder
                    .WithTitle("No duplicate values, please.")
                    .Build()
            )
        );
    }

    var newItem = new MyItem(value);
    AllItems.Add(newItem);
    return CreatedAtId<MyItemApiController>(
        ctrl => nameof(ctrl.GetItem),
        newItem.Id
    );
}
```
{% endcode %}

## Updating an item

Now we can add an action to update an item. We can use the `HttpPut` attribute to define the `HTTP` method and route for the action.

{% code title="MyItemApiController.cs" %}
```csharp
[HttpPut("{id:guid}")]
public IActionResult UpdateItem(Guid id, string value)
{
    MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);
    if (item is null)
    {
        return OperationStatusResult(
            MyItemOperationStatus.NotFound,
            builder => NotFound(
                builder
                    .WithTitle("That thing wasn't there")
                    .WithDetail("Maybe look for something else?")
                    .Build()
            )
        );
    }

    if (AllItems.Any(i => i.Value.InvariantEquals(value)))
    {
        return OperationStatusResult(
            MyItemOperationStatus.DuplicateValue,
            builder => BadRequest(
                builder
                    .WithTitle("You have been DUPED")
                    .Build()
            )
        );
    }

    item.Value = value;
    return Ok();
}
```
{% endcode %}

## Deleting an item

Finally, we can add an action to delete an item. We can use the `HttpDelete` attribute to define the `HTTP` method and route for the action.

{% code title="MyItemApiController.cs" %}
```csharp
[HttpDelete("{id:guid}")]
public IActionResult DeleteItem(Guid id)
{
    MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);

    if (item is null)
    {
        return OperationStatusResult(
            MyItemOperationStatus.NotFound,
            builder => NotFound(
                builder
                    .WithTitle("That thing wasn't there")
                    .WithDetail("Maybe look for something else?")
                    .Build()
            )
        );
    }

    AllItems.Remove(item);
    return Ok();
}
```
{% endcode %}

Now we have created the custom API for our Umbraco project. Below you can see the full example of the implementation.

## Full implementation

{% code title="MyItemApiController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Common.Attributes;
using Umbraco.Cms.Api.Common.ViewModels.Pagination;
using Umbraco.Cms.Api.Management.Controllers;
using Umbraco.Cms.Api.Management.Routing;

namespace UmbracoDocs.Samples;

[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : ManagementApiControllerBase
{
    private static readonly List<MyItem> AllItems = Enumerable.Range(1, 100)
        .Select(i => new MyItem($"My Item #{i}"))
        .ToList();

    [HttpGet]
    public IActionResult GetAllItems(int skip = 0, int take = 10)
        => Ok(
            new PagedViewModel<MyItem>
            {
                Items = AllItems.Skip(skip).Take(take),
                Total = AllItems.Count
            }
        );

    [HttpGet("{id:guid}")]
    public IActionResult GetItem(Guid id)
    {
        MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);

        return item is not null
            ? Ok(item)
            : OperationStatusResult(
                MyItemOperationStatus.NotFound,
                builder => NotFound(
                    builder
                        .WithTitle("That thing wasn't there")
                        .WithDetail("Maybe look for something else?")
                        .Build()
                )
            );
    }

    [HttpPost]
    public IActionResult CreateItem(string value)
    {
        if (value.StartsWith("New") is false)
        {
            return OperationStatusResult(
                MyItemOperationStatus.InvalidValue,
                builder => BadRequest(
                    builder
                        .WithTitle("That was invalid")
                        .Build()
                )
            );
        }

        if (AllItems.Any(item => item.Value.InvariantEquals(value)))
        {
            return OperationStatusResult(
                MyItemOperationStatus.DuplicateValue,
                builder => BadRequest(
                    builder
                        .WithTitle("No duplicate values, please.")
                        .Build()
                )
            );
        }

        var newItem = new MyItem(value);
        AllItems.Add(newItem);
        return CreatedAtId<MyItemApiController>(
            ctrl => nameof(ctrl.GetItem),
            newItem.Id
        );
    }

    [HttpPut("{id:guid}")]
    public IActionResult UpdateItem(Guid id, string value)
    {
        MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);
        if (item is null)
        {
            return OperationStatusResult(
                MyItemOperationStatus.NotFound,
                builder => NotFound(
                    builder
                        .WithTitle("That thing wasn't there")
                        .WithDetail("Maybe look for something else?")
                        .Build()
                )
            );
        }

        if (AllItems.Any(i => i.Value.InvariantEquals(value)))
        {
            return OperationStatusResult(
                MyItemOperationStatus.DuplicateValue,
                builder => BadRequest(
                    builder
                        .WithTitle("You have been DUPED")
                        .Build()
                )
            );
        }

        item.Value = value;
        return Ok();
    }

    [HttpDelete("{id:guid}")]
    public IActionResult DeleteItem(Guid id)
    {
        MyItem? item = AllItems.FirstOrDefault(item => item.Id == id);

        if (item is null)
        {
            return OperationStatusResult(
                MyItemOperationStatus.NotFound,
                builder => NotFound(
                    builder
                        .WithTitle("That thing wasn't there")
                        .WithDetail("Maybe look for something else?")
                        .Build()
                )
            );
        }

        AllItems.Remove(item);
        return Ok();
    }
}

public class MyItem(string value)
{
    public Guid Id { get; } = Guid.NewGuid();

    public string Value { get; set; } = value;
}

public enum MyItemOperationStatus
{
    NotFound,
    InvalidValue,
    DuplicateValue
}
```
{% endcode %}
