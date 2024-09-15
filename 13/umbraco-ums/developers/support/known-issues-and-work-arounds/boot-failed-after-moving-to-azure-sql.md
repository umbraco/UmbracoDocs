**Behaviour:**

Installing Umbraco with the uMarketingSuite on Azure SQL with an instance &lt; S3 will fail with the error message "Boot failed".

**Detailed error message:**

*Umbraco.Core.Exceptions.BootFailedException: Boot failed. ---&gt; System.Data.SqlClient.SqlException: Cannot find the object \"dbo.uMarketingSuiteAnalyticsPageview\" because it does not exist or you do not have permissions.*

*....*

*uMarketingSuite\\uMarketingSuite.Web\\Migrations\\2020-09-01\\AddColumnStoreIndexesForAnalyticsTables.cs:line 100*

**Cause:**

When using Azure SQL with a instance lower than S3 column store is not supported and the uMarketingSuite migration will fail.

**Affected version(s):**

uMarketingSuite &lt; 1.17

**Structural solution**

As of uMarketingSuite 1.17 this should be fixed. Please update to 1.17 or later.

**Work-around ( uMarketingSuite &lt; 1.17):**

1. Scale-up the Azure SQL instance to S3 or higher just before the installation.  
  
![]()
2. Scale down afterwards.

**Status:**

As of uMarketingSuite 1.17 this should be fixed. Please update to 1.17 or later.

**Last updated:**

March 22nd, 2022