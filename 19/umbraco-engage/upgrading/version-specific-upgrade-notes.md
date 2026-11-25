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

A migration moves the settings from the previous per-group permissions table to the new verbs. A user group that previously had no saved Engage permissions will be granted all permissions. Behaviourally, this is equivalent as previous versions defaulted to open rather than closed access.

After you upgrade, check that your user groups have the access you expect.

The previous permission classes are removed: `IUserGroupPermissionService`, `IUserGroupPermissionRepository`, `UserGroupPermission`, `IUserGroupPermissionDtoMapper`, and `UserGroupPermissionDto`. The user group permission endpoints are also removed.

#### The Cockpit is rebuilt

The Engage Cockpit has been rewritten with Lit and no longer uses Vue. It follows the user's access to the Engage section and the Read verbs of their user groups.

The Cockpit segment classes are removed: `ICockpitSegmentRuleFactory`, `DefaultCockpitSegmentRuleFactory`, and `CockpitSegment`. To add a segment rule, register a `segmentRuleProvider` extension instead, then expose these to the Cockpit via `cockpitSegmentRuleProvider`.

#### Reporting generation time

`Engage:Reporting:DataGenerationTime` now defaults to empty instead of `04:00`. When it is empty, Engage picks a random time between 01:00 and 05:00 in the reporting time zone and keeps it across restarts. If you set the value explicitly, it is now scheduled in the reporting time zone instead of the server time zone. If your server and reporting time zones differ, check that the time is still what you want.

#### Legacy segment names are removed

Engage no longer supports the legacy `umarketingsuite_` segment names. The `Engage:Settings:UseLegacySegmentNames` setting is removed.

A migration renames the legacy segments in the Umbraco database and the Engage database:

| Legacy name | New name |
| --- | --- |
| `umarketingsuite_ab-testing_<id>` | `engage_ab-testing_<id>` |
| `umarketingsuite_personalization_<id>` | `engage_personalization_<id>` |

{% hint style="warning" %}
Back up your databases before you upgrade. When a property has both a legacy value and an Engage value, the migration deletes one of them.

Leave `Engage:Settings:UseLegacySegmentNames` at its current production value until the upgrade has run. The migration reads the value once to decide which value to keep. `true` keeps the legacy value. Any other value, or no value, keeps the Engage value.
{% endhint %}

After you upgrade:

* Check the variants of a site that switched from legacy names to Engage names. A legacy value with no Engage value for the same property is renamed and becomes the variant's value.
* Rebuild the content search index. The index holds field names built from the old segment names.
* Rebuild the published cache manually if segment variants do not render.
* Update headless front ends that send or store a legacy segment name. Engage still maps a legacy name in the `Forced-Segment` header to the Engage name. Legacy names used anywhere else are not mapped.

On a site with more than one server, upgrade one server first.

`IAbTestingSegmentNameProvider`, `IPersonalizationSegmentNameProvider`, and their implementations are removed. The segment prefixes are now in the `Umbraco.Engage.Common.Segments.SegmentNames` class. The constructors that took a segment name provider no longer take one.

#### Member tracking requires analytics permission by default

`Engage:Analytics:DataCollection:RequireAnalyticsPermissionForMemberTracking` now defaults to `true`. A logged-in member is attached to a pageview only when `IModulePermissions.AnalyticsIsAllowed` returns `true` for the request. Other requests are still tracked as an anonymous visitor.

Set the value to `false` to keep the behavior of Engage 18.

#### Request filters return insertions

`IRequestFilter.Filter` is removed, so a filter can no longer rewrite the whole page as a string. A custom filter must implement `IRequestFilter.GetInsertions` and return `ContentInsertion` values. Each value places content before the closing `</head>` or `</body>` tag.

The `ModifyHttpResponseBodyAsync` delegate is also removed. Engage now modifies only `text/html` responses instead of every `text/*` response.

#### Segmented properties inside blocks

Engage now finds segmented properties inside blocks. The constructors of `UmbracoSegmentService`, `HasSegmentedPropertyContentTypesController`, and `AbTestUmbracoPageVariantDtoMapper` take new parameters. Resolve these classes through dependency injection.

`IUmbracoSegmentService.CreateSegment` now returns `Success` for a page with segmented properties only inside blocks. Previously, the method returned `NoSegmentedProperties`.

#### Interface members without a default implementation

Engage interface members no longer have a default implementation. If you implement an Engage interface, such as `IGoalService`, `IPersonaService`, `ICustomerJourneyService`, or `IAnalyticsQueryService`, you must implement every member.

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
| `AnalyticsQuery.Page` and `AnalyticsQuery.PageSize` | Use `Paging`. |
| `UmbracoUser.Id` | Use `Key`. |
| The integer ID methods on `IPersonaDeleteHandler` and `ICustomerJourneyDeleteHandler` | Use the methods that take a key. |
| `ITrafficFilterCalculator.IsFiltered` | None. The method was unused. |
| `EnableDocumentTypeSegmentationServerVariablesParsingNotificationHandler` and its composer | None. Umbraco CMS 19 no longer publishes the notification. |

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
