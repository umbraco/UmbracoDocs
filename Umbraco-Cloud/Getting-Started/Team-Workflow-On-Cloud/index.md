---
versionFrom: 7.0.0
---
# Best practice for working in teams on Umbraco Cloud

In this article we will take a look at some of the best practices and recommendations when you are working in teams on your Umbraco Cloud projects.

## Working with GIT in Teams

### Pull before you push

Always start out with making a pull from your project before you push anything back up to cloud.  This way you ensure that you do not accidently overwrite the work that someone else in your team have worked with.

### Create branches locally

Umbraco Cloud is build on top of GIT meaning that you can create branches locally as either a feature or developer branch. You can then work on the project and test out the new features before merging it into the master branch which can then be pushed up to your cloud environments.

## Working with Environments in a team

### Set up a Development environment

We highly recommend that you use a Development environment when you are working in teams. With the Development environment, several members of a team can work on their own local version of the project. They can then push back up to the development environment to be tested and approved before being deployed to either the staging or the live environment.

### Set up a staging environment

When working in a bigger team with both developers and content editors, we highly recommend that you set up a Staging environment. This way the developers can continue developing on the Development environment, while the content editors can focus on create delighful content on the Staging environment.

## Team development workflow On Cloud

For a more in-depth example of how to work in team our Cloud, Our Gold Partner ProWorks have created an article about how they have set up a [Team development workflow on Umbraco Cloud](https://skrift.io/issues/integrating-umbraco-cloud-with-team-development-workflow/).

This article can serve as inspiration if you are an agency and are looking into setting up a bigger project where several people will be working on Umbraco Cloud.
