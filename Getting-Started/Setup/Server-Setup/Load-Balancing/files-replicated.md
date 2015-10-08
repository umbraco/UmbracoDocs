#File Storage with File Replication

_documentation about setting up load balanced environments using file replication_

##Replication techniques

A common way to replicate files on Windows Server is to use [DFS](http://msdn.microsoft.com/en-us/library/windows/desktop/bb540031(v=vs.85).aspx), which is included with Windows Server.

Additional DFS resources:

* [Implementing DFS Replication in Windows Server 2003](http://www.windowsnetworking.com/articles_tutorials/Implementing-DFS-Replication.html)
* [Overview of DFS Replication in Windows Server 2008 R2](http://technet.microsoft.com/en-us/library/cc771058.aspx)
* [Watch an intro to installing and working with DFS](http://www.youtube.com/watch?v=DYfBoUt2RVE)

There are other alternatives for file replication out there, some free and some licensed. You'll need to decide which solution is best for your environment.

##Non-replicated files

When deploying Umbraco in a load balanced scenario using file replication, it is important to ensure that not all files are replicated - otherwise you will experience file locking issues. Here are the folders and files that should not be replicated:

* ~/App_Data/TEMP/*
* ~/App_Data/umbraco.config 
	* Alternatively you can change the web.config entry to store this file inside of the ~/App_Data/TEMP folder using this
	
			<add key="umbracoContentXML" value="~/App_Data/TEMP/umbraco.config" />
	* Another alternative is to store the umbraco.config file in the local server's 'temp' folder. Achieve this by changing this configuration setting to 'true' in the web.config. The downside is that if you need to view this configuration file you'll have to find it in the temp files. Locating the file this way isn't always clear.
			
			<add key="umbracoContentXMLUseLocalTemp" value="true" /> 
* ~/App_Data/Logs/*
	* This is **optional** and depends on how you want your logs configured (see below) 

If for some reason your file replication solution doesn't allow you to not replicate specific files folders (which it should!!) then you can use an alternative approach by using virtual directories. *This is not the recommended setup but it is a viable alternative:*

* Edit /web.config and change the umbracoContentXML to use ~/App_Data/TEMP/umbraco.config.
* Copy the /App_Data/TEMP directory to each server, outside of any replication areas or to a unique folder for each server.
* Create a virtual directory (not a virtual application) in the /App_Data folder, and name it TEMP. Point the virtual directory to the folder you created in step 2.
* You may delete the /App_Data/TEMP folder from the file system - not IIS as this may delete the virtual directory - if you wish.

##IIS Setup

IIS configuration is pretty straightforward with file replication. IIS is just reading files from its own file system like a normal IIS website.