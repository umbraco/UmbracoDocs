# File and folder permissions

_To ensure a stable and smoothly running Umbraco installation, these permissions need to be set correctly. These permissions should be setup before or during the installation of Umbraco. The permissions that need to be set are for the user used by the Application Pool in the IIS website (usually IIS APPPOOL\appPoolName (if set to run under Application Pool Identity), or it may be Network Service or a specific account setup for IIS sites to run under...). If in doubt, ask your server admin / hosting company. (Additionally the server accounts IUSR, and groups IIS_IUSRS should have read permissions to your site).

When running a site locally during development, then generally specific permissions don't need to be strictly applied.

<table border="0">
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
<th>/Bin</th>
<th>Modify / Full control</th>
<td>
<p>Needed for installing packages, if no packages are installed,
this can be set to read accees only</p>
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
<th>/MacroScripts</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for Razor files</p>
</td>
</tr>
<tr>
<th>/Masterpages</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for template files</p>
</td>
</tr>
<tr>
<th>/Media</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for media files uploaded via Umbraco cms interface</p>
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
<th>/Umbraco_client</th>
<th>Modify / Full control</th>
<td>
<p>For upgrades and package installation, it should have modify
rights, but can be set to read-only afterwards</p>
</td>
</tr>
<tr>
<th>/UserControls</th>
<th>Modify / Full control</th>
<td>
<p>Modify rights are needed for installing packages</p>
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
<tr>
<th>/Xslt</th>
<th>Modify / Full control</th>
<td>
<p>Should always have modify rights as the folder and its files
are used for macro files</p>
</td>
</tr>
</tbody>
</table>
