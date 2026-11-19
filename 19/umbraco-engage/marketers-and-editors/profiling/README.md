---
description: >-
  Explore how the Profiles section helps track visitor sessions, manage
  profiles, and differentiate between identified and unidentified visitors.
---

# Profiling

The **Profiles** section offers an overview of all the visitors that visited your website. To access the profiles section, navigate to **Engage** > **Profiles**.

![Profiles section](../../.gitbook/assets/Profiles-v16.png)

This section provides an overview of all visitors:

![Profiles Overview](../../.gitbook/assets/profiles-overview-v16.png)

At the top, the total number of visitors that visited your website is displayed. You can also see how many visitors are identified versus unidentified.

The **New profiles (last 30 days)** chart shows how many profiles were added in the last 30 days. The **Profile growth (last 365 days)** graph shows how the number of profiles has grown over the past year.

The table lists the individual profiles.

## Identified versus Unidentified Profiles

As long as there is no data of a visitor, this profile is called "Unidentified". If a visitor [does not give consent](../../developers/introduction/the-umbraco-engage-cookie/module-permissions.md) to be identified, they remain "Unidentified".

However, once a visitor logs in (via Umbraco's Members section) or submits an Umbraco Form (requires the [Forms](../../add-ons/forms.md) add-on), they become an "Identified Profile." For example: If you see a visitor name in the Profiles table it is because the visitor has logged in as a member.

## Profiles Overview

![Table view of Profiles Overview](../../.gitbook/assets/profiles-overview-table-view-v16.png)

The Profiles table displays all visitors to the website, showing:

* Whether the visitor was identified or unidentified
* The number of sessions of the visitor
* The number of pageviews within those sessions
* The first session that the visitor had on the website
* The last session of the visitor
* The number of goals triggered by the visitor
* The total value of the goals

Finally, you can see a blue or a grey icon at the beginning of the row. A grey icon indicates that Umbraco Engage did not enrich the visitor's experience. A blue icon indicates that Umbraco Engage enriched the visitor's experience by showing an A/B test variant or a personalized version.

### Filtering the Results

It is possible to filter the profiles table by clicking the **Filter** button.

![Filtering the profiles overview using the filter button](../../.gitbook/assets/filtering-results-v16.png)

You can filter by:

* Excluding unidentified or identified profiles
* Excluding high-potential profiles
* A minimum number of completed goals
* A minimum goal value
* The period the profiles were active
* Segment
* Member name

For more details, click **Show profile** in a specific profile's row. For more information, see the [Profile Detail](profile-detail.md) article.

![Filtering Options](../../.gitbook/assets/filtering-results-options-v16.png)
