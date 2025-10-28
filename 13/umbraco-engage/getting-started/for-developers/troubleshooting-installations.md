---
description: >-
  In this section, you will see some common problems when installing Umbraco
  Engage and how to solve them.
---

# Troubleshooting installations

## Boot failure after initial installation

### Description

After installing Umbraco Engage and booting for the first time, an SQL exception might be thrown. This happens when Umbraco Engage fails to run the necessary migrations on startup, and the Umbraco Engage tables are not created.

The most common reasons for this are:

* Database connectivity issues.
* Incompatible SQL Server version.
* No COLUMNS STORE index support on Azure SQL lower than S3.

### Exception

```bash
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

### Steps to resolve

#### When having database connectivity issues

1. Remove the row with the `Umbraco.Core.Upgrader.State+Umbraco.Engage` key from the `umbracoKeyValue` table in the database if it exists.&#x20;
2. Remove all existing umbracoEngage\* tables from the database if they exist.
3. Restart the site.

#### When running on Azure SQL tier lower than S3

**DISCLAIMER:** When running Azure SQL on lower tiers and querying COLUMN STORE indexes, performance may significantly decrease. 
Depending on the amount of data being processed, this can also lead to timeouts. Not reccommend for production level sites. 

Azure SQL lower than S3 doesn't support creating COLUMN STORE indexes. To work around this follow these steps:&#x20;

1. Scale your Azure SQL environment to S3.
2. Restart the site.
3. Scale back to your initial Azure SQL tier.

The COLUMN STORE indexes are created and can be used in a lower tier. 
