---
description: >-
  Different types of data are stored for varying durations in Umbraco Engage. Use this
  article to learn about the specific storage periods and recommendations.
---

# Retention periods of data

There is no reason to store your visitor data forever. As privacy is an important aspect of Umbraco Engage, you have tools to ensure you do not store the data forever.

You can [configure](../../../installing-umarketingsuite/configuration-options-2-x/) Umbraco Engageto delete three data types after a certain period.

* **Raw data** is collected in [the first phase of the data flow](../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/). This data is stored and parsed a few moments later. By default, this data gets deleted after 5 days. It is recommended that this data is stored for no longer than 30 days.
* **Control group data** is used for [personalization](../../../personalization/) purposes. When a visitor visits a personalized page, Umbraco Engage keeps track of whether that visitor is in a control group for user experience consistency. By default, this gets deleted after 180 days. The recommendation is to not increase this.
* [**Processed data**](../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/) is used for [reporting](../../../the-umarketingsuite-broad-overview/dataflow-pipeline/reporting/) and personalization purposes. You most likely need this for a long time. By default Umbraco Engage anonymizes this data after 2 years, and deletes it after 3 years.
  * The first privacy step is to [anonymize](../../../security-privacy/anonymization/) the data so it cannot be linked back to an individual visitor anymore.
  * Besides anonymization, it makes sense to clean up that anonymized data somewhere in the future. What good is this information after 8 years for example? You should ask yourself this question and set the correct setting in the configuration file.
