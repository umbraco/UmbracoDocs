---
description: >-
  The Availability & Performance page lets you see get an overview of your cloud
  projects' past and current health.
---

# Availability and Performance

Leveraging Azure metrics data, the **Availability & Performance** page provides users with valuable insights into the availability and performance of their cloud project. This enables them to monitor and address any issues that may impact the user experience.

## Overview

Under Availability & Performance, you'll find visualization and statistics for three sections:

* Time range and granularity selector
* Panel view
* Chart and statistics view

The visualization and statistics can be seen for all your different environments.

<figure><img src="../.gitbook/assets/image (4) (1) (1) (1).png" alt=""><figcaption><p>Availability and performance Overview</p></figcaption></figure>

{% hint style="info" %}
More detailed visualization and tools intended for troubleshooting are to be added in the future and will be restricted to **Standard** and **Professional** project plans.
{% endhint %}

### Time range and granularity selector

When entering the page, you'll see a default visualization of failed requests for the last 24 hours with a data point set for every fifth minute. You are able to change the time range to a predefined interval or define a specific start and end time. You can also select the granularity of the data points.

![Time-range-selector](../set-up/images/AP-time-range-selector.png)

Initially, you will only be able to set the time granularity to “_5 minutes_”.

### Panel view

The panel selector consists of four tiles, each representing a specific segment of data. The four segments are **failed request**, **App Performance**, **CPU Usage**, and **Memory Usage**.

![Pane-view](../set-up/images/AP-Panel-Selector.png)

Each tile includes relevant statistics and potentially a warning or an error indicator in case there is something you might want to consider.

An error indicator is shown in the following situations:

* **Failed Requests**: when one or more server errors have occurred in the selected time range.
* **CPU Usage**: when the maximum CPU time has exceeded 100% of the plan quota in 5 minutes during the selected time range.
* **Memory Usage**: when the maximum private time has exceeded 100% of the plan quota in 5 minutes during the selected time range.

A warning indicator is shown in the following situations:

* **Failed Requests**: when one or more client errors (but no server errors) have occurred in the selected time range.
* **CPU Usage**: when the maximum CPU time has exceeded 80% percent of the plan quota in a 5-minute period during the selected time range.
* **Memory Usage**: when the maximum private time has exceeded 80% percent of the plan quota in a 5-minute period during the selected time range.

Errors and warnings for **CPU Usage** and **Memory Usage** are only shown for cloud projects on shared plans with a granularity of 5 minutes selected.

### Chart and statistics view

For each segment, there will be shown a chart and a set of related statistics. The charts also show [platform and CMS events](availability-performance.md#platform-and-cms-events), making it convenient to see how different events impact performance.

#### Failed request

The chart shows the breakdown of HTTP status codes for each data point with the selected granularity. Only responses indicating a client (4xx region) or server errors (5xx region) are shown.

![Failed-request](../set-up/images/AP-1-FailedRequests.png)

In the statistics panel on the right, you will find the total instances of the status code in the time range.

#### App Performance

The chart shows the average response time during the selected time range. All requests to the Umbraco solution in the time periods with the length of the selected granularity count to average response time.

![AppPerformance](../set-up/images/AP-2-AppPerformance.png)

The statistics panel shows the average, maximum, and minimum response for the shown data points.

#### CPU Usage

The chart depicts the CPU time consumed by the application in the selected time range with time periods equalling the selected granularity.

![Cpu usage](../set-up/images/AP-3-CpuUsage2.png)

Cloud projects using a shared resource and a granularity of 5 minutes, users will see the assigned CPU time in seconds and a comparison against the [plan quota](https://docs.umbraco.com/umbraco-cloud/getting-started/umbraco-cloud-plans).\
In this case, the statistics panel shows the following:

* The maximum CPU time
* The average CPU time
* The plan quota
* The maximum and average percentage of the consumed CPU in a 5-minute period compared to the plan quota.

Cloud projects on dedicated options (or a shared plan with another granularity than 5 minutes), users will see the average assigned CPU time in seconds. Here the statistics panel will display the maximum, average, and minimum CPU time based on selected granularity.

#### Memory Usage

The chart shows the memory usage in private bytes consumed by the application in the selected time range with time periods equalling the selected granularity.

![Memory usage](../set-up/images/AP-4-MemoryUsage.png)

Cloud projects on shared resources with a granularity of 5 minutes, will see the assigned private bytes in megabytes (MB) and a comparison against the [plan quota](https://docs.umbraco.com/umbraco-cloud/getting-started/umbraco-cloud-plans).

For cloud projects with a dedicated option (or shared plans with another granularity than 5 minutes), users will see the average assigned private bytes in bytes. Here the statistics panel will display the maximum, average, and minimum allocation of private bytes based on selected granularity.

#### Platform and CMS events

The charts are enhanced with platform events like restarts, automatic and manual upgrades, environment-to-environment deployments, and plan changes.

This information will help you in potential troubleshooting, make informed decisions, and ensure smooth project management.

By utilizing the `Umbraco.Cloud.Cms` package we are tracking the **hot** and **cold** boots of your Umbraco environment on Cloud.

<figure><img src="../.gitbook/assets/image (87).png" alt="Hot and Cold boot."><figcaption><p>Hot and Cold boot.</p></figcaption></figure>

Learn more about the difference between [Hot vs. Cold restarts](https://docs.umbraco.com/umbraco-cms/reference/notifications/hot-vs-cold-restarts).

The package is installed on all environments running Umbraco 10, 13, and 14 on Umbraco Cloud. The package will be part of new Cloud projects on upcoming versions of Umbraco CMS.

{% hint style="info" %}
Only installations running in Umbraco Cloud are tracked. The following data is recorded:

* Environment identifier
* Timestamp
* The Umbraco version
* Boot mode, IE. "warm" or "cold" boot

The telemetry is not sent if you are running a cloned environment on your local machine.
{% endhint %}

You can disable Hot/Cold boots tracking on your Umbraco Cloud Project by adding `Umbraco:Cloud:DisableBootTracking` and set to true in the `appsettings.json` file.

```json
"Umbraco":{
  "Cloud": {
    "DisableBootTracking": true
  }
}
```

It is also possible to remove the reference to the `Umbraco.Cloud.Cms` package in the UmbracoProject.csproj.

## Key benefits

Below you can read about the benefits the **Availability & Performance** page gives.

### Health Monitoring

The page allows users to monitor the health of their cloud projects more effectively. By leveraging Azure metrics data, you can access critical information such as HTTPS status codes, response times, CPU time, and memory usage in private bytes.

The CPU and memory usage is particularly important to keep an eye on from time to time. This is to ensure the cloud project running on a shared that the plan quotas aren’t exceeded.

### Issue Discovery

The page enables users to discover application issues that may impact the overall performance of their Umbraco Cloud projects. By analyzing Azure metrics data, you gain valuable insights into the performance of your app service, including response times and CPU/memory usage.

Real-time monitoring of HTTPS status codes helps you identify any errors or disruptions to your application's availability. This proactive approach allows you to respond swiftly, ensuring that your website or application remains accessible and responsive to users.

### User-Friendly Interface

Umbraco Cloud provides a user-friendly interface for accessing and interpreting the "Availability and Performance" page. The interface presents Azure metrics data in a clear and understandable manner, making it easier for users to navigate and gain actionable insights. With intuitive SVG-based visualizations and highlighted statistics for the selected time range, you can monitor the health and performance of your cloud projects effortlessly.

### Future updates

The first version of the “Availability and Performance” feature released on May 26th, 2023 includes a basic visualization and a set of highlighted numbers for failed requests, application performance, CPU time, and memory usage.

More detailed information about each of these domains will be provided for each of the four domains in the future. While the visualization and basic numbers are accessible for any project plan, the detailed information and insight to be added will be exclusive to the upper cloud project plans
