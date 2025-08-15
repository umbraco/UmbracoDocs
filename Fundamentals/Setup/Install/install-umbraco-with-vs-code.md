---
versionFrom: 7.0.0
---

# Install Umbraco with Visual Studio Code

Follow these steps to be up and running with VS Code quickly. The benefit of using VS Code is that it is super quick to get up and running.

:::note
The information in this article covers installing Umbraco 8 or older versions of Umbraco CMS.

Go to [**docs.umbraco.com**](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/install/install-umbraco-with-vs-code) to find documentation on installing the latest recommended version of Umbraco CMS.
:::

## Download and Launch VS Code

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/) and download VS Code for free.

1. Go to [https://www.microsoft.com/en-us/download/details.aspx?id=48264](https://www.microsoft.com/en-us/download/details.aspx?id=48264) and download IIS Express. <br/>*This is optional as the VS Code IIS Express extension will install this automatically for you now*

1. Once installed, launch VS Code.

1. Click the extensions menu at the bottom on the left side. Then search for **IIS Express**, install it then press reload.

    ![VS Code install extension](images/VsCode/1.png)

1. Download a fresh Umbraco installation from  [https://our.umbraco.com/download/](https://our.umbraco.com/download/releases/81815) then unzip and drag it into VS Code.

    ![Fresh Umbraco installation](images/VsCode/2.png)

1. To launch the site press **CTRL+F5**, this will open a local version of Umbraco in your standard browser.


## Umbraco Web Installer
This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.

1. You will see the welcome screen. If you want a fast demo site fill in the information and click **Install!** If you want to decide the database type, or install without a starter site then click **Customize!**

    ![Web Installer - Lets Get Started](images/VsCode/Installer-v8.png)

1. When the installer is done you will automatically be logged into the backoffice.

    ![Web Installer - Install Complete](images/VsCode/dashboard-v8.png)

1. Celebrate - you're all done!

### Congratulations, you have installed an Umbraco site!

### Note
*You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/*
