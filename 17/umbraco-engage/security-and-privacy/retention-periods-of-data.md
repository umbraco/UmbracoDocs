---
description: >-
  Different types of data are stored for varying durations in Umbraco Engage.
  Use this article to learn about the specific storage periods and
  recommendations.
---

# Retention periods of data

There is no reason to store your visitor data forever. As privacy is an important aspect of Umbraco Engage, you have tools to ensure you do not store the data forever.

You can [configure](../developers/settings/configuration.md) Umbraco Engage to delete three types of data after a certain period.

<table><thead><tr><th width="282">Type of data</th><th width="217">Anonymized</th><th>Deleted</th></tr></thead><tbody><tr><td><strong>Raw Data</strong></td><td>-</td><td>5 days</td></tr><tr><td><strong>Control Group Data</strong></td><td>-</td><td>180 days</td></tr><tr><td><strong>Processed Data</strong></td><td> 2 years</td><td>3 years</td></tr></tbody></table>

* **Raw data** is collected in [the first phase of the data flow](../developers/introduction/dataflow-pipeline/data-collection.md). This data is stored and parsed a few moments later. By default, this data gets deleted after 5 days. It is recommended that this data is stored for no longer than 30 days.
* **Control group data** is used for [personalization](../developers/personalization/) purposes. When a visitor visits a personalized page, Umbraco Engage keeps track of whether that visitor is in a control group for user experience consistency. By default, this gets deleted after 180 days. The recommendation is to not increase this.
* [**Processed data**](../developers/introduction/dataflow-pipeline/data-parsing.md) is used for [reporting](../developers/introduction/dataflow-pipeline/reporting.md) and personalization purposes. You most likely need this for a long time. By default, Umbraco Engage anonymizes this data after 2 years and deletes it after 3 years.
  * The first privacy step is to [anonymize](anonymization.md) the data so it cannot be linked back to an individual visitor anymore.
  * Besides anonymization, it makes sense to clean up that anonymized data somewhere in the future. What good is this information after 8 years for example? You should ask yourself this question and set the correct setting in the configuration file.
