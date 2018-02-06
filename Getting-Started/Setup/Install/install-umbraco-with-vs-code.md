#Install Umbraco with Visual Studio Code

Follow these simple steps to be up and running with VS Code quickly and easily. The benefit of using VS Code is that it is super simple to get up and running.

##Download and Launch VS Code

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/) and download VS Code for free.

1. Once installed, launch VS Code.

1. Click the extensions menu at the bottom on the left side. Then search for **IIS Express**, install it then press reload.

	![VS Code install extension](images/VsCode/1.PNG)

1. Download a fresh Umbraco installation from  [https://our.umbraco.org/download/](https://our.umbraco.org/download/) then unzip and drag it into VS Code.

	![Fresh Umbraco installation](images/VsCode/2.PNG)

1. To launch the site press **CTRL+F5**, this will open a local version of Umbraco in your standard browser.


## Umbraco Web Installer
This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.

1. You will see the welcome screen. If you want a fast demo site just fill in the information and click **Install!** If you want to decide the database type, or install without a starter site then click **Customize!**

	![Web Installer - Lets Get Started](images/VsCode/3.PNG)

1. When the installer is done you will automatically be logged into the backoffice.

	![Web Installer - Install Complete](images/VsCode/4.png)

1. Celebrate - you're all done!

### Congratulations, you have installed an Umbraco site!

### Note
*You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/*

###Post installation
One important recommendation is to always remove the `install` folder immediately after installing Umbraco and never to upload it to a live server.