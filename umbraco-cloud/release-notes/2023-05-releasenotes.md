# May 2023

## Key Takeaways
* *Availability & Performance* - With Umbraco Cloud's user-friendly interface, you will receive a new set of tools to monitor and optimize your cloud projects effectively.
* *Specific views for dedicated and shared project plans* - The Availability & Performance feature will show different views for CPU Usage and Memory usage, highlighting a comparison to the plan quota for shared plans.
* *What the future will bring to the feature* - More exciting features and enhancements will be added to Availability & Performance in the future.

## Availability & Performance
Umbraco Cloud's "Availability and Performance" feature offers you a new option to monitor the health and performance of your cloud projects. By leveraging HTTPS status codes, response times, CPU time, and memory usage, you can proactively identify and address issues, supporting you to deliver a seamless experience for the users of your cloud project.

![FailedRequest](images/AP-1-FailedRequests-Com.png)

The page is initially shown for all project plans. More detailed visualization and tools intended for troubleshooting to be added in the future will be restricted to “Standard” and “Professional” project plans.

When entering the page you will find a panel with four tiles where you have the option to choose a dedicated view to see _Failed Request_, _App Performance_, _CPU Usage_, and _Memory Usage_, respectively. You might also find an error or warning indicator for each tile if there is something you should consider.

## Specific views for dedicated and shared projects
When selecting a specific topic the chart will be updated with specific data points in the selected time range and granularity. For cloud projects with a **dedicated** option enabled, you will for the CPU usage and memory usage find the average value for the CPU time and private bytes highlighted, respectively.

![Demo-dedicated](images/AP-DemoDedicated.gif)

For cloud projects on a **shared** plan and when selecting a granularity of 5 minutes, you will find a comparison of the maximum CPU time compared to the plan quota of the shared project plan. In case the live environment project has exceeded the plan quota that will be highlighted with an error indicator on CPU usage tile. The same is the case for memory usage, where the memory consumption of the environment is held up against the project’s plan quota.

![Shared-multiple-warnings](images/AP-Shared-Multiple-warnings.png)

## What the future will bring to the feature
The first version of the “Availability and Performance” feature released on May 26th, 2023 includes a basic visualization and a set of highlighted numbers for failed requests, application performance, CPU time, and memory usage.

We expect to add much more information about each of these domains in the future, which will enable you to get more details about a potential error, what might have caused it, and what likely fix to address information could be.

While the visualization and basic numbers are accessible for any project plan, a subset of the future extensions and improvements would be provided to cloud projects on one of the higher cloud project plans (Standard or Professional).
