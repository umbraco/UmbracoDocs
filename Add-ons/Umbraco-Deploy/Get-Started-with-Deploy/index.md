---
versionFrom: 8.0.0
meta.Title: "Getting started with Umbraco Deploy"
meta.Description: "What is Umbraco Deploy, how does it work and how to get started using Umbraco Deploy "
---

# Getting started with Umbraco Deploy

Umbraco Deploy is the engine that runs behind the scenes on Umbraco Cloud and takes care of all the deployment processes of both code, schema and content on projects.

With Umbraco Deploy (on-premises) you get to use the Umbraco Cloud Deployment technology outside of Umbraco Cloud to ease deployment between multiple Umbraco environments. This is done by connecting external hosted Umbraco projects with a local instance of your Umbraco website.

In this article you can learn more about what it takes to get started using Umbraco Deploy on your project, and you can also get a high-level overview of how the product works.

## Getting started

There are three main steps you need to go through in order to start using Umbraco Deploy on your website.

1. [Set up Git repository and new Umbraco project](../installation/new-site#set-up-git-repository-and-umbraco-project)
    - Set up a repository and then install a new Umbraco project inside it.

2. [Install Umbraco Deploy via NuGet](../Installation/new-site#installing-and-setting-up-umbraco-deploy)
    - Umbraco Deploy can be installed via NuGet.

3. [Configure CI/CD build server](../Installation/new-site#setting-up-cicd-build-server-with-github-actions)
    - Umbraco Deploy needs a CI/CD build server needs to be set up to run when you want changes to be deployed to next upstream environment

## How Umbraco Deploy works

Umbraco Deploy works by serializing non-content Umbraco items (called “Schema” items) to disk. These serialized files are located in the `~/data` folder at the root of your website.

These items are entities like Document Types, Media Types, Data Types, etc, and these files must be committed to source control (i.e. Git). Umbraco Deploy works by “extracting” this serialized information back into your Umbraco installation, which is done by deployment triggers when a deployment is sent to a target environment.

For example, when working locally you might create a new Document Type. This will automatically create a new on-disk file in the `~/data` folder which is the serialized version of the new Document Type. You would then commit this file to your repository and push this change to your hosted source control (i.e. GitHub).

When you want this deployed to your next upstream environment (i.e. staging), you would trigger your CI/CD process or Build Server (e.g. Azure DevOps or Github Actions). This will then push the changes to your development environment and once the build deployment completes successfully, a Deployment Trigger would be executed as an HTTPS request to your target environment. All changes found in the `~/data` folder will then be extracted into the Umbraco target environment.

![Deploy workflow](images/Deploy_concept.png)
