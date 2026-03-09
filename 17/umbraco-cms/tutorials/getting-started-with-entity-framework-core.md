---
meta.Title: Umbraco Database
description: >-
  Learn how to create custom database tables in Umbraco using Entity Framework Core, including migrations, composers, and notification handlers.
---

# Creating Custom Database Tables with Entity Framework

## Introduction

Custom database tables allow you to store additional data in the Umbraco database that you don't want to store as normal content nodes.

Use custom tables when:

* You need to store large datasets.
* The data does not need backoffice editing.
* You want better performance by decoupling data from Umbraco content.
* The data should not be indexed or cached as content.

Data stored in custom database tables:

* Is not manageable from the backoffice by default.
* Requires custom implementation for editing or display.
* Is not automatically synchronized between environments.
* Is not deployable using Umbraco Deploy by default.

## Prerequisites

Ensure the following requirements are met before starting:

* An existing Umbraco project with content.
* The `Umbraco.Cms.Persistence.EFCore` NuGet package installed.
* If your model and context live in a separate project, that project must also reference:
  * `Microsoft.EntityFrameworkCore`
  * `Microsoft.EntityFrameworkCore.Relational`
* Install the EF Core CLI tool by running the following command in your terminal:
  * `dotnet tool install --global dotnet-ef`.
* For .NET 10 Compatibility: To avoid Roslyn compiler version conflicts during migration generation, ensure the following packages are explicitly added to your `.csproj`. Match the version required by your EF Core Design tools:
  * `Microsoft.CodeAnalysis.CSharp` (Version 5.0.0 or later)
  * `Microsoft.CodeAnalysis.CSharp.Workspaces` (Version 5.0.0 or later)
  * `Microsoft.EntityFrameworkCore.Design` (Version 10.0.x)

## Implementation Overview

You will:

* [Create a model class](#step-1-create-a-model-class)
* [Create a DbContext](#step-2-create-the-dbcontext-class)
* [Register the DbContext in a Composer](#step-3-register-the-dbcontext-class)
* [Generate a migration](#step-4-generate-the-migration)
* [Create a notification handler to run migrations](#step-5-create-the-notification-handler)
* [Register the notification handler](#step-6-register-the-notification-handler)

## Step 1: Create a Model Class

1. Create a file named `BlogComment.cs`.
2. Add the following code:

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

## Step 2: Create the DbContext class

1. Create a file named `BlogContext.cs`.
2. Add the following code:

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

## Step 3: Register the DbContext class

The `DbContext` must be registered so Umbraco can resolve it. The recommended place to register it is inside an `IComposer`.

1. Create a file named `BlogCommentsComposer.cs`.
2. Register the context using `AddUmbracoDbContext` inside the `Compose` method:

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

## Step 4: Generate the Migration

The database can now be accessed via `BlogContext`. Before using it, generate a migration to create the custom tables. With EFCore, migrations can be auto-generated from the terminal.

1. Open your terminal.
2. Navigate to your project folder.
3. Run the following command to generate the migration:

```bash
dotnet ef migrations add InitialCreate --context BlogContext
```

### DbContext in a separate library

If your models and `DbContext` reside in a separate library like `Project.Core`, while `Project.Web` is the startup project, follow these steps:

1. Navigate to the class library folder, for example, `/Project.Core`
2. Run the following command with the relative path to your startup project:

```bash
dotnet ef migrations add initialCreate -s ../Project.Web/ --context BlogContext
```

In this example, the migration is named `InitialCreate`. You can choose any name you like.

The `DbContext` class in this example is named `BlogContext`. If you've used a different name, make sure to update the `--context` argument accordingly.

### Understanding Scopes in Umbraco

When working with EFCore you would normally inject your `Context` class directly. You can still do that, but it is not the recommended approach in Umbraco.

In Umbraco, the `Scope` concept is an implementation of the `Unit of work` pattern. This ensures that a transaction is started when using the database. If the scope is not completed (for example when an exception is thrown), it will roll back automatically.

## Step 5: Create the Notification Handler

To ensure migrations are applied automatically at startup:

1. Create a file named `RunBlogCommentsMigration.cs`.
2. Implement `INotificationAsyncHandler<UmbracoApplicationStartedNotification>`.
3. Add the following code:

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

## Step 6: Register the Notification Handler

1. Open `BlogCommentsComposer.cs`.
2. Add the handler registration inside `Compose`.

{% code title="BlogCommentsComposer.cs" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;
using Microsoft.EntityFrameworkCore;

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

## Verify the Migration

After registering the notification handler:

1. Build the project.
2. Run the application.
3. Open your database.
4. Confirm that the `blogComment` table has been created.

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
