# Getting started with Umbraco Deploy

## What is Umbraco Deploy

Umbraco Deploy is the engine that runs behind the scenes on Umbraco Cloud.

Umbraco Deploy lets you use the Umbraco Cloud Deployment technology outside of Umbraco Cloud to ease deployment between multiple Umbraco environments by connecting external hosted Umbraco projects with localhost or Umbraco Cloud as Development environments.

## How Umbraco Deploy works

Umbraco Deploy works by serializing non-content Umbraco items (called “Schema” items) to disk. These serialized files are located in the folder ~/data at the root of your website.

These items are entities like Content-Types, Media Types, Data Types, etc.

These files must be committed to Source control (i.e. Git). Umbraco Deploy works by “extracting” this serialized information back into your Umbraco installation. This is done by Deployment Triggers when a deployment is sent to a target environment.

For example, when working locally you might create a new Content-Type, this will automatically create a new on-disk file in the ~/data folder which is the serialized version of the new Content-Type. You would commit this file to your repository and push this change to your hosted source control (i.e. GitHub).

When you want this deployed to your next upstream environment (i.e. staging), you would trigger your CI/CD process or Build Server (e.g. Azure DevOps) which will push the changes to your development environment and once the build deployment completes successfully, a Deployment Trigger would be executed as an HTTPS request to your target environment which will extract all changes found in the `~/data` folder into the Umbraco target environment.

![Deploy workflow](images/Deploy_concept.png)

## Getting started

1. [Set up Git repository and new Umbraco project](Installation#Set-up-Git-repository-and-Umbraco-project)
    - Set up a repository and then install a new Umbraco project inside it.

2. [Install Umbraco Deploy via NuGet](Installation#Installing-and-setting-up-Umbraco-Deploy)
    - Umbraco Deploy can be installed via NuGet.

3. [Configure CI/CD build server](Installation#Setting-up-CI/CD-build-server-with-Github-actions)
    - Umbraco Deploy needs a CI/CD build server needs to be set up to run when you want changes to be deployed to next upstream environment
