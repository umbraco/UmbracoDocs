# Hotfixes

When managing an Umbraco Cloud project with multiple environments, you might need to push a hotfix to your Live environment. There might be a possiblity that you have pending changes in other environments that are not ready for deployment.

## Scenario

Imagine you have two environments: Live and Development. You are currently working on some changes in your local clone of the Development environment. These changes will not be ready for the Live environment for a couple of weeks. However, you need to apply a minor change to your Live environment – a _hotfix_.

### Standard Workflow

Typically, you would make the hotfix locally, push it to the Development environment, and then deploy it to Live. In this scenario, that process is not possible as you do not want to deploy the other pending changes you are still working on.

### Best Practices

Following Umbraco Cloud's workflow, you should never make changes directly to the Live environment unless it is the only environment you have. For more information about environments on Umbraco Cloud, see the [Project Overview](../../../begin-your-cloud-journey/project-features/) article.

## Applying Hotfixes

It is possible to apply specific changes to your Live environment without breaking Umbraco Cloud workflow. Here are two approaches:

1. [Deploy hotfix with Git branching](./#deploy-hotfix-with-git-branching)
2. [Move files manually](./#move-files-manually)

## [Deploy hotfix with Git branching](using-git.md)

Clone the Development environment and use Git to push the selected changes to the Live environment. The advantage of using this approach is that your Git history is more accurate and you only work with one local repository. This method requires Git knowledge, but a Git client can simplify the process. You should only go with this guide if you feel comfortable working with Git.

For more information, see the [Apply hotfix by using Git](using-git.md) article.

![Use Git](../../../deployment/hotfixes/images/hotfix-using-git.gif)

## [Move files manually](move-files-manually.md)

Clone both your Development and Live environment to your local machine. Copy the updated files from the cloned Development environment to the cloned Live environment. Push the files to the Live environment on Umbraco Cloud. This allows you to test the changes on a cloned Live environment before pushing it to the Cloud.

For more information, see the [Apply hotfix by manually moving files](move-files-manually.md) article.

![Manual move](../../../deployment/hotfixes/images/hotfix-manual-move.gif)
