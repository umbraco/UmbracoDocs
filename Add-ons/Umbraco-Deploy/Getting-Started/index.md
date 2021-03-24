---
versionFrom: 8.0.0
---

# Getting started with Umbraco Deploy

Umbraco Deploy is the engine that runs behind the scenes on Umbraco Cloud.

Umbraco Deploy lets you use the Umbraco Cloud Deployment technology outside of Umbraco Cloud to ease deployment between multiple Umbraco environments by connecting external hosted Umbraco projects with localhost or Umbraco Cloud as Development environments.

## Getting started

There are three main steps you need to go through in order to start using Umbraco Deploy on your website.

1. [Set up Git repository and new Umbraco project](Installation#Set-up-Git-repository-and-Umbraco-project)
    - Set up a repository and then install a new Umbraco project inside it.

2. [Install Umbraco Deploy via NuGet](Installation#Installing-and-setting-up-Umbraco-Deploy)
    - Umbraco Deploy can be installed via NuGet.

3. [Configure CI/CD build server](Installation#Setting-up-CI/CD-build-server-with-Github-actions)
    - Umbraco Deploy needs a CI/CD build server needs to be set up to run when you want changes to be deployed to next upstream environment

## How Umbraco Deploy works

Umbraco Deploy works by serializing non-content Umbraco items (called “Schema” items) to disk. These serialized files are located in the `~/data` folder at the root of your website.

These items are entities like Document Types, Media Types, Data Types, etc, and these files must be committed to source control (i.e. Git). Umbraco Deploy works by “extracting” this serialized information back into your Umbraco installation, which is done by deployment triggers when a deployment is sent to a target environment.

For example, when working locally you might create a new Document Type. This will automatically create a new on-disk file in the `~/data` folder which is the serialized version of the new Document Type. You would then commit this file to your repository and push this change to your hosted source control (i.e. GitHub).

When you want this deployed to your next upstream environment (i.e. staging), you would trigger your CI/CD process or Build Server (e.g. Azure DevOps or Github Actions). This will then push the changes to your development environment and once the build deployment completes successfully, a Deployment Trigger would be executed as an HTTPS request to your target environment. All changes found in the `~/data` folder will then be extracted into the Umbraco target environment.

![Deploy workflow](images/Deploy_concept.png)
