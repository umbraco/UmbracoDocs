---
description: Working with EF Core in Umbraco
---

# Working with EF Core in Umbraco

As of [Umbraco 12](https://umbraco.com/blog/umbraco-12-release/#entity) Entity Framework Core ([EF Core](https://learn.microsoft.com/en-us/ef/core/)) is shipped alongside Umbraco.

There is a tutorial to get you started with EF Core in Umbraco: [Getting started with Entity Framework Core](../../tutorials/getting-started-with-entity-framework-core.md)

## Ways of registering EF Context

There are several ways of registering EF Context, and it will need to be done differently depending on your project. Here is a quick overview of the common cases:

### Same project, explicit connection string and provider

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddDeliveryApi()
        .AddComposers()
        .Build();
        
    services.AddUmbracoEFCoreContext<BlogContext>("{YOUR CONNECTIONSTRING HERE}", "{YOUR PROVIDER NAME HERE}");
}
```

{% hint style="warning" %}
Explicitly writing the conn string in startup is a problem if deploying across environments like fx on Umbraco Cloud, and this usage is hardly ever the best option.
{% endhint %}

### Same project, using the configured database connection

If you use localDb or Sql Server across all environments then you can use this format to get the Umbraco dbs connection string

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddDeliveryApi()
        .AddComposers()
        .Build();
        
    services.AddUmbracoEFCoreContext<BlogContext>((options, connectionString, providerName) =>
            options.UseSqlServer(connectionString));
}
```

There is also a .UseSqlite method.

### Different project, using the configured database connection

Let's say you have a seperate project, fx a classlibrary with `Umbraco.Cms.Persistence.EFCore` installed which is added to the website project. Then you need to specify the assembly that the migrations are running from to make it work:

```csharp
public static class DependencyInjection
{
    public static IServiceCollection AddPersistence(this IServiceCollection services)
    {
        services.AddUmbracoEFCoreContext<BlogContext>((options, connectionString, providerName) => options.UseSqlServer(connectionString,
            builder =>
            {
                builder.MigrationsAssembly(typeof(DependencyInjection).Assembly.GetName().FullName);
            }));

        return services;
    } 
}
```

It can then be added in the websites startup:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddDeliveryApi()
        .AddComposers()
        .Build();
        
    services.AddPersistence();
}
```

{% hint style="warning" %}
When adding an EF Core migrations in a seperate project you need to also add a parameter to say which project is the source:
```
dotnet ef migrations add CreateTable --context ProductRoutingContext -o .\Generated\ProductRouting\ -s ..\..\Presentation\Website\Website.csproj
```
{% endhint %}