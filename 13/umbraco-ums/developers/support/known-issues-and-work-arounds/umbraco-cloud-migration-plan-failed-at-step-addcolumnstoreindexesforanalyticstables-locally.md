**Behaviour:**

Cloning an Umbraco Cloud instance making use of LocalDB, installing uMarketingSuite on it, and running it fails, causing a Migration Plan failed at step "AddColumnStoreIndexesForAnalyticsTables" issue.

**Details:**

When installing uMarketingSuite on a new Umbraco Cloud instance making use of a LocalDB develoopment database, it may occur that you're getting an "Invalid object name 'uMarketingSuiteAbTestingAbTest'." exception on startup, and when looking at the logs you notice a "Migration Plan failed at step "AddColumnStoreIndexesForAnalyticsTables"" log entry. If you open Umbraco's KeyValue table, you also notice that the last value added for the uMarketingSuite migration row is 'MigrateTimeOfDaySegmentRuleFormat'.

**Solution:**

uMarketingSuite couldn't find a valid umbracoDbDSN connectionstring, fails to connect to the database therefor fails to create its nessecary database tables. When using LocalDB, the solution would be to add a connectionstring in your appsettings(.development).json file pointing towards said database.

An example of such string could be:

    Data Source=(localdb)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Umbraco.mdf;Integrated Security=True

**Reference:**

[https://github.com/uMarketingSolutions/uMarketingSuite/issues/36](https://github.com/uMarketingSolutions/uMarketingSuite/issues/36)

**Last updated:**

September 14th, 2023