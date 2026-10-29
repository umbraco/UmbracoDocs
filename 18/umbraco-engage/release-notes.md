---
description: Get an overview of the changes and fixes in each version of Umbraco Engage.
---

# Release Notes

This section summarizes the changes and fixes introduced in each version of Umbraco Engage. Each release includes a link to the [Engage issue tracker](https://github.com/umbraco/Umbraco.Engage.Issues/), where you can find a list of resolved issues. Individual issues are also linked for more details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific-upgrade-notes.md) article.
{% endhint %}

## Release History

Below are the release notes for Umbraco Engage 18, detailing all changes in this version.

#### [18.3.0](https://www.nuget.org/packages/Umbraco.Engage/18.3.0) (October 29th 2026)

**Analytics and reporting**

* Fixed analytics tracking throwing an error on requests with a malformed or truncated form body. These requests are no longer treated as Umbraco surface actions ([Issue #112](https://github.com/umbraco/Umbraco.Engage.Issues/issues/112)).
* Fixed report date ranges being shifted when the reporting timezone is not UTC. A timezone ahead of UTC added an extra day at the end of the range, and one behind UTC added an extra day at the start. In comparison mode, the previous period also overlapped the primary one.
* Fixed the Realtime Visitors chart and table returning a server error over long date ranges on large databases. Paged tables now compute their rows once instead of repeating the aggregation for the row count, the page, and the totals.
* Added `Engage:Reporting:QueryCommandTimeout`, the time in seconds allowed for each analytics SQL command. The default is `120` and the minimum is `30`.
* Analytics queries are now cancelled when a page is reloaded or a tab is closed. The query endpoint returns HTTP 499 for an aborted request instead of HTTP 500.
* A chart or table whose query fails now shows an error with a retry button instead of a blank chart or "No data found".
* Realtime visitors are now dated by the start of their session. A session that crosses midnight counts on its start day only, and a session with no remaining pageviews is now counted.
* Combining the Sessions or Visitors metric with a page dimension now returns a validation error (HTTP 400) instead of a server error (HTTP 500). This affected the Sessions and Locations tabs on a document when report-data generation was disabled.
* A document's analytics tabs now request page-level data whenever they are opened on a content page, instead of depending on whether report-data generation is enabled. The empty state shows "No reporting data has been generated for this site yet." when no report data exists.
* Fixed the Search terms report failing with "Prefab is missing" when "Include subpages" was selected. The metric is now labeled "Search volume (with subpages)".
* Fixed the table staying on the previous scope when "Include subpages" changed after the chart had loaded.
* Fixed the totals strip showing "NaN% of total" or "Infinity% of total" when no total was available.
* Fixed overlapping star-schema generation runs not being skipped. Generation now uses an application lock.

**Analytics: visual redesign**

* Table URLs, share bars, and annotation accents now use a lighter accent color that stays readable in the dark theme.
* The page range in the table footer, for example "1-10 of 23", now sits next to the pager.

**A/B testing and personalization**

* The Engage segment preview app is now only used when the Personalization feature is licensed. Without it, Umbraco's own segment switcher is used, and opening a document preview no longer shows a Personalization license error ([Issue #113](https://github.com/umbraco/Umbraco.Engage.Issues/issues/113)).
* Added the ability to archive an A/B test. Running tests can't be selected for bulk actions.
* The A/B test list now has a grid view and a table view, with status tags, sorting, and filters.
* The A/B test list and test project workspace have been redesigned. The "New" status is now labeled "Draft", and tests are grouped by status.

**Headless**

* Headless segmentation and Delivery API calls can now pass the visitor's browser User-Agent in a `Visitor-User-Agent` header. Device segments now resolve from the visitor's browser instead of the server-side frontend's HTTP client.
* Segmentation and Delivery API calls no longer store segment rule results that apply only once, such as Device, in the visitor's profile. The results are stored by the tracked pageview instead.
* A tracked URL on a non-default port now keeps its port in the headless request host. Previously a pageview for `https://localhost:44367/` was stored against the default port and created a second page row. Existing rows are not migrated.

**Backoffice and platform**

* Updated `Umbraco.Licenses` to 18.0.4. This fixes a rare startup failure with the error "Unable to verify license for Umbraco.Engage. The details provided do not match the signature", caused by SQL Server `datetime` precision ([Issue #110](https://github.com/umbraco/Umbraco.Engage.Issues/issues/110)).
* Added `DataProcessing:ProfileBuildCommandTimeout`, the time in seconds allowed for the visitor profile build command. The default is `5`, so a slow profile query no longer holds a request for the 30 second SQL default.
* Added a generated appsettings JSON schema, `appsettings-schema.Umbraco.Engage.json`, which is shipped in the package. The Engage configuration options now have descriptions and default values in the schema, and `SessionCookieSameSite` lists its allowed values.
* Fixed the `AlignSchema` migration failing when both a legacy and an aligned database object name exist.
* The `FctSession.Page` and `FctSession.UmbracoPageVariant` members are marked as obsolete, and will be removed in Umbraco Engage 19. The database columns they referred to were never created.

#### [18.2.0](https://www.nuget.org/packages/Umbraco.Engage/18.2.0) (October 1st 2026)

**Analytics and reporting**

* Report tables, charts and the comparison view now page and search on the server instead of loading the whole report into the browser. Large reports open faster, and search now filters the entire report rather than only the rows already loaded.
* Column totals and each cell's "% of total" are now computed by the server against the whole report. These values stay accurate while paging or searching, instead of reflecting only the loaded page.
* Fixed the "contains" and "does not contain" filter operators in analytics queries, which generated invalid SQL and failed. "Contains" and "does not contain" are now rejected on visitor type, where a text search cannot match. "Does not contain" now includes rows with no value, and a blank filter value is treated as no filter.
* Combining the Users metric with a page or segment dimension now returns a validation error (HTTP 400) instead of a server error (HTTP 500). Filtering the Users metric by one is also rejected. Users are counted per visitor per day and carry no page or segment.

**Analytics: visual redesign**

* The chart and its data table are now combined into a single pane instead of two separate boxes.
* Annotations moved out of the chart into a compact popover in the pane header. The popover shows a bookmark icon, a count, and a list for creating or deleting annotations inline. Annotation markers are now pinned directly on the chart, and their tooltips appear only when the pointer is over the marker.
* Line/area and bar charts have been restyled to match the updated design. Legends label each series by its type or dimension instead of repeating the date range. Tooltip rows are named by series, and the value tooltip sits beside the hovered marker.
* Data tables have been restyled with a mini bar indicator per metric cell, colour-coded visitor-type rows, clearer "no results" messaging, and an improved loading state. Table headers, the totals strip, and row links have also been restyled.
* Comparison mode has been restyled. Table cells show a bar for the previous value and a delta chip (new, flat, up or down). Each total in the strip carries a delta chip. Charts draw the comparison period as a dashed line with a gain/loss band between the two lines. Stacked bar charts show the previous period as a grey total. Series colors match the colored dots in the table.
* Pagination footers now stay visible even when all rows fit on one page, showing a "1–10 of 14" style range. Two-row breakdown tables, for example New and Returning visitors, show no footer.
* The panel header and toolbar are more compact, with field labels hidden and a "Show rows" label on the page-size control.

**A/B testing and personalization**

* Deleting a segment that is still used by a personalization is now also blocked when the deletion arrives through Umbraco Deploy. The error names the personalizations that use the segment.

* All changes from 18.2.0 release candidates

#### [18.2.0-rc1](https://www.nuget.org/packages/Umbraco.Engage/18.2.0-rc1) (September 18th 2026)

**Analytics and reporting**

* Fixed installations with report-data generation disabled sometimes serving realtime results instead of reporting results. One case returned a 500 error on the backoffice start page.
* Fixed the "% change" column in comparison mode showing the wrong row's value after paging, searching, or sorting ([Issue #91](https://github.com/umbraco/Umbraco.Engage.Issues/issues/91)).
* Fixed the Location report's country-to-city drill-down throwing an error, and fixed drill-down tables (including Goals) not reloading correctly when moving between levels ([Issue #96](https://github.com/umbraco/Umbraco.Engage.Issues/issues/96)).
* Fixed a SQL syntax error that made the "Applied segment insights" report fail on every request.
* Fixed incorrect goal-completion and applied-segment reporting caused by stale references to columns removed in earlier key-column migrations.
* Hardened comparison-mode paging against malformed requests, such as an omitted paging block or a large page number. These could previously return rows in the wrong order or cause a server error.

**Heatmaps**

* Fixed heatmap rendering on invariant documents that have a defined culture/hostname, which previously requested heatmap data using the wrong culture ([Issue #97](https://github.com/umbraco/Umbraco.Engage.Issues/issues/97)).

**A/B testing and personalization**

* Added inline creation for Goals, Segments, and Projects, directly from their picker in the A/B test and personalization editors. A new goal, segment, or project can be created without leaving the workspace being edited.
* Deleting or stopping an A/B test, removing a single variant, or deleting a personalization now removes only the content it created. It no longer risks affecting unrelated content on other pages. A one-off migration cleans up any orphaned content left behind by earlier versions ([Issue #93](https://github.com/umbraco/Umbraco.Engage.Issues/issues/93)).
* Added the ability to copy a winning A/B test variant to the default (published) content. This can be done directly from the "select winner" dialog, with options to publish or save. The winner-selection and scoring-overview dialogs have also been streamlined.
* Restored a guard, lost between v13 and v17, that blocks deleting a segment still referenced by a personalization. It shows a dialog listing the personalizations using it ([Issue #106](https://github.com/umbraco/Umbraco.Engage.Issues/issues/106)).
* Fixed the Segments list "Applied" column always showing 0, caused by comparing the segment's GUID against a numeric ID that could never match. Segment usage is now counted correctly ([Issue #105](https://github.com/umbraco/Umbraco.Engage.Issues/issues/105)).

**Backoffice and platform**

* Fixed the Engage section crashing when duplicate user-group permission rows existed in the database; duplicate rows are also now prevented going forward.
* Fixed the Analytics and Profiles tabs sometimes being absent from the Engage section navigation on newer Umbraco CMS versions, with no error shown. The cause was a duplicate script load triggered by Umbraco CMS asset cache-busting ([Issue #101](https://github.com/umbraco/Umbraco.Engage.Issues/issues/101)). This also fixes the Suspicious Activity Profile ID panel hanging indefinitely on load, a symptom of the same issue ([Issue #104](https://github.com/umbraco/Umbraco.Engage.Issues/issues/104)).
* Added `Analytics:DataCollection:RequireAnalyticsPermissionForMemberTracking` (default `false`). When enabled, a pageview from a visitor without analytics consent is still recorded, but without their member identity attached.
* Fixed a migration that could silently record itself as completed even when it failed part-way through. This could leave a site stuck on an old schema after a failed upgrade. Two related legacy-format migrations were also tightened, so a genuine database error is no longer mistaken for "not applicable" and ignored.

#### [18.1.0](https://www.nuget.org/packages/Umbraco.Engage/18.1.0) (August 20th 2026)

* All changes from 18.1.0 release candidates

#### [18.1.0-rc](https://www.nuget.org/packages/Umbraco.Engage/18.1.0) (August 7th 2026)

**Upgrading**

* An incomplete database schema alignment no longer blocks the upgrade. In 18.0.0 the migration failed and the site did not start. Engage now starts, marks its schema unhealthy, disables its own runtime, and logs what still needs to be done. The site stays available while the alignment is completed.

**Previewing**

* Previewing A/B test variants now goes through Umbraco's native preview segment switcher, bringing it in line with how personalizations are previewed. Every test type can now be previewed, including the benchmark (control) variant, as can ContentType-scoped and MultiPage personalizations.
* The legacy `?EngagePreviewVariantId` and applied-personalization preview query string parameters have been removed, along with the endpoint that generated preview URLs from them. Any bookmarked or hand-built preview URLs relying on these parameters will no longer work.
* The `HasSegmentedPropertyContentTypes` endpoint has been removed. The backoffice now receives the Document Type key directly instead of asking the server about property variance.
* The A/B test variant picker now handles Umbraco variants that no longer exist, such as deleted or recycled pages. Preview is disabled for a test with no page variants or Document Types.
* Fixed the preview segment selector disappearing after switching culture and never reappearing.
* Fixed variant edit links silently losing their segment after any call made without one.
* Fixed the erroneous "Document Type does not support segmentation" warning shown when selecting an A/B test variant.
* Fixed the control group suppressing a personalized variant's CSS/JS in preview, even though the control group is deliberately ignored while previewing.
* The heatmap variant selector now drives the preview with a real Umbraco segment instead of legacy query string parameters.
* The heatmap preview session is correctly managed within the heatmap screen element lifecycle.
* Fixed the A/B test preview button doing nothing, and prevented a previewing visitor from falling into A/B test buckets.
* Fixed a 404 when editing a personalized variant on an invariant document, and resolved previewing on invariant documents.
* The Engage Cockpit is now suppressed while Umbraco's own preview is active.
* Improved the A/B test editing flow with prompts to save the test before previewing or modifying variants.

**Serving and content**

* Invariant A/B tests and personalizations are now applied on culture-specific pages. Culture matching previously tested for `null` rather than an empty string, so invariant configurations were skipped entirely. A `NormalizeInvariantCultureToNull` migration rewrites `culture = ''` to `NULL` across four configuration tables during upgrade.
  * **Behaviour change**: invariant A/B tests and personalizations that were previously inert will start serving variants after upgrading.
* Fixed the A/B variant segment placeholder only being created under the default culture. This prevented variants for other cultures being authored or served on multilingual sites.
* ContentType-scoped personalizations now appear on the Personalization tab. An integer ContentTypeId was being compared to a GUID, so they were never listed.
* Applied personalizations with an unresolvable node key no longer render a dead edit link or vanish from the Personalization tab.
* Document references in personalizations are no longer cached for the lifetime of the process. A deleted page now stops showing a dead link without needing a restart.
* The segment is now written to the analytics page variant table, so segmented traffic is attributed correctly.
* Segment options in the backoffice are now filtered to the A/B tests and personalizations configured for the document being edited or previewed. The CMS preview segment switcher is replaced with a document-scoped version.
* Editing a Single Page A/B test variant now opens the segment-scoped editor.
* Fixed Split URL test page selection, matching test pages by node id rather than row key.
* Fixed the Pageview goal picker storing a generated row identity instead of the Umbraco document key. This caused picked pages to show as "Not found" on reopen and the goal to never convert.
  * **Action required**: Pageview goals saved on 18.0.0 hold unrecoverable values and must have their pages re-picked after upgrading.

**Analytics and reporting**

* Custom event fields (category, action, label) are widened to 1000 characters. They were previously truncated to 50 characters silently.
* Fixed segment reporting charts showing stale or empty data when switching segments, and the percentage toggle not redrawing.
* Replaced a nested row scan with a hash lookup when merging analytics tables, resolving browser timeouts on large data sets.
* Lift vs Control now reports 0 rather than a misleading prognosis lift. This applies when a variant has no traffic, or when the control has no baseline visitors.
* Fixed filter mutation and redraw flicker in the analytics UI.

**Customer journeys and scoring**

* **Behaviour change**: the default minimum deviation for persona and customer journey scoring changed from 0 to 1. The value was previously written by hand at nine call sites and disagreed between them. It is applied when reading a group with no configured value, so no migration runs. A step that leads by no points no longer wins.

**Backoffice and platform**

* Downgrading a license no longer leaves functionality running. A/B testing and personalization are now gated on their respective licenses in the request pipeline, on both the rendered and headless page-view paths.
* Backoffice endpoints that touch the database are now gated when the Engage schema is unhealthy or migrations have failed. They return a `503 Service Unavailable` with a descriptive problem detail instead of throwing or returning nonsense. Configuration-only endpoints — including the main switch — stay reachable so Engage can be re-enabled.
* Added the ability to mark a visitor as a bot from the **Suspicious Activity** overview. The activity-type filter is shown only when more than one option is available.
* Fixed a `401` response on the Engage tab after a period of inactivity. The Engage backoffice client is now routed through the CMS `configureClient`.
* Added validation highlighting properties whose variance does not align with their Document Type's variance. This is a common cause of A/B test variants failing to save or serve.
* The create-segment endpoints are now GUID-driven, removing the integer-to-GUID mapping previously performed in the API.
* Bumped the **Umbraco.Licenses** dependency to 18.0.2. License product IDs are now matched case-insensitively, so a license configured under a differently-cased key still resolves.
* The data retention card now reports only the cleanup tasks that ran. The **Database Schema Status** health check wording is aligned with the reduced-mode card.
* Fixed the start-page schema warning text not aligning with the warning message.

#### [18.0.0](https://www.nuget.org/packages/Umbraco.Engage/18.0.0) (June 25th 2026)

Umbraco Engage 18 adds support for Umbraco CMS 18.

* Added support for Umbraco CMS 18.
* The database schema alignment introduced in 17.2.0 is now **enforced** when upgrading. If the alignment was not completed on your installation, the upgrade to Engage 18 is blocked at startup. A clear error explains how to complete the alignment before retrying. Fresh installs are unaffected.

See [version-specific-upgrade-notes.md](upgrading/version-specific-upgrade-notes.md "mention") for breaking changes and the required upgrade steps.
