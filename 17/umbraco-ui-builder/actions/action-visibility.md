---
description: Controlling the visibility of actions in Umbraco UI Builder.
---

# Action Visibility

By default, actions are hidden in the UI. You must define when and where an action should appear. This can be done either at the action definition level or when registering it in the collection config.

## Controlling Default Action Visibility

To define the default visibility of an action, override the `IsVisible` method of the `Action<>` base class.

```csharp
// Example
public class MyAction : Action<ActionResult>
{
    ...
    public override bool IsVisible(ActionVisibilityContext ctx)
    {
        return ctx.ActionType == ActionType.Bulk 
            || ctx.ActionType == ActionType.Row;
    }
    ...
}
```

The `IsVisible` method receives an `ActionVisibilityContext`. You can use this context to decide whether the action should be displayed. Return `true` to show it, or `false` to hide it. For more information, see the [Action visibility context](action-visibility.md#action-visibility-context) section below.

## Overriding Action Visibility

You can override an action's visibility in the [Collections](../collections/overview.md) settings.

### Using the `AddAction<TMenuActionType>()` Method

Adds an action of the given type to the collection with the specified visibility.

#### Method Syntax

```cs
AddAction<TMenuActionType>(Lambda actionConfig = null) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.AddAction<ExportMenuAction>(actionConfig => actionConfig
    .SetVisibility(x => x.ActionType == ActionType.Bulk 
        || x.ActionType == ActionType.Row)
);
```

### Using the `AddAction(Type actionType, Lambda actionConfig = null)` Method

Adds an action of the given type to the collection by specifying the action type dynamically using `Type` instead of a generic type.

#### Method Syntax

```cs
AddAction(Type actionType, Lambda actionConfig = null) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.AddAction(typeof(ExportMenuAction), actionConfig => actionConfig
    .SetVisibility(x => x.ActionType == ActionType.Bulk 
        || x.ActionType == ActionType.Row)
);
```

### Using the `AddAction(IAction action, Lambda actionConfig = null)` Method

Adds the already defined action instance to the collection with the specified visibility.

#### Method Syntax

```cs
AddAction(IAction action, Lambda actionConfig = null) : CollectionConfigBuilder<TEntityType>
```

#### Example

```csharp
collectionConfig.AddAction(action, actionConfig => actionConfig
    .SetVisibility(x => x.ActionType == ActionType.Bulk 
        || x.ActionType == ActionType.Row)
);
```

## Action Visibility Context

When controlling the visibility of an action, you will receive an `ActionVisibilityContext` object. This context allows you to decide whether to show the action. The context contains two key pieces of information for this decision.

### ActionType

The `ActionType` property is an enum property that defines which area of the UI wants to access the action. This property helps determine where the action is displayed.

#### ContainerMenu

The `ContainerMenu` action type displays the action in both the collection tree and its list view actions menu.

![Container Menu](../.gitbook/assets/container_actions_menu.png)

#### EntityMenu

The `EntityMenu` action type shows the action in the collection editor UI's actions menu.

![Entity Menu](../.gitbook/assets/entity_actions_menu.png)

#### Bulk

The `Bulk` action type displays the action in the collection list view bulk actions menu.

![Bulk Actions](../.gitbook/assets/bulk_actions_menu.png)

#### Row

The `Row` action type shows the action in the collection list view action row menu.

![Row Actions](../.gitbook/assets/row_actions_menu.png)

#### Save

The `Save` action type displays the action as a sub-button in the entity editor’s save button. All `Save` actions trigger a save before executing. Their labels are prefixed with `Save & [Action Name]`.

![Save Actions](../.gitbook/assets/save_actions_menu.png)

### UserGroups

The `UserGroups` collection contains a list of `IReadOnlyUserGroup` objects for the current logged-in backoffice user. This allows you to control action visibility for members of specific user groups.
