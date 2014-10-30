#Install Umbraco manually

_Follow these steps to do a full manual install of Umbraco._

##Download Umbraco binaries
The stable releases of the Umbraco binaries are available from [our.umbraco.org/download](http://our.umbraco.org/download/). If you don't mind working with experimental builds, you could download a [nightly release](http://nightly.umbraco.org/) at your own peril (no guarantees that it will work).

##Unzip files
Once you have the binary release of your liking saved to disk, make sure that the file has not been blocked by Windows. Right-click the file you downloaded and choose "Properties". If it says at the bottom of the properties window: "This file came from another computer and might be blocked to help protect this computer" then make sure to click the "Unblock" button so that all of the binary files will be unzipped later on.

Now you can unzip the file to a location of your choosing (for example: `D:\Dev\MyUmbracoSite\`)

##Choose your webserver
There are two ways to run the binaries in a webserver:

1. The easy way: using IIS Express
2. Internet Information Server (IIS)

###Using IIS Express

You can download IIS Express from the [Web Platform Installer (WebPI)](http://www.microsoft.com/web/downloads/platform.aspx) (search for "IIS Express"). To be able to develop against IIS Express from Visual Studio 2010, you need to have VS2010 Service Pack 1 installed, which can also be acquired from the WebPI. 

![IIS Express on the Web Platform Installer](images/Manual/2012-03-17_164508.png?raw=true)

While you will be able to launch IIS Express from the command line and use it to serve your site this way, it is much easier to use Microsoft WebMatrix (also available through the WebPI) which spins up an IIS Express instance when needed. In fact, choosing WebMatrix in the WebPI will automatically also download and install IIS Express as a dependency.

Once WebMatrix is installed, you can simply right-click the folder in which you unzipped Umbraco, choose "Open as a Web Site with Microsoft WebMatrix" from the context menu (should be near the top). Once WebMatrix starts, just click the "Run" button to launch your site. WebMatrix has an additional benefit: it allows you to edit the files in your site out of the box.

![Start Umbraco through Web Matrix](images/Manual/2012-03-17_173822.png?raw=true)

###Using IIS
If you want to use IIS to host your Umbraco site, you have two options:

1. **Using a hostname that points to your local machine.**

	*Note: We strongly recommend using IIS7(.5). While IIS6 may work, this guide will cover IIS7 only. IIS7 is available in Windows 7 and Windows Server 2008.*
	
	Create a new website in IIS by right-clicking *Sites* and choosing "Add site...". The site name can be anything you want.
	
	You will then be asked what kind of application this is, make sure to pick (or create) an application pool that uses ASP.NET 4.0 as its basis. (The default ASP.NET 4.0 is configured perfectly for this, so we recommend you pick that one.) Use the "Select.." button to pick a different application pool. You shouldn't have to change the other settings.
	
	Finally fill in the hostname. In this example we'll use *MyUmbracoSite.local*.
	
	![Configure new website in IIS](images/Manual/2012-03-12_223022.png?raw=true)
	
 	As a final step, you will need to add the *MyUmbracoSite.local* hostname to your hosts file. If you haven't altered your host file before you will need to make sure that your current user has write permissions to the hosts file. The hosts file typically lives in C:\Windows\System32\drivers\etc\hosts (the file has no extension).
	
	To enable you to write to the file, right-click it and click "Properties". Go to the "Security" tab and find the current logged in user, click the user and then the "Edit..." button. Check the *Allow Modify* permission there.
	
	*Note: **this is not without risk**. If your user account can edit the hosts file, malware can do the same under your account and attempt to change the hosts file to redirect well known sites to malicious websites. Always make sure to revert the security settings if you want to be safe!*
	
	Add a line to the hosts file that points the new hostname to the local machine:
	
	`127.0.0.1 MyUmbracoSite.local`
	
	You can now go to http://MyUmbracoSite.local and the install wizard should appear.
	
2. **Using a virtual directory**
	
	*Note: We strongly recommend using IIS7(.5). While IIS6 may work, this guide will cover IIS7 only. IIS7 is available in Windows 7 and Windows Server 2008.*
	
	To do so, start IIS Manager and right click on the **Default Website** and choose **Add virtual directory**.
	
	![Add Virtual directory](images/Manual/2012-03-12_204006.png?raw=true)
	
	Fill in the virtual directory name and the path where you unzipped Umbraco's files (the path where default.aspx and web.config are located).
	
	![Virtual directory configuration](images/Manual/2012-03-12_204144.png?raw=true)
	
	Now you have a new virtual directory. IIS doesn't yet know that you're pointing to an application, so you need to tell it that. Right-click the vdir you just created - in this case called *MyUmbracoSite* - and choose **Convert to application**.
	
	![Convert virtual directory to application](images/Manual/2012-03-12_204429.png?raw=true)
	
	You will then be asked what kind of application this is. Make sure to pick (or create) an application pool that uses ASP.NET 4.0 as its basis. (The default ASP.NET 4.0 is configured perfectly for this, so we recommend you pick that one.) Use the "Select.." button to pick a different application pool. You shouldn't have to change the other settings.
	
	![Configure web application](images/Manual/2012-03-12_204433.png?raw=true)
	
	*Note: if ASP.NET 4.0 is not a choice in your list of application pools, don't attempt to create it manually. You will need to [register it in IIS](http://stackoverflow.com/questions/4890245/how-to-add-asp-net-4-0-as-application-pool-on-iis-7-windows-7#answer-4890368). Be sure to use Brad Christie's answer here, you **have** to register it, not just create a new application pool manually as that will not work.*
	
	You can now go to http://localhost/MyUmbracoSite and the install wizzard should appear.
	
*Please note: You will not be able to run Umbraco from Visual Studio's built-in webserver Casini. You do, however, have the option to configure VS to use IIS Express or IIS if needed.*

In order for Umbraco to have the correct permissions to write files to disk, you should give the IIS_IUSRS user modify permissions in the folder in which you've unzipped your Umbraco files. 

While giving broad permissions is usually fine for development environments, you may want to restrict permissions further on a public-facing server. In that case, at least the App\_Data folder needs modify permissons for either the IIS_IUSRS group or the specific user that is linked to the application pool that you're using. (This assumes that you will not do live editing or installing on the server).

###Choose database environment
There are two options to choose from with regards to a database environment:

1. SQL Compact Edition
2. SQL Server 2008 (Express and higher)

###SQL Compact Edition

SQL CE is a good option if you want to get started quickly. You don't need to create a database in a server ahead of time and it's free. That said, it doesn't scale very well for sites with a large amount of content. Once you reach the point where SQL CE doesn't seem to cut it for your site, you can migrate it to a SQL Server database.

To start using SQL CE, just choose it in the install wizzard: "*I want to use SQL CE 4, a free, quick-and-simple embedded database*".

###SQL Server 2008
To be able to use SQL Server, you should setup an empty database before you can continue installing Umbraco. It's completely up to you how you want to configure this database, but make sure it's connectable over TCP/IP and that it has a SQL username and SQL password. (You can use Windows authentication, but that would require you to write your own connection string).

Generally, for development environments you would ensure that the database user has database owner rights, but make sure to comply with the rules you or your workspace has set up for this.

Once you've created the database and credentials, enter those details in the install wizard after choosing the *I already have a blank SQL Server 2008 database* option.

IMPORTANT: The SQL server user must have their language set to the default English language, do not set this to British english as it parses date structures incorrectly. This issue will hopefully be resolved in the future. 

##Finishing off
Follow the installation wizard and after a few easy steps and choices you should get a message saying the installation was a success.

##Post installation in production
Umbraco 4.x includes uGoLive components which are accessible as a tab in the the developer section of Umbraco backoffice. 
uGoLive does certain post-installation checks and gives recommendations on what to do post-install - the recommendations should 
be followed to secure your Umbraco installation.  
One important recommendation is to always remove the `install` folder immediately after installing Umbraco and never to upload it to a live server.

After applying the recommended measures you can optionally delete the uGoLive-binaries which are named Our.Umbraco.uGoLive.* 
from the bin folder to increase site performance.
