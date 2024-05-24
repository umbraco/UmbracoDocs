# Documenting your controllers
Documenting your API controllers using Swagger in Umbraco Version 14 simplifies the creation of detailed and interactive API documentation. Adding Swagger attributes automatically generates comprehensive information about routes, parameters, and response types. This will enhance the developer experience and ensure clarity and consistency in your API documentation.


## ApiExplorerSettings
With the `ApiExplorerSettings` attribute, we can put all of our endpoints into a given group, this is a nice way of organizing our endpoints in the Swagger UI.

```csharp
## ProducesResponseType Attribute

Use [ProducesResponseType] to specify the possible responses for each action method. This helps Swagger generate accurate documentation for your API.
For example, in the GetItem method:
```csharp
[HttpGet("{id:guid}")]
[ProducesResponseType<MyItem>(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult GetItem(Guid id)
{
// Method implementation
}
```

Here, `[ProducesResponseType]` specifies that a 200 OK response will return a MyItem, and a 404 Not Found response will return a ProblemDetails.

## Example Documentation for Each Controller Method
TO get a feel for how you'd document each of your controller methods, here are some examples of how you might document each of the operations for a simple API controller, this controller is from the [Creating your own api](./create-your-own-api.md) article:
### GetAllItems
```csharp
[HttpGet]
[ProducesResponseType<PagedViewModel<MyItem>>(StatusCodes.Status200OK)]
public IActionResult GetAllItems(int skip = 0, int take = 10)
```
### GetItem

```csharp
[HttpGet("{id:guid}")]
[ProducesResponseType<MyItem>(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult GetItem(Guid id)
```
### CreateItem

```csharp
[HttpPost]
[ProducesResponseType(StatusCodes.Status201Created)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
public IActionResult CreateItem(string value)
```
### UpdateItem

```csharp
[HttpPut("{id:guid}")]
[ProducesResponseType(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult UpdateItem(Guid id, string value)
```
### DeleteItem

```csharp
[HttpDelete("{id:guid}")]
[ProducesResponseType(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult DeleteItem(Guid id)
```
## Verifying the changes
Run your application and navigate to the Swagger UI (typically found at /swagger).
Verify that your API documentation is correctly displaying the routes, parameters, and response types.
