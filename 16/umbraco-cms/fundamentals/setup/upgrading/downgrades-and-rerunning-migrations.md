---
description: Discusses the possibility of downgrading to a previous version, along with the related topic of re-running the migrations that have occurred during an upgrade
---

# Downgrade to a Previous Version

## Downgrades are not strictly supported

Downgrades are not a supported feature of the Umbraco product.

The reason for this is the Umbraco migration scheme only supports upward migrations.

When updating to a new version, often there are migrations to run that will make changes to Umbraco schema and data. This is done to bring the database to a state that will support the functionality of the version being upgraded to.

There isn't an equivalent downward migration that will undo these changes.

Given that, it can't be guaranteed that a database from a later version will work with an earlier one.

If you wish to downgrade to an earlier version of Umbraco, it's best to also revert to a compatible database backup. You will need one from the version you are downgrading to.

## Particular downgrades are possible and safe

That said, between some versions, a downgrade may be possible and perfectly safe. There may be no migrations that run between them. Or, as is often the case, the migrations are backward compatible (e.g. adding a new, nullable field to a database table).

You will need to determine this for yourself, likely via reviewing the changes and migrations between versions and testing.

Once you have done that, this article will explain how to proceed with downgrading.

## Downgrade process

Downgrading the Umbraco application itself is straightforward. In the same way as when upgrading, you update the dependency on Umbraco in your project, you do the same when downgrading:

`dotnet add package Umbraco.Cms --version <VERSION>`

If you try to start Umbraco, it's quite likely you will find an exception thrown on boot indicating a problem with the migration state. This is because the version of Umbraco you are running now doesn't recognize the state stored by the higher version you were running previously.

To resolve this, you need to query the Umbraco database.

There are two migration states stored for the CMS - for the core migrations and the pre-migrations (which run at different times on start-up).

You can find the current state of these via:

```sql
select value from umbracoKeyValue where [key] = 'Umbraco.Core.Upgrader.State+Umbraco.Core.Premigrations'
select value from umbracoKeyValue where [key] = 'Umbraco.Core.Upgrader.State+Umbraco.Core'
```

You then need to find the latest state for the version of Umbraco you want to downgrade to.

To find the earlier states you have to look in the source code, specifically [here for the pre-migrations](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Infrastructure/Migrations/Upgrade/UmbracoPremigrationPlan.cs) and [here for the core ones](https://github.com/umbraco/Umbraco-CMS/blob/main/src/Umbraco.Infrastructure/Migrations/Upgrade/UmbracoPlan.cs).

Each migration is commented with the version it was added, so you can read off the latest one for the version you wish to run.

Having found the state you need, you set it via a query of the form:

```sql
update umbracoKeyValue
set value = '{state value}'
where [key] = 'Umbraco.Core.Upgrader.State+Umbraco.Core'
```

Then restart Umbraco.

## Re-running Migrations

A related topic is if you want to re-run the migrations from a prior version to the version you are on.

This isn't something that should be needed in normal usage of Umbraco. Umbraco handles running the necessary migrations on start-up and keeps track of it's state. However, if investigating an upgrade related issue, or testing an upgrade before running in production, it's useful to know how to do this.

Again you need to manipulate the migration state stored in the database.

You can update these values to an earlier state, and on start-up Umbraco will recognize that it's not at the latest. It will re-run the migrations from the earlier state to the current one.

For example, let's say you are running 16.2, and want to re-run the core migrations for 15 and 16. Here you would set the core migration state to the latest one from 14, via:

```sql
update umbracoKeyValue
set value = '{EEF792FC-318C-4921-9859-51EBF07A53A3}'
where [key] = 'Umbraco.Core.Upgrader.State+Umbraco.Core'
```

And then restart Umbraco.

Migrations are written to be idempotent, so they can be run multiple times. If the change the migration is making is already detected to be there, it should skip without throwing an exception.
