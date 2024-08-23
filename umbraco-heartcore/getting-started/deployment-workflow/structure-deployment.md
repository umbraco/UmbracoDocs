# Structure deployments

Structure changes like new and/or updated Document Types need to be deployed through environments using the Project View in the Cloud Portal.

<figure><img src="../../.gitbook/assets/image (5).png" alt="Deploy to Live"><figcaption></figcaption></figure>

In the screenshot above, changes made on a Development environment are ready to be deployed to the Live environment, as indicated by the blue button: "_Deploy changes to Live_". Had there been a Staging environment on the project, the changes would first be sent to the Staging and then opened up for the option to deploy from Staging to Live.

A deployment from one environment (source) to another (target) goes through the following steps:

1. The target environment is checked for changes
2. If changes are found, these are pulled down and merged into the source environment
3. The changes in the source environment are then pushed to the target environment

This process might take a few minutes, depending on the amount of changes being deployed.

Once your structure has been deployed, it will be possible to transfer your content and media as well. This is done from the Umbraco Backoffice - read more about this in the [Content transfer/restore article](content-transfer.md).
