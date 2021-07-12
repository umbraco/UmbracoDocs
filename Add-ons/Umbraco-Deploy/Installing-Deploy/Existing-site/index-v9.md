---
versionFrom: 9.0.0
meta.Title: "Installing Umbraco Deploy on an existing Umbraco website"
meta.Description: "Steps to how Umbraco Deploy can be set up on an existing Umbraco website"
state: complete
verified-against: beta001
---

# Installing Umbraco Deploy on an existing project

In this article, we will cover the steps in order for you to install Umbraco deploy on your already existing website with content

We will cover how to install Umbraco deploy and set up Umbraco deploy on your website and how you can generate the UDA files based on your production websites database.

## Prerequisites

* Visual studio 2017 v15.9.6 or later

* Umbraco Deploy license

* Copy of your production site's database

* Copy of views, css and scripts folder from production

* CI/CD or Build Server that supports executing Powershell

## Installation steps

1. [Create copy of database and download views, CSS and scripts files from your production site](#install-umbraco-deploy-on-existing-site)
2. [Set up Git repository and new Umbraco project](#set-up-git-repository-and-umbraco-project)
3. [Install Umbraco Deploy via NuGet](#installing-and-setting-up-umbraco-deploy)
4. [Configure CI/CD build server](#set-up-cicd-pipeline)

## Install Umbraco Deploy on Existing site

To install Umbraco Deploy on an already existing site there are some additional steps that needs to be taken to make sure that Umbraco Deploy can run with your website.

On an existing Umbraco website, there is already a set of Document Types, Templates and Data Types with ID's in the database. In order for Umbraco Deploy to work with your website, you will need to make sure that these IDs are in sync between the different environments that you want to add to your setup.

1. Make a copy of the database on the production site.
2. Download your `/Views` folder as well as the folders holding your css files and scripts.

When the production database, folder and files have been copied down, it's time to set up a git repository and a new Umbraco project.

### Set up Git repository and Umbraco project

The next step to get Umbraco Deploy up and running is to set up a repository and install Umbraco into it.

1. Set up a repository with a .gitignore file using the Visual Studio template.
2. Clone down the repository to your local machine.
3. [Create a new Umbraco V9 project](UmbracoNetCoreUpdates).
4. Use the copy of your production Database when setting up the database for the emppty project.
5. Add the `/Views` folder as well as the folders holding your css files and scripts.
6. Commit the files so they are ready to be pushed up once you have set up the build server.
7. Run the project.

After the Umbraco files have been committed add the following lines to the .gitignore so that they will not be picked up by Git when we are deploying.

```none
**/App_Data/*
!**/App_Data/packages
**/media/*

# Umbraco deploy specific
**/data/deploy*
```

### Installing and setting up Umbraco Deploy

When Umbraco has been installed in a repository, we can go ahead to [install and configure Umbraco Deploy in the project](../Install-Configure/index-v9).

### Set up CI/CD Pipeline

At this stage your new website is prepared for use with Umbraco Deploy.  You should now move on to the setup of your [CI/CD build and deployment pipeline](../CICD-Pipeline).

Once the build server has been set up you can start creating content and sync it between your environments. Make sure to follow the proper [deployment workflow](../../Deployment-Workflow).

This will only deploy the schema data. To transfer content and media you will need to do it from the backoffice of your project using the [queue for transfer feature](../../deployment-workflow/content-transfer).
