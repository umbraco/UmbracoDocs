## Connecting to the database on Umbraco Cloud locally
For security, your database on Umbraco Cloud is running behind a firewall so in order to connect to the database, you'll need to open the firewall for the relevant IPs. This can be a single IP, a list of IPs or even an IP range. It's done from the Connection Details page on your project. Click the "Settings" menu in the upper right corner of your project and select "Connection Details". If you don't see the menu item, it's due to permissions and you'll need to contact the administrator of your project.

## Opening the firewall
The easiest way to open the firewall for your IP address is to click the "Add Now" link. It'll automatically add your current IP address and save the settings. It might take up to five minutes for the firewall to be open for your IP.

If you need to open for specific IP addresses, click the "Add New IP Address" button.

## Setting up SQL Management Studio
Once the firewall is open, it's time to fire up SQL Management Studio and connect to the database. Be aware that a database exist for each environment you have on Umbraco Cloud and any changes you make to custom tables needs to be done for each of them.

To connect, choose "Connect Database Engine" and copy the values from the Connection Details page on Umbraco Cloud where you'll find handy "copy" short-cut buttons to the right of each value. In the "Connect to Server" dialog in SQL Management Studio, choose "SQL Server Authentication" as the authentication type and also remember to click the "Options" button *before you connect* and paste the name of your database in the "Database" input field (otherwise, security settings on Umbraco Cloud will prevent you from connecting). You can see it all in this short gif:

<iframe width="800" height="450" src="https://www.youtube.com/embed/f3YIEHGHZB4?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## Connecting to your local Umbraco installation
When cloning down your project to work locally you might want to have a look in your database every now and then. You can connect to your local Umbraco database through, for example, Visual Studio.

In Visual Studio this is done through the Server Explorer. Add a new connection to a SQL server database file. Umbraco's database file can be found in `App_Data`:

![Connecting to Umbraco.mdf in Visual Studio](images/connect-via-vsstudio.gif)

If this is your first time connecting to a local database this way, you might have to choose a data source when clicking `Add Connection`. Select `Microsoft SQL Server Database File` and hit OK.

Umbraco will create an mdf file (LocalDB) if you have SQL Server installed on your local machine, provided LocalDB is enabled and can be discovered by Deploy. If Deploy can't create an mdf file it will create a SQL CE (sdf) file instead. 
