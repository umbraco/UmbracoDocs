# Best Practice for Working in Teams

This article will look at some of the best practices and recommendations when you are working in teams on your Umbraco Cloud projects.

## Working with Git in Teams

Always start by making a pull request from your project before you push anything back up to Cloud. This way you ensure that you do not accidentally overwrite the work that someone else in your team has worked with.

### Create branches locally

Umbraco Cloud is built on top of Git which means that you can create branches locally as either a feature or developer branch. You can then work on the project and test out the new features before merging it into the master branch. The branch can then be pushed up to your cloud environments.

## Working with Environments in a team

It is recommended to use multiple environments when you are working in teams. With additional environments, members of a team can work locally, pushing up changes to the Cloud environment for testing.

Having multiple environments enables developers to continue developing, while content editors can focus on creating content in a separate environment.

### Flexible Environments

When you need to work on a new feature, using a flexible environment ensures that the regular workflow isn't affected. The flexible environment is connected to a single mainline environment and isn't part of the left-to-right deployment workflow.

Learn more about how this works in the [Flexible Environments](../../../begin-your-cloud-journey/project-features/flexible-environments.md) article.

## Team development workflow On Cloud

For a more in-depth example of how to work in teams, our Gold Partner ProWorks has written an article on [Team development workflows](https://skrift.io/issues/integrating-umbraco-cloud-with-team-development-workflow/).

This article serves as inspiration if you looking into setting up a bigger project where multiple people will be working on Umbraco Cloud.
