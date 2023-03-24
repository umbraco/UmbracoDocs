---
description: A guide displaying the options available in the Settings section in Umbraco Backoffice.
---

# Backoffice Settings Section

The **Settings** section of the Umbraco backoffice has its own set of default dashboards:

<details>

<summary>Welcome</summary>

The Welcome dashboard is part of the Settings section. It is displayed next to the Settings tree and consists of a blank view that can be used to build any custom dashboard. The Welcome dashboard can be customized to display information as per your needs. It is possible to extend the dashboard and add them to either an existing section or a custom one.

For more information about creating custom dashoards, see the [Dashboards](../extending/dashboards.md) article.

</details>

<details>

<summary>Examine Management</summary>

The Examine Management dashboard provides an overview of the Examine functionality available directly within the Umbraco backoffice. The Umbraco backoffice allows you to view details about your Examine indexes and searchers - all in one place. You can see which fields are being indexed and rebuild the indexes if there's a problem. You can also test keywords to see what results will be returned.

For more information about Examine Management, see the [Examine Management](../reference/searching/examine/examine-management.md) article.

</details>

<details>

<summary>Published Status</summary>

The Published Status dashboard displays the status of your site in the Published Cache Status section alongwith the Content and Media nodes value. The Caches section provides three options: Memory Cache, Database Cache, and Internals (NuCache).

- Memory Cache - Reloads the in-memory cache by entirely reloading it from the database cache. Use it when you think that the memory cache has not been properly refreshed.

- Database Cache - Rebuilds the database cache that is the content of the `cmsContentNu` table. Use it when reloading the Memory Cache is not enough and you think that the database cache has not been properly generated.

- Internals - Lets you trigger a NuCache snapshots collection.

</details>

<details>

<summary>Models Builder</summary>

Models builder is a tool that can generate a complete set of strongly-typed published content models for Umbraco. Models are available in both controllers and views.

For more information about Models Builder, see the [Models Builder](../reference/templating/modelsbuilder/README.md) article.

</details>

<details>

<summary>Health Check</summary>

Health Checks are used to determine the status of your Umbraco project. It is a handy list of checks to see if your Umbraco installation is configured according to best practices. It's possible to add your custom-built health checks.

For more information about Health Checks, see the [Health Check](health-check/README.md) article.

</details>

<details>

<summary>Profiling</summary>

You can use the built-in performance profiler to assess the performance when rendering pages. To activate the profiler for a specific page rendering, add `umbDebug=true` to the querystring when requesting the page.

The Profiling dashboard provides a toggle option - `Activate the profiler by default` to keep the profiler active by default for all page renderings. You can use this option without having to set `umbDebug=true` on each page request. The toggle button sets a cookie named `UMB-DEBUG` in your browser, which then activates the profiler automatically.

For more information about MiniProfiler, see the [MiniProfiler](../code/debugging/README.md#miniprofiler) section in the [Debugging](../code/debugging/README.md) article.

</details>

<details>

<summary>Telemetry Data</summary>

The Telemetry Data dashboard is a consent screen that is used for collecting system and usage information from your installation. Here, you can see what type of data is being collected and even adjust the level of reporting. Currently, there are three levels available: **Minimal**, **Basic**, and **Detailed**. **Basic** is the default option where the data sent is an anonymized site ID, Umbraco version, and packages installed. You can see the specific data being sent on each of the levels directly in the Dashboard.

For more information about Package Telemetry, see the [Package Telemetry](https://umbraco.com/blog/umbraco-92-release/) section in the Umbraco 9.2 Release Blog Post.

</details>
