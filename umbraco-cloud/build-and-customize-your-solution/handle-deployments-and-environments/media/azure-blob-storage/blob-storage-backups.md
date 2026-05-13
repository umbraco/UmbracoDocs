---
description: >-
  Learn how to back up your Umbraco Cloud Blob Storage using AzCopy.
---

# Blob Storage Backups

Umbraco Cloud uses Azure Blob Storage to store all media files for your project. This includes images, PDFs, and other files added through the Media library in the Umbraco backoffice.

While Umbraco Cloud provides database backups through the Cloud Portal, you may want to create your own backups of the Blob Storage. This article describes how to back up and restore Blob Storage using AzCopy.

## Prerequisites

- A project on Umbraco Cloud with access to the Cloud Portal.
- AzCopy is installed on your local machine.
- Access to the **Connections** page under **Configuration** in the Cloud Portal.

## Download AzCopy

1. Download the AzCopy portable binary from the [official Microsoft AzCopy page](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#download-azcopy).
2. Extract the binary to a directory on your local machine.
3. Verify that AzCopy runs from the command line by running:

```bash
azcopy --version
```

{% hint style="info" %}
On macOS, you may need to allow the binary in **System Settings** > **Privacy & Security** after the first run.
{% endhint %}

## Locate the Shared Access Signature (SAS) URL

1. Go to the Umbraco Cloud Portal for your project.
2. Open the **Connections** page found under **Configuration**.
3. Locate the **Blob Storage SAS URL** for the environment you want to back up.

{% hint style="warning" %}
SAS tokens expire after a set period. Ensure the token is valid before running the backup commands.
{% endhint %}

## Back Up Blob Storage to a Local Directory

Use the following AzCopy command to download the Blob Storage contents to a local directory:

```bash
azcopy copy "<SAS-URL>" "C:\BlobBackup" --recursive
```

- Replace `<SAS-URL>` with the Blob Storage SAS URL from the Connections page.
- Replace `C:\BlobBackup` with the path to the local directory where you want to store the backup.
- The `--recursive` flag ensures that all files and subdirectories are copied.

{% hint style="info" %}
On macOS or Linux, use a path like `/Users/yourname/BlobBackup` instead.
{% endhint %}

### Verify the Backup

List the files in your Blob Storage container using the following command:

```bash
azcopy list "<SAS-URL>"
```

Compare the output with the contents of your local backup directory to confirm that all files have been downloaded.

## Back Up Blob Storage to Another Storage Account

You can also copy the Blob Storage contents to another Azure Storage account. Use the following command:

```bash
azcopy copy "<Source-SAS-URL>" "<Destination-SAS-URL>" --recursive
```

- Replace `<Source-SAS-URL>` with the SAS URL of the source Blob Storage container.
- Replace `<Destination-SAS-URL>` with the SAS URL of the destination container.
- The `--recursive` flag ensures that all files and subdirectories are copied.

## Restore Blob Storage from a Local Backup

If you need to restore the Blob Storage from a local backup, use the following command:

```bash
azcopy copy "C:\BlobBackup\*" "<SAS-URL>" --recursive
```

- Replace `C:\BlobBackup` with the path to your local backup directory.
- Replace `<SAS-URL>` with the Blob Storage SAS URL for the target environment.
- The `--recursive` flag ensures that all files and subdirectories are uploaded.

{% hint style="warning" %}
Restoring overwrites existing files with the same name. Verify that you are targeting the correct environment before running the restore command.
{% endhint %}

## Related Articles

- [Azure Blob Storage](README.md)
- [Connect to Azure Storage Explorer](connect-to-azure-storage-explorer.md)
- [Database backups](../../../set-up-your-project/databases/backups.md)
