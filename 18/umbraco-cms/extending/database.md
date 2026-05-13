---
description: A guide to creating a custom Database table in Umbraco
---

# Creating a Custom Database Table

Umbraco ships with [NPoco](https://github.com/schotime/NPoco), which enables mapping the results of database queries to Common Language Runtime (CLR) objects. NPoco allows custom database tables to be added to your site to store additional data that should not be stored as normal content nodes.

The end result looks like this:

![Database result of a migration](<../.gitbook/assets/db-table (1).png>)

## Using a Composer and Component

The following code sample shows how this is done using a composer and component.

When migrating from version 8 there are a few changes to be aware of. The first change is that namespace updates are dependencies that need to be passed to the `Upgrader.Execute()` method. Another is a change to the access modifier of the `Migrate()` method.

```csharp
using Microsoft.Extensions.Logging;
using NPoco;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Migrations;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Migrations;
using Umbraco.Cms.Infrastructure.Migrations.Upgrade;
using Umbraco.Cms.Infrastructure.Persistence.DatabaseAnnotations;

namespace MyNamespace;

public class BlogCommentsComposer : ComponentComposer<BlogCommentsComponent>
{
}

public class BlogCommentsComponent : IComponent
{
    private readonly ICoreScopeProvider _coreScopeProvider;
    private readonly IMigrationPlanExecutor _migrationPlanExecutor;
    private readonly IKeyValueService _keyValueService;
    private readonly IRuntimeState _runtimeState;

    public BlogCommentsComponent(
        ICoreScopeProvider coreScopeProvider,
        IMigrationPlanExecutor migrationPlanExecutor,
        IKeyValueService keyValueService,
        IRuntimeState runtimeState)
    {
        _coreScopeProvider = coreScopeProvider;
        _migrationPlanExecutor = migrationPlanExecutor;
        _keyValueService = keyValueService;
        _runtimeState = runtimeState;
    }

    public void Initialize()
    {
        if (_runtimeState.Level < RuntimeLevel.Run)
        {
            return;
        }

        // Create a migration plan for a specific project/feature
        // We can then track that latest migration state/step for this project/feature
        var migrationPlan = new MigrationPlan("BlogComments");

        // This is the steps we need to take
        // Each step in the migration adds a unique value
        migrationPlan.From(string.Empty)
            .To<AddCommentsTable>("blogcomments-db");

        // Go and upgrade our site (Will check if it needs to do the work or not)
        // Based on the current/latest step
        var upgrader = new Upgrader(migrationPlan);
        upgrader.Execute(_migrationPlanExecutor, _coreScopeProvider, _keyValueService);
    }

    public void Terminate()
    {
    }
}

public class AddCommentsTable : MigrationBase
{
    public AddCommentsTable(IMigrationContext context) : base(context)
    {
    }
    protected override void Migrate()
    {
        Logger.LogDebug("Running migration {MigrationStep}", "AddCommentsTable");

        // Lots of methods available in the MigrationBase class - discover with this.
        if (TableExists("BlogComments") == false)
        {
            Create.Table<BlogCommentSchema>().Do();
        }
        else
        {
            Logger.LogDebug("The database table {DbTable} already exists, skipping", "BlogComments");
        }
    }

    [TableName("BlogComments")]
    [PrimaryKey("Id", AutoIncrement = true)]
    [ExplicitColumns]
    public class BlogCommentSchema
    {
        [PrimaryKeyColumn(AutoIncrement = true, IdentitySeed = 1)]
        [Column("Id")]
        public int Id { get; set; }

        [Column("BlogPostUmbracoId")]
        public int BlogPostUmbracoId { get; set; }

        [Column("Name")]
        public required string Name { get; set; }

        [Column("Email")]
        public required string Email { get; set; }

        [Column("Website")]
        public required string Website { get; set; }

        [Column("Message")]
        [SpecialDbType(SpecialDbTypes.NVARCHARMAX)]
        public string Message { get; set; }
    }
}
```

## Using a Notification Handler

If building a new solution, you can adopt a new pattern. With this pattern you create and run a similar migration but trigger it in response to a [notification handler](../fundamentals/code/subscribing-to-notifications.md).

The code for this approach is as follows:

```csharp
using Microsoft.Extensions.Logging;
using NPoco;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Migrations;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Migrations;
using Umbraco.Cms.Infrastructure.Migrations.Upgrade;
using Umbraco.Cms.Infrastructure.Persistence.DatabaseAnnotations;

namespace MyNamespace;

public class RunBlogCommentsMigration : INotificationHandler<UmbracoApplicationStartingNotification>
{
    private readonly IMigrationPlanExecutor _migrationPlanExecutor;
    private readonly ICoreScopeProvider _coreScopeProvider;
    private readonly IKeyValueService _keyValueService;
    private readonly IRuntimeState _runtimeState;

    public RunBlogCommentsMigration(
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

    public void Handle(UmbracoApplicationStartingNotification notification)
    {
        if (_runtimeState.Level < RuntimeLevel.Run)
        {
            return;
        }

        // Create a migration plan for a specific project/feature
        // We can then track that latest migration state/step for this project/feature
        var migrationPlan = new MigrationPlan("BlogComments");

        // This is the steps we need to take
        // Each step in the migration adds a unique value
        migrationPlan.From(string.Empty)
            .To<AddCommentsTable>("blogcomments-db");

        // Go and upgrade our site (Will check if it needs to do the work or not)
        // Based on the current/latest step
        var upgrader = new Upgrader(migrationPlan);
        upgrader.Execute(
            _migrationPlanExecutor,
            _coreScopeProvider,
            _keyValueService);
    }
}

// Migration and schema defined as in the previous code sample.
```

The notification handler can be registered in a composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace TableMigrationTest;

public class BlogCommentsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<UmbracoApplicationStartingNotification, RunBlogCommentsMigration>();
    }
}
```

## Which to use?

In short, it's up to you. If you are migrating from version 8 and want the quickest route to getting running with the latest version, then using a component makes sense.

You will be using the notification pattern elsewhere. This could be when responding to Umbraco events that run many times in the lifetime of the application, like when content is saved. And so you may also prefer to align with that pattern for start-up events.

It is also worth noting that components offer both `Initialize` and `Terminate` methods. With these you will need to handle two notifications to do the same with the notification handler approach (`UmbracoApplicationStartingNotification` and `UmbracoApplicationStoppingNotification`). A single handler class can be used for both notifications though.

## Schema Class and Migrations

**Important!** The `BlogCommentSchema` class nested inside the migration is purely used as a database schema representation class. It should not be used as a Data Transfer Object (DTO) to access the table data. Equally, you shouldn't use your DTO classes to define the schema used by your migration. Instead, you should create a duplicate snapshot for the purpose of creating or working with your database tables in the current migration. The name of the class is not important as you will be overriding it using the TableName attribute. You should choose a name that makes it clear that this class is purely for defining the schema in this migration.

Whilst this adds a level of duplication, it is important that migrations and the code/classes within a migration remain immutable. If the DTO was to be used for both, it could cause unexpected behaviour. Should you later modify your DTO used in your application but you have previous migrations expecting the DTO to be in its unmodified state.

Once a snapshot has been created, and once your code has been deployed, the snapshot should never be changed directly. Instead, you should use further migrations to alter the database table into the state you require. This ensures that migrations can be run in sequence and that each migration can expect the database to be in a known state before executing.

When adding further migrations and if you need to reuse the schema class, it is a good idea to duplicate this in those particular migrations. You want the migrations to be immutable. Having separate classes in separate namespaces, reduces the risk of modifying a schema class from your initial migration.

## Data stored in Custom Database Tables

When storing data in custom database tables, this is by default not manageable by Umbraco at all. This can be great for many purposes such as storing massive amounts of data that you do not need to edit from the backoffice. Decoupling part of your data from being managed by Umbraco as content can be a way of achieving better performance for your site. It will no longer take up space in indexes and caches, and the Umbraco database.

This also means that if you do need to edit or display this data, you need to implement the underlying functionality to support this. The same if the case if you need this data to be transferred or kept synchronized between multiple sites or environments. Data stored in custom tables are not supported by default by add-ons such as Umbraco Deploy and will not be deployable by default.

Figuring out how to manage data across multiple environments can be different between individual sites and there is not one solution that fits all. Some sites may have automated database synchronization set up to ensure specific tables in multiple databases are always kept in sync. Other sites may be better off with scripts moving data around manually on demand.

## Working with data in Custom Database Tables

To create, read, update or delete data from your custom database tables, you can use the `IScopeProvider` to get access to the database operations.

The following example creates a `Controller` that uses `[Route]` annotations to create API endpoints for fetching and inserting blog comments.

{% hint style="info" %}
This example does not use the aforementioned `BlogCommentSchema` class but rather a separate (yet duplicate) class that is not part of the example. Also, be aware that things like error handling and data validation have been omitted for brevity.
{% endhint %}

```csharp
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Umbraco.Cms.Infrastructure.Scoping;

namespace MyNamespace;

[ApiController]
[Route("/umbraco/api/blogcomments")]
public class BlogCommentsApiController : Controller
{
    private readonly IScopeProvider _scopeProvider;
    public BlogCommentsApiController(IScopeProvider scopeProvider)
    {
        _scopeProvider = scopeProvider;
    }

    [HttpGet("getcomments")]
    public IEnumerable<BlogComment> GetComments(int umbracoNodeId)
    {
        using var scope = _scopeProvider.CreateScope();
        var queryResults = scope.Database.Fetch<BlogComment>("SELECT * FROM BlogComments WHERE BlogPostUmbracoId = @0", umbracoNodeId);
        scope.Complete();
        return queryResults;
    }

    [HttpPost("insertcomment")]
    public void InsertComment(BlogComment comment)
    {
        using var scope = _scopeProvider.CreateScope();
        scope.Database.Insert<BlogComment>(comment);
        scope.Complete();
    }
}
```
