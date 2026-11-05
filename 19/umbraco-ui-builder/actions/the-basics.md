---
description: Configuring actions in Umbraco UI Builder.
---

# The Basics

Actions allow you to add custom functionality to Umbraco UI Builder without creating custom UI elements. By providing an action to run, Umbraco UI Builder can trigger actions from different UI locations.

## Defining an Action

To define an action, create a class that inherits from the base class `Action<>`. Override `ExecuteAsync` with the work the action performs.

The following action changes the email addresses of the selected people to lower case. The action uses a `Person` model with an `int` ID and an `Email` property.

{% code title="LowercaseEmailsAction.cs" %}
```csharp
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;
using MyProject.Models;
using Umbraco.UIBuilder.Configuration.Actions;
using Umbraco.UIBuilder.Persistence;

namespace MyProject.Actions;

public class LowercaseEmailsAction : Action<ActionResult>
{
    private readonly IRepositoryFactory _repositoryFactory;

    public LowercaseEmailsAction(IRepositoryFactory repositoryFactory)
        => _repositoryFactory = repositoryFactory;

    public override string Icon => "icon-edit";
    public override string Alias => "lowercaseEmails";
    public override string Name => "Lowercase Emails";
    public override bool ConfirmAction => true;

    public override bool IsVisible(ActionVisibilityContext ctx)
        => ctx.ActionType == ActionType.Bulk || ctx.ActionType == ActionType.Row;

    public override async Task<ActionResult> ExecuteAsync(string collectionAlias, object[] entityIds, CancellationToken cancellationToken = default)
    {
        Repository<Person, int> repository = _repositoryFactory.GetRepository<Person, int>(collectionAlias);

        foreach (object entityId in entityIds)
        {
            // Use System.Convert in full: "using System;" would make Action<> ambiguous
            var id = System.Convert.ToInt32(entityId, CultureInfo.InvariantCulture);
            var result = await repository.GetAsync(id, cancellationToken: cancellationToken);
            if (!result.Success || result.Model is null)
            {
                return new ActionResult(false, new ActionNotification("Person not found", $"No person has the ID {id}."));
            }

            Person person = result.Model;
            person.Email = person.Email.ToLowerInvariant();

            var saved = await repository.SaveAsync(person, cancellationToken: cancellationToken);
            if (!saved.Success)
            {
                return new ActionResult(false, new ActionNotification("Save failed", $"The person with the ID {id} could not be saved."));
            }
        }

        return new ActionResult(true);
    }
}
```
{% endcode %}

### Configuration Options

| Option | Description | Required |
| --- | --- | --- |
| `Name` | The name of the action. | Yes |
| `Alias` | A unique alias for the action. | Yes |
| `Icon` | An icon to display next to the action's name. | No |
| `ExecuteAsync` | The method that runs for the given list of entities. | Yes, or `Execute` |
| `Execute` | The synchronous version of `ExecuteAsync`. | Yes, or `ExecuteAsync` |
| `ConfirmAction` | Set whether a confirm dialog should display before performing this action. | No |
| `IsVisible` | Set where the action is displayed. Actions are hidden by default. For more information, see the [Action Visibility](action-visibility.md) article. | No |

The generic argument specifies the return type for the action. For more details, see the [Controlling the Action Result](the-basics.md#controlling-the-action-result) section below.

{% hint style="info" %}

You can use dependency injection to inject any services required for your specific task. It's recommended to inject `Lazy<YourService>` implementations of the required services to ensure they are resolved only when needed.

{% endhint %}

### Choosing Between `ExecuteAsync` and `Execute`

Umbraco UI Builder runs every action through `ExecuteAsync`. By default, `ExecuteAsync` calls `Execute`, so an action that only overrides `Execute` keeps working.

Override `ExecuteAsync` when the action awaits anything, such as a repository call, a database query, or an HTTP request. Override only one of the two methods:

* An action that overrides neither method throws a `NotImplementedException` when it runs.
* An action that only overrides `ExecuteAsync` throws a `NotImplementedException` when code calls `Execute` directly.

The method signatures are:

```cs
Task<TResult> ExecuteAsync(string collectionAlias, object[] entityIds, CancellationToken cancellationToken = default)
TResult Execute(string collectionAlias, object[] entityIds)
```

{% hint style="warning" %}

To change one of the inbuilt actions, such as `ExportEntityAction`, override `ExecuteAsync`. Umbraco UI Builder no longer calls an override of their synchronous `Execute` method. That method is obsolete and is scheduled for removal in Umbraco UI Builder 20.

{% endhint %}

## Controlling the Action Result

By default, actions return an `ActionResult`, but you can return other types by changing the `Action<>` generic argument.

* **`ActionResult`** - Standard result with a boolean `Success` value and an optional `ActionNotification` to show to the user.
* **`FileActionResult`** - Returns a file stream or bytes and triggers a download dialog.

## Capturing Settings for an Action

Sometimes, you need to collect user input before performing an action. You can achieve this by using the `Action<>` base class with an additional `TSettings` generic argument.

The following action sends the selected people's details to an email address that the user enters. The action uses Umbraco's `IEmailSender` service.

{% code title="SendPeopleAction.cs" %}
```csharp
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Umbraco.Cms.Core.Mail;
using Umbraco.Cms.Core.Models.Email;
using Umbraco.UIBuilder.Configuration.Actions;
using Umbraco.UIBuilder.Configuration.Builders;

namespace MyProject.Actions;

public class SendPeopleAction : Action<SendPeopleSettings, ActionResult>
{
    private readonly IEmailSender _emailSender;

    public SendPeopleAction(IEmailSender emailSender)
        => _emailSender = emailSender;

    public override string Icon => "icon-message";
    public override string Alias => "sendPeople";
    public override string Name => "Send People";
    public override bool ConfirmAction => true;

    public override bool IsVisible(ActionVisibilityContext ctx)
        => ctx.ActionType == ActionType.Bulk;

    public override void Configure(SettingsConfigBuilder<SendPeopleSettings> settingsConfig)
    {
        settingsConfig.AddFieldset("General", fieldsetConfig => fieldsetConfig
            .AddField(s => s.RecipientName).SetLabel("Recipient Name")
            .AddField(s => s.RecipientEmail).SetLabel("Recipient Email"));
    }

    public override async Task<ActionResult> ExecuteAsync(string collectionAlias, object[] entityIds, SendPeopleSettings? settings, CancellationToken cancellationToken = default)
    {
        if (settings is null || string.IsNullOrWhiteSpace(settings.RecipientEmail))
        {
            return new ActionResult(false, new ActionNotification("No recipient", "Enter an email address to send to."));
        }

        var body = new StringBuilder($"Hello {settings.RecipientName},\n\nThe selected people have these IDs:\n");
        foreach (object entityId in entityIds)
        {
            body.AppendLine(entityId.ToString());
        }

        var message = new EmailMessage(null, settings.RecipientEmail, "Selected people", body.ToString(), false);
        await _emailSender.SendAsync(message, "UIBuilderSendPeople");

        return new ActionResult(true);
    }
}

public class SendPeopleSettings
{
    public string RecipientName { get; set; } = string.Empty;

    public string RecipientEmail { get; set; } = string.Empty;
}
```
{% endcode %}

By implementing this base class, you must also implement the `Configure` method which accepts a `SettingsConfigBuilder<>` parameter. Use this builder to define the settings dialog UI and how it maps to the settings type. You can create fieldsets and fields with the same fluent API as in the [Collection Editors](../collections/editors.md#adding-a-fieldset-to-a-tab) section.

Additionally, the `ExecuteAsync` and `Execute` methods accept an extra `settings` parameter. Umbraco UI Builder pre-populates the parameter with the user-entered values. You can adjust the action's behavior based on this data.

The method signatures are:

```cs
Task<TResult> ExecuteAsync(string collectionAlias, object[] entityIds, TSettings? settings, CancellationToken cancellationToken = default)
TResult Execute(string collectionAlias, object[] entityIds, TSettings? settings)
```

## Adding an Action to a Collection

Actions are added via the [Collections](../collections/overview.md) settings.

### Using the `AddAction<TMenuActionType>()` Method

Adds an action of the specified type to the collection.

#### Method Syntax

```cs
AddAction<TMenuActionType>() : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.AddAction<ExportMenuAction>();
```

#### Using the `AddAction(Type actionType)` Method

Adds an action of the specified type to the collection.

#### Method Syntax

```cs
AddAction(Type actionType) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.AddAction(actionType);
```

#### Using the `AddAction(IAction action)` Method

Adds the given action to the collection.

#### Method Syntax

```cs
AddAction(IAction action) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.AddAction(action);
```
