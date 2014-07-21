#Install Umbraco with Microsoft WebMatrix

Follow these simple steps to be up and running with WebMatrix quickly and easily. The benefit of using WebMatrix is that it is super simple to get up and running.

##Download and Launch WebMatrix 3

1. Go to [http://www.microsoft.com/web/webmatrix/](http://www.microsoft.com/web/webmatrix/) and download WebMatrix 3 for free.

1. Once installed, launch WebMatrix.

1. From the three options shown, choose the option **New**. Then choose **App Gallery**.

	![Web Matrix - Choose New](images/WebMatrix/webmatrix3-start.PNG?raw=true)

1. In the search box in the top right hand corner, type "Umbraco".

	![Web Matrix - Search for Umbraco CMS](images/WebMatrix/webmatrix-search.png?raw=true)

1. From the results select the item marked **Umbraco CMS**. Click **Next**.

1. In the **Site Name** box give your site an appropriate name and click **Next** again.

	*The list of items may be more than just Umbraco as shown in the screenshot. This is because WebMatrix uses the Web Platform installer behind the scenes to install Umbraco and will also download any other software that is required in order for the website to run.*

1. The next screen presents you with two options for the database to be used by Umbraco. Choose the option marked **SQL CE Server (Installed)** and click **Next**. This is the quickest and easiest option to get started with Umbraco - especially for small sites - and uses a file stored on disk as the database.

	![Web Matrix - Database Selection](images/WebMatrix/webmatrix3-database.png?raw=true)

	*If you need to migrate your database from SQL CE Server to the full edition of SQL Server, you can do it at a later point.*

1. Accept the licensing terms and conditions by clicking **I Accept**.

1. WebMatrix will download the required files to run Umbraco. Once done you will see a confirmation message.

	![Web Matrix - Install Complete](images/WebMatrix/webmatrix3-install-complete.png?raw=true)

## Umbraco Web Installer
This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.
	
1. Once completed you may need to launch the website from WebMatrix. (WebMatrix may also launch the site automatically upon completion of installation.)
	1. Click the Sites section in the lower left-hand corner.
	1. Then click on the URL such as `http://localhost:22830`<br/>*Port number may be different as it is random*.
	1. The Web installer for Umbraco will now launch inside your default browser.

	![Web Matrix - Finding Local Host](images/WebMatrix/webmatrix3-localhost.png?raw=true)

1. You will see the welcome screen. After reading through the page click **Lets get started!**

	![Web Installer - Lets Get Started](images/WebMatrix/web-start.png?raw=true)

1. On the next screen, review the licensing terms and conditions and click **Accept and Continue**.

1. On the next screen you are presented with four options for configuring the database to be used by Umbraco. Choose the option marked I want to use SQL CE 4 and click Install. This is the quickest and easiest option to get started with Umbraco, especially for small sites, and uses a file stored on disk as the database.

	*If you need to migrate your database from SQL CE to SQL Server you can do it at a later point.*

	![Web Installer - Database choice](images/WebMatrix/web-db-CE.png?raw=true)

	1. You will be shown the progress bar during the database installation, once done click **Next**

	![Web Installer - Database Install](images/WebMatrix/web-db-install.png?raw=true)

1. On the next screen you need to fill in the form to create a user so you can access the back office of Umbraco. Once completed click **Create user**

	![Web Installer - Create User](images/WebMatrix/web-user.png?raw=true)

1.  From this next step you can decide if you want to install a starter kit. A starter kit installs an example site for you which allows you to pull it apart and learn how Umbraco works.

1. After deciding whether to skip or install a starter kit you are finished!

1. Now click the **Set up your new website** to be logged into the Umbraco back-office.

	![Web Installer - Install Complete](images/WebMatrix/web-finish.png?raw=true)

1. Celebrate - you're all done!

### Congratulations, you have installed an Umbraco site!

### Note
*You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/*

###Post installation
One important recommendation is to always remove the `install` folder immediately after installing Umbraco and never to upload it to a live server.
