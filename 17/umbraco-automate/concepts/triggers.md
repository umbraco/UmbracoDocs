---
description: >-
  A trigger is the event that starts an automation. Each automation has exactly
  one trigger.
---

# Triggers

A trigger subscribes to an event source. When the event fires, the trigger starts a run of the automation.

## **Available Built-in Triggers**

Use built-in triggers to start automations from backoffice events, schedules, and webhooks.

### General

| Trigger               | Fires when                                                                                                                                    |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **Manual Trigger**    | A user runs the automation by hand from the backoffice.                                                                                       |
| **Scheduled Trigger** | A Command Run On Notice (CRON) expression matches the current time. Can also be run by hand with **Run now**, the same as a Manual Trigger.  |
| **Webhook**           | An HTTP request is received at the automation's webhook URL. Authentication is configured per automation (Hash-based Message Authentication Code (HMAC) signature or a shared secret). Can also be run manually with **Run now**, using the trigger's saved test request instead of a real HTTP call. |

### Content

| Trigger                 | Fires when                                               |
| ----------------------- | -------------------------------------------------------- |
| **Content Published**   | A content item is published. Filterable by content type. |
| **Content Saved**       | A content item is saved. Filterable by content type.     |
| **Content Unpublished** | A content item is unpublished.                           |

### Media

| Trigger           | Fires when                                                          |
| ----------------- | ------------------------------------------------------------------- |
| **Media Saved**   | A media item is saved. Filterable by media type.                    |
| **Media Trashed** | A media item is moved to the recycle bin. Filterable by media type. |
| **Media Deleted** | A media item is permanently deleted. Filterable by media type.      |

### Members

| Trigger            | Fires when                                                                          |
| ------------------ | ----------------------------------------------------------------------------------- |
| **Member Saved**   | A member is saved (created or updated). Filterable by member type and member group. |
| **Member Deleted** | A member is deleted. Filterable by member type and member group.                    |

### Users

| Trigger                   | Fires when                                                                 |
| ------------------------- | -------------------------------------------------------------------------- |
| **User Saved**            | A backoffice user is saved (created or updated). Filterable by user group. |
| **User Deleted**          | A backoffice user is deleted. Filterable by user group.                    |
| **User Login Success**    | A backoffice user successfully logs in. Filterable by user group.          |
| **User Login Failed**     | A backoffice login attempt fails. Filterable by user group.                |
| **User Locked**           | A backoffice user account is locked. Filterable by user group.             |
| **User Password Changed** | A backoffice user's password is changed. Filterable by user group.         |

{% hint style="info" %}

Each content and media trigger has a batch variant (for example, Content Batch Published). The batch trigger fires once per save or publish operation with all affected items as a single collection. Use it when you want one automation run to process the whole batch.

{% endhint %}

Add-on packages contribute additional triggers. See [Add-ons](../add-ons/) for the catalogue.

## Running a Trigger On Demand

Open the automation's context menu (the three dots next to it in the tree) and select **Run now**. The automation starts immediately, without waiting for its trigger to fire naturally. The option only appears when the automation's trigger supports it.

* **Manual Trigger** and **Scheduled Trigger** always support **Run now**.
* **Webhook** also supports it, using the trigger's saved **Test request body** and **Test request headers** instead of a real HTTP request. See [Finding the Webhook URL](#finding-the-webhook-url) below. Authentication and the allowed-method check are skipped for on-demand runs, since nothing is calling the webhook endpoint.
* Content, Media, Member, and User triggers don't support **Run now**. Trigger their automations by performing the underlying action (publish a content item, save a media item, and so on).
* Add-on and custom triggers can opt in to **Run now** individually. If the option isn't in the context menu, the automation's trigger doesn't support it.

## Finding the Webhook URL

Once an automation using the Webhook trigger has been saved, its webhook URL appears in two places:

* The automation's **Info** tab.
* The Webhook trigger's own settings panel, alongside the **Test request body** and **Test request headers** fields used by **Run now** (above).

The URL has the form `{host}/automate/webhook/{automationId}`. The host reflects the site's configured `WebRouting:UmbracoApplicationUrl` setting, not the address in your browser. Behind a load balancer or reverse proxy, the URL uses the configured public host instead of an internal one.

## Trigger Output

Every trigger produces output data that subsequent steps can bind to. For example, the **Content** **Published** trigger outputs the content name, key, content type alias, and cultures. The **Scheduled Trigger** outputs the time it fired and the CRON expression that fired it:

```
${ trigger.firedAtUtc }
${ trigger.cronExpression }
```

Use the binding picker in the step settings dialog to insert trigger output values into action settings:

```
${ trigger.contentName }
${ trigger.contentKey }
${ trigger.contentTypeAlias }
```

See [Bindings](bindings.md) for the full syntax.

On variant (multilingual) content, the content triggers also expose which cultures were affected by the save, publish, or unpublish:

```
${ trigger.cultures }
```

This is an array of ISO culture codes, for example `["en-us", "da-dk"]`. It is `null` for content types that aren't set up for variation.

{% hint style="info" %}

When a descendant is republished as a side effect of publishing an ancestor, Umbraco doesn't report which cultures changed on that descendant specifically. In that case, `cultures` falls back to all of the descendant's currently published cultures rather than the true delta.

{% endhint %}

The **Content Saved**, **Media Saved**, **Member Saved**, and **User Saved** triggers also expose an `isNew` flag that is `true` when the entity is newly created. Use it to branch between create-only and update-only logic:

```
${ trigger.isNew }
```

This is a soft signal derived from the entity's create or update dates. Automations needing a hard guarantee should re-fetch.

## Trigger Settings

Most triggers expose settings that filter when they fire. For example, the **Content Published** trigger lets you restrict it to specific content types. The trigger then only fires for publishes on those content types.

## See Also

* [Build an Automation](../backoffice/building-an-automation.md)
* [Bindings](bindings.md)
* [Create a Custom Trigger](../extending/custom-trigger.md)
