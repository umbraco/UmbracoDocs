---
description: >-
  The Traffic & Performance page gives you an overview of your cloud
  project's past and current health.
---

# Traffic and Performance

**Traffic & Performance** combines Azure application metrics with Cloudflare edge analytics. You get a complete picture of your cloud project's health and traffic patterns. The page lets you monitor HTTP traffic, response times, resource usage, and detailed traffic breakdowns — helping you identify and resolve issues that impact user experience.

## Overview

The page is made up of the following sections:

* [Time range, environment, and hostname selectors](#time-range-environment-and-hostname-selectors)
* [Performance overview tiles](#performance-overview-tiles)
* [Interactive chart](#interactive-chart)
* [Traffic breakdown tables](#traffic-breakdown-tables)
* [Edge data granularity](#edge-data-granularity)
* [Edge data limitations](#edge-data-limitations)

<figure><img src="../../.gitbook/assets/tp-page-overview.png" alt="The Traffic & Performance page showing the selectors, overview tiles, chart, and breakdown tables."><figcaption><p>The Traffic & Performance page.</p></figcaption></figure>

## Time Range, Environment, and Hostname Selectors

At the top of the page, you will find controls that determine which data is displayed.

### Time Range

The default view shows data for the **last 24 hours** with data points every 5 minutes. See the [Edge Data Granularity](#edge-data-granularity) section for the edge analytics granularity table.

You can change the time range to a predefined interval or define a specific start and end time.

![Time-range-selector](../../.gitbook/assets/AP-time-range-selector.png)

### Environment

Use the environment dropdown to select which environment (for example, Live, Staging, or Development) to view metrics for.

### Hostname Selector

The hostname selector lets you pick one or more custom hostnames associated with your project. Selecting at least one hostname **enables edge analytics** — the Requests and Data Transfer tiles, edge metrics on the chart, and the traffic breakdown tables.

{% hint style="info" %}
Edge analytics data is only available when at least one hostname is selected.
{% endhint %}

## Performance Overview Tiles

The overview section shows summary tiles for key metrics. Five application metric tiles are visible by default. Two edge metric tiles appear when hostnames are selected.

<figure><img src="../../.gitbook/assets/tp-performance-overview-tiles.png" alt="Seven overview tiles: Failed Origin Requests, App Performance, CPU Usage, Memory Usage, App Service Plan CPU, Edge Requests, Edge Data Transfer."><figcaption><p>Performance overview tiles.</p></figcaption></figure>

Each tile shows the headline value for its metric. Tiles may also display a warning or error indicator when usage approaches plan limits.

### Application Metric Tiles

#### Failed Origin Requests

Displays the total count of HTTP 4xx and 5xx responses from the origin (labelled "HTTP Status 4xx and 5xx" in the UI).

* **Error indicator** appears when one or more HTTP 5xx (server error) responses occur.
* **Warning indicator** appears when HTTP 4xx client errors exist, but there are no server errors.

#### App Performance

Displays the average response time in milliseconds across all requests.

#### CPU Usage

Displays CPU time consumed.

* **Shared plans**: Shown as a percentage of your plan quota. An orange warning appears when the maximum CPU usage exceeds **80%** of the plan quota within a 5-minute period. A red error appears when the maximum CPU exceeds **100%**.
* **Dedicated plans**: Shows average CPU time.

#### Memory Usage

Displays private bytes (memory) consumed.

* **Shared plans**: Shown as a percentage of your plan quota. An orange warning appears when maximum private bytes exceed **80%** of the plan quota within a 5-minute period. A red error appears when maximum private bytes exceed **100%**.
* **Dedicated plans**: Shows average private bytes in MB.

#### App Service Plan CPU

Displays the average CPU utilization across the App Service Plan. This metric is most useful on dedicated plans, where the App Service Plan represents your actual capacity ceiling.

{% hint style="info" %}
CPU and Memory warning/error indicators only display for shared plans.
{% endhint %}

### Edge Metric Tiles

These tiles appear when you have selected one or more hostnames in the hostname selector.

#### Edge Requests

Displays the total number of HTTP requests hitting your site through Cloudflare's edge network.

#### Edge Data Transfer

Displays the total data transferred from your site through the edge. High values may indicate large media files or heavy traffic.

## Interactive Chart

The overview tiles at the top of the page double as a selector for the chart below. By default, one metric is active (Failed Origin Requests). You can:

* Click a tile to add its metric to the chart.
* Click an active tile again to remove that metric from the chart.
* Display multiple metrics simultaneously on the same chart for comparison.

Available metrics include:

* Five application metrics — Failed Origin Requests, App Performance, CPU Usage, Memory Usage, and App Service Plan CPU.
* Two edge metrics (when hostnames are selected) — Edge Requests and Edge Data Transfer.

At least one metric must always be selected.

The chart displays an interactive line graph of the selected metrics over the chosen time range. Each selected metric is drawn as its own line on a shared time axis with independent value axes on the sides.

It supports the following interactions:

* **Hover** anywhere on the chart to see a tooltip with the exact value of every active metric at that moment.
* **Click a layer on the chart** (or its matching pill above the chart) to focus on that metric. The other layers fade so you can analyze the focused metric in isolation. Click the empty chart area to reset focus.
* **Zoom and pan** using the chart toolbar (see [Chart Toolbar](#chart-toolbar)).

The chart also shows [platform and CMS events](#platform-and-cms-events), making it convenient to see how different events impact performance.

<figure><img src="../../.gitbook/assets/tp-chart-zoomed-interactive.png" alt="Chart zoomed to a narrow time range with a tooltip showing values at a hovered point and one metric focused."><figcaption><p>Hover tooltip and click-to-focus on a single metric.</p></figcaption></figure>

#### Sub-Value Accordions

Below the chart, expandable sections show statistical sub-values for each active application metric. These give you the headline numbers behind the chart line: maximum, average, minimum, plan quota where applicable, and a percentage breakdown of HTTP status codes for Failed Origin Requests.

<figure><img src="../../.gitbook/assets/tp-chart-subvalues-accordions.png" alt="Expandable sub-value sections for Failed Origin Requests, CPU Usage, Memory Usage, App Service Plan CPU, and App Performance."><figcaption><p>Sub-value accordions below the chart.</p></figcaption></figure>

#### Metric-Specific Notes

**Failed Origin Requests** — the sub-value section breaks down HTTP status codes (for example, 401, 403, 404, 406, 5xx) over the selected time range.

**App Performance** — sub-values show maximum, average, and minimum response time in milliseconds.

**CPU Usage** — for shared plans at 5-minute granularity, the sub-values show maximum CPU time, average CPU time, plan quota, and the maximum / average percentage of the consumed CPU compared to the [plan quota](https://docs.umbraco.com/umbraco-cloud/getting-started/umbraco-cloud-plans). For dedicated plans, sub-values show CPU time in seconds without the quota comparison.

**Memory Usage** — for shared plans at 5-minute granularity, the sub-values compare allocated private bytes (MB) against the [plan quota](https://docs.umbraco.com/umbraco-cloud/getting-started/umbraco-cloud-plans). For dedicated plans, sub-values show maximum, average, and minimum private bytes without the quota comparison.

**App Service Plan CPU** — sub-values show maximum, average, and minimum CPU percentage across the App Service Plan.

**Edge Requests** and **Edge Data Transfer** — these series only appear when at least one hostname is selected. The [Traffic Breakdown Tables](#traffic-breakdown-tables) section further down the page provides a detailed view of edge traffic.

#### Chart Toolbar

The chart toolbar provides the following controls:

* **Platform events toggle** — Show or hide deployment events, restarts, and other platform events as vertical annotations on the chart.
* **Zoom in / Zoom out / Reset zoom** — Adjust the chart zoom level.
* **Selection zoom** (default) — Click and drag to zoom into a specific area.
* **Pan mode** — Click and drag to move across the chart.
* **Export** — Download the chart as SVG, PNG, or CSV.

#### Platform and CMS Events

The charts are enhanced with platform events like restarts, automatic and manual upgrades, environment-to-environment deployments, and plan changes.

These events help you correlate performance changes with deployments and other project activity.

By utilizing the `Umbraco.Cloud.Cms` package, the platform tracks the **hot** and **cold** boots of your Umbraco environment on Cloud.

<figure><img src="../../.gitbook/assets/tp-platform-metrics.png" alt="Hot and Cold boot."><figcaption><p>Hot and Cold boot.</p></figcaption></figure>

Learn more about the difference between [Hot vs. Cold restarts](https://docs.umbraco.com/umbraco-cms/reference/notifications/hot-vs-cold-restarts).

The package is installed on all environments running Umbraco 10, 13, and 14 on Umbraco Cloud. The package will be part of new Cloud projects on upcoming versions of Umbraco CMS.

{% hint style="info" %}
Only installations running in Umbraco Cloud are tracked. The following data is recorded:

* Environment identifier
* Timestamp
* The Umbraco version
* Boot mode, like "warm" or "cold" boot

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

You can also remove the reference to the `Umbraco.Cloud.Cms` package in the UmbracoProject.csproj.

## Traffic Breakdown Tables

The breakdown tables provide detailed Cloudflare edge analytics, giving you visibility into how traffic flows through the edge network. The section appears when edge analytics are available (hostnames selected and a valid time range).

Two tabs at the top of this section let you switch the table values between **Edge Requests** (count) and **Edge Data Traffic** (bytes transferred).

<figure><img src="../../.gitbook/assets/tp-breakdown-tables-toggle.png" alt="Breakdown table data type section header with Edge Requests and Edge Data Traffic tabs, followed by the Response Characteristics tables."><figcaption><p>Switch the breakdown tables between Edge Requests and Edge Data Traffic.</p></figcaption></figure>

Each table shows the top entries sorted by count or bytes.

### Response Characteristics

![Response characteristics breakdown](../../.gitbook/assets/tp-breakdown-tables-response-characteristics.png)

#### Edge Status Codes

Shows the distribution of HTTP status codes returned by the Cloudflare edge. Examples:

* 200 OK
* 301 Moved Permanently
* 404 Not Found
* 500 Internal Server Error

#### Cache Statuses

Shows how the Cloudflare cache serves requests — for example, `HIT` (served from cache), `MISS` (fetched from origin), or `BYPASS` (cache skipped).

#### HTTP Versions

Shows the distribution of HTTP protocol versions used by clients (HTTP/1.0, HTTP/1.1, HTTP/2, HTTP/3).

### Traffic Destination

![Traffic destination breakdown](../../.gitbook/assets/tp-breakdown-tables-traffic-destination.png)

#### Paths

The most requested URL paths on your site.

#### Hosts

The hostnames receiving traffic.

#### Data Centers

The Cloudflare data centers serve requests to your site. The data centers help you understand the geographic distribution of your edge traffic.

#### HTTP Methods

The distribution of HTTP methods used by clients (for example, GET, POST, PUT, DELETE).

### Traffic Source

![Traffic source breakdown](../../.gitbook/assets/tp-breakdown-tables-traffic-source.png)

#### Referers

The HTTP referer headers — showing which sites or pages are sending traffic to you.

#### Countries

The geographic origin of requests by country.

#### Source IPs

The client IP addresses that make requests.

#### Source Browsers

The browser types used by visitors (for example, Chrome, Firefox, Safari).

#### Source Device Types

The device classification of visitors — desktop, mobile, tablet, and so on.

#### Source Operating Systems

The operating systems used by visitors (for example, Windows, macOS, Android, iOS).

#### Source User Agents

The full user agent strings from requests.

#### Autonomous System Numbers (ASN)

ASNs are the network providers from which requests originate.

### Other

![Other breakdown](../../.gitbook/assets/tp-breakdown-tables-other.png)

#### X-Requested-With Headers

Shows values of the `X-Requested-With` HTTP header, commonly used to identify AJAX requests. Entries without this header appear as "(not set)".

## Edge Data Granularity

Cloudflare edge data (the Requests and Data Transfer chart series, and the traffic breakdown tables) is bucketed automatically based on the selected time range:

| Selected time range   | Data point interval |
| --------------------- | ------------------- |
| 30 minutes to 6 hours | 5 minutes           |
| 6 hours to 3 days     | 15 minutes          |
| 3 days to 8 days      | 1 hour              |
| 8 days and longer     | 1 day               |

Granularity is not user-configurable. Application metric tiles and charts use a separate fixed 5-minute granularity.

## Edge Data Limitations

Cloudflare edge analytics has the following constraints:

* Data is available for up to **90 days** in the past.
* A single time range query can span at most **30 days**.
* Select at least one hostname.
* The page displays a notice when the selected time range is too far back, the time range is too wide, or extends into the future.
* Cloudflare applies **adaptive sampling** to high-traffic datasets. For projects with high request volumes, Cloudflare samples the data and extrapolates totals. The edge tiles, chart, and breakdown tables show estimates rather than exact counts. Cloudflare does not sample smaller projects, and the sampling thresholds are not user-configurable.

## Key Benefits

The **Traffic & Performance** page supports the following use cases.

### Health Monitoring

Use the application metrics to monitor your cloud project's health. The metrics cover HTTP and HTTPS status codes, response times, CPU time, and memory usage in private bytes. With hostnames selected, the edge metrics also show request volume and data transfer.

On shared plans, keep an eye on CPU and memory usage to ensure your project does not exceed its plan quotas.

### Traffic Analysis

The traffic breakdown tables show:

* Where traffic comes from — geography, devices, browsers, and network providers.
* How traffic flows through the Cloudflare edge — cache hit rates, status codes, and HTTP versions.
* Where traffic goes — paths, hosts, and data centers.

### Issue Discovery

Use the application metrics to discover application-level issues, such as slow response times or rising CPU and memory consumption. Real-time HTTPS status codes help you identify errors or availability disruptions early.

Cloudflare edge analytics surfaces issues that occur before traffic reaches your application. Examples include unexpected spikes in request volume, low cache hit rates, or a high share of edge-level errors. Combining Azure and edge data makes it easier to pinpoint whether a problem originates in your application, the edge layer, or the traffic itself.

### Side-by-Side Comparison

Cloudflare edge analytics appear alongside the application metrics in the same chart and overview tiles. You can compare application and edge behavior without leaving the page. The traffic breakdown tables let you drill into specific dimensions on the same view.
