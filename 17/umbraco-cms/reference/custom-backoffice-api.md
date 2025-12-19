---
description: Example of a Custom Backoffice API with Authorization and OpenAPI
---

# Custom Backoffice API

This article covers how to create a Custom API controller protected by the backoffice authorization policies. It also shows how to enable the authorization UI in Swagger UI.

{% hint style="info" %}
Before proceeding, make sure to read the [Management API](management-api/) article. It provides information about the OpenAPI documentation and Authorization used in this article.
{% endhint %}

This example can be a starting point for creating a secure custom API with automatic OpenAPI documentation. You can find other examples in the [API versioning and OpenAPI](api-versioning-and-openapi.md) article.

1. Add the following code to `Program.cs` so that the new API shows in the OpenAPI documentation and Swagger UI:

{% code title="Program.cs" lineNumbers="true" %}
```csharp
builder.Services.AddOpenApi("my-api-v1", options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        document.Info.Title = "My API v1";
        document.Info.Version = "1.0";
        return Task.CompletedTask;
    });

    // Add backoffice security requirements to enable authorization in Swagger UI
    options.AddBackofficeSecurityRequirements();
});
```
{% endcode %}

The `AddBackofficeSecurityRequirements()` extension method adds the OAuth2 security scheme and marks our API as supporting authorization via Swagger UI.

{% hint style="info" %}
For more modular configurations, you can use `IConfigureNamedOptions<OpenApiOptions>` with a composer instead of configuring in Program.cs. See the [API versioning and OpenAPI](api-versioning-and-openapi.md) article for details on different configuration approaches.
{% endhint %}

2. Create a new `.cs` file called `MyApiController` and add the ApiController to setup the logic behind the endpoint:

{% code title="MyApiController.cs" lineNumbers="true" %}
```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Common.Attributes;
using Umbraco.Cms.Api.Common.Filters;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.Membership;
using Umbraco.Cms.Core.Security;
using Umbraco.Cms.Web.Common.Authorization;

namespace Umbraco.Cms.Web.UI.Custom;

[ApiController]
[ApiVersion("1.0")]
[MapToApi("my-api-v1")]
[Authorize(Policy = AuthorizationPolicies.BackOfficeAccess)]
[JsonOptionsName(Constants.JsonOptionsNames.BackOffice)]
[Route("api/v{version:apiVersion}/my")]
public class MyApiController : Controller
{
    private readonly IBackOfficeSecurityAccessor _backOfficeSecurityAccessor;

    public MyApiController(IBackOfficeSecurityAccessor backOfficeSecurityAccessor)
        => _backOfficeSecurityAccessor = backOfficeSecurityAccessor;

    [HttpGet("say-hello")]
    [MapToApiVersion("1.0")]
    [ProducesResponseType(typeof(string), StatusCodes.Status200OK)]
    public IActionResult SayHello()
    {
        IUser currentUser = _backOfficeSecurityAccessor.BackOfficeSecurity?.CurrentUser
                            ?? throw new InvalidOperationException("No backoffice user found");
        return Ok($"Hello, {currentUser.Name}");
    }
}
```
{% endcode %}

3. Run the project and navigate to `{yourdomain}/umbraco/swagger`.
4. Choose the OpenAPI document we created with the code above named **My API v1** from **Select a definition**.

![Created Custom API in OpenAPI documentation](../.gitbook/assets/custom-api-swagger-example.png)

Here, we can find the endpoint that we created:

```http
GET /api/v1/my/say-hello
```

5. Click on the **Authorize** button to authenticate.
6. Try out the endpoint using the **Try it out** button.
7. Click on **Execute**.

![Trying out the endpoint](../.gitbook/assets/custom-api-swagger-example-response.png)

We now get the response we have setup using the code: `"Hello, {{userName}}"`.
