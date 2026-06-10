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
| **Scheduled Trigger** | A Command Run On Notice (CRON) expression matches the current time.                                                                                                   |
| **Webhook**           | An HTTP request is received at the automation's webhook URL. Authentication is configured per automation (Hash-based Message Authentication Code (HMAC) signature or a shared secret). |

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

## Trigger Output

Every trigger produces output data that subsequent steps can bind to. For example, the **Content** **Published** trigger outputs the content name, key, content type alias, and culture.

Use the binding picker in the step settings dialog to insert trigger output values into action settings:

```
${ trigger.contentName }
${ trigger.contentKey }
${ trigger.contentTypeAlias }
```

See [Bindings](bindings.md) for the full syntax.

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
