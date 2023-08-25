---
description: Configuring actions in Konstrukt, the back office UI builder for Umbraco.
---

# The Basics

Actions are a powerful way of adding custom functionality to Konstrukt without needing to create an custom UI elements. By providing an action to run Konstrukt can automatically trigger actions from a number of UI locations.

## Defining an action

To define an action you create a class that inherits from the base class `KonstruktAction<>` and configure it like so.

````csharp
// Example
public class MyAction : KonstruktAction<KonstruktActionResult>
{
    public override string Icon => "icon-settings";
    public override string Alias => "myaction";
    public override string Name => "My Action";
    public override bool ConfirmAction => true;

    public override KonstruktActionResult Execute(string collectionAlias, object[] entityIds)
    {
        // Perform operation here...
    }
}
````

The required configuration options are:

* **Name:** The name of the action.
* **Alias:** A unique alias for the action.
* **Icon:** An icon to display next to the name in the action button.
* **Execute:** The method to run against a given list of entities.

Additional optional configuration options are:

* **ConfirmAction:** Set whether a confirm dialog should display before performing this action.

The generic argument is a return type for the action. See [Controlling the action result](#controlling-the-action-result) below.

{% hint style="info" %}
You can use dependency injection to inject any services you require to perform your specific task. When injecting dependencies, it's always recomended that you inject `Lazy<YourService>` implementations of the required services to ensure they are only resolved when needed.
{% endhint %}

## Controlling the action result

Actions by default will return a `KonstruktActionResult` but you can return other types of result by swapping the `KonstruktAction<>` generic argument.

* **`KonstruktActionResult`** - Standard result with a simple boolean `Success` value.
* **`KonstruktFileActionResult`** - Returns a file stream / bytes and triggers a download dialog.

## Capturing settings for an action

Sometimes you may need to collect further user input before you can perform an action. To achieve this you can use the `KonstruktAction<>` base class that accepts an additional `TSetting` generic argument. 

````csharp
// Example
public class MyAction : KonstruktAction<MyBulkdActionSettings, KonstruktActionResult>
{
    public override string Icon => "icon-settings";
    public override string Alias => "myaction";
    public override string Name => "My Action";
    public override bool ConfirmAction => true;

    public override void Configure(KonstruktSettingsConfigBuilder<MyActionSettings> settingsConfig)
    {
        settingsConfig.AddFielset("General", fieldsetConfig => fieldsetConfig
            .AddField(s => s.RecipientName).SetLabel("Recipient Name")
            .AddField(s => s.ReceipientEmail).SetLabel("Recipient Email"))
    }

    public override KonstruktActionResult Execute(string collectionAlias, object[] entityIds, MyActionSettings settings)
    {
        // Perform operation here...
    }
}

public class MyActionSettings
{
    public string ReceipientName { get; set; }
    public string ReceipientEmail { get; set; }
}
````

By implementing this base class you are required to implement an additional `Configure` method which accepts a `KonstruktSettingsConfigBuilder<>` parameter. You should use this parameter calling the builders fluent API to define the settings dialog UI and how it maps to the settings type. With the settings config builder you are able to create fieldsets and fields with the same fluent API as defined in the [editor section](collection-editors.md#adding-a-fieldset-to-a-tab).

In addition to this `Configure` method, your `Execute` method will also now accept an additional `settings` parameter of the settings type which will be pre-populated by Konstrukt with the value entered by the user allowing you to alter your actions behaviour accordingly.

## Adding an action to a collection

Actions are added via the [collections](../collections/overview.md) configuration.

#### **AddAction&lt;TMenuActionType&gt;() : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds an action of the given type to the collection.

````csharp
// Example
collectionConfig.AddAction<ExportMenuAction>();
````

#### **AddAction(Type actionType) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds an action of the given type to the collection.

````csharp
// Example
collectionConfig.AddAction(actionType);
````

#### **AddAction(IKonstruktAction action) : KonstruktCollectionConfigBuilder&lt;TEntityType&gt;**

Adds the given action to the collection.

````csharp
// Example
collectionConfig.AddAction(action);
````
