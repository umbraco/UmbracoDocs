---
description: >-
  Discover how to analyze visitor profiles, including insights on engagement
  metrics,  potential, personas, and detailed activity tracking.
---

# Profile detail

In the Profiles section, you can access specific visitor profiles, by clicking **Show profile**. It contains two sections: **Insights** and **Activity**.

## Insights

The Insights section provides an overview of the visitor.

![Insight section overview.](../../.gitbook/assets/Insight-section-overview-v16.png)

Here, you can see:

* The date of the visitor's first session on the website,
* The date of the visitor's last activity,
* The number of sessions,
* The number of page views,
* The time spent on the website, and
* The total engaged time.

You can also view any goals triggered by this visitor.

### Profile Potential

Umbraco Engage also shows the potential of the profile based on the engagement time and when the profile was last active.

By default, a profile is considered active if the profile has visited the website in the last 30 days.

By default, a profile is considered engaged when the engagement time of the visitor was higher than 300 seconds in the last 3 sessions.

## Calculated Persona & Customer Journey Phase

Within the profile, you can see all [personas](../personalization/implicit-and-explicit-personalization/setting-up-personas.md) and [customer journeys](../personalization/implicit-and-explicit-personalization/setting-up-the-customer-journey.md) that you have set up within Umbraco Engage. Each persona and customer journey phase displays a score. You can see if Umbraco Engage has assigned a persona or journey phase to this visitor. In the below example, you see that the Umbraco Engage has assigned the persona "Data & Privacy officer" to this visitor.

![Assigned phase.](../../.gitbook/assets/Assigned-phase-v16.png)

## Activity Tab

In the Activity tab, you can view all the activity of this visitor.

![Activity tab.](../../.gitbook/assets/activity-tab-v16.png)

For each session, you can see:

* An icon indicating whether Umbraco Engage enriched the visitor's experience (blue icon for A/B Test variant or personalized variant; grey icon if not).
* The timestamp when the session was recorded.
* Which device type was used.
* The number of pages that were visited in this session.
* The duration of the session.
* How long the person was engaged.
* The number of goals that were triggered.
* The events that were triggered.
* On which page the session started.
* From which website the visitor came into your website.

By clicking on a row, you can access more detailed information about that session.

![Detailed session information.](../../.gitbook/assets/Detailed-session-information.png)

You will see:

* The visited page.
* The time of visit.
* The time on page.
* The engaged time on page.
* The scroll depth on that page.
* The number of goals that were triggered.
* The number of recorded events.
* The variant of the page is displayed to the visitor.
* The operating system, browser, and (anonymized) IP address are used.
* An icon indicating whether the visitor saw a personalized or A/B tested variant of the page.

Finally, you can drill down into the activity on a specific page:

![Activity on a specific page.](../../.gitbook/assets/Activity-on-specific-page-v16.png)

Here, you can see:

* When the visitor started their visit on the page.
* When the maximum scroll depth was reached.
* When the visit ended.
* When goals were triggered.
