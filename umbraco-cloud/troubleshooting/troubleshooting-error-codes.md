# Error Codes and Descriptions for Website Operations and Deployments

This document compiles a comprehensive list of error codes commonly encountered during website operations, deployment, infrastructure management, and environment setup processes. Each error code is accompanied by a clear description of the issue it represents and an extended explanation to aid in diagnosing and resolving the underlying problems.


## Website Operations Errors

1. **MoveWebsitePreflightStatusCheckFailed{StatusCode}{StatusCodeName}**
   - **Description**: Unable to ping website before moving website to server.
   - **Extended Explanation**: This error occurs when the system fails to ping the website before initiating the migration process to a new server. It suggests potential network issues or server unavailability. Retry the operation after verifying network connectivity and server status.

2. **MoveWebsitePreflightStatusCheckFailedTimout**
   - **Description**: Unable to ping website before moving website to server. Website responded with a timeout.
   - **Extended Explanation**: This error indicates a timeout occurred while trying to ping the website before migration. It suggests the website or server is not responding within expected time frames. Verify website availability, server performance, and retry the migration.

3. **MoveWebsitePreflightStatusCheckFailedDNSMisconfigured**
   - **Description**: Unable to ping website before moving website to server. DNS Misconfigured. Please revisit your website's hostname configuration.
   - **Extended Explanation**: This error occurs when DNS settings for the website's hostname are misconfigured, preventing successful pinging. Verify DNS configurations and retry the migration after correcting any issues.

4. **MoveWebsitePostStatusCheckFailed{StatusCode}{StatusCodeName}**
   - **Description**: After moving your website to new hardware, we pinged your website and did not retrieve a successful response code. Please review the attached Umbraco Logs and review redirect rules.
   - **Extended Explanation**: This error occurs after migrating the website to new hardware, where subsequent checks fail to retrieve a successful response from the website. It suggests potential issues with configuration, redirects, or server settings. Review logs and configuration details, and retry after addressing identified issues.

5. **MoveWebsitePostflightStatusCheckFailedTimout**
   - **Description**: After moving your website to new hardware, we tried to connect to your website, but we were unable to get a response in a timely manner. Please review your website boot-up performance.
   - **Extended Explanation**: This error occurs when attempts to connect to the website after migration timeout. It suggests slow website boot-up times or server performance issues. Improve server performance, optimize boot-up processes, and retry the connection.

6. **MoveWebsitePostStatusCheckFailedDNSMisconfigured**
   - **Description**: Unable to ping website after moving website to server. DNS Misconfigured. Please revisit your website's hostname configuration.
   - **Extended Explanation**: This error occurs when DNS settings for the website's hostname are misconfigured after migration, preventing successful pinging. Verify DNS configurations and retry after correcting any issues.

## Job Monitoring and Execution Errors

7. **MoveWebsiteJobMonitorFailed**
   - **Description**: The component orchestrating the job for moving the website to new hardware failed to get the latest status. This is caused by an internal error and can safely be retried.
   - **Extended Explanation**: This error indicates a failure in retrieving the latest status of the website migration job due to an internal issue. Retry the operation as it may resolve with subsequent attempts.

8. **MoveWebsiteJobTimedOut**
   - **Description**: The component orchestrating the job for moving the website to new hardware timed out. This error is typically caused by the repository folder being too large. Please review your repository and try again.
   - **Extended Explanation**: This error occurs when the job orchestrating the website migration times out due to large repository sizes. Review repository size, optimize content, and retry the migration.

9. **MoveWebsiteJobFailedToStart**
   - **Description**: The component orchestrating the job for moving the website to new hardware failed to start. This is caused by an internal error and can safely be retried.
   - **Extended Explanation**: This error indicates a failure in starting the job orchestrating the website migration due to an internal issue. Retry the operation as it may resolve with subsequent attempts.

10. **MoveWebsiteJobFailedUnhandledError**
    - **Description**: The component orchestrating the job for moving the website to new hardware failed with an unhandled error. This is caused by an internal error and can safely be retried.
    - **Extended Explanation**: This error indicates a failure in the job orchestrating the website migration due to an unexpected and unhandled error. Retry the operation as it may resolve with subsequent attempts.

## Infrastructure and Configuration Errors

11. **MoveWebsiteFailedUnableToCreateAppService**
    - **Description**: We were unable to allocate new hardware for the requests. This is caused by an internal error and can safely be retried.
    - **Extended Explanation**: This error occurs when the system fails to allocate new hardware resources for website migration due to internal issues. Retry the operation as it may resolve with subsequent attempts.

12. **MoveWebsiteFailedUnableToAttachSecretKeyStore**
    - **Description**: We were unable to reliably connect the project secret key store to the new infrastructure. This is caused by an internal error and can safely be retried.
    - **Extended Explanation**: This error occurs when the system fails to establish a reliable connection between the project's secret key store and the new infrastructure during migration. Retry the operation as it may resolve with subsequent attempts.

13. **MoveWebsiteFailedUnableToFetchDeploymentConfiguration**
    - **Description**: We are unable to fetch deployment configuration from our hosting provider.
    - **Extended Explanation**: This error occurs when the system cannot retrieve deployment configuration required for migration from the hosting provider. Verify credentials, permissions, or connectivity settings and retry the operation.

14. **UnhandledExceptionWhileExecutingConfigurationStep**
    - **Description**: While updating relations between your environments, we experienced an unhandled exception. This is caused by an internal error and can safely be retried.
    - **Extended Explanation**: This error indicates an unhandled exception occurred during updates between environments, suggesting an internal issue. Retry the operation as it may resolve with subsequent attempts.

15. **CopySharedAppSettingsFailed**
    - **Description**: An unexpected error occurred while trying to copy shared secrets from source environment to new environment. Please try again, and if the problem persists, please reach out to support.
    - **Extended Explanation**: This error indicates a failure while copying shared application settings or secrets from one environment to another during migration. Retry the operation and contact support if the issue persists.

16. **CopySharedAppSettingsFailedUnhandledException**
    - **Description**: An unexpected error occurred while trying to copy shared secrets from source environment to new environment. Please try again, and if the problem persists, please reach out to support.
    - **Extended Explanation**: Similar to the previous error, indicating an unexpected and unhandled exception during the process of copying shared secrets. Retry the operation and contact support if the issue persists.

17. **CopySharedAppSettingsFailedTimeoutExceeded**
    - **Description**: The process of copying shared secrets from source environment to new environment took longer than expected. Please try again, and if the problem persists, please reach out to support.
    - **Extended Explanation**: This error occurs when the time taken to transfer shared secrets exceeds expected duration. Retry the operation and contact support if the issue persists.

18. **InitializingGitRepositoryFailed**
    - **Description**: An error occurred while trying to configure new hardware. Please try again, and if the problem persists, please reach out to support.
    - **Extended Explanation**: This error indicates a failure during the initialization of a Git repository on new hardware. Retry the operation and contact support if the issue persists.

19. **UpdateRemoteFailed**
    - **Description**: We failed to update the Git remotes to adjacent environments. Please try again, and if the problem persists, please reach out to support.
    - **Extended Explanation**: This error occurs when the system encounters a problem while updating Git remote configurations between environments. Retry the operation and contact support if the issue persists.

20. **UpdateDeployConfigFailed**
    - **Description**: We failed to update the deploy configuration on your website. Please try again, and if the problem persists, please reach out to support.
    - **Extended Explanation**: This error indicates a failure to update deployment configuration settings on the website. Retry the operation and contact support if the issue persists.

21. **FetchFromRemoteFailed**
    - **Description**: We failed to fetch changes from an upstream environment. This is most likely caused by the source repository having lots of changes.
    - **Extended Explanation**: This error occurs when the system encounters difficulties fetching changes from a remote repository due to large volume of changes. Retry the operation and review repository settings.

22. **MergeFromRemoteFailed**
    - **Description**: We failed to merge changes from an upstream environment. This is most likely caused by the two environments having Git conflicts. Please read [Umbraco Cloud Git Conflict Resolution](https://docs.umbraco.com/umbraco-cloud/troubleshooting/deployments/structure-error) on how to resolve Git conflicts on Umbraco Cloud.
    - **Extended Explanation**: This error occurs when merging changes from a remote environment fails due to Git conflicts. Follow documentation for resolving Git conflicts specific to Umbraco Cloud environments.

23. **SetRemoteAsTrackingFailed**
    - **Description**: Unhandled error. Please reach out to support.
    - **Extended Explanation**: This error suggests an unhandled error occurred while attempting to set a remote repository as tracking for changes. Contact support for assistance in diagnosing and resolving the issue.

24. **BuildAndDeployFailedUnhandledError**
    - **Description**: An unhandled exception happened while trying to build and deploy your cloud repository to the website. Please review Kudu logs and try again.
    - **Extended Explanation**: This error indicates an unexpected and unhandled exception occurred during the build and deployment process of the website's cloud repository. Review Kudu logs for detailed error messages and retry the operation.

25. **BuildAndDeployFailed**
    - **Description**: An exception happened while trying to build and deploy your cloud repository to the website. Please review Kudu logs and try again.
    - **Extended Explanation**: This error indicates an exception occurred during the build and deployment process of the website's cloud repository. Review Kudu logs for detailed error messages and retry the operation.

26. **PlaceSqlInitializeFileFailed**
    - **Description**: Unhandled error. Please reach out to support.
    - **Extended Explanation**: This error indicates an unhandled error occurred while attempting to place an SQL initialization file. Contact support for assistance in diagnosing and resolving the issue.

27. **PingWebsiteFailed**
    - **Description**: We were unable to contact your website and get a successful response. This can be caused by multiple issues such as slow boot-up times, invalid redirect rules, or missing configuration.
    - **Extended Explanation**: This error occurs when attempts to contact the website fail to retrieve a successful response. Verify website settings, boot-up performance, redirects, and configuration. Retry after addressing identified issues.

28. **DeployExtractionFailed**
    - **Description**: Umbraco Deploy tried to extract changes but encountered a problem. Please review the CMS log files for detailed information.
    - **Extended Explanation**: This error occurs when Umbraco Deploy encounters difficulties while extracting changes during deployment. Review CMS log files for detailed error messages and take corrective actions as necessary.

## Website Provisioning Errors

29. **CreateAppPlanFailedUnableToStartProvisioning**
    - **Description**: We tried to provision new infrastructure. Unfortunately, our hosting provider wasn’t able to accommodate the request at that time. Please try again.
    - **Extended Explanation**: This error occurs when the hosting provider fails to provision new infrastructure as requested. Retry the operation after some time or contact support for further assistance.

30. **CreateAppPlanFailedUnableToScaleToMatchRequirements**
    - **Description**: We retrieved an internal error while trying to scale the requested infrastructure. Please try again.
    - **Extended Explanation**: This error occurs when scaling infrastructure to meet requirements fails due to an internal error. Retry the operation after some time or contact support for further assistance.

31. **CreateAppPlanFailedUnableScaleToRequirementTimedOut**
    - **Description**: The operation to scale infrastructure to your requirements took longer than anticipated. Please try again.
    - **Extended Explanation**: This error occurs when the operation to scale infrastructure exceeds the expected time limit. Retry the operation after some time or contact support for further assistance.

32. **CreateAppPlanFailedScaleOperationTimedOut**
    - **Description**: The operation to scale infrastructure to your requirements took longer than anticipated. Please try again.
    - **Extended Explanation**: Similar to the previous error, indicating the operation to scale infrastructure exceeds the expected time limit. Retry the operation after some time or contact support for further assistance.

33. **CreateAppPlanFailedUnhandledError**
    - **Description**: An internal error happened while modifying infrastructure. Please try again, or reach out to support.
    - **Extended Explanation**: This error indicates an internal error occurred while modifying infrastructure settings. Retry the operation after some time or contact support for further assistance.

## Environment Creation and Deletion Errors

34. **AddEnvironmentFailedInitialize**
    - **Description**: We encountered an issue while setting up your environment.
    - **Extended Explanation**: This error occurs when there is an issue during the setup process of a new environment. Verify configurations, permissions, or connectivity and retry the environment setup.

35. **AddEnvironmentFailedDatabase**
    - **Description**: There was a problem creating the database during environment creation.
    - **Extended Explanation**: This error occurs when creating the database during environment setup fails. Verify database settings, permissions, or connectivity and retry the environment setup.

36. **AddEnvironmentFailedAppService**
    - **Description**: There was an error with the App Service during environment creation.
    - **Extended Explanation**: This error occurs when there is an issue with the App Service component during environment creation. Verify App Service settings, permissions, or connectivity and retry the environment setup.

37. **AddEnvironmentFailedStorage**
    - **Description**: We ran into a storage issue while creating your environment.
    - **Extended Explanation**: This error occurs when encountering storage issues during environment creation. Verify storage resources, permissions, or connectivity and retry the environment setup.

38. **AddEnvironmentFailedIdentityApplication**
    - **Description**: There was an error with the identity application during environment creation.
    - **Extended Explanation**: This error occurs when encountering issues with the identity application (e.g., authentication or authorization service) during environment creation. Verify identity application settings, permissions, or connectivity and retry the environment setup.

39. **AddEnvironmentFailedUnknown**
    - **Description**: An unknown error occurred while adding your environment.
    - **Extended Explanation**: This error indicates an unexpected issue occurred during the addition of a new environment. Contact support for assistance in diagnosing and resolving the issue.

40. **DeleteEnvironmentFailedNotFound**
    - **Description**: Used when the environment requested to be deleted could not be found in Hosting Management.
    - **Extended Explanation**: This error occurs when attempting to delete an environment that cannot be located in the hosting management system. Verify environment identifiers and permissions and retry the deletion operation.

## Deployment Update and SiteExtension Errors

41. **DeploymentUpdateUnableToInitializeUpdateInSiteExtension**
    - **Description**: Some preflight checks failed from the Deployment.Update service.
    - **Extended Explanation**: This error occurs when preflight checks from the Deployment.Update service fail, preventing the initialization of the update process. Retry the operation after verifying configurations and permissions.

42. **DeploymentUpdateSourceSiteExtensionNotFound**
    - **Description**: We were unable to reach the source SiteExtension - either 404 or BadRequest.
    - **Extended Explanation**: This error occurs when the system cannot locate or access the source SiteExtension required for the deployment update process. Verify source SiteExtension settings and retry the deployment update.

43. **DeploymentUpdateTargetSiteExtensionNotFound**
    - **Description**: We were unable to reach the target SiteExtension - either 404 or BadRequest.
    - **Extended Explanation**: This error occurs when the system cannot locate or access the target SiteExtension required for the deployment update process. Verify target SiteExtension settings and retry the deployment update.

44. **DeploymentUpdateDeploymentTimedOut**
    - **Description**: We never got a completed or failed answer from the SiteExtension within our timeout.
    - **Extended Explanation**: This error occurs when the deployment update process does not receive a response (completed or failed) from the SiteExtension within the expected time frame. Adjust timeout settings and retry the deployment update.

45. **DeploymentUpdateSiteExtensionCantConnectToRemoteRepository**
    - **Description**: SiteExtension preflight, can't reach the remote repository.
    - **Extended Explanation**: This error occurs when the SiteExtension encounters difficulties connecting to the remote repository during preflight checks. Verify network settings, repository permissions, or firewall configurations and retry the operation.

46. **DeploymentUpdateSiteExtensionIsSourceBusy**
    - **Description**: SiteExtension preflight, source is busy.
    - **Extended Explanation**: This error occurs when the SiteExtension detects that the source environment or repository is currently busy and unavailable for updates. Retry the operation later when the source environment is less busy.

47. **DeploymentUpdateSiteExtensionIsTargetBusy**
    - **Description**: SiteExtension preflight, target is busy.
    - **Extended Explanation**: This error occurs when the SiteExtension detects that the target environment or repository is currently busy and unavailable for updates. Retry the operation later when the target environment is less busy.

48. **DeploymentUpdateSiteExtensionIsConfiguredForUmbracoDeploy**
    - **Description**: SiteExtension preflight, UmbracoDeploy API key not found or configured.
    - **Extended Explanation**: This error occurs during preflight checks when the SiteExtension is not properly configured with the necessary UmbracoDeploy API key. Verify and configure the API key correctly in the SiteExtension settings to resolve the issue.

49. **DeploymentUpdateSiteExtensionGitPullFailed**
    - **Description**: Unable to do a Git pull, if it was required.
    - **Extended Explanation**: This error occurs when the SiteExtension fails to perform a Git pull operation as part of the deployment update process. Verify repository settings, permissions, or authentication and retry the operation.

50. **DeploymentUpdateSiteExtensionGitPushFailed**
    - **Description**: This also hides a build error - it's the Kudu process that kicks in, so it's a combined Git push + Kudu deploy.
    - **Extended Explanation**: This error occurs when the Git push and subsequent Kudu deployment process fails during the deployment update. Review Kudu logs for detailed error messages and retry the operation.

51. **DeploymentUpdateSiteExtensionExtractionFailed**
    - **Description**: Umbraco Deploy tried to extract changes but encountered a problem. Please review the CMS log files for detailed information.
    - **Extended Explanation**: This error occurs when Umbraco Deploy encounters difficulties while extracting changes during deployment update. Review CMS log files for detailed error messages and take corrective actions as necessary.

52. **DeploymentUpdateSiteExtensionExtractionTimedOut**
    - **Description**: Umbraco Deploy extraction timed out.
    - **Extended Explanation**: This error occurs when the Umbraco Deploy extraction process exceeds the expected time limit during deployment update. Adjust timeout settings and retry the deployment update.

## Database Allocation and Movement Errors

53. **UnableToAllocateDatabaseSlotTimeoutExceeded**
- **Description**: Unable to allocate a database slot within the time limit.
- **Extended Explanation**: This error occurs when the system fails to allocate a database slot within the designated time frame. The issue could be due to resource constraints, network latency, or high system load. Retry the operation after some time or check for any underlying resource limitations or connectivity issues. If the problem persists, consider reaching out to support for further assistance.

54. **UnableToMoveDatabaseToAnotherResourceUnit**
- **Description**: An unexpected error occurred while trying to move the resource unit. Please retry the operation or reach out to support.
- **Extended Explanation**: This error indicates that an unexpected issue was encountered while attempting to move the database to another resource unit. This can be caused by conflicts in resource allocation, network issues, or internal errors. Retry the operation after some time, and if the issue persists, contact support for detailed diagnostics and resolution steps.

55. **UnableToMoveDatabaseServer**
- **Description**: We were unable to move the database to a new database server. The operation either timed out or failed. Please retry the operation again, or reach out to support.
- **Extended Explanation**: This error occurs when the system fails to move the database to a new server, either due to a timeout or an operational failure. This could be caused by connectivity issues, resource limitations, or server misconfigurations. Retry the operation after verifying the server settings and ensuring adequate resources. If the problem continues, contact support for further assistance and troubleshooting.