# Known Limitations and Considerations

## Potential Limitations and Considerations

**Format Restrictions**

* The packaged artifact from your CI/CD pipeline must adhere to the Umbraco Cloud API's required format, which is a zip source file. This could necessitate changes to your existing build and packaging scripts.

**Back Office Limitations**

* To ensure smooth execution of the Umbraco CI/CD Flow, it is highly recommended to adhere to a specific principle: refrain from making any alterations to the schema, except in the leftmost environment within the Umbraco Cloud back offices. The intention behind this principle is to prevent conflicts that could potentially arise due to simultaneous modifications made in different environments.

**Additional Build Step**

* The flow feature adds an extra build to the deployment process. As a result, it takes longer to post to Umbraco Cloud using Umbraco CI/CD Flow compared to standard deployments.

**Conflict Management**

* Given the necessity to avoid changes in other environments, the lack of strict coordination among multiple teams or individuals working on the same project elevates the risk of conflicts.

**Usage of Private NuGet Feeds**
* If you have followed the [documentation](https://docs.umbraco.com/umbraco-cloud/set-up/private-nuget-feed) to use a private NuGet feed on Umbraco Cloud, you need to make sure that your NuGet.config file has the correct credentials on your leftmost environment. 
* If your leftmost environment does not have the credentials, and you try to push the NuGet.config changes through CI/CD, you will encounter problems.
* You can add the correct credentials that reference your Umbraco Cloud secrets by following the steps below:
  1. Login to Kudu on your leftmost environment.
  2. Navigate to your NuGet.config file via the console (the default location is the repository root).
  3. Edit the NuGet.config file to include your private feed and credentials.
  4. Save the file.
  5. Commit the changes while in Kudu.
* After making sure that your NuGet.config has the credentials for your private feed, copy the NuGet.config file to your local project. You should be able to trigger the CI/CD flow successfully afterwards.

As we continue to prototype and gather insights from beta users, there are some known limitations and considerations to be aware of:

## Key Points to Consider

* **Direct Commits to Umbraco Git Repos**: Any commits made directly to the Umbraco-git-repos will cause the process to fail.
* **Remote Build/Test Options**: It is currently not possible to skip the first build step before committing.
* **Incomplete API**:
  * The list endpoint lacks filtering capabilities.
  * The promotion endpoint for transitioning from dev to stage to live is not fully functional yet.
* **Hotfix Deployments**: Direct deployments to a specific environment are not supported at this time.
* **Lack of Predefined Tasks**: There are no Umbraco-provided Azure DevOps tasks or GitHub Actions available.
* **No Webhooks**: Currently, there's no webhook support for real-time feedback to the pipeline; polling is the only option.
* **Casing Conflicts**: Be cautious of casing issues, such as having a README.md file created by Azure DevOps and a `Readme.md` file from the default Umbraco Cloud, as this can cause conflicts in the cloud Git repository.
* **Documentation Alignment**: We are in the process of updating our documentation to align with standard Umbraco guidelines.
* **Developer Experience**: Plans are underway to create Umbraco-specific Azure DevOps tasks and GitHub Actions to enhance the developer experience.

## Contact Information

For any queries, comments, or further clarifications, feel free to reach out to us at Umbraco via email at [umbraco-cicd@umbraco.dk](mailto:umbraco-cicd@umbraco.dk).
