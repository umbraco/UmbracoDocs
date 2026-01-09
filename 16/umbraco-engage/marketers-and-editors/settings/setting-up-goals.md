---
description: >-
  Learn how to set up and implement goals to effectively measure the success of
  your optimization strategies.
---

# Goals

Goals are important in Umbraco Engage. Without goals you cannot determine whether your optimization strategy through [A/B Testing](../ab-testing/) or [Personalization](../personalization/) really works.

A/B Testing and/or Personalization is never the goal. The goal is to increase your goals which can be achieved by personalization or A/B testing.

In the Goals menu, you can set up goals and specify their value.

You have a complete overview of all of the goals that are currently set:

![Settings dashboard in the Engage section](<../../.gitbook/assets/Settings-Goals-v16 (1).png>)

From this page, you can edit existing goals or set up new goals.

## Setting up a new goal

When you click on **Create new goal** you can set up a new goal. You have to give it a name and an optional goal value.

You can specify whether it is a micro or macro goal.

* A macro goal should be used for the "bigger things" in your website like a purchase or filling in a contact form.
* Micro goals are smaller / less important things like "_Reaching the contact page_" or "_Clicking open a FAQ_". These micro goals should eventually contribute to macro goals.

In Umbraco Engage, we always keep track of the macro goals, for example during A/B tests. Perhaps your micro goal is increased, but it hurts your macro goal. In that case, Umbraco Engage will give you a warning.

You can specify whether you want to increase or decrease the goal. Most of the time you want to increase your goal. Other times you might want to lower the goal. An example of this could be a goal of "_Unsubscribing from a newsletter_"

You can specify how the goal will be triggered:

* Via a pageview/set of pages that are visited
* Via a page event that can be triggered
  *   If you want to trigger a goal based on a GA4 event, use the following information:

      Category: **GA 4 Bridging** Action: **\<your action>**
* Via an Umbraco Forms submission
* Via some custom code

<figure><img src="../../.gitbook/assets/settings-create-goal-v16 (1).png" alt=""><figcaption><p>Create a new goal</p></figcaption></figure>
