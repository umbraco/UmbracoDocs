## Introduction

Version 17 introduces the single block property editor. Its purpose is to replace the "single mode" option that exists in the blocklist property editor. This is part of the more general effort to ensure type consistency within core property editors.

## Included migration
Version 17 ships with a migration to: 
- Update all block list Data Types that have been properly configured in "single" mode.
- Update all (nested) property data that uses this Data Type.

This migration will not be enabled until at least version 18.

## Pre running the migration

You can run the migration at any time by using your own migration plan, as shown in the example below. If you run this migration yourself, the default Umbraco migration won't update any data. It only changes data in the old format.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Migrations;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Migrations;
using Umbraco.Cms.Infrastructure.Migrations.Upgrade;
using Umbraco.Cms.Infrastructure.Migrations.Upgrade.V_18_0_0;

namespace SingleBlockMigrationRunner;

public class TestMigrationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationAsyncHandler<UmbracoApplicationStartingNotification, RunTestMigration>();
    }
}

public class RunTestMigration : INotificationAsyncHandler<UmbracoApplicationStartingNotification>
{
    private readonly IMigrationPlanExecutor _migrationPlanExecutor;
    private readonly ICoreScopeProvider _coreScopeProvider;
    private readonly IKeyValueService _keyValueService;
    private readonly IRuntimeState _runtimeState;

    public RunTestMigration(
        ICoreScopeProvider coreScopeProvider,
        IMigrationPlanExecutor migrationPlanExecutor,
        IKeyValueService keyValueService,
        IRuntimeState runtimeState)
    {
        _migrationPlanExecutor = migrationPlanExecutor;
        _coreScopeProvider = coreScopeProvider;
        _keyValueService = keyValueService;
        _runtimeState = runtimeState;
    }

    public async Task HandleAsync(UmbracoApplicationStartingNotification notification, CancellationToken cancellationToken)
    {
        if (_runtimeState.Level < RuntimeLevel.Run)
        {
            return;
        }

        // One-off migration plan
        var migrationPlan = new MigrationPlan("Single Block Migration");

        // define the step
        migrationPlan.From(string.Empty)
            .To<MigrateSingleBlockList>("test-run-singleBlock-migration");

        // Go and upgrade our site (Will check if it needs to do the work or not)
        // Based on the current/latest step
        var upgrader = new Upgrader(migrationPlan);
        await upgrader.ExecuteAsync(
            _migrationPlanExecutor,
            _coreScopeProvider,
            _keyValueService);
    }
}

```

## Extending the migration
If you have a non core propertyEditor that allows nesting content within it and stores that content within it's own value, then you will need to extend the migration. To do this you will need create and register a class that implements `ITypedSingleBlockListProcessor` and register it. You can see how we register the build in types at `Umbraco.Cms.Infrastructure.Migrations.Upgrade.V_18_0_0.SingleBlockList.MigrateSingleBlockListComposer`. The interface needs the following properties and methods:
- `IEnumerable<string> PropertyEditorAliases`: The alias of the property editor as defined on its DataEditor attribute. Since a processor can support multiple editors if they use the same model, it takes an IEnumerable over a single string. These alias are used to limit the amount of data fetched from the database.
- `Type PropertyEditorValueType`: The type of the value the propertyEditor would return when `valueEditor.ToEditor()` would be called.
- `Func<object?, Func<object?, bool>, Func<BlockListValue,object>, bool> Process` The function to run when the main processor detects a value that matches your processor. The function needs to suport the following parameters
    - `object?`: The value being passed in from the outer caller or the top level processor
    - `Func<object?, bool>` The function the processor needs to call when it detects nested content. This is passed in from the top level processor.
    - `Func<BlockListValue, object>` The function that needs to be called when the outer layer of the current value is a blockList that needs to be converted to singleblock. This should only ever be called from the core processors. It is passed around to make recursion just the little bit easier.