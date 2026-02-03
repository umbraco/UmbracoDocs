---
description: Learn about the different limitations the feature currently holds, and what is being considered for the future.
---

# Known Limitations and Considerations

As insights are being gathered from users of this feature, there are some known limitations and considerations to be aware of.

## Format Restrictions

The packaged artifact from your CI/CD pipeline must adhere to the Umbraco Cloud API's required format, which is a zip source file. This could necessitate changes to your existing build and packaging scripts.

## Workflow considerations

To ensure smooth execution of the CI/CD Flow, it is recommended to make schema changes in the [left-most mainline environment](../deployment/). This could be the local development environment. Schema changes include changes made to Document Types, Data Types, Templates, and the like. The intention behind this principle is to prevent conflicts that could potentially arise due to simultaneous modifications made in different environments.

## Additional Build Steps

The flow feature adds an extra build to the deployment process. As a result, it takes longer to post to Umbraco Cloud using Umbraco CI/CD Flow compared to standard deployments.

## Conflict Management

Without coordination between teams, the risk of project conflicts increases, especially when trying to avoid unintended changes across different environments.

## Key Points to Consider

* **Direct Commits to Umbraco Git Repos**: Any commits made directly to the Umbraco-git-repos will cause the process to fail.
* **Remote Build/Test Options**: It is currently not possible to skip the first build step before committing.
* **Incomplete API**: The promotion endpoint for transitioning between environments is not fully functional yet.
* **Hotfix Deployments**: Direct deployments to a specific environment are not supported at this time.
* **Lack of Predefined Tasks**: There are no Umbraco-provided Azure DevOps tasks or GitHub Actions available.
* **No Webhooks**: Currently, there's no webhook support for real-time feedback to the pipeline; polling is the only option.
* **Casing Conflicts**: Be cautious of casing issues, such as having a `README.md` file created by Azure DevOps and a `Readme.md` file from the default Umbraco Cloud. This can cause conflicts in the cloud Git repository.
