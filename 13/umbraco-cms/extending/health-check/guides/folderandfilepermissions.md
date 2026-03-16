# Folder & File Permissions

_Checks that the web server folder and file permissions are set correctly for Umbraco to run._

## How to fix this health check

This health check can be fixed by ensuring that the process running Umbraco also has write access to the listed folders and files.

### Updating the file permissions on Windows

Here's an example of how to adjust permissions for a folder. This process works the same way for files.

First we see an example of an error from the health check

![Failed health check for folder creation](../../../.gitbook/assets/failed_healthcheck_folder_permissions.png)

To fix this, we find the specified folder, from the report and choose `Properties` and the `Security` tab.

![Folder properties](../../../.gitbook/assets/folder_properties.png) ![Folder properties - Security tab](../../../.gitbook/assets/folder_properties_security.png)

From here you can edit the permissions for a specific user or user group.

{% hint style="info" %}
For security reasons we recommend only giving write access to the required users or groups.
{% endhint %}
