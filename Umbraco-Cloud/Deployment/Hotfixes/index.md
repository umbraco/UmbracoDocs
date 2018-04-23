# How to handle hotfixes on Umbraco Cloud projects

When you have an Umbraco Cloud project with multiple environments, you might run into a situation where you need to push a hotfix to your Live environment, but have other pending changes on your Development environment that is not ready for the Live site.

Let's say you have 2 environments, a Live environment and a Development environment. You are currently working on building some changes on your Development environment, but these changes wont be ready for the Live environment for another few weeks. Now you need to apply a minor change to your Live environment - a *hotfix*. Normally you would do this, by making the hotfix on the Development environment and deploy it to the Live environment. In this scenario that's not possible, as you do not want to deploy the other changes you are still working on.

Following the workflow of an Umbraco Cloud project, the 

