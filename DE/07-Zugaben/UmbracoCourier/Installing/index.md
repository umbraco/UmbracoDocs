---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Installation

## Installing Courier

The following guide will use two example sites; *development.site* and *live.site*. The guide will go through how to install and configure Umbraco Courier on two sites in order to be able to use Courier to transfer types and content between the two.

* Go to the **Developer** section of the backoffice
* Find **Packages** in the left navigation tree
* The **Umbraco Courier** package is usually one of the top packages - otherwise you can search for it
* Follow the installation directions
* Once Courier has been installed, make sure to **refresh the page**
* Next step is to **add a location**
    * In the gif below Courier is installed on development.site, and live.site is added as the location
* The location you add, will be set in the `config/courier.config` file as a *repository*. Learn more about this in the [Repository Providers](../Configuration/RepositoryProviders.md) article.

![InstallingCourier](images/InstallCourier.gif)

Repeat these steps on **all sites where you want to use Courier**.

Before you can start transferring between your sites, you need to **add a Courier API key** to the `courier.config` file on all the sites.

* Find the `courier.config` file in the `/config` folder
* In the `<security>` section, find the `<auth>` section - it will look like this:

```xml
<auth>
    <method>credentials</method>
    <apikey></apikey>
</auth>
```

* Change `<method>` to **token**
* Add a **randomly generated api key with at least 10 characters** - use only letters and/or numbers, ex. `3ljh6k2l1e`
* The <auth> section should look something like this:

```xml
<auth>
    <method>token</method>
    <apikey>1234567890</apikey>
</auth>
```

* Make sure to make this change on all the sites where you want to use Courier
* **Important:** For Courier to work between the projects, you need to use the same Courier API key on all sites

You have now set up Courier on your sites, and you are ready to start transferring between them!

:::note
If you are testing Courier locally, you need to setup local hostnames to run your projects from. Follow the steps outlined below to get up and running.
:::

### Testing Courier locally

When you are testing Courier on two Umbraco sites locally, it’s recommended that you bind local hostnames to the sites.

* Open **IIS (Internet Information Services) Manager** on your local Windows machine
* In the navigation bar to the left, right-click on **Sites**, and choose **Add Websites…**
* Give the site a name - *example: Development*
* Add the **path to the project directory**
* Finally, set the hostname - *example: development.site*
* When you click ‘*OK*’ the website will start
* In the navigation to the left, click **Browse _yourdomain_**

![Setup Local hostnames](images/setupLocalIIShostnames.gif)

## Reference

* [Install older versions of Courier](../Old-Courier-versions/Installation)
