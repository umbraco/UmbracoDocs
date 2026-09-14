---
description: >-
  Learn about the scoring settings shared by Persona Groups and Customer Journey Groups, and how to fine-tune them.
---

# Persona and customer journey group settings

Persona Groups and Customer Journey Groups share the same scoring settings. These settings determine:

- When a persona or customer journey step becomes active,
- How long scores are retained, and
- How many points can be assigned when configuring scoring.

You can find these settings in the **Advanced** settings of a Persona group or Customer journey group.

## Group settings

### Threshold value

The threshold value determines the minimum score a visitor must reach before a persona or customer journey step can become active.

Once the threshold has been reached, the profile with the highest score in the group becomes active, provided it also meets the minimal deviation requirement.

Use a higher threshold when you want to collect more evidence before assigning a visitor to a persona or customer journey step.

### Minimal deviation

Minimal deviation determines how much higher the highest score must be compared to the next highest score before it becomes active.

This setting helps avoid activating a persona or customer journey step when a visitor's behaviour matches multiple profiles equally well.

If the minimal deviation is set to 0, the profile with the highest score becomes active as soon as the threshold value is reached.

#### Absolute

When set to Absolute, the deviation is measured in points. For example, if the highest score is 40 and the next highest score is 35, the deviation is 5 points.

#### Percentage

When set to Percentage, the deviation is measured as a percentage of the second-highest score. This can be useful when you want the required gap between profiles to scale with the overall score.

### Expiration type

Expiration determines how long scores are retained for a visitor. When scores expire, all scores in the group are reset and the visitor starts over. By default, scores never expire.

#### Days

When using Days, scores are retained for the specified number of days after the most recent scoring activity in the group. Each new scoring event restarts the countdown.

#### Sessions

When using Sessions, scores are retained for a specified number of visitor sessions. A session follows the standard Engage session definition, where all activity within 30 minutes is considered part of the same session.

For example, if the expiration value is set to 5 sessions, scores remain available during the first five sessions after scoring. When the visitor returns for the sixth session, all scores in the group are reset.

### Maximum points to score

This setting controls how many points editors can distribute across personas or customer journey steps within the group when configuring scoring.

It does not limit how many points a visitor can accumulate over time. Different groups can use different maximum values depending on how detailed the scoring model should be. The default value is 10.

## Fine-tuning scoring

The default settings work well for most scenarios. However, you can adjust the settings to make personas and customer journey steps activate sooner, later, or with more confidence.

### When personas activate too quickly

If visitors are assigned to a persona after only a few interactions, consider increasing the **Threshold value**. A higher threshold requires more evidence before a persona becomes active.

For example, a software company may have personas such as *Developer*, *Technical Decision Maker*, and *Business Decision Maker*. If visitors are assigned after viewing only a few pages, increasing the threshold can help ensure that the assigned persona better reflects their actual interests.

### When personas activate too slowly

If visitors need many interactions before a persona becomes active, consider lowering the **Threshold value**. This can be useful when visitors typically view only a small number of pages before converting or leaving the site.

### When profiles are too similar

If visitors often show interest in multiple personas or customer journey steps at the same time, increase the **Minimal deviation**. This ensures that a profile only becomes active when it stands out from the others.

For example, a visitor may read content aimed at both developers and technical decision makers. Increasing the minimal deviation prevents either profile from becoming active until one has a clear lead.

### When interests change over time

Some interests are temporary and should not influence personalization forever. For example, a visitor researching Black Friday promotions may be highly engaged for a few weeks. But that interest is unlikely to remain relevant couple of months later.

In these cases, consider using an **Expiration type** to automatically reset scores after a period of time or a number of sessions.

This allows Engage to build a new profile based on the visitor's current interests rather than relying on historical behaviour.

### Choosing between Days and Sessions

Use **Days** when interests naturally expire over time. Examples include:

* Seasonal campaigns
* Product launches
* Event registrations
* Holiday promotions

Use **Sessions** when you want to focus on a visitor's most recent interactions, regardless of how much time passes between visits.

This can be useful for customer journeys where recent behaviour is more important than long-term interests.

### Keeping scoring balanced

The **Maximum points to score** setting helps maintain consistency when editors configure scoring. A lower value encourages more subtle scoring, while a higher value allows individual interactions to have a greater impact.

For most scenarios, the default value provides a good balance between flexibility and control.
