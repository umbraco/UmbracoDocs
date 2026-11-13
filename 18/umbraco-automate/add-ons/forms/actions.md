---
description: >-
  Reference for the actions contributed by the Umbraco.Forms.Automate add-on.
---

# Actions

The Forms add-on contributes the following actions.

## Submit Form

Alias: `umbracoForms.submitForm`. Programmatically submit a form entry from inside an automation. Pick the form to submit to and provide values for its fields.

## Export Form Entries

Alias: `umbracoForms.exportEntries`. Read entries from a form. The action returns the entries as a collection that downstream steps can iterate over with a **For Each** node.

{% hint style="info" %}
Reading entries from the database and hiding sensitive values are available from Umbraco.Forms.Automate 18.0.4.
{% endhint %}

The action reads entries from the Forms database, so an entry submitted a moment before the run is included. Each entry holds only the form's current fields. Fields removed from the form are not exported.

Sensitive data follows the rules of the Forms backoffice export. A field marked as containing sensitive data is exported only when the workspace service account is in the **Sensitive data** user group. Without that access, sensitive values read `This value is hidden.`, and each entry's `memberKey` is `null`.

{% hint style="warning" %}
Exported values pass through Umbraco Automate's run history and logs. Add the service account to the **Sensitive data** user group only when that is acceptable for your site.
{% endhint %}

{% hint style="info" %}
Open the step in the canvas to see each action's settings and output fields.
{% endhint %}
