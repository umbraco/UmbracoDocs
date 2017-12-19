# Welcome to Umbraco Cloud
We're excited you have decided to use Umbraco Cloud!

In this article you can read all about how to manage your Umbraco Cloud projects, and learn what a project on Umbraco Cloud constists of.

## Overview
Umbraco Cloud is a new way to work with your favorite CMS! It includes 10-ears of experience and best-practices in an intuitive, simple, but robust approach. No matter if you’re working in a team or of you’re single handedly building a website, Umbraco Cloud removed the barriers that slow down projects and get in the way of beautiful, functional sites.

Umbraco Cloud is Umbraco - plus a whole lot more! Built on the Microsoft Azure Cloud and encompassing web standard approaches, Umbraco Cloud is familiar to Umbraco users new and old. We’ve made it painfully simple to get started with Umbraco Cloud and there are no limits to what you can accomplish - literally anything you can do with Umbraco and web technology you can do with Umbraco Cloud.

Umbraco Cloud takes care of installation, infrastructure and security. We also provide you the tools to work with your project in the Cloud or or locally by cloning the project down to your PC, Mac or even your tablet.

When you’re ready to show your work to the world, Umbraco Cloud provides a safe deployment mechanism that makes it easy for you to publish to the web. When you have changes or updates to your site, Umbraco Cloud has got you covered: An easy to follow process for moving, testing and deploying your changes to your public site. 

With all the success you’ll have building your site with Umbraco Cloud you’ll want to add more, which is easily done using the same account and team members - all this is done from one single place: The Umbraco Cloud Portal. That’s simplicity!

[Learn more and sign up for Umbraco Cloud](https://umbraco.com/cloud)

## An Umbraco Cloud project

The easiest way to get started with an Umbraco Cloud project is to take a 14-day free Trial - the project will automatically be created for you, and you are ready to get started within a few minutes.

Once the project has been setup, you can choose to either start with a blank slate or go for a [*Starter kit*](https://our.umbraco.org/Documentation/Tutorials/Starter-kit/Index/) which will install a full template site for you.

To start working with and building your site, you can either work directly in the backoffice on the Cloud environment or you can [clone down the project to your local machine](../../set-up/working-locally) - for Mac uses, see [Working with UaaS-Cli](../../Set-up/working-with-uaas-cli).

### Get to know your project

Umbraco Cloud projects are made of three major components: environments, team members and a settings section.

![Project overview](images/project-components.png)

#### Environments

The number of environments on your project is dependent on which plan you are on:

* With the **Starter plan** you get a single _Live_ environment and have the option to add additional environments - a _Development_ and a _Staging_ environment
* With the **Professional plan** you will get a _Development_ AND a _Live_ environment - as with the Starter Plan you can add/remove environments as needed

When you have multiple environments on your Umbraco Cloud project the *Development* environment will be the *first* environment in the workflow. What this means, is that this is the environment you are going to work with when building the structure of your website. This is also the environment you clone down when you want to work with your project locally.

The environment next in line in the workflow is the *Staging* environment. Having this environment enables you to give your team members different workspaces - the developers can work with code on the Development environment while the content editors can work with content on the Staging environment. All of this without affecting the actual public site.

Both the Development and the Staging environments are protected with **basic authentication**. This means that you have to login to see the frontend of these environments. Alternatively you can [whitelist IP's](/the-umbraco-cloud-portal/#manage-ip-whitelist) to allow access to the environments.

The final environment is the *Live* environment. This is your live site - the site that's visible to the public. When you are in Trial mode the Live environment will be protected by basic authentication - this will of course be removed, as soon as you setup a subscription for the project.

For a more technical overview of your Cloud environments read the [Environments article](/Environments) and for more information about the workflow on Umbraco Cloud read the article about [Deployments](../Deployment).

#### Team Members

The second major component on your Umbraco Cloud project are the team members. When you add team members to a project, they will automatically be added as backoffice users on all the environments as well. Team members can be added as *Admins*, *Writers* or *Readers*. Read the [Team Members article](../../Set-up/Team-members) to learn more about these roles.

#### Settings

The final major component on your Umbraco Cloud project is the *Settings*, where you can manage and configure your project to fit your needs. Learn more about the different settings in the [Umbraco Cloud Portal](/the-umbraco-cloud-portal) article.

## Other ways to start an Umbraco Cloud project

You might not always want to start your Umbraco Cloud project with a clean slate. Perhaps you have an already existing site that you want to move on to the Cloud. For this purpose we've created a [Migration guide](/migrate-existing-site) that you can follow in order to succesfully move your project to Umbraco Cloud.

Another scenario could be if you are creating several similar projects. For this purpose we have built a feature called [Baselines](/Baselines) that let's you create new projects based on existing Umbraco Cloud projects.