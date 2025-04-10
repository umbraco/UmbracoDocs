---
meta.Title: Umbraco Database
description: >-
  This tutorial will show you how to get started with creating custom database
  tables with the Entity Framework Core in Umbraco.
---

# Creating Custom Database Tables with Entity Framework

## Introduction

Custom database tables let you store additional data in the Umbraco database that you don't want to be stored as normal content nodes.

Using custom tables can be great for many things such as storing massive amounts of data that you do not need to edit from the backoffice.

Decoupling part of your data from being managed by Umbraco as content is a way to achieve better performance for your site. It will no longer take up space in indexes and caches, and the Umbraco database.

{% hint style="warning" %}
Be aware that storing data in custom database tables is by default not manageable by Umbraco.

This means that if you need to edit or display this data, you need to implement the underlying functionality to support this.

The case is the same if you need this data to be transferred or kept synchronized between multiple sites or environments.

Data stored in custom tables are not supported by default by add-ons such as Umbraco Deploy and will not be deployable by default.
{% endhint %}

## Prerequisite

* An Umbraco project with content
* EFCore CLI tool
  * Can be installed by running `dotnet tool install --global dotnet-ef` in the terminal

<details>

<summary>If you are using EF Core, and have installed the <code>Microsoft.EntityFrameworkCore.Design 8.0.0</code> package</summary>

You need to be aware of some things if you are using EF Core, and have installed the `Microsoft.EntityFrameworkCore.Design 8.0.0` package:

* This package has a transient dependency to `Microsoft.CodeAnalysis.Common` which clashes with the same transient dependency from `Umbraco.Cms 13.0.0`. This happens because `Microsoft.EntityFrameworkCore.Design 8.0.0` requires `Microsoft.CodeAnalysis.CSharp.Workspaces` in v4.5.0 or higher.
* If there are no other dependencies that need that package then it installs it in the lowest allowed version (4.5.0). That package then has a strict dependency on `Microsoft.CodeAnalysis.Common` version 4.5.0. The problem is `Umbraco.Cms` through its own transient dependencies that require the version of `Microsoft.CodeAnalysis.Common` to be >= 4.8.0.
* This can be fixed by installing `Microsoft.CodeAnalysis.CSharp.Workspaces` version 4.8.0 as a specific package instead of leaving it as a transient dependency. This is because it will then have a strict transient dependency on `Microsoft.CodeAnalysis.Common` version 4.8.0, which is the same that Umbraco has.

</details>

The tutorial will show how to create custom database tables using a composer and a notification handler. With this pattern, you create and run a similar migration but trigger it in response to a [notification handler](https://docs.umbraco.com/umbraco-cms/fundamentals/code/subscribing-to-notifications).

## Step 1: Create Model Class

First, create a class and add the following code:

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

## Step 2: Create DBContext class

Now that we have the model, we create a `DbContext` class so we can interact with the database and add the following code:

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

## Step 3: Register the DbContext

We need to register the `DbContext` to be able to use it in Umbraco.

To do this we can use this helpful extension method:

```csharp
builder.Services.AddUmbracoDbContext<BlogContext>(options => 
{
    options.UseSqlServer("{YOUR CONNECTIONSTRING HERE}");
    //If you are using SQlite, replace UseSqlServer with UseSqlite
});
```

If you are using SQlite, replace `UseSqlServer` with `UseSqlite`.

1. Add the method in the `Program.cs` file:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

builder.Services.AddUmbracoDbContext<BlogContext>(options => 
{
    options.UseSqlServer("{YOUR CONNECTIONSTRING HERE}");
    //If you are using SQlite, replace UseSqlServer with UseSqlite
});
```

We can then access the database via the `BlogContext.` First, we need to migrate the database to add our tables. With EFCore, we can autogenerate the migrations with the terminal.

{% hint style="info" %}

For package developers and not only, but in general as well, it's recommended to use the `UseUmbracoDatabaseProvider` logic. This is because it will then figure out what the correct database is used:

```csharp
builder.Services.AddUmbracoDbContext<CustomDbContext>((serviceProvider, options) =>
    {
        options.UseUmbracoDatabaseProvider(serviceProvider);
    });
```

{% endhint %}

2. Open your terminal and navigate to your project folder.
3. Generate the migration by running:&#x20;

```bash
dotnet ef migrations add InitialCreate --context BlogContext
```

{% hint style="info" %}
If you use another class library in your project to store models and DBContext classes such as Project.Core (Project.Web being the main startup Project):

* Go to the project folder where you have your custom class library such as /Project.Core
* Run the following script with the relative path to your main startup project Project.Web:

```bash
dotnet ef migrations add initialCreate -s ../Project.Web/ --context BlogContext
```

{% endhint %}

In this example, we have named the migration `InitialCreate`. However, you can choose the name you like.

We've named the DbContext class `BlogContext`, however, if you have renamed it to something else, make sure to also change it when running the command.

This might be confusing at first, as when working with EFCore you would inject your `Context` class. You can still do that, it is however not the recommended approach in Umbraco.

In Umbraco, we use a concept called `Scope` which is our implementation of the `Unit of work` pattern. This ensures that we start a transaction when using the database. If the scope is not completed (for example when exceptions are thrown) it will roll it back.

## Step 4: Create the notification handler

Next, we create the notification handler that will handle our migrations. We need to create a new class and add the following code to it:

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Migrations;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.Migrations;
using Umbraco.Cms.Infrastructure.Migrations.Upgrade;

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
        IEnumerable<string> pendingMigrations = await _blogContext.Database.GetPendingMigrationsAsync();

        if (pendingMigrations.Any())
        {
            await _blogContext.Database.MigrateAsync();
        }
    }
}
```

## Step 5: Register the notification handler

Lastly, we have to register the notification handler, with an `IComposer` class and add the following code:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Notifications;

namespace Umbraco.Demo;

public class BlogCommentsComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder) => builder.AddNotificationAsyncHandler<UmbracoApplicationStartedNotification, RunBlogCommentsMigration>();
}
```

After registering the notification handler, build the project and take a look at the database and we can see our new table:

![Database result of a migration](<../../../10/umbraco-cms/extending/images/db-table (2).png>)

We now have some custom database tables in our database that we can work with through the Entity framework.

## Going Further

### Working with the data in the Custom Database Tables

To create, read, update, or delete data from your custom database tables, use the `IEFCoreScopeProvider<T>` (T is your `DbContext` class) to access the EFCore context.

The example below creates a `UmbracoApiController` to be able to fetch and insert blog comments in a custom database table.

{% hint style="warning" %}

* This example uses the `BlogComment` class, which is a database model. The recommended approach would be to map these over to a ViewModel instead, that way your database & UI layers are not coupled. Be aware that things like error handling and data validation have been omitted for brevity.

{% endhint %}

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
