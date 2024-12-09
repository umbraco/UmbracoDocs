---
description: >-
  In this section, you will see some common problems when installing Umbraco
  Engage and how to solve them.
---

# Troubleshooting installations

### Issue: Boot failure after initial installation

#### Description:

After installing Umbraco Engage and booting for the first time the following exception can be thrown. Due to not always known reasons Umbraco Engage fails to run the necessary migrations on startup and (probably) the Umbraco Engage tables are not created.

#### Error message:

```
SqlException: Invalid object name 'umbracoEngageAbTestingAbTest'.
Umbraco.Engage.Data.AbTesting.DbAbTestRepository.Query(Expression<Func<DbAbTest, bool>> whereExpression) in DbAbTestRepository.cs
Umbraco.Engage.Data.AbTesting.DbAbTestRepository.GetAll() in DbAbTestRepository.cs
Umbraco.Engage.Infrastructure.AbTesting.Repositories.AbTestRepository.GetAll() in AbTestRepository.cs
Umbraco.Engage.Infrastructure.AbTesting.Services.CachedAbTestRepository.RefreshCache() in CachedAbTestRepository.cs
Umbraco.Engage.Infrastructure.AbTesting.Services.CachedAbTestRepository.Handle(MigrationsCompletedEvent event) in CachedAbTestRepository.cs
Umbraco.Engage.Infrastructure.Events.SystemEventService.Raise<T>(T event) in SystemEventService.cs
Umbraco.Engage.Web.Migrations.UmsMigrationsComponent.Initialize() in UmsMigrationsComponent.cs
Umbraco.Cms.Core.Composing.ComponentCollection.Initialize()
Umbraco.Cms.Infrastructure.Runtime.CoreRuntime.StartAsync(CancellationToken cancellationToken, bool isRestarting)
Umbraco.Cms.Infrastructure.Runtime.CoreRuntime.StartAsync(CancellationToken cancellationToken)
Umbraco.Extensions.WebApplicationExtensions.BootUmbracoAsync(WebApplication app)
Program.<Main>$(string[] args) in Program.cs
await app.BootUmbracoAsync();
```

#### Steps to resolve:

1. Remove the row with `Umbraco.Core.Upgrader.State+Umbraco.Engage` key from the `umbracoKeyValue` table in the database.&#x20;
2. If they exist, remove all umbracoEngage\* tables from the database.&#x20;
3. Restart the site.
