---
description: How to deal with Corrupt Examine indexes
hidden: true
---

# Corrupt Indexes

The data integrity of Examine index files can be compromised if for example files are removed. When this happens, Umbraco considers the index to be corrupt.

As some systems are already hooked into the Examine index lifecycle, resolving this issue outside the application is safest.

## Resolution in a self-hosted environment

The following steps cover clearing out corrupt indexes in a self-hosted environment.

1. Stop the website/app pool.
2. Remove the directory containing the corrupted index files.
3. Restart the website.

## Resolution on Umbraco Cloud

The following steps cover clearing out corrupt indexes in a setup hosted on Umbraco Cloud.

1. Open the project in the Cloud Portal.
2. Select the correct environment.
3. Access KUDU.
4. Open the debug console.
5. Choose CMD.
6. Navigate to `C:\home\site\wwwroot\umbraco\Data\Temp`.
7- Click the delete button next to the index file.
8. Restart the environment.
