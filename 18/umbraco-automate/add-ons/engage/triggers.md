---
description: >-
  Reference for the triggers contributed by the Umbraco.Engage.Automate add-on.
---

# Triggers

The Engage add-on contributes the following triggers.

## A/B Test Triggers

| Display Name | Alias |
| ------------ | ----- |
| A/B Test Saved | `umbracoEngage.abTestSaved` |
| A/B Test Scheduled | `umbracoEngage.abTestScheduled` |
| A/B Test Started | `umbracoEngage.abTestStarted` |
| A/B Test Stopped | `umbracoEngage.abTestStopped` |
| A/B Test Variant Saved | `umbracoEngage.abTestVariantSaved` |

## Session and Pageview Triggers

| Display Name | Alias |
| ------------ | ----- |
| New Session Started | `umbracoEngage.newSessionStarted` |
| Pageview Extracted | `umbracoEngage.pageviewExtracted` |

## Personalization and Segment Triggers

| Display Name | Alias |
| ------------ | ----- |
| Applied Personalization Saved | `umbracoEngage.appliedPersonalizationSaved` |
| Segment Saved | `umbracoEngage.segmentSaved` |
| Segment Deleted | `umbracoEngage.segmentDeleted` |

## Customer Journey Triggers

| Display Name | Alias |
| ------------ | ----- |
| Customer Journey Group Saved | `umbracoEngage.customerJourneyGroupSaved` |
| Customer Journey Step Scored | `umbracoEngage.customerJourneyStepScored` |
| Customer Journey Step Explicitly Assigned | `umbracoEngage.customerJourneyStepExplicitScored` |
| Customer Journey Step Assignment Removed | `umbracoEngage.customerJourneyStepExplicitScoreRemoved` |

## Persona Triggers

| Display Name | Alias |
| ------------ | ----- |
| Persona Group Saved | `umbracoEngage.personaGroupSaved` |
| Persona Scored | `umbracoEngage.personaScored` |
| Persona Explicitly Assigned | `umbracoEngage.personaExplicitScored` |
| Persona Assignment Removed | `umbracoEngage.personaExplicitScoreRemoved` |

## Goal and Campaign Triggers

| Display Name | Alias |
| ------------ | ----- |
| Goals Saved | `umbracoEngage.goalsSaved` |
| Custom Goal Completed | `umbracoEngage.customGoalCompleted` |
| Client-Side Goal Completed | `umbracoEngage.clientSideGoalCompleted` |
| Campaign Group Saved | `umbracoEngage.campaignGroupSaved` |

{% hint style="info" %}
Each Engage trigger emits details about the entity it fired on. Inspect a real run in the **Runs** view to see the exact field names, then use the binding picker to reference them in downstream steps.
{% endhint %}
