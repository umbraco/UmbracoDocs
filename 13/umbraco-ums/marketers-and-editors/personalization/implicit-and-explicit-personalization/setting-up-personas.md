---
description: >-
  To set up implicit personalization within Umbraco uMS you can set up personas
  for your website.
---

# Setting up Personas

This can be done by going to the Marketing section in your Umbraco installation and the sub-section "**Personalization**". There you can navigate to the tab "**Personas**".

![]()

Here you can create one or more persona groups, and within each group, you can create one or more personas.

## Personas

Personas are an important concept for implicit personalization in the Umbraco uMS. A persona is an archetypical user whose goals, needs, and characteristics represent a group of visitors to your website. By creating personas you can define behavior on your website and personalize the website experience depending on the persona's needs.

Creating personas is something that you should do for your website. If it's your first time coming up with personas we always advise creating a maximum of 3 personas.&#x20;

If you want to add many more personas, be aware that each added persona will increase the complexity of coming up with good personalization strategies. And every extra persona requires extra content.

In Umbraco uMS we for example have three different personas:

* **The data & privacy officer**. This type of visitor is mainly interested in how Umbraco uMS is safeguarding data storage and GDPR ruling.
* **The developer**. This persona is interested in how to set up Umbraco uMS.
* **The marketer**. This persona is looking for inspiration and functionalities; what has Umbraco uMS to offer.

## Setting up a persona group

Personas can be grouped in a persona group. You can create a persona group by clicking "**Add new persona group**". This will show a popup where you can specify a title for the persona group and a short description.

![]()

## Setting up personas

Within this persona group, you can specify one or more personas. Creating a persona can be done by clicking on "**Add persona**". In this popup, you can specify the name of the persona, a short description, a color, and an image. The uMarketingSuite **ships 16 persona images by default** but you can add your own images as well!

![]()

You've set up your personas and can now score your [content](../../../../../personalization/implicit-personalization-scoring-explained/content-scoring/), [campaigns](../../../../../personalization/implicit-personalization-scoring-explained/campaign-scoring/), and [referrals](../../../../../personalization/implicit-personalization-scoring-explained/referral-scoring/) against these personas.

## Advanced persona group parameters

If you want to tweak the working of the persona scoring in-depth you can go to the advanced settings of a persona group.

![]()

Here you have the option to set different parameters:

* **Threshold value**. This threshold value needs to be reached before a persona can become active. In this case, a persona needs to have 25 points at least before a visitor can be this persona.
* **The minimal deviation**. This setting specifies the minimal deviation between the persona with the highest score and the second-highest score. This can be specified in an absolute value or in a percentage.
* **The minimal deviation percentage**. The percentage specifies the minimum difference between the highest score and the second highest score before a persona becomes active. In this case, the difference between the first and second persona should be at least 25%.
* **The absolute value deviation**. The absolute value specifies the minimum difference between the highest score and the second-highest score before a persona becomes active.
* **The expiration type**. Specify whether the implicit persona scoring expires. This can be set to 'never' when it does not expire or can be set to a number of days or sessions.
* **The maximum points to score**. Specify the maximum number of points that can be scored per persona per item.

By adjusting these settings you can tweak the performance of the Umbraco uMS algorithm.
