---
description: Configuring actions in Umbraco UI Builder.
---

# The Basics

Actions allow you to add custom functionality to Umbraco UI Builder without creating custom UI elements. By providing an action to run, Umbraco UI Builder can trigger actions from different UI locations.

## Defining an Action

To define an action, create a class that inherits from the base class `Action<>` and configure it as shown below:

```csharp
// Example
public class MyAction : Action<ActionResult>
{
    public override string Icon => "icon-settings";
    public override string Alias => "myaction";
    public override string Name => "My Action";
    public override bool ConfirmAction => true;

    public override ActionResult Execute(string collectionAlias, object[] entityIds)
    {
        // Perform operation here...
    }
}
```

### Configuration Options

|     Option    |                                 Description                                | Required |
| :-----------: | :------------------------------------------------------------------------: | -------- |
|      Name     |                           The name of the action.                          | Yes      |
|     Alias     |                       A unique alias for the action.                       | Yes      |
|      Icon     |                An icon to display next to the action’s name.               | Yes      |
|    Execute    |            The method that runs for the given list of entities.            | Yes      |
| ConfirmAction | Set whether a confirm dialog should display before performing this action. | No       |

The generic argument specifies the return type for the action. For more details, see the [Controlling the Action Result](the-basics.md#controlling-the-action-result) section below.

\{% hint style="info" %\} You can use dependency injection to inject any services required for your specific task. It's recommended to inject `Lazy<YourService>` implementations of the required services to ensure they are resolved only when needed. \{% endhint %\}

## Controlling the Action Result

By default, actions return an `ActionResult`, but you can return other types by changing the `Action<>` generic argument.

* **`ActionResult`** - Standard result with a boolean `Success` value.
* **`FileActionResult`** - Returns a file stream or bytes and triggers a download dialog.

## Capturing Settings for an Action

Sometimes, you need to collect user input before performing an action. You can achieve this by using the `Action<>` base class with an additional `TSetting` generic argument.

```csharp
// Example
public class MyAction : Action<MyActionSettings, ActionResult>
{
    public override string Icon => "icon-settings";
    public override string Alias => "myaction";
    public override string Name => "My Action";
    public override bool ConfirmAction => true;

    public override void Configure(SettingsConfigBuilder<MyActionSettings> settingsConfig)
    {
        settingsConfig.AddFieldset("General", fieldsetConfig => fieldsetConfig
            .AddField(s => s.RecipientName).SetLabel("Recipient Name")
            .AddField(s => s.RecipientEmail).SetLabel("Recipient Email"));
    }

    public override ActionResult Execute(string collectionAlias, object[] entityIds, MyActionSettings settings)
    {
        // Perform operation here...
    }
}

public class MyActionSettings
{
    public string RecipientName { get; set; }
    public string RecipientEmail { get; set; }
}
```

By implementing this base class, you must also implement the `Configure` method which accepts a `SettingsConfigBuilder<>` parameter. Use this builder to define the settings dialog UI and how it maps to the settings type. You can create fieldsets and fields with the same fluent API as in the [Collection Editors](../collections/editors.md#adding-a-fieldset-to-a-tab) section.

Additionally, the `Execute` method now accepts an extra `settings` parameter, which Umbraco UI Builder will pre-populate with the user-entered values. You can adjust the action's behavior based on this data.

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
