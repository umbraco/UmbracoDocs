---
versionFrom: 7.0.0
---

# Repositories in an Umbraco Cloud Project

Each Umbraco Cloud project can have multiple environments: Development, Staging, and Live depending on your Cloud project plan. Each environment has it's own git repository that is hosted on Umbraco’s Cloud platform.

:::note
Umbraco Cloud repositories are *only* deployment repositories and should not be used as source code repositories.
:::

Ideally, your Umbraco Cloud setup should look like this:

- [A source control repository with your own code](#a-source-control-repository-with-your-own-code)
- [A Umbraco Cloud source control repository with the locally cloned Umbraco project](#a-git-umbraco-cloud-source-control-repository-with-the-locally-cloned-umbraco-project)

## A source control repository with your own code

Source control is a way to control changes to files and directories. You can keep a record of changes and revert to specific versions of a file in the event you would like to back up to an earlier time. A source control repository is used as the single source of truth that has the latest version of your project source code with all the git branches.

There are different source code management tools that you can use such as GitHub, Git, GitLab, Apache Subversion (SVN), Mercurial, etc.

You need to put your custom code in a different source control repository of your choice. You can use the source control repository to store the custom models, controllers, class libraries, CS code etc as the Umbraco Cloud Git repository can only store the dll files of your C# files.

## A Git Umbraco Cloud source control repository with the locally cloned Umbraco project

We recommend creating a Cloud project with at least two environments: a Development environment and a Live environment. To work with a local copy of your site, you then clone down the Development environment using the **Clone project** option from the Cloud Portal and start building your website locally. This repository is different from your source control repository.

Once you're happy with the results or wish to see how your website has progressed, you push the changes back to the Development environment. If everything is working as expected you then deploy your changes to the Live environment.

### Code Deployment Summary

![Umbraco Cloud Overview](images/UCP_v8.png)

In the above diagram, the external git repository contains the source code of a class library CS project, if you had a class library project that was used in your Umbraco Cloud project.

With this setup, you commit your changes twice. Once to commit your code in your source control and the other commit to the Umbraco Cloud GIT repository to deploy your website. Your source code is not hosted on Umbraco Cloud but only your cloned project will be in the Umbraco Cloud GIT Repository. Your code is built and compiled into the cloned project and then pushed to Umbraco Cloud. Thus updating the site with your latest code changes.

## Disadvantages of using an Umbraco Cloud Project repository as a source code repository

- We only guarantee to maintain and keep the `master` branch. If there are any other branches, they might be removed without any notification causing data loss.

- You will always need to commit your dll files.
