---
meta.Title: "Umbraco file and folder permissions"
meta.Description: "Information on file and folder permissions required for Umbraco sites"
versionFrom: 8.0.0
---

# File and folder permissions

:::note
To ensure a stable and smoothly running Umbraco installation, these permissions need to be set correctly. These permissions should be setup before or during the installation of Umbraco.

The main account that requires 'modify' file permissions to be set on the folders below, is the account used by the Application Pool Identity for the IIS website. Usually IIS APPPOOL\appPoolName or a specific local account or in some circumstances Network Service - If in doubt, ask your server admin / hosting company. Additionally the IUSR account and IIS_IUSRS account only require 'read only' access to the site's folders.

Generally when developing locally with Visual Studio or WebMatrix, permissions do not need to be strictly applied.
:::

:::note
If you have any specific static files / media items / etc then you should add the appropriate permissions accordingly.
The permissions documentation as it is should allow you to run a plain Umbraco install successfully, the rest.. is up to you! 👍
:::


<table border="0" style="margin-top:20px;">
<thead>
<tr>
<th>File / folder</th>
<th>Permission</th>
<th>Comment</th>
</tr>
</thead>

<tbody>
<tr>
<th>/Web.config</th>
<th>Modify / Full control</th>
<td>
<p>Only needed for setting database and version Information during
installation. So can be set to read-only afterwards for enhanced
security</p>
</td>
</tr>
<tr>
<th>/App_Code</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for dynamically loading in and generating dlls</p>
</td>
</tr>
<tr>
<th>/App_Data</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for cache and storage</p>
</td>
</tr>
<tr>
<th>/App_Plugins</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used by packages</p>
</td>
</tr>
<tr>
<th>/Bin</th>
<th>Modify / Full control</th>
<td>
<p>Needed for installing packages, if no packages are installed,
this can be set to read access only</p>
</td>
</tr>
<tr>
<th>/Config</th>
<th>Modify / Full control</th>
<td>
<p>Only needed for setting database and version Information during
installation. So can be set to read-only afterwards for enhanced
security</p>
</td>
</tr>
<tr>
<th>/Css</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for css files</p>
</td>
</tr>
<tr>
<th>/Media</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for media files uploaded via Umbraco CMS interface</p>
</td>
</tr>
<tr>
<th>/Scripts</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for script files</p>
</td>
</tr>
<tr>
<th>/Umbraco</th>
<th>Modify / Full control</th>
<td>
<p>For upgrades and package installation, it should have modify
rights, but can be set to read-only afterwards</p>
</td>
</tr>
<tr>
<th>/Views</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for template, partial view and macro files</p>
</td>
</tr>
</tbody>
</table>
