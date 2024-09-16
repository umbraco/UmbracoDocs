# Boot failed when updating to uMS 1.15

**Behaviour:**

Installing uMarketingSuite 1.15 on a (live) environment with a large uMarketingSuiteAnalyticsPageview table ( &gt; ~ 10.000.000 rows) will fail with the error message "Boot failed".

**Detailed error message:**

*Umbraco.Core.Exceptions.BootFailedException: Boot failed: Umbraco cannot run. See Umbraco's log file for more details.*

*-&gt; Umbraco.Core.Exceptions.BootFailedException: Boot failed.*

*-&gt; System.Data.SqlClient.SqlException: Execution Timeout Expired. The timeout period elapsed prior to completion of the operation or the server is not responding.*

*........*

*at uMarketingSuite.Web.Migrations.\_2021\_11\_03.AddIncludesToPageviewSessionIdIndex.Migrate() in D:\projecten\uMarketingSuite\uMarketingSuite.Web\Migrations\2021-11-03\AddIncludesToPageviewSessionIdIndex.cs:line 21*

**Cause:**

The Index on the table uMarketingSuiteAnalyticsPageview is updated in uMarketingSuite 1.15. Updating a index on a large table will trigger a rebuild of the Index which will take time on larger tables / smaller SQL instances. Sometimes this will cause a SQL timeout.

**Work-around:**

1. Before updating, add or edit the [**ConnectionTimeout**](https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout) property and set it to for example 300 seconds in the database connection string.
2. Update the environment with uMarketingSuite 1.15
3. After a successful update, remove the [**ConnectionTimeout**](https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout) property or edit the ConnectionTimout property and set the timeout value back to it's previous value.

**Solution:**

This is fixed in uMarketingSuite 1.18

**Last updated:**

May 9th, 2022