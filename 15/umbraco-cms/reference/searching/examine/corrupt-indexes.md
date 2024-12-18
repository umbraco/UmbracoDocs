---
description: How to deal with...
hidden: true
---

# Corrupt Indexes
Due to various reasons,like  missing files, the data integrety of the examine index files my be compromised. When this happens, Umbraco considers the index to be corrupt.
Due to some systems already being hooked into the examine index lifecycle, it is safest to resolve this issue from outside of the application.

## Resolution in a self hosted environment
- Stop the website/app pool
- Remove the Folder containing the corrupted index files
- Restart the website

## Resolution on umbraco cloud
- Open the project in the cloud portal
- Select the correct environment
- Open kudo in the debug console
- Choose CMD
- Navigate to `C:\home\site\wwwroot\umbraco\Data\Temp>`
- Click the delete button next to the index in question
- Restart the environment.
