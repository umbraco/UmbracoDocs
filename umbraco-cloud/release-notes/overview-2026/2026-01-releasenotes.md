# January 2026

## Key Takeaways

* **CI/CD Flow page** - CI/CD Flow has been moved from the `Configuration -> Advanced` page to a standalone page `Configuration -> CI/CD Flow`.
* **Enhanced debug information for CI/CD deployments** - Added a new "See More" link on the `Insights -> Project History` page for CI/CD Flow deployment events. That leads to a new page with logs, artifact info, and so on about the deployment.
* **List of deployment artifacts** - Added a list of deployment artifacts on the `Configuration -> CI/CD Flow` page with a download link to help with debugging.

## CI/CD Flow page

The CI/CD flow on the `Configuration -> Advanced` page has been moved to `Configuration -> CI/CD Flow`. This has been done in preparation for the upcoming enhancements to the CI/CD Flow. 

## Enhanced debug information for CI/CD deployments

On the `Insights -> Project History` page, you will now see CI/CD Flow deployments. Use the "See More" button to find even more information about each deployment.

![Project History page with new CI/CD Deployment](../images/project-history-cicd.png)

This detail page for the event contains the following information:

- Metadata for the deployment.
- Metadata about the deployment artifact, including a download link.
- The configured deployment options.
- The process log.
- The Kudu log.

Having these details available makes debugging deployments that went wrong much easier.

## List of deployment artifacts

Added a list of deployment artifacts on the `Configuration -> CI/CD Flow` page with a download link to help with debugging:

![List of deployment artifacts on the CI/CD Flow page](../images/cicd-artifacts.png)
