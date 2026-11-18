---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco
  Engage.
---

# Version specific Upgrade Notes

This article provides specific upgrade instructions and breaking changes introduced when migrating to major version 19 of Umbraco Engage.

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes

### 19.0.0

#### Engage segments no longer come from the CMS segment service

Engage no longer implements the CMS `ISegmentService`. Umbraco CMS 19 no longer limits segments by culture, so Engage supplies the cultures itself. The default CMS implementation returns an empty list for `GET /segment`, so the CMS never serves Engage segments.

Engage now adds its segments to the document workspace through its own front-end segment provider. The provider reads them through two services:

| Purpose | Service | Returns |
| --- | --- | --- |
| Segments to edit | `IEditableSegmentService` | Only the segments Engage serves. |
| Segments to preview | `IPreviewableSegmentService` | Segments to preview, including segments that only apply CSS or JavaScript. |

If your code uses `SegmentService` directly, or resolves Engage's implementation through `ISegmentService`, switch to one of these services. Both return `EngageSegment`, which includes the cultures the segment applies to.

`IPreviewableSegmentService` now has a single member, `GetPagedPreviewableSegmentsAsync`. The following are removed:

* `GetPagedPreviewableSegmentsForDocumentAsync`
* `GetPagedPreviewableSegmentsWithCulturesForDocumentAsync`
* `PreviewableSegment`
* `PreviewableSegmentDto`

#### Database command timeout no longer falls back to `Connect Timeout`

Umbraco CMS 19 no longer uses the `Connect Timeout` connection string value as the command timeout. If you set `Connect Timeout` to give long Engage queries more time, set `Command Timeout` in the connection string or `Umbraco:CMS:Global:DatabaseCommandTimeout` instead.

#### Access to the Engage API now requires user group permissions

Engage now checks Umbraco user group permission verbs on the server, such as `Engage.Analytics.Read` and `Engage.AbTesting.Write`.

A migration moves the settings from the previous per-group permissions table to the new verbs. After you upgrade, check that your user groups have the access you expect.

The previous permission classes are removed: `IUserGroupPermissionService`, `IUserGroupPermissionRepository`, `UserGroupPermission`, `IUserGroupPermissionDtoMapper`, and `UserGroupPermissionDto`. The user group permission endpoints are also removed.

#### The Cockpit is rebuilt

The Engage Cockpit has been rewritten with Lit and no longer uses Vue. It follows the user's access to the Engage section and the Read verbs of their user groups.

The Cockpit segment classes are removed: `ICockpitSegmentRuleFactory`, `DefaultCockpitSegmentRuleFactory`, and `CockpitSegment`. To add a segment rule, register a `segmentRuleProvider` extension instead.

#### Reporting generation time

`Engage:Reporting:DataGenerationTime` now defaults to empty instead of `04:00`. When it is empty, Engage picks a random time between 01:00 and 05:00 in the reporting time zone and keeps it across restarts. If you set the value explicitly, it is now scheduled in the reporting time zone instead of the server time zone. If your server and reporting time zones differ, check that the time is still what you want.

#### Removed members and classes

The following members and classes were marked obsolete in earlier versions and are now removed:

| Removed | Replacement |
| --- | --- |
| `FctSession.Page` and `FctSession.UmbracoPageVariant` | None. The database columns were never created. |
| `HttpContextRawPageviewExtractor` constructor without all parameters | Use the constructor that takes all parameters. |
| `IMigrationPlanExecuter.ExecuteAsync(MigrationPlan, bool ignoreExceptions)` | Use `ExecuteAsync(MigrationPlan)`. Migration failures always throw `EngageMigrationFailedException`. |
| `IAbTestVisitorToVariantManager.AssignAllVariantsForVisitor` | Use `AssignAllVariantsForVisitorAsync`. |
| `FctPageviewBot` and the bot pageview reporting metric | None. Bot pageview reporting isn't supported and its table is never created. |
| `AnalyticsDataCleanupConfiguration.StartAfterSeconds` and `IntervalInSeconds` | Use `FirstRunTime` or `StartupDelay`, and `Interval`. |
| `AnalyticsDataCleanupConfiguration.NumberOfRows` | None. The value is no longer used. |

Other constructor overloads that were kept for compatibility are also removed, including those on `StarGenerationBackgroundJob`, `ConfigurationController`, `HeadlessHttpContext`, `AbTestProject`, `AbTestHealthService`, `AbTestProjectConnector`, and `SegmentService`. Use the overloads that take all parameters.

If you have custom code that uses any of these, compile against Engage 19 and fix the errors the compiler reports.

#### Chart code removed from the backoffice client

If you extend the Engage backoffice with your own TypeScript, the old Engage chart code and its Chart.js build are removed. Every chart now uses the Umbraco Analytics UI components. The following no longer exist:

* `ue-chart` (`UeAnalyticsChartElement`), `ue-bar-chart`, `UeChartElement`, `UeChartBaseElement`, `UeChartTooltipDefaults`, and the `UeBarChartData` type.
* `UeChartDatasetGeneratorController` and `UeChartSettingsGeneratorController`.
* The `@umbraco-engage/backoffice/chartjs` entry, and the `chart.js` and `chartjs-plugin-annotation` dependencies.
* The `look` field of `UeChartConfig` and the `UeChartLook` type. The chart type is now `"line"` or `"bar"`.

Use `ue-analytics-time-chart` for time charts, and `@umbraco/analytics-ui/external/chart.js` for a custom chart.

Refer to the [Umbraco Analytics UI Storybook](https://umbraco.github.io/Umbraco.Analytics.UI) for examples and documentation.
