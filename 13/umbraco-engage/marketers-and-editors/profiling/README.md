---
description: >-
  Explore how the Profiles section helps track visitor sessions, manage
  profiles, and differentiate between identified and anonymous visitors.
---

# Profiling

The **Profiles** section offers an overview of all the visitors that visited your website. Access the profiles section by navigating to the **Engage** section and then to the **Profiles** subsection in the topmenu.

![Profiles section](<../../.gitbook/assets/Profiles (1).png>)

This section provides an overview of all visitors:

![Profiles Overview](<../../.gitbook/assets/profiles-overview (1).png>)

At the top, the total number of visitors that visited your website (in this case in total 25.521 profiles) is displayed. You can also see how many visitors are identified versus unknown.

The graph in the middle shows the number of new identified visitors over the last 30 days.

Below that there is an overview of the profiles per month.

## Identified versus Anonymous Profiles

As long as we have no data of a visitor we will call this profile "Anonymous". If a visitor [does not give consent](../../developers/introduction/the-umbraco-engage-cookie/module-permissions.md) to be identified, they remain "Anonymous".

However, once a visitor logs in (via Umbraco's Members section) or submits an Umbraco form, they become an "Identified Profile." For example: In the above screenshot you see "Jeffrey Schoemaker". We see this name because this visitor has logged in as the member "Jeffrey Schoemaker" at a moment in time.

## Profiles Overview

![Table view of Profiles Overview](<../../.gitbook/assets/profiles-overview-table view (1).png>)

The overview table displays all visitors to the website, showing:

* Whether the visitor was anonymous or identified
* The number of sessions the visitor had
* The number of pageviews within those session
* The first session that the visitor had on the website
* The last session that the visitor had
* The number of goals triggered by the visitor
* The total value the goals had

Finally, you can see a blue or a grey icon at the beginning of the row. A grey icon indicates that Umbraco Engage did not enrich the visitor's experience. A blue icon indicates that Umbraco Engage enriched the visitor's experience by showing an A/B test variant or a personalized version.

### Filtering the Results

It is possible to filter the overview of profiles by clicking the **Filter** button at the top of the profiles overview.

![Filtering the profiles overview using the filter button](<../../.gitbook/assets/filtering-results (1).png>)

You can filter by:

* Anonymous or Identified profiles.
* Profiles with a "High potential"
* Profiles with more than X conversions
* Profiles with more than X total value achieved by triggered goals
* Specific date ranges

For more details, click **Show profile** in a specific profile's row. For more information, see the [Profile Detail](profile-detail.md) article.
