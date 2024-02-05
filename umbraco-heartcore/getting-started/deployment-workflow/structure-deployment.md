# Structure deployments

Structure changes like new and/or updated Document Types needs to deployed through environments using the Project View in the Cloud Portal.

![Deploy to Live](images/deploy-changes-to-live.png)

In the screenshot above, changes made on a Development environment is ready to be deployed to the Live environment, as indicated by the green button: "_Deploy changes to Live_". Had there been a Staging environment on the project, the changes would first be send to the Staging and then open up for the option to deploy from Staging to Live.

A deployment from one environment (source) to another (target) goes through the following steps:

1. The target environment is checked for changes
2. If changes are found, these are pulled down and merged into the source environment
3. The changes on the source environment is then pushed to the target environment

This process might take a few minutes, depending on the amount of changes being deployed.

Once your structure has been deployed, it will be possible to transfer your content and media as well. This is done from the Umbraco Backoffice - read more about this in the [Content transfer/restore article](content-transfer.md).
