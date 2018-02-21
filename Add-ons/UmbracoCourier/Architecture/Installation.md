# Installation

## Installing Courier 3



## Installing Courier 2 using a package

1. Open the embrace repository from the developer section in Umbraco
2. Browse to the Umbraco PRO category
3. Click Umbraco Courier, and choose install, follow directions on screen
4. At the end of the install, you are prompted for a location, enter the domain of the other site you want to use with courier, e.g.: domain.com, www.sample.com or internaldev
5. Courier expects that the user you are deploying content with, has the same credentials on all locations, if this is not case, either change credentials or read the chapter on configuring locations in this guide
6. If you have bought a license, copy the .lic file to the website's /bin folder or use the dashboard to configure your license
7. That's it

## Updating Courier 2 to 2.x
If you already have Courier 2.0 installed, follow these steps to upgrade to 2.x:

1. Backup your /config/courier.config file
2. Copy the contents of /bin, /config and /umbraco from the manual update zip, to the root of your site
3. Delete the DLL: Castle.DynamicProxy2.dll and it’s .pdb file from the /bin folder
4. Update the /config/courier.config file with settings from your backed-up one. 

 * Ensure your <repositories> node is copied over
 * You resource filters
 * And the itemdataresolver settings
 *  In 90% of all installations, a default configuration is used, so <repositories> node is the crucial one

5. You're done


## Manual installation
If for some reason the package installation fails or due to permissions or other reasons is not an option on your system, we provide a manual installation process.

To manually install, download the manual install package from umbraco.com or one of the hotfix releases from nightly.umbraco.org

The manual process consists of several files:

 * **The folders /bin,  /config and /umbraco**  
Folders containing the application files for Courier 2
 * **/sql folder**
 Folder containing install and uninstall sql files. For install there are variations for each of the 3 supported databases
 * **/sql/uninstall folder**
Contains the single uninstall sql script, which will remove custom courier table as well as the any courier app entries, it will not remove any files

### Installing the files
Simply unzip the /bin, /config and /umbraco folders to the root of your website, the archive follows the structure needed to place the files correctly. Notice: the archive assumes your Umbraco director is located at /umbraco. If not you will need to move those files manually to the right location.

If you have purchased Umbraco Courier, you can download a license file on umbraco.com. This license file must be placed in the websites /bin directory to be registered.

### Installing the database
To install the database we need to execute a sql script against the database Umbraco is installed on. Courier  currently only supports SQL server 2005 and 2008.

* Open Microsoft Sql Server Management Studio and connect to your database. 
* Right click your Umbraco database and choose "new query" 
* Open the /sql/install folder and pick the appropriate sql files. If you use MS Sql, you pick “app.sql” and “create.sql” if not, you pick the files with the correct database name in them.
* Copy the contents of sql files to the query window
* Execute the script

If any errors are displayed, check your permissions. The install script requires database owner access, as it creates new tables. 

### Uninstalling the database
In case of error you can use the /sql/uninstall/uninstall.sql file to remove all courier tables. Follow the same procedure as the one describing "installing the database"