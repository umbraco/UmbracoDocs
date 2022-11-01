---
versionFrom: 8.0.0
---
# Introduction

The **Creating a Basic Site** tutorial provides step by step instructions to build an Umbraco website using a set of flat HTML, CSS, and JavaScript files. The tutorial allows you to use a website template, customize it, and wire up the sections that need content managing in the Umbraco CMS.

## **What You Need**

To install a basic website in the Umbraco CMS, you need the following:

* A clean and empty installation of the Umbraco CMS without the starter site installed. See the [Verifying your Umbraco Installation](#verifying-your-umbraco-installation).
* This tutorial uses a copy of the Custom Umbraco Template – a HTML5, responsive website template. Download the [Custom Umbraco Template](https://umbra.co/Umbracotemplate) or, if you prefer, you can use your own flat HTML files.

## **Getting Started**

### Installing Umbraco

To download the latest version of Umbraco, refer to the [Installation article](../../../Getting-Started/Setup/Install). On the installation wizard, follow the steps:

1. Enter your **Name**, **Email**, and **Password**.
    ![Installing Umbraco](images/figure-7-installing-umbraco.png)
2. Click **Customize**.
3. In the **Configure an ASP.Net Machine Key** window, click **Continue**.
4. In the **Configure your database** window, leave the default selection and click **Continue**.
5. In the **Install a starter website**, click **No thanks, I do not want to install a starter website**.
    ![Starter Website](images/figure-8-starter-website.png)
6. The installation will take a couple of minutes to complete.
7. Once the installation is complete, you will see the **Login** screen. You can enter the **Name** and **Password** used during the installation process.

### Verifying your Umbraco Installation

When you run your localhost address (<http://localhost:xxxx>), you will see the **Welcome to your Umbraco installation** screen.
![Welcome to your Umbraco installation screen](images/figure-3-empty-umbraco-install-v8.png)

If you see the starter kit, you need to re-install Umbraco. To re-install Umbraco, follow these steps:

1. Delete the folder from where you run the localhost.
2. Unzip the downloaded Umbraco installation folder and open the extracted folder in VS Code.
3. Run localhost in your browser and complete the [installation steps](#installing-umbraco).

### Preparing the Custom Umbraco Template Site

1. Unzip the [Custom Umbraco Template](https://umbra.co/Umbracotemplate) to a folder on your system.  
2. Open the **index.html** from the folder in your preferred browser to see the template. The template contains some text with dummy links. We’re going to turn this into a fully fledged, Umbraco-powered site!
![Custom Umbraco Template](images/figure-5-retrospect-template-v8.png)

### Logging in to Umbraco

You can login to Umbraco in two ways:

1. Once the installation is complete, you will see the **Login** screen. You can enter the **Name** and **Password** used during the installation process.
2. Run localhost in your browser, you will see the **Welcome to your Umbraco installation** screen:
    1. Click **Open Umbraco**.
    2. Enter the **Name** and **Password** used during the installation process. You should see a similar Umbraco Backoffice as the image below:
    ![An empty Umbraco installation backoffice](images/figure-6-umbraco-empty-v8.png)

---

## Next: [Creating Your First Document Type](../Document-Types)
