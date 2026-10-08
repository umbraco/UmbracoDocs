---
description: >-
  Reference for the triggers contributed by the Umbraco.Forms.Automate add-on.
---

# Triggers

The Forms add-on contributes the following triggers. Both triggers can be filtered to specific forms via the settings panel.

## Form Submitted

Alias: `umbracoForms.formSubmitted`. Fires when a form entry is submitted.

## Form Entry Approved

Alias: `umbracoForms.formEntryApproved`. Fires when a form entry transitions to the approved state.

{% hint style="info" %}
Both triggers emit the form's metadata and the submitted field values. Inspect a real run in the **Runs** view to see the exact field names, then use the binding picker to reference them in downstream steps.
{% endhint %}
