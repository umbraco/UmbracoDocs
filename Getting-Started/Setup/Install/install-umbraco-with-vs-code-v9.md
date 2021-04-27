---
v8-equivalent: "https://github.com/umbraco/UmbracoDocs/blob/main/Getting-Started/Setup/Install/install-umbraco-with-vs-code.md"
versionFrom: 9.0.0
verified-against: alpha-4
state: partial
updated-links: true
---

# Install Umbraco with Visual Studio Code

Follow these steps to set up an Umbraco solution with VS Code. The benefit of using VS Code is that it is super quick to get up and running.

## Download and Launch VS Code

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/) and download VS Code for free.

1. Go to [https://www.microsoft.com/en-us/download/details.aspx?id=48264](https://www.microsoft.com/en-us/download/details.aspx?id=48264) and download IIS Express. <br/>*This is optional as the VS Code IIS Express extension will install this automatically for you now*

1. Once installed, launch VS Code.

1. Click the extensions menu at the bottom on the left side. Then search for **IIS Express**, install it then press reload.

    ![VS Code install extension](images/VsCode/1.png)

1. Download a fresh Umbraco installation from [https://our.umbraco.com/download/](https://our.umbraco.com/download/) then unzip and drag it into VS Code. Or use our Umbraco .NET Core template which will download Umbraco automatically. For a guide on how to do that, check the [New templates installation](install-umbraco-with-templates.md).

    ![Fresh Umbraco installation](images/VsCode/2.png)

1. To launch the site press **CTRL+F5**, this will open a local version of Umbraco in your standard browser.


## Umbraco Web Installer
This section continues from where we left off but covers the installation and configuration of Umbraco inside your web browser when you run Umbraco for the first time.

1. You will see the welcome screen. If you want a fast demo site fill in the information and click **Install!** If you want to decide the database type, or install without a starter site then click **Customize!**

    ![Web Installer - Lets Get Started](images/VsCode/installer-v9.png)

1. When the installer is done you will automatically be logged into the backoffice.

    ![Web Installer - Install Complete](images/VsCode/dashboard-v8.png)

1. Celebrate - you're all done!

### Congratulations, you have installed an Umbraco site!

### Note
*You can log into your Umbraco site by entering the following into your browser: http://yoursite.com/umbraco/*