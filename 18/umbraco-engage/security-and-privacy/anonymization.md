---
description: >-
  When you are working with user data, it is recommended to anonymiza it after
  some time. Learn more about what is means to anonymize data in Umbraco Engage.
---

# Anonymization

For short-term Analytics it would be important who clicked on what link at what time and with what browser. This is relevant as you would want to [personalize](../developers/personalization/) the website or webpage based on that behavior. In the long term, however, this is no longer important. Aggregated and anonymized data will still be needed comparing the number of visitors month after month.

Umbraco Engage gives you the ability to anonymize your data. By anonymizing the data the data is unlinked from the specific session and visitor but remains stored.

Let us take a look at an example:

_Before_ anonymization, you can see that visitor X has visited your website four times. On the first visit, the visitor visited the web pages **w1** and **w2** and scrolled down to 80% of the page length. That visit was on an iPhone with Safari. Three days later the visitor saw webpage **w1** again and made a purchase on **w3**. This visit was with Firefox on a Windows computer.

_After_ anonymization, you cannot relate the individual visits of the webpages or the browser to visitor X. If you go to the Analytics reports of visits, browsers, and scroll depths you still see the same number as before the anonymization.

It is recommended that the data is anonymized after two years or sooner.
