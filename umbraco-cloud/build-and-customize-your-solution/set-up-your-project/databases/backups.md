---
description: >-
  Sometimes you might need to have a backup of your Cloud database. This can be
  accomplished directly on Umbraco Cloud.
---

# Database backups

{% hint style="info" %}
Read more about Umbraco Cloud's Backup and data retention policy in the [FAQ](https://docs.umbraco.com/umbraco-cloud/frequently-asked-questions).
{% endhint %}

## Limitations

When restoring a database backup on Umbraco Cloud, certain elements may cause issues:

* **SQL Server logins** - Custom SQL Server logins (for example, admin, sysuser, etc.) may conflict with existing logins when restoring the database in the hosting platform.
* **Complex Database Objects** - Custom complex database objects in SQL is an element with external dependencies or special server configurations, which may result in conflicts when restoring the database in our hosting platform.

{% hint style="info" %}
Restoring a database replaces the existing database with a fresh one containing the restored content. Once a Restore has run, you cannot create database backups with a **Date and Time for snapshot (UTC)** going back before the Restore-operation. However, any existing backups are still available.
{% endhint %}

## Backup on Umbraco Cloud

On Umbraco Cloud, you can utilize our 35-day point-in-time recovery to create and download a `bacpac` file from your project.

{% hint style="info" %}
Only Project Administrators have access to the **Backups** page on Umbraco Cloud.
{% endhint %}

To create a backup follow the steps below:

1. Open your Cloud project.
2.  Go to **Backups** in the **Settings** menu.

    <figure><img src="../../../.gitbook/assets/image (45).png" alt="Backups on Cloud"><figcaption><p>Backups on Cloud</p></figcaption></figure>
3.  Click **Create Backup.**

    <figure><img src="../../../.gitbook/assets/image (75).png" alt="Click Create Backup."><figcaption><p>Click Create Backup.</p></figcaption></figure>
4. Enter a **description** for your **backup**.
5. Choose the **Environment** from which you want to create the backup.
6. Choose the **Date and Time** for the backup to be created.

<figure><img src="../../../.gitbook/assets/image (4) (1) (1).png" alt=""><figcaption><p>Creating new Backup</p></figcaption></figure>

1. Click **Create Backup.**

When you click on the **Create Backup** button, the system will start creating a backup file in the form of a `bacpac` file. Once the `bacpac` file is created, you can download it by clicking on the **download** icon. If you want to delete any backups, click the **delete** icon next to the backup.

<figure><img src="../../../.gitbook/assets/image (73).png" alt="Download or delete backup"><figcaption><p>Download or delete backup</p></figcaption></figure>

### Create Backup Errors

When a backup creation fails, you can click the triangle icon to view more details about the error.

| Error Name                                                 | Description                                                                             |
| ---------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| CreateDatabaseBackupFailedUnableToFindResource             | Metadata for new backup is missing.                                                     |
| CreateDatabaseBackupFailedUnableToFindOperation            | Operation metadata for new backup is missing.                                           |
| CreateDatabaseBackupFailedUnableToCreatePointInTimeRestore | Cannot create the temporary database used for point-in-time restore.                    |
| CreateDatabaseBackupFailedUnableToStartDatabaseRestore     | Point-in-time restore on the temporary database failed.                                 |
| CreateBackupJobContainerFailed                             | The job that creates and stores the backup file failed.                                 |
| CreateBackupJobContainerUnknownError                       | An uncategorized error occurred during the job that creates and stores the backup file. |
| CreateBackupJobContainerTimeOut                            | Job for creating and storing the backup file took too long.                             |

## Upload Database

There might be times when you want to upload a database backup to Umbraco Cloud. You might need to restore your database to a certain point in time, or you might be migrating a project to Umbraco Cloud.

Follow the steps below to upload a `.bacpac` file to your Umbraco Cloud project:

1. Go to your **Umbraco Cloud** project.
2. Go to the **"Configuration"** tab in the side menu.
3. Click on **"Backup".**
4.  Click **"Upload backup"** under "Database Uploads to Umbraco Cloud".

    <figure><img src="../../../.gitbook/assets/image (70).png" alt="Upload backup"><figcaption><p>Upload backup</p></figcaption></figure>
5. Choose a `.bacpac` file to upload to your project.
6. Write a description of the database you are uploading.
7. Click **"Upload .bacpac"**.

Once the Database has been uploaded, restoring the backup to your environment is possible.

### Upload Database Errors

When an upload fails, you can click the triangle icon to view more details about the error.

| Error Name                | Description                                  |
| ------------------------- | -------------------------------------------- |
| ImportBackupAborted       | User aborted the upload.                     |
| ImportBackupFailedUnknown | An unknown error occurred during the upload. |
| ImportBackupFailed        | Upload took too long.                       |

## Restore Database

When restoring a database backup on Umbraco Cloud, certain elements may cause issues. For more details, see the [Limitations](backups.md#limitations) section .

Once you have uploaded a backup, you might want to restore it to one of your environments. To restore a backup to an environment follow the steps below.

1.  Click on the small watch on the right side.

    <figure><img src="../../../.gitbook/assets/image (71).png" alt="Restore Database to environment"><figcaption><p>Restore Database to environment</p></figcaption></figure>
2.  Choose which environment to replace the database with the backup.

    <figure><img src="../../../.gitbook/assets/image (72).png" alt="Choose which environment to restore the backup on"><figcaption><p>Choose which environment to restore the backup on</p></figcaption></figure>
3. **Optional:** Create a Cloud Backup of the selected environment's database before restoring the backup.
4. Click **"Restore backup"**

Once you click **"Restore backup"** the database will be restored to your selected environment. Wait for it to finish and you will successfully have replaced your environment database with your backup.

Make sure to check your environment and see if everything works as expected and that the data from the backup is there.

## Restoring a Cloud backup to a SQL Server Database

Use the following steps:

1. Connect to your SQL Server using SQL Server Management Studio (SSMS).
2. Expand "Databases", right-click "Databases", then select "Import Data-tier Application...".
3. Proceed through the dialog, by browsing to the saved location of your `bacpac` file, and then setting the options appropriate to your configuration
4. Complete the import dialog and the database will be restored.

{% hint style="info" %}
If a `bacpac` restore fails in SQL server, ensure the 'Contained Database Authentication' flag is set to true for resolution.

If it is not set the import will fail.

To Enable Contained Database Authentication, run the following SQL against your SQL server on the main database.

```sql
sp_configure 'contained database authentication', 1;  
GO  
RECONFIGURE;  
GO  
```

For reference please see the [Microsoft documentation on the topic](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/contained-database-authentication-server-configuration-option?view=sql-server-ver16).
{% endhint %}
