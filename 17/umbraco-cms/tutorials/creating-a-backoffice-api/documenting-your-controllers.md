# Documenting your controllers

Documenting your API controllers using OpenAPI simplifies the creation of detailed and interactive API documentation. Adding the appropriate attributes automatically generates comprehensive information about routes, parameters, and response types. This will enhance the developer experience and ensure clarity and consistency in your API documentation.

## ApiExplorerSettings

With the `ApiExplorerSettings` attribute, we can put all our endpoints into a given group. This is a nice way of organizing our endpoints in the Swagger UI.

{% code title="MyItemApiController.cs" %}
```csharp
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : ManagementApiControllerBase
```
{% endcode %}

## ProducesResponseType Attribute

Use \[ProducesResponseType] to specify the possible responses for each action method. This helps OpenAPI generate accurate documentation for your API.\
For example, in the GetItem method:

{% code title="MyItemApiController.cs" %}
```csharp
[HttpGet("{id:guid}")]
[ProducesResponseType<MyItem>(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult GetItem(Guid id)
{
// Method implementation
}
```
{% endcode %}

Here, `[ProducesResponseType]` specifies that a 200 OK response will return a MyItem, and a 404 Not Found response will return a ProblemDetails.

## Example Documentation for Each Controller Method

To get an idea of how to document each controller method, below are some examples of how to document each operation for an API controller.\
The controller is from the [Creating your own API article](./)

### GetAllItems

{% code title="MyItemApiController.cs" %}
```csharp

[HttpGet]
[ProducesResponseType<PagedViewModel<MyItem>>(StatusCodes.Status200OK)]
public IActionResult GetAllItems(int skip = 0, int take = 10)
```
{% endcode %}

### GetItem

{% code title="MyItemApiController.cs" %}
```csharp
[HttpGet("{id:guid}")]
[ProducesResponseType<MyItem>(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult GetItem(Guid id)
```
{% endcode %}

### CreateItem

{% code title="MyItemApiController.cs" %}
```csharp
[HttpPost]
[ProducesResponseType(StatusCodes.Status201Created)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
public IActionResult CreateItem(string value)
```
{% endcode %}

### UpdateItem

{% code title="MyItemApiController.cs" %}
```csharp
[HttpPut("{id:guid}")]
[ProducesResponseType(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult UpdateItem(Guid id, string value)
```
{% endcode %}

### DeleteItem

{% code title="MyItemApiController.cs" %}
```csharp
[HttpDelete("{id:guid}")]
[ProducesResponseType(StatusCodes.Status200OK)]
[ProducesResponseType<ProblemDetails>(StatusCodes.Status404NotFound)]
public IActionResult DeleteItem(Guid id)
```
{% endcode %}

## Verifying the changes

Run your application and navigate to the OpenAPI UI at `{yourdomain}/umbraco/openapi`.\
Verify that your API documentation is correctly displaying the routes, parameters, and response types.
