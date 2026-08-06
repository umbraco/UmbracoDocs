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

#### [18.1.0](https://www.nuget.org/packages/Umbraco.Engage/18.1.0) (August 2026)

**Upgrading**

* An incomplete database schema alignment no longer blocks the upgrade. In 18.0.0 the migration failed and the site did not start. Engage now starts, marks its schema unhealthy, disables its own runtime, and logs what still needs to be done. The site stays available while the alignment is completed.

**Previewing**

* Previewing A/B test variants now goes through Umbraco's native preview segment switcher, bringing it in line with how personalizations are previewed. Every test type can now be previewed, including the benchmark (control) variant, as can ContentType-scoped and MultiPage personalizations.
* The legacy `?EngagePreviewVariantId` and applied-personalization preview query string parameters have been removed, along with the endpoint that generated preview URLs from them. Any bookmarked or hand-built preview URLs relying on these parameters will no longer work.
* Preview is now correctly unavailable for Split URL tests, which cannot be previewed in place.
* Fixed the preview segment selector disappearing after switching culture and never reappearing.
* Fixed variant edit links silently losing their segment after any call made without one.
* Fixed the erroneous "Document Type does not support segmentation" warning shown when selecting an A/B test variant.
* Fixed the control group suppressing a personalized variant's CSS/JS in preview, even though the control group is deliberately ignored while previewing.
* The heatmap variant selector now drives the preview with a real Umbraco segment instead of legacy query string parameters.
* The heatmap preview session is no longer ended prematurely when switching variant.
* Fixed the A/B test preview button doing nothing, and prevented a previewing visitor from falling into A/B test buckets.
* Fixed a 404 when editing a personalized variant on an invariant document, and resolved previewing on invariant documents.
* The Engage Cockpit is now suppressed while Umbraco's own preview is active.
* Improved the A/B test editing flow with prompts to save the test before previewing or modifying variants.

**Serving and content**

* Invariant A/B tests and personalizations are now applied on culture-specific pages. Culture matching previously tested for `null` rather than an empty string, so invariant configurations were skipped entirely. A `NormalizeInvariantCultureToNull` migration rewrites `culture = ''` to `NULL` across four configuration tables during upgrade.
  * **Behaviour change**: invariant A/B tests and personalizations that were previously inert will start serving variants after upgrading.
* Fixed the A/B variant segment placeholder only being created under the default culture. This prevented variants for other cultures being authored or served on multilingual sites.
* ContentType-scoped personalizations now appear on the Personalization tab. An integer ContentTypeId was being compared to a GUID, so they were never listed.
* Document references in personalizations are no longer cached for the lifetime of the process. A deleted page now stops showing a dead link without needing a restart.
* The segment is now written to the analytics page variant table, so segmented traffic is attributed correctly.
* Segment options in the backoffice are now filtered to the A/B tests and personalizations configured for the document being edited or previewed. The CMS preview segment switcher is replaced with a document-scoped version.
* Editing a Single Page A/B test variant now opens the segment-scoped editor.
* Fixed Split URL test page selection, matching test pages by node id rather than row key.
* Fixed the Pageview goal picker storing a generated row identity instead of the Umbraco document key. This caused picked pages to show as "Not found" on reopen and the goal to never convert.
  * **Action required**: Pageview goals saved on 18.0.0 hold unrecoverable values and must have their pages re-picked after upgrading.

**Analytics and reporting**

* Adds server-side paging to analytics report queries.
* Fixed percentage-change values in the comparison view lining up with the wrong rows after sorting or paging.
* Custom event fields (category, action, label) are widened to 1000 characters. They were previously truncated to 50 characters silently.
* Fixed segment reporting charts showing stale or empty data when switching segments, and the percentage toggle not redrawing.
* Replaced a nested row scan with a hash lookup when merging analytics tables, resolving browser timeouts on large data sets.
* Lift vs Control now reports 0 rather than a misleading prognosis lift. This applies when a variant has no traffic, or when the control has no baseline visitors.
* Fixed filter mutation and redraw flicker in the analytics UI.

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
