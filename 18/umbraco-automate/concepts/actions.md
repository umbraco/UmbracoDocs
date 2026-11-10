---
description: >-
  Actions are reusable units of work — HTTP requests, content updates, log
  messages — that run as steps in an automation.
---

# Actions

An action is a reusable unit of work. You add actions to an automation as steps and configure each step with its own settings.

## Available Built-in Actions

Use built-in actions to send data, update Umbraco entities, and control automation flow.

### General

| Action               | Purpose                                                                                                                                                                    |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **HTTP Request**     | Send an HTTP request to an external URL.                                                                                                                                   |
| **Send Email**       | Send an email to one or more recipients, with optional Reply-To, CC, and BCC addresses. See [Send Email Addresses](actions.md#send-email-addresses).                       |
| **Log Message**      | Write a message to the application log. Useful for debugging.                                                                                                              |
| **Delay**            | Pause the automation for a configurable duration.                                                                                                                          |
| **Set Variable**     | Output a named value that downstream steps can bind to.                                                                                                                    |
| **Notify Editor**    | Send a realtime toast to any backoffice user currently editing a content item.                                                                                             |
| **Request Approval** | Suspend the run and wait for a user to approve or reject.                                                                                                                  |
| **Run Script**       | Run a short JavaScript snippet in a sandbox to transform or compute data, with optional outbound `fetch` support and a configurable output schema for downstream bindings. |
| **Start Automation** | Start another published automation in the same workspace, optionally passing trigger data. See [Start Another Automation](actions.md#start-another-automation).            |

### Content

| Action                      | Purpose                                                                        |
| --------------------------- | ------------------------------------------------------------------------------ |
| **Create Content**          | Create a content item under a parent or at the content root (draft save).      |
| **Move Content**            | Move a content item to a new parent or to the content root.                    |
| **Publish Content**         | Publish an Umbraco content item.                                               |
| **Unpublish Content**       | Unpublish an Umbraco content item.                                             |
| **Get Content**             | Fetch a published content item and expose its properties for downstream steps. |
| **Find Content**            | Find content items by name, optionally filtered by content type.               |
| **Get Content Property**    | Read a single property value from a published content item.                    |
| **Update Content Property** | Write a single property value on a content item (draft save).                  |

### Media

| Action                    | Purpose                                                            |
| ------------------------- | ------------------------------------------------------------------ |
| **Create Media**          | Create a media item in a folder or at the media root, optionally downloading its file from a URL. |
| **Move Media**            | Move a media item to a new folder or to the media root.            |
| **Get Media**             | Fetch a media item and expose its properties for downstream steps. |
| **Find Media**            | Find media items by name, optionally filtered by media type.       |
| **Get Media Property**    | Read a single property value from a media item.                    |
| **Update Media Property** | Write a single property value on a media item.                     |

### Library

| Action                      | Purpose                                                                           |
| --------------------------- | --------------------------------------------------------------------------------- |
| **Create Element**          | Create a Library element in a folder or at the Library root (draft save).         |
| **Get Element**             | Fetch a published Library element and expose its properties for downstream steps. |
| **Get Element Property**    | Read a single property value from a published Library element.                    |
| **Update Element Property** | Write a single property value on a Library element (draft save).                  |
| **Publish Element**         | Publish a Library element.                                                        |
| **Unpublish Element**       | Unpublish a Library element.                                                      |

See [Library Elements](actions.md#library-elements) for permissions and settings.

Add-on packages contribute additional actions. See [Add-ons](../add-ons/add-ons.md) for the catalogue.

You can only select an action that needs a connection once the workspace allows a connection of the right type. Until then, the action picker shows it as unavailable, with the reason. See [Connections](../backoffice/connections.md).

## Action Settings

Each action exposes its own settings. The settings panel is generated from the action's settings model. Many settings support [Bindings](bindings.md) so values can be pulled in from the trigger or previous steps at runtime. Content, media, and Library element pickers can take a binding instead of a picked item. See [Pick or Bind an Item](bindings.md#pick-or-bind-an-item).

<figure><img src="../.gitbook/assets/action-settings.png" alt="The settings panel for the HTTP Request action."><figcaption><p>Configuring an action's settings.</p></figcaption></figure>

## Action Output

Actions can produce output that downstream steps can bind to. For example, the HTTP Request action outputs the response status code and body:

```
${ steps.callApi.statusCode }
${ steps.callApi.responseBody }
```

Each step has a **Name** (its label on the canvas) and an **Alias** (`callApi` in the example). See [Step Behaviour](actions.md#step-behaviour) below for both.

## HTTP Request Headers and Body

**Headers** are optional. Click **Add** to add a row, one row per header. Removing a row that has a name or value asks you to confirm first. Each value can include [bindings](bindings.md), for example `Bearer ${ steps.getToken.result }`. Header values are treated as sensitive: they are encrypted when stored and masked in the run view.

Automate ignores rows where both the name and the value are empty. The following rows fail the step with a validation error, and the request is not sent:

* A row with a value but no name.
* A header name with invalid characters.
* A content header, such as `Content-Type`, on a request that sends no body.

On a request with a body, a content header applies to the body and overrides the content type the body sets.

**Body type** controls how the request body is built. Only `POST`, `PUT`, and `PATCH` requests send a body.

* **Raw** sends the **Body** text as written, with the **Content Type** you set. Use it for JSON or XML.
* **Form** sends the **Form fields** rows as an `application/x-www-form-urlencoded` body and sets the content type for you. Rows without a name are skipped.

Form field values are not treated as sensitive, so keep credentials in **Headers**.

The settings panel only shows the fields for the selected body type. Values you entered for the other type are kept, so switching back restores them.

Steps saved with the earlier JSON **Headers** field keep working. Automate reads the JSON as header rows when the step runs, and stores them as rows the next time you save the step.

{% hint style="warning" %}

The HTTP Request action rejects responses larger than `Execution:MaxHttpResponseBodyBytes` (10 MB by default). The step fails with a terminal error that names the response size and the limit. Raise the limit in [Configuration](../getting-started/configuration.md) for larger payloads.

The HTTP Request action only calls public destinations. See [Outbound Requests](../getting-started/configuration.md#outbound-requests) for the address categories Automate refuses and how it handles proxies.

{% endhint %}

{% hint style="warning" %}

The Run Script action runs in a JavaScript sandbox with a 5 MB memory cap and a 15-second total execution timeout by default. Configure both via `Scripting:*` settings. See [Run Script Settings](../getting-started/configuration.md#run-script-settings).

A script can only make outbound `fetch` calls when both of these are on:

* **Allow fetch** on the step. This is off for new Run Script steps, so turn it on for each step that needs `fetch`. Existing steps keep the value they were saved with. A step created through the Management API or imported from JSON without an `allowFetch` value has fetch turned off.
* `Scripting:FetchEnabled` for the whole site. This is `true` by default. Set it to `false` to turn off `fetch` for every Run Script step. A step with **Allow fetch** on then writes a warning to its **Logs** tab.

To restrict which hosts scripts can call, list them in `Scripting:FetchAllowedHosts`. When the list is empty, `fetch` can call any public host. `fetch` follows the same destination rules as the HTTP Request action. See [Outbound Requests](../getting-started/configuration.md#outbound-requests).

When a `fetch` request fails, the promise rejects with a short error message, for example, `http request was blocked` or `fetch failed: connection refused`. Automate writes the full details to the server log.

{% endhint %}

## Run Script Data

A Run Script step exports a default function. The function receives a `data` argument and returns the step's output.

`data` holds the values a binding can reach, at the same paths. If a binding would use `${ steps.getMedia.properties.umbracoBytes }`, the script reads `data.steps.getMedia.properties.umbracoBytes`.

| Binding                              | Script                                                           |
| ------------------------------------ | ---------------------------------------------------------------- |
| `${ trigger.<path> }`                | `data.trigger.<path>`                                            |
| `${ steps.<alias>.<path> }`          | `data.steps.<alias>.<path>`                                      |
| `${ previous.<path> }`               | `data.previous.<path>`. Not present for the first step.          |
| `${ loop.item }` / `${ loop.index }` | `data.loop.item` / `data.loop.index`. Inside a **For Each** only. |

{% code title="Run Script" %}
```javascript
export default function (data) {
    const bytes = data.steps.getMedia.properties.umbracoBytes;
    return {
        name: data.trigger.contentName.toUpperCase(),
        sizeKb: Math.round(bytes / 1024)
    };
}
```
{% endcode %}

Keep the following in mind when you read from `data`:

* Property names in a script are case-sensitive, unlike bindings. Match the casing of each alias and property exactly.
* A step without an alias appears under its ID, for example `data.steps['<id>']`.
* Only steps that already ran are present. A step on a branch that did not run is missing, so guard optional paths, for example `data.steps.maybe?.result`.
* Automate does not resolve `${ ... }` bindings inside the script body. Read the values from `data` instead.
* `data` is a copy. Changing it has no effect on later steps. Return any values that later steps need.
* Data nested more than 64 levels deep, or data that refers to itself, fails the step with a validation error.

The returned value becomes the step's `result` output. Downstream steps bind to it with `${ steps.<alias>.result }`.

Output from `console.log` and the other `console` methods appears in the step's **Logs** tab in the run view. See [Reviewing Runs](../backoffice/runs.md#log-entries).

## Send Email Addresses

The **Send Email** action has four address settings:

| Setting      | Description                                                                                                                                                      |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **To**       | The recipients. At least one address is required.                                                                                                                |
| **Reply-To** | Optional. Where replies go. When empty, replies go to the sender. An address that can't be parsed is skipped, and the step writes a warning to its **Logs** tab. |
| **CC**       | Optional. Addresses that receive a copy. The step fails with a validation error if an address can't be parsed.                                                   |
| **BCC**      | Optional. Addresses that receive a hidden copy. The step fails with a validation error if an address can't be parsed.                                            |

Each address shows as a tag, as in an email client. Type an address and press Enter, or type a comma or a semicolon, to add it. Click a tag, or press Backspace in the empty input, to edit an address. A tag that doesn't look like an email address is marked as invalid.

Use **Insert Binding Expression** to add a binding, for example `${ trigger.email }`. The binding gets a tag of its own and is resolved when the step runs. Reply-To often holds visitor input, which is why an address that can't be parsed is skipped there instead of failing the step.

A comma inside a quoted display name does not split the address, so `"Doe, John" <john@example.com>` stays one address.

## Start Another Automation

Use **Start Automation** to split a long flow into smaller automations. Pick the automation to start in **Automation**. The list only shows automations from the current workspace.

Use **Trigger Data** to pass a JSON object to the started automation. Its steps read the values with bindings such as `${ trigger.orderId }`. The started automation's own trigger does not fire, so its trigger output contains only this data.

The started automation must be published when the step runs. Automate runs its published version, not its draft. Rate limits and the circuit breaker still apply. The step does not wait for the started run to finish.

The step outputs `started`, `runId`, `automationKey`, and `skippedReason`. It fails without retrying in these cases:

* The target is missing, unpublished, or in another workspace.
* Starting the target would create a cycle.
* The chain would exceed `Execution:MaxChainDepth` Start Automation hops, 5 by default.

When the target's circuit breaker is open, the step succeeds with `started` set to `false`. The reason is in `skippedReason` and the step's log.

You can save a draft before you pick an automation. Publishing checks that an automation is selected, that it is not the automation itself, and that it exists in this workspace.

## Create and Move Items

**Create Content** saves a new draft. Add a **Publish Content** step after it to publish the item. Leave **Parent** empty to create the item at the content root. The content type must allow being created at the root. Under a parent, the parent's content type must allow the content type as a child. Otherwise the step fails with a validation error, as the backoffice would refuse the item.

Set **Culture** when the content type varies by culture, for example `en-US`. Culture-variant properties in **Property Values** are set for that culture.

Enter **Property Values** as a JSON object of property aliases and values, for example `{"bodyText": "Hello", "rating": 4, "featured": true}`. Keep the following in mind:

* Strings, numbers, and `true`/`false` values are set as they are. Umbraco converts them to the property's storage type.
* Objects and arrays are stored as JSON text. Write them in the format the property stores, for example for a block or picker property.
* `null` values are skipped.
* Automate skips unknown aliases, and writes a warning to the step's **Logs** tab.
* If the text is not valid JSON, or is not a JSON object, Automate ignores all of it and writes a warning.
* A value that can't be converted to the property's storage type fails the step.

**Create Media** saves a new media item. Media has no draft, so the item is live straight away. Leave **Parent** empty to create it at the media root. The media type must be allowed at the media root, or under the parent's media type.

Set **Source URL** to download a file onto the item, for example `${ loop.item.imageUrl }`. Leave it empty for media types without a file, such as folders. Downloads follow the [Outbound Requests](../getting-started/configuration.md#outbound-requests) rules. They are capped by `Execution:MaxMediaFileBytes`, 10 MB by default. **Property Values** on **Create Media** sets invariant properties only, and cannot set the file.

When a download fails, Automate still creates the item, without a file. The step writes a warning, and the `fileName` output is empty. One unreachable file does not stop a **For Each** loop.

When the parent is missing or in the recycle bin, or the content type or media type no longer exists, both create actions create nothing. The step takes its **Parent not found**, **Content type not found**, or **Media type not found** exit, and writes a warning to its **Logs** tab. The `contentKey` or `mediaKey` output is an empty GUID. See [Control Flow](control-flow.md) for how exits route a run.

**Move Content** and **Move Media** move an item to **Target Parent**. Leave it empty to move the item to the root. The service account needs access to both the item and the destination. The step fails when the item is missing or in the recycle bin.

Creating or moving an item at the content or media root needs root access for the service account of the workspace. See [Service-Account Permissions](workspaces.md#service-account-permissions).

## Items in the Recycle Bin

Content and media actions treat an item in the recycle bin as missing, whatever the start node of the service account:

* **Update Content Property**, **Update Media Property**, and **Notify Editor** take their **Not found** exit. The update actions write nothing to the item.
* **Create Content** and **Create Media** take their **Parent not found** exit when the parent is in the recycle bin.
* **Move Content** and **Move Media** fail the step.
* **Find Content** leaves items in the recycle bin out of its results, also when **Include unpublished** is on.

## Library Elements

The Library actions work on Library elements. They need Umbraco CMS 18.1.0 or later.

The service account of the workspace needs access to the **Library** section. It also needs the permission for the action on the element, or on the folder for **Create Element**. Permissions set on a Library folder apply to the elements in it.

| Action                                    | Permission |
| ----------------------------------------- | ---------- |
| **Get Element**, **Get Element Property** | Read       |
| **Create Element**                        | Create     |
| **Update Element Property**               | Update     |
| **Publish Element**                       | Publish    |
| **Unpublish Element**                     | Unpublish  |

Pick the element in **Element**, or bind its key from the trigger or an earlier step, for example `${ trigger.elementKey }`.

**Create Element** saves a new draft. Add a **Publish Element** step after it to publish the element. Leave **Folder** empty to create the element at the Library root, which needs root access for the service account. You can only create element types that have **Allow in Library** turned on and that the folder allows. Otherwise the step fails with a validation error. Enter **Property Values** in the same JSON format as **Create Content**.

Set **Culture** on the get, create, and update actions for a variant element, and leave it empty for an invariant one. Set **Segment** on **Update Element Property** for a segmented element. For **Publish Element** and **Unpublish Element**, enter **Cultures** as comma-separated codes, for example `en-US,da-DK`. Leave **Cultures** empty to publish an invariant element, or to unpublish all cultures.

An element or folder that is missing or in the recycle bin counts as not found, for every service account:

* **Get Element**, **Get Element Property**, and **Update Element Property** take their **Not found** exit. The get actions also take it when the element isn't published.
* **Create Element** takes its **Folder not found** exit. An element type that no longer exists takes **Element type not found**.
* **Publish Element** and **Unpublish Element** fail the step.

**Get Element Property** and **Update Element Property** take their **Property not found** exit when the element type has no property with that alias.

## Step Behaviour

Each step has additional settings on the canvas:

| Setting            | Description                                                                                                                                                                                                   |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Name**           | The step's display label on the canvas.                                                                                                                                                                       |
| **Alias**          | The identifier used to reference the step's output in bindings, for example `${ steps.callApi.responseBody }`. Automate suggests one automatically when you add the step, adding a number if another step already uses it, for example `tellTeam2`. Edit it any time before publishing. |
| **Error behavior** | What to do when the step fails: **Retry** the step, **Suspend** the run for manual intervention, or **Terminate** the run. A step set to **Retry** stops the run when retrying can't fix the error, or after its last retry. |
| **Max retries**    | When the error behavior is **Retry**, how many times the step retries before the run stops.                                                                                                                   |
| **Retry interval** | When the error behavior is **Retry**, how long to wait between retries.                                                                                                                                       |

{% hint style="info" %}
An alias must start with a letter and contain only letters and numbers, and must be unique within the automation. Renaming a step's **Name** after it's been added does not change its **Alias**: the two are independent once set. Publishing fails if any binding elsewhere in the automation still references an alias that no longer exists.
{% endhint %}

A step that already uses the **Compensate** error behavior shows **Compensate (legacy)**. Automate has no compensation steps to run, so **Compensate** stops the run without rolling anything back.

If a step's action is no longer installed, the step fails when it runs. This happens when the package that provides the action is removed or the action is disabled. The error names the missing action, and the step's error behavior applies. A step set to **Retry** isn't retried, because the action won't come back between attempts.

The engine-wide default step timeout is controlled by the `Execution:DefaultTimeout` setting. See [Configuration](../getting-started/configuration.md).

## See Also

* [Build an Automation](../backoffice/building-an-automation.md)
* [Connections](connections.md)
* [Create a Custom Action](../extending/custom-action.md)
