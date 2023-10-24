# Database backups

Sometimes you might need to have a backup of your Cloud database. This can be accomplished with SQL Server Management Studio.

{% hint style="info" %}
Read more about the [Backup and data retention policy](../frequently-asked-questions.md#backups-and-data-retention) on Umbraco Cloud in the FAQ.
{% endhint %}

## Backup with SQL Server Management Studio

Follow these steps:

* Log in to Umbraco Cloud, and visit your project page.
* From the "Settings" drop-down for the project, select "Connection Details".
* If your IP address is not listed, click "Add now" next to "Your IP address is not on the list". It should then say "Your IP address is on the list".
* Note the server name, login, password, and database listed on this screen for whichever environment you are backing up (e.g., development or live).
* Open SQL Server Management Studio (SSMS).
* Once the "Connect to Server" dialog appears, enter your server name, login, and password (you will also need to be sure the authentication drop-down is set to "SQL Server Authentication" rather than "Windows Authentication").
* Click the "Options >>" button.
* In the "Connect to database" field, type your database name (this was listed on the Umbraco Cloud connection details page).
* It is important that you enter the database name. If you do not, the connection will fail.
* Expand "Databases", right-click your database (it should be the only one listed), select "Tasks", then select "Export Data-tier Application...".
* Proceed through the dialog, setting the options appropriate to your situation, to save the "bacpac" file. This is your database backup.

## Restoring a Cloud backup to a SQL Server Database

Use the following steps:

* Connect to your SQL Server using Sql Server Management Studio (SSMS).
* Expand "Databases", right-click "Databases", then select "Import Data-tier Application...".
* Proceed through the dialog, by browsing to the saved location of your `bacpac` file, and then setting the options appropriate to your configuration
* Complete the import dialog and the database will be restored.

{% hint style="info" %}
If a `bacpac` restore fails in SQL server, ensure the 'Contained Database Authentication' flag is set to true for resolution.

If it is not set the import will fail.



To Enable Contained Database Authentication, run the following SQL against your SQL server on the Master database.

```sql
sp_configure 'contained database authentication', 1;  
GO  
RECONFIGURE;  
GO  
```

For reference please see the [Microsoft documentation on the topic](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/contained-database-authentication-server-configuration-option?view=sql-server-ver16).
{% endhint %}

