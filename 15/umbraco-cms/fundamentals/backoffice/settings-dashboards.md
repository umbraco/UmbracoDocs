---
description: >-
  A guide displaying the options available in the Settings section in Umbraco
  CMS backoffice.
---

# Settings Dashboards

The **Settings** section of the Umbraco backoffice has its own set of default dashboards. In this article, you can get an overview of each dashboard available in the **Settings** section:

<details>

<summary>Welcome</summary>

The Welcome dashboard is the first dashboard in the Settings section. Like all dashboards, it has a customizable view and links to different resources for developing your Umbraco website.

For more information about creating custom dashboards, see the [Dashboards](../../customizing/extending-overview/extension-types/dashboard.md) article.

</details>

<details>

<summary>Examine Management</summary>

The Examine Management dashboard provides an overview of the Examine functionality available directly within the Umbraco backoffice. The Umbraco backoffice allows you to view details about your Examine indexes and searchers - all in one place. You can see which fields are being indexed and rebuild the indexes if there's a problem. You can also test keywords to see what results will be returned.

For more information about Examine Management, see the [Examine Management](../../reference/searching/examine/examine-management.md) article.

</details>

<details>

<summary>Published Status</summary>

The Published Status dashboard displays the status of your site in the Published Cache Status section alongside the Content and Media nodes value. The Caches section provides two options:

* Reload Memory Cache - Reloads the in-memory cache by from the database cache. Use it when you think that the memory cache has not been properly refreshed.
* Rebuild Database Cache - Rebuilds the database cache - that is, the content of the `cmsContentNu` table. Use it when reloading the Memory Cache is not enough and you think that the database cache has not been properly generated.

</details>

<details>

<summary>Models Builder</summary>

Models builder is a tool that can generate a complete set of strongly-typed published content models for Umbraco. Models are available in both controllers and views. When using the Models Builder, the content cache does not return `IPublishedContent` objects anymore but returns strongly typed models implementing `IPublishedContent`.

The Models Builder dashboard displays the following information:

* Details on how Models Builder is configured, that is: `InMemoryAuto`, `Nothing`, `SourceCodeAuto`, and `SourceCodeManual`.
* Provides a button to generate models (if the models mode is `SourceCodeManual` mode only).
* Reports the last error (if any) that would have prevented models from being properly generated.

For more information about Models Builder, see the [Models Builder](../../reference/templating/modelsbuilder/) article.

</details>

<details>

<summary>Health Check</summary>

Health Checks are used to determine the status of your Umbraco project. It is a handy list of checks to see if your Umbraco installation is configured according to best practices. It's possible to add your custom-built health checks.

For more information about Health Checks, see the [Health Check](../../extending/health-check/) articles.

</details>

<details>

<summary>Profiling</summary>

You can use the built-in performance profiler to assess the performance when rendering pages. To activate the profiler for a specific page rendering, add `umbDebug=true` to the querystring when requesting the page.

The Profiling dashboard provides a toggle option - `Activate the profiler by default` to keep the profiler active by default for all page renderings. You can use this option without having to set `umbDebug=true` on each page request. The toggle button sets a cookie named `UMB-DEBUG` in your browser, which then activates the profiler automatically.

For more information about MiniProfiler, see the [MiniProfiler](../code/debugging/#miniprofiler) section in the [Debugging](../code/debugging/) article.

</details>

<details>

<summary>Telemetry Data</summary>

The Telemetry Data dashboard is a consent screen that is used for collecting system and usage information from your installation. Here, you can see what type of data is being collected and even adjust the level of reporting. Currently, there are three levels available: **Minimal**, **Basic**, and **Detailed**.

**Detailed** is the default option where the data sent contains:

* Anonymized site ID, Umbraco version, and packages installed.
* Number of: Root nodes, Content nodes, Media, Document Types, Templates, Languages, Domains, User Group, Users, Members, and Property Editors in use.
* System information: Webserver, server OS, server framework, server OS language, and database provider.
* Configuration settings: Modelsbuilder mode, if custom Umbraco path exists, ASP environment, and if you are in debug mode.

**Basic** contains:

* Anonymized site ID, Umbraco version, and packages installed.

**Minimal** contains:

* Anonymized site ID only

You can see the specific data being sent on each of the levels directly in the **Telemetry Data** Dashboard.

Additionally, Telemetry Data also sends anonymized, analytical data on package usage in Umbraco. Having solid data on package usage is important for both package developers and the Umbraco ecosystem.

For more information about Package Telemetry, see the [Package Telemetry](https://umbraco.com/blog/umbraco-92-release/) section in the Umbraco 9.2 Release Blog Post.

</details>
