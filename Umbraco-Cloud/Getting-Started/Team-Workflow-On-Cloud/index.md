---
versionFrom: 7.0.0
versionTo: 10.0.0
---

# Best Practice for Working in Teams on Umbraco Cloud

In this article, we will look at some of the best practices and recommendations when you are working in teams on your Umbraco Cloud projects.

## Working with GIT in Teams

### Pull before you Push

Always start by making a pull request from your project before you push anything back up to Cloud. This way you ensure that you do not accidentally overwrite the work that someone else in your team has worked with.

### Create branches locally

Umbraco Cloud is built on top of GIT which means that you can create branches locally as either a feature or developer branch. You can then work on the project and test out the new features before merging it into the master branch which can then be pushed up to your cloud environments.

## Working with Environments in a team

### Set up a Development environment

We highly recommend that you use a Development environment when you are working in teams. With the Development environment, members of a team can work on their local version of the project. They can then push back up to the development environment to be tested and approved before being deployed to either the staging or the live environment.

### Set up a Staging environment

When working in a bigger team with both developers and content editors, we highly recommend that you set up a Staging environment. This way the developers can continue developing in the Development environment, while the content editors can focus on creating delightful content in the Staging environment.

## Team development workflow On Cloud

For a more in-depth example of how to work in teams on Umbraco Cloud projects, Our Gold Partner ProWorks have created an article about how they have set up a [Team development workflow on Umbraco Cloud](https://skrift.io/issues/integrating-umbraco-cloud-with-team-development-workflow/).

This article can serve as inspiration if you are an agency and are looking into setting up a bigger project where several people will be working on Umbraco Cloud.
