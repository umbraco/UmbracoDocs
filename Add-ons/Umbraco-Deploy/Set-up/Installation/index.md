---
versionFrom: 8.0.0
---

# Installing Umbraco Deploy

In this article we will cover the steps in order for you to install Umbraco deploy on a brand new website.

We will cover how to install Umbraco deploy and set up Umbraco deploy on your website as well as how you can set up a CI/CD build server using Github actions to run the deployment process.

## Prerequisites

* Umbraco CMS version 8

* Visual studio 2017 v15.9.6 or later

* Git and Github repository

* CI/CD or Build Server that supports executing Powershell

* SQL Server Database

## Installing Umbraco Deploy on a new site

<!--SHould be moved to the installation guide
## UmbracoDeploy.config

You might notice a new file in your config folder called UmbracoDeploy.config. This files tells the deployment engine where to deploy to, it knows which environment you’re currently on (for example local or staging) and chooses the next environment in the list to deploy to.

![clone dialog](images/umbraco-deploy-config.png)

**Note**: you’re free to update the “name” attribute to make it clearer in the interface where you’re deploying to. So if you want to name “Development” something like “The everything-goes area” then you can do that and it will be shown when deploying to that environment.
-->