# Known Limitations and Considerations

As we continue to gather insights from our users, there are some known limitations and considerations to be aware of.

{% hint style="info" %}
Attaching a CI/CD pipeline to a flexible environment is currently not possible. The CI/CD workflow must go through the mainline deployment workflow.
{% endhint %}

## Potential Limitations and Considerations

**Format Restrictions**

* The packaged artifact from your CI/CD pipeline must adhere to the Umbraco Cloud API's required format, which is a zip source file. This could necessitate changes to your existing build and packaging scripts.

**Workflow considerations**

* To ensure smooth execution of the CI/CD Flow, it is recommended to make schema changes in the [left-most mainline environment](../../../deployment/). For example, the local development environment. Schema changes include changes made to Document Types, Data Types, Templates, and the like. The intention behind this principle is to prevent conflicts that could potentially arise due to simultaneous modifications made in different environments.

**Additional Build Step**

* The flow feature adds an extra build to the deployment process. As a result, it takes longer to post to Umbraco Cloud using Umbraco CI/CD Flow compared to standard deployments.

**Conflict Management**

* Given the necessity to avoid changes in other environments, the lack of strict coordination among multiple teams or individuals working on the same project elevates the risk of conflicts.

## Key Points to Consider

* **Direct Commits to Umbraco Git Repos**: Any commits made directly to the Umbraco-git-repos will cause the process to fail.
* **Remote Build/Test Options**: It is currently not possible to skip the first build step before committing.
* **Incomplete API**:
  * The promotion endpoint for transitioning from dev to stage to live is not fully functional yet.
* **Hotfix Deployments**: Direct deployments to a specific environment are not supported at this time.
* **Lack of Predefined Tasks**: There are no Umbraco-provided Azure DevOps tasks or GitHub Actions available.
* **No Webhooks**: Currently, there's no webhook support for real-time feedback to the pipeline; polling is the only option.
* **Casing Conflicts**: Be cautious of casing issues, such as having a README.md file created by Azure DevOps and a `Readme.md` file from the default Umbraco Cloud, as this can cause conflicts in the cloud Git repository.

