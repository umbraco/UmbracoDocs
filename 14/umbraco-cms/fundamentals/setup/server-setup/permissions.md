---
description: "Information on file and folder permissions required for Umbraco sites"
---

# File and folder permissions

{% hint style="info" %}
To ensure a stable and smoothly running Umbraco installation, these permissions need to be set correctly. These permissions should be set up before or during the installation of Umbraco.

The main account that requires 'modify' file permissions to be set on the folders below, is the account used start Umbraco. If Umbraco is hosted in IIS this will be the Application Pool Identity for the IIS website. Usually IIS APPPOOL\appPoolName or a specific local account or in some circumstances Network Service. If in doubt, ask your server admin / hosting company. Additionally, the Internet User (IUSR) account and IIS_IUSRS account only require 'read only' access to the site's folders.

Generally, when developing locally with Visual Studio or Rider, permissions do not need to be strictly applied.
{% endhint %}

{% hint style="info" %}
If you have any specific static files/media items/etc, you should add the appropriate permissions accordingly.

The permissions documentation should allow you to run a plain Umbraco install successfully.
{% endhint %}

|File / folder             |Permission             |Comment                                              |
|--------------------------|-----------------------|-----------------------------------------------------|
|`/appSettings*.json`      |Modify / Full control  |Only needed for setting database and a global identifier during installation. So can be set to read-only afterwards for enhanced security.|
|`/App_Plugins`            |Modify / Full control  |Should always have modify rights as the folder and its files are used by packages. Not part of your project by default.|
|`/umbraco`            |Modify / Full control  |Should always have modify rights as the folder and its files are used for cache and storage.|
|`/Views`            |Modify / Full control  |Should always have modify rights as the folder and its files are used for Templates and Partial views|
|`/wwwroot/css`            |Modify / Full control  |Should always have modify rights as the folder and its files are used for css files.|
|`/wwwroot/media`            |Modify / Full control  |Should always have modify rights as the folder and its files are used for Media files uploaded via the Umbraco CMS backoffice.|
|`/wwwroot/scripts`            |Modify / Full control  |Should always have modify rights as the folder and its files are used for script files.|
