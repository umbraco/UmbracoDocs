# Database backups

Sometimes you might need to have a backup of your Cloud database. This can be accomplished directly on Umbraco Cloud.

{% hint style="info" %}
Read more about the [Backup and data retention policy](../frequently-asked-questions.md#backups-and-data-retention) on Umbraco Cloud in the FAQ.
{% endhint %}

## Backup on Umbraco Cloud

On Umbraco Cloud, you can utilize our point-in-time recovery to create and download a `bacpac` file from your project.

{% hint style="info" %}
Only Project Administrators have access to the **Backups** page on Umbraco Cloud.
{% endhint %}

To create a backup follow the steps below:

1. Open your Cloud project.
2.  Go to **Backups** in the **Settings** menu.

    <figure><img src="../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>
3.  Click **Create Backup.**

    <figure><img src="../.gitbook/assets/image (17).png" alt=""><figcaption><p>Click Create Backup.</p></figcaption></figure>

    1. Enter a **description** for your **backup**.
    2. Choose the **Environment** from the **Environment** dropdown you want to create the backup from.
    3. Choose the **Date and Time** for the backup to be created.

    <figure><img src="../.gitbook/assets/image (4).png" alt=""><figcaption><p>Creating new Backup</p></figcaption></figure>
4. Click **Create Backup.**

When you click on the **Create Backup** button, the system will start creating a backup file in the form of a `bacpac` file. Once the `bacpac` file is created, you can download it by clicking on the **download** icon. In case you want to delete any of your backups, click on the **delete** icon.

<figure><img src="../.gitbook/assets/image (18).png" alt=""><figcaption></figcaption></figure>

## Restoring a Cloud backup to a SQL Server Database

Use the following steps:

* Connect to your SQL Server using SQL Server Management Studio (SSMS).
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
