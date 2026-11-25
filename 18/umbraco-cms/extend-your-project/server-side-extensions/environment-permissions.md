---
description: >-
  Deny specific changes through the Management API for every user of the installation, and protect your own API endpoints the same way.
---

# Environment Permissions

Environment permissions let you deny specific changes for every user, across the whole installation. For example, you can stop anyone from creating or updating Document Types on a production environment where the schema arrives with a deployment.

{% hint style="info" %}
Environment permissions are available from Umbraco 18.4.
{% endhint %}

Umbraco includes permissions for changes to its own schema. Your own code can deny these, and it can define permissions of its own for its own API endpoints.

{% hint style="info" %}
Environment permissions are enforced by the Management API. Backoffice support is coming later. Until then, the backoffice still offers actions that are denied, and shows an error when the API rejects them.
{% endhint %}

## How environment permissions work

* **Permissions** are identified by verbs. A verb is a string. For example, `Umb.DocumentType.Update` is the permission to update a Document Type. Umbraco defines [permissions for its own schema](#umbracos-permission-verbs), and your code can define its own.
* **Configurators** deny permissions. Everything is permitted until a configurator denies it. A denial can't be lifted by another configurator.
* **The Management API** rejects a request that needs a denied permission with a `403 Forbidden` response. The response has an `Umb-Denied-Permission` header naming the denied verb.

Environment permissions are built once, at startup. A setting a configurator reads is evaluated at that point, and changing it requires a restart.

Only changes made through the Management API are governed:

* Reading is never denied.
* Services, migrations, and package installs are not affected. Code that uses `IContentTypeService` or other services keeps working while the same changes are denied through the Management API.

## Denying permissions

To deny permission verbs, create a class that implements `IEnvironmentPermissionsConfigurator`. Configurators are resolved from dependency injection, so they can depend on settings or other services.

The following configurator locks the schema when the site runs in the `Production` [runtime mode](../../run-in-production/runtime-modes.md). It denies creating, updating, and deleting Data Types, Document Types, Media Types, and Member Types.

{% code title="LockSchemaInProductionConfigurator.cs" %}
```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.Permissions;

namespace MyProject.Permissions;

public class LockSchemaInProductionConfigurator : IEnvironmentPermissionsConfigurator
{
    private readonly IOptions<RuntimeSettings> _runtimeSettings;

    public LockSchemaInProductionConfigurator(IOptions<RuntimeSettings> runtimeSettings)
        => _runtimeSettings = runtimeSettings;

    public void Configure(IEnvironmentPermissionsBuilder builder)
    {
        if (_runtimeSettings.Value.Mode != RuntimeMode.Production)
        {
            return;
        }

        builder.Deny(
            "Umb.DataType.Create",
            "Umb.DataType.Update",
            "Umb.DataType.Delete",
            "Umb.DocumentType.Create",
            "Umb.DocumentType.Update",
            "Umb.DocumentType.Delete",
            "Umb.MediaType.Create",
            "Umb.MediaType.Update",
            "Umb.MediaType.Delete",
            "Umb.MemberType.Create",
            "Umb.MemberType.Update",
            "Umb.MemberType.Delete");
    }
}
```
{% endcode %}

Register the configurator in a composer:

{% code title="LockSchemaInProductionComposer.cs" %}
```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MyProject.Permissions;

public class LockSchemaInProductionComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.EnvironmentPermissionsConfigurators().Add<LockSchemaInProductionConfigurator>();
}
```
{% endcode %}

With the configurator registered, updating a Document Type in production returns `403 Forbidden` with the header `Umb-Denied-Permission: Umb.DocumentType.Update`.

Configurators are a collection, so a site and its installed packages can each register their own.

## Checking denied permissions

Inject `IEnvironmentPermissions` to check whether a permission verb is denied. For example, to skip a feature that would make a denied change.

{% code title="SchemaImportService.cs" %}
```csharp
using Umbraco.Cms.Core.Permissions;

namespace MyProject.Services;

public class SchemaImportService
{
    private readonly IEnvironmentPermissions _environmentPermissions;

    public SchemaImportService(IEnvironmentPermissions environmentPermissions)
        => _environmentPermissions = environmentPermissions;

    public bool CanCreateDocumentTypes()
        => _environmentPermissions.IsDenied("Umb.DocumentType.Create") is false;
}
```
{% endcode %}

The `DeniedPermissions` property lists every denied verb. Any other verb is permitted.

## Protecting your own API endpoints

Your own Management API controllers can use environment permissions the same way Umbraco's controllers do. An endpoint can make a change that Umbraco already has a permission for, such as creating a Document Type. Use Umbraco's verb for that change, so the same denial applies. For other changes, use verbs of your own.

Declaring a verb on an endpoint doesn't deny anything. A configurator decides what is denied.

### Protecting a controller

Add the `RequiresPermissionsFor` attribute to a controller, or to a controller base class. Every action in the controller is then covered. The attribute takes a resource name and builds the verb as `{Resource}.{Operation}`. The operation is inferred from the HTTP method of the action:

| HTTP method | Operation |
| --- | --- |
| `GET`, `HEAD`, `OPTIONS` | None. The action is never denied. |
| `POST` | `Create` |
| `DELETE` | `Delete` |
| `PUT`, `PATCH`, and any other method | `Update` |

The following example adds the attribute to the controller from the [Creating a Backoffice API](../tutorials/creating-a-backoffice-api/README.md) tutorial:

{% code title="MyItemApiController.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Management.Controllers;
using Umbraco.Cms.Api.Management.Permissions;
using Umbraco.Cms.Api.Management.Routing;

namespace MyProject.Controllers;

[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
[RequiresPermissionsFor("MyProject.Item")]
public class MyItemApiController : ManagementApiControllerBase
{
}
```
{% endcode %}

A `POST` action in the controller now requires `MyProject.Item.Create`, and a `PUT` action requires `MyProject.Item.Update`. A configurator that denies `MyProject.Item.Create` blocks every `POST` action in the controller that doesn't declare its own verbs.

An attribute on a derived controller replaces the one inherited from its base class.

### Protecting a single action

Add the `RequiresPermissions` attribute to an action to declare exactly the verbs it requires. Use it to protect a single action, without `RequiresPermissionsFor` on the controller. Also use it when the HTTP method doesn't describe the change an action makes. On a controller with `RequiresPermissionsFor`, the listed verbs replace the inferred verb.

{% code title="MyItemApiController.cs" %}
```csharp
// A POST action that only reads data is never denied.
[HttpPost("search")]
[RequiresPermissions([])]
public IActionResult Search(string query)
{
    // Search the items.
    return Ok();
}

// An action that makes more than one change is denied if any of the verbs is denied.
[HttpPut("{id:guid}/save-and-publish")]
[RequiresPermissions(["MyProject.Item.Update", "MyProject.Item.Publish"])]
public IActionResult SaveAndPublish(Guid id)
{
    // Save and publish the item.
    return Ok();
}
```
{% endcode %}

Verbs in attributes must be constants. Define your own verbs as constant fields to reuse them in attributes and configurators.

### OpenAPI documentation

Endpoints protected with `RequiresPermissionsFor` or `RequiresPermissions` have the `Umb-Denied-Permission` header documented on their `403` response. Actions that are never denied, such as `GET` actions, are left out. The `403` response is added when the endpoint doesn't document one already. This applies to OpenAPI documents that use the backoffice security requirements, as described in [Custom Backoffice API](custom-backoffice-api.md).

## Templates and partial views in production

Umbraco includes a configurator that applies in the `Production` [runtime mode](../../run-in-production/runtime-modes.md). Template and partial view files arrive with the deployment and aren't written to disk in that mode. The configurator denies:

* `Umb.Template.Create`
* `Umb.Template.Update`
* `Umb.PartialView.Create`
* `Umb.PartialView.Update`
* `Umb.PartialView.Delete`

Deleting a template is still permitted. Deleting removes only the database record and leaves the file. A template removed from the code can then be cleaned up on the environments it was deployed to. A partial view is only its file, so deleting a partial view is denied.

## Umbraco's permission verbs

Umbraco's verbs cover its schema entity types: Data Types, Document Types, templates, and dictionary items, among others. The verbs are available as constants in `Constants.Permissions.Entities`.

The verbs follow the HTTP method mapping described in [Protecting a controller](#protecting-a-controller). They also cover folders, for the entity types that have them:

* **Create** covers creating an item or a folder, and copying an item.
* **Update** covers updating, moving, and renaming an item, and updating a folder.
* **Delete** covers deleting an item or a folder.
