# October 2025

## Key Takeaways

* **Daily Usage** - Gain daily insights into your project’s bandwidth trends over the last 31 days for a faster feedback loop and optimization.
* **CI/CD Improvements** - Deployments now complete faster when no changes are detected and include a verification step to ensure successful deployments.

## Daily Bandwidth Usage

A new Daily Usage graph is now available in the *Usage* section of Umbraco Cloud. It provides a rolling 31-day view of bandwidth usage, giving you faster feedback on the effects of site optimizations and improved predictability.
    
![alt_text](../images/Daily-Usage-Bandwidth-Trend-October-2025.png "Rolling Bandwidth Trend - last 31 days")

For instance, you can now see the impact of reducing image sizes, disabling autoplay videos, or improving caching strategies. This makes it easier to understand how adjustments influence bandwidth consumption day by day.

## CI/CD Improvements

We’ve made several updates to the CI/CD flow to improve speed, reliability, and transparency during deployments.

**Faster completion for unchanged deployments** 
If your uploaded package doesn’t include any new changes that affect the Cloud Environment, the CI/CD job will now skip unnecessary steps and complete faster.

**New verification step for deployment completion** 
A new verification step ensures that changes pushed to the App Service have been successfully deployed through Kudu.  

These improvements make the deployment flow faster, more predictable, and easier to troubleshoot. See the updated documentation for more details:
   
   - [Deployment reports: No changes detected - cleaning up](../../build-and-customize-your-solution/handle-deployments-and-environments/umbraco-cicd/troubleshooting.md#deployment-reports-no-changes-detected---cleaning-up)
   - [Unable to verify Deployment has finished](../../build-and-customize-your-solution/handle-deployments-and-environments/umbraco-cicd/troubleshooting.md#unable-to-verify-deployment-has-finished)
