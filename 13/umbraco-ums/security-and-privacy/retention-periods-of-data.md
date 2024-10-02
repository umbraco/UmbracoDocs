# Retention Periods of data

There is never a reason to store your visitor data for ever. Privacy is an important aspect of uMS, and you have tools to make sure you do not store the data for ever.

You can [configure](/installing-umarketingsuite/configuration-options-2-x/) uMS to delete three types of the data after a certain period.

- The raw data that is collected in [the first phase of the dataflow](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/). This data is stored and parsed a few moments later. After being processed the raw data is no longer used. Only if you want to reprocess your raw data at a later moment it could be convenient to store this data for a short while. By default it gets deleted after 5 days. Our recommendation is to store this raw data no longer than 30 days.
- The control group data that is used for [personalization](/personalization/) purposes. When a visitor visits a personalized page, uMS keeps track of whether that visitor was in a control group for user experience consistency. By default this gets deleted after 180 days. Our recommendation is to not increase this.
- The [processed data](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-parsing/) that is used for [reporting](/the-umarketingsuite-broad-overview/dataflow-pipeline/reporting/) and [personalization](/personalization/)purposes. You most likely need this for a long period of time. By default uMS anonymizes this data after 2 years, and deletes it after 3 years.
  - The first privacy step is to [anonymize](/security-privacy/anonymization/) the data so it cannot be linked back to an individual visitor anymore.
  - Besides anonymization, it makes sense to clean up that anonymized data somewhere in the future as well. What good is this information after 8 years for example? You should ask yourself this question and set the correct setting in the configuration file.
