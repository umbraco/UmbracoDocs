---
meta.Title: Umbraco Database
description: >-
  This tutorial will show you how to get started with creating custom database
  tables with the Entity Framework Core in Umbraco.
---

# Creating Custom Database Tables with Entity Framework

## Introduction

Custom database tables let you store additional data in the Umbraco database that you don't want to be stored as normal content nodes.

Use custom tables to store large datasets. They are ideal when you do not need to edit information from the backoffice.

Decoupling part of your data from being managed by Umbraco as content is a way to achieve better performance for your site. It will no longer take up space in indexes and caches, and the Umbraco database.

{% hint style="warning" %}
Be aware that storing data in custom database tables is by default not manageable by Umbraco.

This means that if you need to edit or display this data, you need to implement the underlying functionality to support this.

The case is the same if you need this data to be transferred or kept synchronized between multiple sites or environments.

Data stored in custom tables are not supported by default by add-ons such as Umbraco Deploy and will not be deployable by default.
{% endhint %}

## Prerequisite

* An Umbraco project with content.
* `Umbraco.Cms.Persistence.EFCore` NuGet package installed.
* If the code is created in a separate project (outside the main Umbraco project), that project must also reference:
  * `Microsoft.EntityFrameworkCore`
  * `Microsoft.EntityFrameworkCore.Relational`
* EFCore CLI tool:
  * Install it by running `dotnet tool install --global dotnet-ef` in your terminal.
* For .NET 9 Compatibility: To avoid version conflicts with the Roslyn compiler during migration generation, ensure the following packages are explicitly added to your `.csproj` and match the version required by your EF Core Design tools:
  * `Microsoft.CodeAnalysis.CSharp` (Version 4.14.0 or later)
  * `Microsoft.CodeAnalysis.CSharp.Workspaces` (Version 4.14.0 or later)
  * `Microsoft.EntityFrameworkCore.Design` (Version 9.0.x)

The tutorial will show how to create custom database tables using a composer and a notification handler. With this pattern, you create and run a similar migration but trigger it in response to a [notification handler](https://docs.umbraco.com/umbraco-cms/fundamentals/code/subscribing-to-notifications).

## Step 1: Create Model Class

First, create a class and add the following code:

{% code title="BlogComment.cs" %}

```csharp
namespace Umbraco.Demo;

public class BlogComment
{
    public int Id { get; set; }

    public Guid BlogPostUmbracoKey { get; set; }

    public required string Name { get; set; }

    public required string Email { get; set; }

    public required string Website { get; set; }

    public string Message { get; set; } = string.Empty;
}
```

{% endcode %}

## Step 2: Create DBContext class

With the model in place, create a file called `BlogContext.cs` to interact with the database:

{% code title="BlogContext.cs" %}

```csharp
using Microsoft.EntityFrameworkCore;

namespace Umbraco.Demo;

public class BlogContext : DbContext
{
    public BlogContext(DbContextOptions<BlogContext> options)
        : base(options)
    {
    }

    public required DbSet<BlogComment> BlogComments { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder) =>
        modelBuilder.Entity<BlogComment>(entity =>
        {
            entity.ToTable("blogComment");
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BlogPostUmbracoKey).HasColumnName("blogPostUmbracoKey");
            entity.Property(e => e.Message).HasColumnName("message");
            entity.Property(e => e.Website).HasColumnName("website");
            entity.Property(e => e.Email).HasColumnName("email");
        });
}
```

{% endcode %}

## Step 3: Register the DbContext

The `DbContext` must be registered so Umbraco can use it. The recommended place to do this is inside an IComposer. Create a file called `BlogCommentsComposer.cs`. Inside `Compose`, register the context using `AddUmbracoDbContext`:

{% code title="BlogCommentsComposer.cs" %}

```csharp
using Microsoft.EntityFrameworkCore;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;

namespace Umbraco.Demo;

public class BlogCommentsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUmbracoDbContext<BlogContext>((serviceProvider, options, connectionString, providerName) =>
        {
            if (string.IsNullOrEmpty(providerName) || string.IsNullOrEmpty(connectionString))
            {
                return;
            }

            // Automatically uses the correct provider (SQL Server, SQLite, etc.)
            // based on your Umbraco connection string configuration.
            options.UseDatabaseProvider(providerName, connectionString);
        });
    }
}
```

{% endcode %}

Using `UseDatabaseProvider(providerName, connectionString)` is the recommended approach. It reads the provider name and connection string directly from your Umbraco configuration (`appsettings.json`). It works correctly for SQL Server, SQLite, and any other supported database without any hardcoding.

The database can then be accessed via `BlogContext.` First, the database needs to be migrated to add the custom tables. With EFCore, migrations can be auto-generated from the terminal.

1. Open your terminal and navigate to your project folder.
2. Generate the migration by running:

```bash
dotnet ef migrations add InitialCreate --context BlogContext
```

{% hint style="info" %}

If your models and `DBContext` reside in a separate library like `Project.Core`, while `Project.Web` is the startup project, follow these steps:

* Navigate to your custom library folder, for example, `/Project.Core`
* Run the following command with the relative path to your startup project:

```bash
dotnet ef migrations add initialCreate -s ../Project.Web/ --context BlogContext
```

{% endhint %}

In this example, the migration is named `InitialCreate`. You can choose any name you like.

The `DbContext` class in this example is named `BlogContext`. If you've used a different name, make sure to update the `--context` argument accordingly.

This might be confusing. When working with EFCore you would normally inject your `Context` class directly. You can still do that, but it is not the recommended approach in Umbraco.

In Umbraco, the `Scope` concept is an implementation of the `Unit of work` pattern. This ensures that a transaction is started when using the database. If the scope is not completed (for example when an exception is thrown), it will roll back automatically.

## Step 4: Create the Notification Handler

Create a file called `RunBlogCommentsMigration.cs` with the following code. This handler checks for any pending EF migrations and applies them automatically on startup:

{% code title="RunBlogCommentsMigration.cs" %}

```csharp
using Microsoft.EntityFrameworkCore;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Demo;

public class RunBlogCommentsMigration : INotificationAsyncHandler<UmbracoApplicationStartedNotification>
{
    private readonly BlogContext _blogContext;

    public RunBlogCommentsMigration(BlogContext blogContext)
    {
        _blogContext = blogContext;
    }

    public async Task HandleAsync(UmbracoApplicationStartedNotification notification, CancellationToken cancellationToken)
    {
        IEnumerable<string> pendingMigrations = await _blogContext.Database.GetPendingMigrationsAsync(cancellationToken);

        if (pendingMigrations.Any())
        {
            await _blogContext.Database.MigrateAsync(cancellationToken);
        }
    }
}
```

{% endcode %}

## Step 5: Register the Notification Handler

Add the notification handler registration to `BlogCommentsComposer.cs`. This is also where the `DbContext` registration from Step 3 lives, both belong in the same Composer:

{% code title="BlogCommentsComposer.cs" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;

namespace Umbraco.Demo;

public class BlogCommentsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {

        builder.Services.AddUmbracoDbContext<BlogContext>((serviceProvider, options, connectionString, providerName) =>
        {
            if (string.IsNullOrEmpty(providerName) || string.IsNullOrEmpty(connectionString))
            {
                return;
            }

            options.UseDatabaseProvider(providerName, connectionString);
        });

        builder.AddNotificationAsyncHandler<UmbracoApplicationStartedNotification, RunBlogCommentsMigration>();
    }
}
```

{% endcode %}

After registering the notification handler, build the project and check the database. You should see the new `blogComment` table has been created.

![Database result of a migration](<../.gitbook/assets/db-table (1) (1).png>)

{% hint style="info" %}
If you are using the default SQLite database, you cannot use SQL Server Management Studio (SSMS) to view your tables. Use a tool like **DB Browser for SQLite** and open the file located at `/umbraco/Data/Umbraco.sqlite.db`.
{% endhint %}

The custom database tables are now available to work with through Entity Framework.

## Going Further

### Working with the Data in the Custom Database Tables

To create, read, update, or delete data from your custom database tables, use the `IEFCoreScopeProvider<T>` (where `T` is your `DbContext` class) to access the EFCore context.

The example below creates a `BlogCommentsController.cs` file with an `UmbracoApiController` to fetch and insert blog comments from a custom database table.

{% hint style="warning" %}
This example uses the `BlogComment` class directly as a database model. The recommended approach would be to map it to a ViewModel instead, so your database and UI layers are not coupled. Error handling and data validation have been omitted for brevity.

{% endhint %}

{% code title="BlogCommentsController.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Persistence.EFCore.Scoping;

namespace Umbraco.Demo;

[ApiController]
[Route("/umbraco/api/blogcomments")]
public class BlogCommentsController : Controller
{
    private readonly IEFCoreScopeProvider<BlogContext> _efCoreScopeProvider;

    public BlogCommentsController(IEFCoreScopeProvider<BlogContext> efCoreScopeProvider)
        => _efCoreScopeProvider = efCoreScopeProvider;

    [HttpGet("all")]
    public async Task<IActionResult> All()
    {
        using IEfCoreScope<BlogContext> scope = _efCoreScopeProvider.CreateScope();
        IEnumerable<BlogComment> comments = await scope.ExecuteWithContextAsync(async db => db.BlogComments.ToArray());
        scope.Complete();
        return Ok(comments);
    }

    [HttpGet("getcomments")]
    public async Task<IActionResult> GetComments(Guid umbracoNodeKey)
    {
        using IEfCoreScope<BlogContext> scope = _efCoreScopeProvider.CreateScope();
        IEnumerable<BlogComment> comments = await scope.ExecuteWithContextAsync(async db =>
        {
            return db.BlogComments.Where(x => x.BlogPostUmbracoKey == umbracoNodeKey).ToArray();
        });

        scope.Complete();
        return Ok(comments);
    }

    [HttpPost("insertcomment")]
    public async Task InsertComment(BlogComment comment)
    {
        using IEfCoreScope<BlogContext> scope = _efCoreScopeProvider.CreateScope();

        await scope.ExecuteWithContextAsync<Task>(async db =>
        {
            db.BlogComments.Add(comment);
            await db.SaveChangesAsync();
        });

        scope.Complete();
    }
}

```

{% endcode %}
