---
description: Get an overview of the changes and fixes in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow that were released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
Check the [Version Specific Upgrade Notes](upgrading/version-specific.md) article for breaking changes when upgrading to a new major version.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 19, including all changes for this version.

### [19.0.0-rc1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F19.0.0-rc1) (November 17 2026)

{% hint style="warning" %}
Umbraco Workflow 19.0.0-rc1 requires Umbraco CMS 19.0.0-rc1 or later.
{% endhint %}

#### Updated for Umbraco CMS 19

Umbraco Workflow 19 targets Umbraco CMS 19 and .NET 11. Umbraco CMS 19 replaces the Examine-based search integration with new search abstractions, which Workflow's advanced search is now built on. This changes how advanced search behaves, and removes some public types, as described below.

#### Advanced search uses the Umbraco CMS 19 search

Advanced search now queries the Umbraco CMS content index through the search abstractions in `Umbraco.Cms.Core.Search`, instead of through Examine. The search options and results shown in the backoffice are unchanged, with the following differences:

* The **fuzzy** option no longer has an effect. Text searches match the whole term, or part of it, but do not match similar terms.
* Results no longer have a relevance score. The `Score` value in the search response is always `0`, and results are ordered by name.
* Each field is searched separately and the results are combined, so content that matches any of the searched fields is returned once.
* Restrictions based on the user's content start nodes, and filters on the writer and creator of the content, are applied to the content returned by the search.

#### CSV exports use CsvHelper 34

Workflow now uses CsvHelper 34 to export the workflow history and content review reports as CSV. The exported columns, column order and date format are unchanged.

CsvHelper 34 no longer supports `ClassMap<T>`. The columns of the built-in exports are now defined with CsvHelper attributes on the export models, such as `WorkflowInstanceExportDto` and `ContentReviewExportDto`.

#### Charts are drawn with Analytics.UI

The workflow activity chart on the dashboard and the approval group views, and the content review chart, are now drawn with Analytics.UI instead of Workflow's own Chart.js code. The header cards are replaced by status tiles that are colored by status and have an icon.

Other changes to the charts:

* The date range is chosen with a button toggle of 7, 30 and 90 days, instead of a free-form number of days. The default is 30 days.
* The **Pending approval** tile opens **Active workflows**. Previously, it opened **History**.
* When a chart request fails, the chart shows an error with a **Retry** button instead of an error notification, and the status tiles show a dash.
* Chart points are returned from the API with an ISO date (`yyyy-MM-dd`), instead of `MMM d, yyyy` in the server's culture.

{% hint style="warning" %}
Workflow 19 depends on a pre-release build of the `Umbraco.Analytics.UI` package, which is only available from the Umbraco nightly NuGet feed. Add the feed to the NuGet sources of the site, as described in the [Version Specific Upgrade Notes](upgrading/version-specific.md#dependencies). The dependency will move to a stable release of Analytics.UI before Workflow 19 is released.
{% endhint %}

#### Settings customizations are configured in typed sections

The `Umbraco:Workflow:SettingsCustomization` configuration is replaced by typed sections directly under `Umbraco:Workflow`. Each setting has the same `Value`, `IsHidden` and `IsReadOnly` options as before.

| Workflow 18                                              | Workflow 19                        |
| -------------------------------------------------------- | ---------------------------------- |
| `Umbraco:Workflow:SettingsCustomization:{Section}:{Key}` | `Umbraco:Workflow:{Section}:{Key}` |

The sections are `ContentApprovals`, `ContentReviews` and `ReleaseSets`. An invalid value now fails when the configuration is bound at startup, instead of being reported by a custom validator.

The `Umbraco:Workflow:Colors` setting is removed. The status colors in workflow emails are fixed to red, orange, and green.

The `Umbraco:Workflow:DateFormats` setting is removed.

{% hint style="warning" %}
Existing `SettingsCustomization`, `Colors` and `DateFormats` configuration is ignored. Move any customizations to the new location.
{% endhint %}

#### Code scheduled for removal in Workflow 19 is removed

Obsolete members, the `workflow-history-csv` endpoint and the default implementations of several interface members are removed. Use the `workflow-export` endpoint to export the workflow history.

Custom email templates that read `CurrentTask.Type`, `task.Type` or `Node.Url` no longer compile. When a customized template fails to compile, Workflow renders the template it ships and the **Email Templates** health check lists the error.

#### Breaking changes for developers

The full list of removed and changed types and members is in the [Version Specific Upgrade Notes](upgrading/version-specific.md#code).

#### Bug fixes and other changes

* Splits `ContentReviewConfigDto` into a persistence data transfer object (DTO) and a `ContentReviewConfig` model. See the [Version Specific Upgrade Notes](upgrading/version-specific.md#code) for the affected members.
* Returns `NotFound` from the content diff for a workflow with no source version, instead of looking up a version to compare. 
* Removes the group deletion cleanup from `DeleteApprovalGroupController`. Cancelling workflows and removing permissions for a deleted approval group is now done by a notification handler.
* Renames `ApprovalGroupCollectionReponseModel` to `ApprovalGroupCollectionResponseModel`.
* Fixes release set collections showing no items.
* Sets the permitted state of backoffice conditions to `false` when their context is lost.
