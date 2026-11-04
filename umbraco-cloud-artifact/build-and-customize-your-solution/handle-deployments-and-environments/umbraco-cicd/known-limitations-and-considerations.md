---
description: Learn about the different feature limitations and what is being considered for the future.
---

# Known Limitations and Considerations

As insights are gathered from users of this feature, there are some known limitations and considerations to be aware of.

## Format Restrictions

The packaged artifact from your CI/CD pipeline must adhere to the Umbraco Cloud API's required zip source file format. This could necessitate changes to your existing build and packaging scripts. Read about [Artifact best practice](./samplecicdpipeline/artifact-best-practice.md).

## Workflow considerations

To ensure smooth execution of the CI/CD Flow, it is recommended to avoid making any schema changes on any [cloud environment](../deployment/). 
Use your local clone to add or edit Document Types, Data Types, Templates, and the like. Use CI/CD Flow to deploy to Umbraco Cloud. The intention behind this principle is to prevent conflicts that could potentially arise due to simultaneous modifications made in different environments.

## Additional Build Steps

The CI/CD Flow feature starts an isolated instance, which may add an extra build to the deployment process. It takes longer for a deployment to finish through Umbraco CI/CD Flow compared to standard deployments.

## Conflict Management

Without coordination between teams, the risk of project conflicts increases, especially when trying to avoid unintended changes across different environments. Make sure to handle changes and local conflicts in your version control system. 

## Key Points to Consider

* **Direct Commits to Umbraco Git Repos**: Any commits made directly to the Umbraco Git Repos are not advised.
* **Incomplete API**: The promotion endpoint for transitioning between environments is not fully functional yet.
* **Lack of Predefined Tasks**: There are no Umbraco-provided Azure DevOps tasks or GitHub Actions available.
  * [GitHub Actions: Our Umbraco Cloud Action](https://github.com/marketplace/actions/umbraco-cloud-deployment-action)
* **No Webhooks**: Currently, there's no webhook support for real-time feedback to the pipeline; polling is the only option.
* **Casing Conflicts**: Be cautious of casing issues, such as having a `README.md` file created by Azure DevOps and a `Readme.md` file from the default Umbraco Cloud. This can cause conflicts in the cloud Git repository.
