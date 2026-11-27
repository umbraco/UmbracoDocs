---
description: Information on the runtime settings section
---

# Runtime Settings

In the Runtime settings you can configure:

* Size limits for requests and query strings. Neither of these settings needs to be configured. If nothing is configured, requests and query strings can be any size.
* The runtime mode of Umbraco.
* The lifetime of temporary file uploads. This is primarily used when uploading images and other media in the backoffice.
* How migrations are handled at boot. For more information, see the [Migration behavior](#migration-behavior) section.

An example of a configuration could look something like:

```json
"Umbraco": {
  "CMS": {
    "Runtime": {
      "MaxRequestLength": 2048,
      "Mode": "BackofficeDevelopment",
      "TemporaryFileLifeTime": "1.00:00:00"
    }
  }
}
```

* `MaxRequestLength` is specified in kilobytes. Setting this limits the request size, including the size of uploaded files. This only has an effect on the server when hosting with Kestrel, but is also used by the Backoffice to advise users. See the [Maximum Upload Size Settings ](maximumuploadsizesettings.md)article for more information.
* `Mode` can have three values: `BackofficeDevelopment` (default), `Development`, and `Production`. For more information, see the [Runtime modes](../../run-in-production/runtime-modes.md) article.
* `TemporaryFileLifeTime` is specified as a timespan. The default value is one day - `1.00:00:00`.

## Migration behavior

{% hint style="info" %}
`MigrationBehavior` is available from Umbraco CMS version 17.10.
{% endhint %}

`MigrationBehavior` controls how Umbraco handles migrations at boot when the database isn't at the final state of a migration plan. The setting applies to the Umbraco migrations, the premigrations, and package migrations. Running package migrations manually from the backoffice isn't affected.

At boot, a migration plan can be in one of these states:

* **Behind**: The stored state is missing or is an earlier state of the plan, so the database needs to be upgraded.
* **Unknown**: The stored state isn't a state this version knows. Typically, a newer version of Umbraco or a package that shares the database has already migrated it.

The available options are:

| Option | Plan behind its final state | Plan at an unknown state |
|---|---|---|
| `Upgrade` (default) | Upgraded | Boot fails |
| `None` | Not upgraded, logs a warning | Boot fails |
| `IgnoreUnknown` | Not upgraded, logs a warning | Logs a warning and boots |
| `RollingUpgrade` | Upgraded | Logs a warning and boots |

* `Upgrade` keeps the behavior of earlier versions. The `UpgradeUnattended` and `PackageMigrationsUnattended` options in the [Unattended](unattendedsettings.md) settings decide whether the upgrade runs unattended or from the backoffice.
* `RollingUpgrade` combines `Upgrade` and `IgnoreUnknown`. You can also set the combination as `"Upgrade, IgnoreUnknown"`.

```json
"Umbraco": {
  "CMS": {
    "Runtime": {
      "MigrationBehavior": "RollingUpgrade"
    }
  }
}
```

### Rolling upgrades

Use `RollingUpgrade` when two versions of Umbraco share one database for a while. For example, during a deployment slot swap on Azure App Service, or with multiple environments connected to one database. The newer version upgrades the database. The older version keeps booting instead of failing on the unknown migration state.

* Set `RollingUpgrade` on every instance, for both the older and the newer version.
* The older version must have the setting before the newer version migrates the database. Otherwise, a restart of the older version fails.
* Use the readiness endpoint `/umbraco/api/health/ready` to check when the newer version has finished migrating. For more information, see the [Health Probes](../../run-in-production/infrastructure-and-ops/server-setup/health-probes.md) article.

{% hint style="warning" %}
An older version only runs correctly against a newer database when the migrations in between are forward-compatible. Forward-compatible migrations add to the schema and data. They don't rename, remove, or reshape anything the older version reads. Otherwise, the older version boots but fails at runtime.

Don't deploy an upgrade to a new major version as a rolling upgrade. Major versions can migrate both the schema and the stored data. Stop the older version before starting the newer version, and plan for the downtime.
{% endhint %}

{% hint style="warning" %}
`IgnoreUnknown` and `RollingUpgrade` also let Umbraco boot against a database that is too old to be upgraded by this version. Check the log for warnings naming a migration plan and its state.
{% endhint %}
