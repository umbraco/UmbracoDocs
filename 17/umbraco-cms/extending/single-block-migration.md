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

If your non-core property editor nests content and stores it within its own value, you must extend the migration. To do this, create and register a class that implements `ITypedSingleBlockListProcessor` and register it. See how the built-in types are registered at `Umbraco.Cms.Infrastructure.Migrations.Upgrade.V_18_0_0.SingleBlockList.MigrateSingleBlockListComposer`. The interface needs the following properties and methods:
- `IEnumerable<string> PropertyEditorAliases`: The alias of the property editor as defined in its DataEditor attribute. Since a processor can support multiple editors if they use the same model, it takes an IEnumerable rather than a single string. These aliases are used to limit the amount of data fetched from the database.
- `Type PropertyEditorValueType`: The type of value the property editor would return when `valueEditor.ToEditor()` is called.
- `Func<object?, Func<object?, bool>, Func<BlockListValue, object>, bool> Process` The function to run when the main processor detects a value that matches your processor. The function must support the following parameters:
    - `object?`: The value passed in from the outer caller or the top-level processor.
    - `Func<object?, bool>` The function the processor calls when it detects nested content. This is passed in from the top-level processor.
    - `Func<BlockListValue, object>` The function called when the outer layer of the current value is a block list that needs to be converted to a single block. This should only be called from the core processors. It is passed around to make recursion a little easier.