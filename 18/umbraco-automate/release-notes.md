---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Automate.
---

# Release Notes

This section summarizes the changes to Umbraco Automate released in each version. Each version links to the full list of changes on GitHub, and individual items link to the pull request that made the change. The complete history is in the [Umbraco Automate changelog](https://github.com/umbraco/Umbraco.Automate/blob/v18/main/Umbraco.Automate/CHANGELOG.md).

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

## Release History

This section contains the release notes for Umbraco Automate 18, including all changes for this version.

### [18.5.1](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.5.0...Umbraco.Automate@18.5.1) (October 8th 2026)

{% hint style="warning" %}

This release changes how some failures are handled. Review these points before upgrading:

* **A step that can't succeed now stops the run.** A step set to **Retry** stops the run when its error can't be fixed by retrying, or when it has used all its retries. The run ends as **Failed**. Before, the run carried on, and steps connected to the failed step's unlabeled output still ran [#453](https://github.com/umbraco/Umbraco.Automate/pull/453).
* **A step whose action is no longer installed fails the run.** This happens when the package that provides the action is removed or the action is disabled. The step fails with an error that names the missing action. Before, the step was skipped, and later steps ran without its output [#475](https://github.com/umbraco/Umbraco.Automate/pull/475).
* **Publishing checks every step's settings.** A step with an empty required setting can no longer be published. That includes steps saved through the Management API or an import. Creating, importing, or rolling back an invalid automation returns a 422 response that lists the errors [#471](https://github.com/umbraco/Umbraco.Automate/pull/471).
* **Notify Editor needs content access.** The service account of the workspace needs the Content section and Browse permission on the target item. Without access to the item, the step fails [#446](https://github.com/umbraco/Umbraco.Automate/pull/446).
* **Batch content and media triggers check node access.** Items the service account can't browse are left out of the batch. When none remain, the run is skipped [#451](https://github.com/umbraco/Umbraco.Automate/pull/451).

{% endhint %}

#### Restarts and recovery

Automate no longer marks a run as failed on restart while another node is still running. Each node now records a heartbeat in a new `umbracoAutomateWorkflowNodeHeartbeat` table, which Automate creates on startup. A starting node only fails interrupted runs when no other node is live. Startup now fails when `WorkflowLock:RenewalInterval` is not shorter than `WorkflowLock:LeaseDuration` [#424](https://github.com/umbraco/Umbraco.Automate/pull/424). For more information, see [Restarting a Node](run-in-production/load-balancing.md#restarting-a-node).

An approval whose decision was saved shortly before the site stopped now continues down the path that was chosen [#464](https://github.com/umbraco/Umbraco.Automate/pull/464) [#470](https://github.com/umbraco/Umbraco.Automate/pull/470).

#### Other

* Steps: Hide the **Compensate** error behavior, which never rolled anything back. Steps that already use it show **Compensate (legacy)** and behave as before [#455](https://github.com/umbraco/Umbraco.Automate/pull/455).
* Steps: Evaluate binding defaults, such as `${ trigger.formId }`, for steps saved without any settings [#441](https://github.com/umbraco/Umbraco.Automate/pull/441).
* Settings: Show binding syntax such as `${ trigger.yourKey }` in field descriptions, instead of removing it [#442](https://github.com/umbraco/Umbraco.Automate/pull/442).
* Backoffice: Validate the automation editor before **Save and publish**, so an empty name is highlighted instead of returning a server error [#463](https://github.com/umbraco/Umbraco.Automate/pull/463).

### [18.5.0](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.4.0...Umbraco.Automate@18.5.0) (October 1st 2026)

{% hint style="warning" %}

This release changes some existing behavior. Review these points before upgrading:

* **Service accounts must be API users.** Saving a workspace whose service account is a regular backoffice user is refused until you choose an API user. Existing workspaces keep running until their next save [#428](https://github.com/umbraco/Umbraco.Automate/pull/428).
* **`Execution:MaxConcurrentRuns` now takes effect.** Earlier versions of the configuration article showed `10` in the example, but the setting was never applied. If your configuration still sets it to `10`, each node is now limited to 10 concurrent runs. Set it to `0` to use the engine default [#409](https://github.com/umbraco/Umbraco.Automate/pull/409).
* **Webhook responses changed.** Calls for an unknown automation return 401 instead of 404. An unauthenticated call to an unpublished automation returns 401 instead of 409 [#427](https://github.com/umbraco/Umbraco.Automate/pull/427).
* **`Umbraco:Automate:Enabled` and `Umbraco:Automate:Governance` are obsolete.** They never had any effect, and are scheduled for removal in Umbraco Automate 19 [#409](https://github.com/umbraco/Umbraco.Automate/pull/409).

{% endhint %}

#### New actions

* **Start Automation** starts another automation from a step, so automations can be chained. It blocks cycles and respects the maximum chain depth [#277](https://github.com/umbraco/Umbraco.Automate/pull/277). See [Start Another Automation](concepts/actions.md#start-another-automation).
* **Create Content** and **Create Media** create an item under a parent, with property values set from bindings [#285](https://github.com/umbraco/Umbraco.Automate/pull/285) [#293](https://github.com/umbraco/Umbraco.Automate/pull/293).
* **Move Content** and **Move Media** move an item to a new parent, or to the root [#319](https://github.com/umbraco/Umbraco.Automate/pull/319). See [Create and Move Items](concepts/actions.md#create-and-move-items).

#### Run view and log entries

Each run now shows the data that went into and came out of every step. Expand the trigger row to see the trigger data, or a step row to see its resolved input and its output [#376](https://github.com/umbraco/Umbraco.Automate/pull/376).

Actions can write log entries to the run, and the built-in actions now do. A step's **Logs** tab appears when it wrote at least one entry. Sensitive values are redacted from log entries [#164](https://github.com/umbraco/Umbraco.Automate/pull/164) [#379](https://github.com/umbraco/Umbraco.Automate/pull/379).

For more information, see [Reviewing Runs](backoffice/runs.md) and [Writing Run Log Entries](extending/custom-action.md#writing-run-log-entries).

#### HTTP Request headers and bodies

Headers and form bodies are edited as key/value rows. The action only shows the body fields for the body type you choose [#308](https://github.com/umbraco/Umbraco.Automate/pull/308) [#378](https://github.com/umbraco/Umbraco.Automate/pull/378). For more information, see [HTTP Request Headers and Body](concepts/actions.md#http-request-headers-and-body).

#### Approvals suspend the run

A run waiting on an approval now shows as **Suspended** and sends Suspended notifications. It continues once the approval is decided [#418](https://github.com/umbraco/Umbraco.Automate/pull/418). For more information, see [Use Approvals](backoffice/approvals.md).

#### Webhooks

The webhook endpoint authenticates the caller before it reveals anything about the automation. Form-encoded bodies and bodies without a `Content-Length` now reach the run intact. The caller's secret or signature is no longer stored with the run or passed to steps [#427](https://github.com/umbraco/Umbraco.Automate/pull/427). For more information, see [Webhook Requests](concepts/triggers.md#webhook-requests).

#### Restarts and recovery

A run that was in progress when a node stopped is now marked as failed when that node starts again. It no longer resumes part of the way through. Runs still in progress on another node are left alone [#359](https://github.com/umbraco/Umbraco.Automate/pull/359) [#404](https://github.com/umbraco/Umbraco.Automate/pull/404) [#417](https://github.com/umbraco/Umbraco.Automate/pull/417). For more information, see [Runs Interrupted by a Restart](concepts/runs.md#runs-interrupted-by-a-restart).

#### Other

* Steps: Validate step settings when an automation is published, as well as when it's saved [#337](https://github.com/umbraco/Umbraco.Automate/pull/337). See [Validating Settings on Save and Publish](extending/action-behavior.md#validating-settings-on-save-and-publish).
* Configuration: Apply `Execution:MaxConcurrentRuns` and `Execution:PollInterval` to the workflow engine [#409](https://github.com/umbraco/Umbraco.Automate/pull/409). See [Engine Concurrency and Polling](getting-started/configuration.md#engine-concurrency-and-polling).
* Run Cleanup: Also remove the workflow engine's data for finished runs [#416](https://github.com/umbraco/Umbraco.Automate/pull/416).
* Rate Limiting: Skip an automation that is over its limit and log a warning, instead of failing the event for every automation [#415](https://github.com/umbraco/Umbraco.Automate/pull/415).
* Run Script: Turn off **Allow fetch** by default for new steps [#355](https://github.com/umbraco/Umbraco.Automate/pull/355), and pass the binding context to scripts as `data` [#345](https://github.com/umbraco/Umbraco.Automate/pull/345).
* Outbound Requests: Refuse requests to private and reserved addresses, and return short error messages from Run Script `fetch` [#360](https://github.com/umbraco/Umbraco.Automate/pull/360). See [Outbound Requests](getting-started/configuration.md#outbound-requests).
* Create Content: Set culture-variant property values for the chosen culture [#357](https://github.com/umbraco/Umbraco.Automate/pull/357), and accept non-string property values [#393](https://github.com/umbraco/Umbraco.Automate/pull/393).
* Canvas: Insert a step added to a connected output between the two existing steps, instead of replacing the connection [#346](https://github.com/umbraco/Umbraco.Automate/pull/346) [#324](https://github.com/umbraco/Umbraco.Automate/pull/324).
* Canvas: Allow more than one connection into a step [#323](https://github.com/umbraco/Umbraco.Automate/pull/323), and place new steps beside the output that was clicked [#322](https://github.com/umbraco/Umbraco.Automate/pull/322).
* Canvas: Show actions that need a connection the workspace doesn't allow as unavailable [#325](https://github.com/umbraco/Umbraco.Automate/pull/325).
* Binding Picker: Show a description for each value, and list earlier steps in the order they run [#307](https://github.com/umbraco/Umbraco.Automate/pull/307) [#299](https://github.com/umbraco/Umbraco.Automate/pull/299).
* Connections: Save unsaved changes before testing a connection [#347](https://github.com/umbraco/Umbraco.Automate/pull/347), and allow choosing a connection on actions that have no other settings.
* Runs: Show the failing step's error on a run that a step terminated, and disable **Replay** while the automation is unpublished [#430](https://github.com/umbraco/Umbraco.Automate/pull/430).
* Run Now: Only offer **Run now** on published automations.
* Backoffice: Show the server's error message when saving an automation, connection, or workspace fails, and when an approval decision fails [#429](https://github.com/umbraco/Umbraco.Automate/pull/429).
* Backoffice: Match the section's URL path to its **Automation** label [#269](https://github.com/umbraco/Umbraco.Automate/pull/269) [#392](https://github.com/umbraco/Umbraco.Automate/pull/392), and restore the create buttons in the collection views [#297](https://github.com/umbraco/Umbraco.Automate/pull/297).
* Backoffice: Accessibility, theming, and confirmation prompts across the run view, approvals, and modals [#418](https://github.com/umbraco/Umbraco.Automate/pull/418).
* Extending: Add default implementations for the new `IAutomationActionAuthorizer` members, so existing implementations still compile [#394](https://github.com/umbraco/Umbraco.Automate/pull/394).
* Approvals: Stop an approval decision being lost when it arrives as the step starts waiting [#372](https://github.com/umbraco/Umbraco.Automate/pull/372).

### [18.4.0](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.3.0...Umbraco.Automate@18.4.0) (September 2nd 2026)

#### Run Script action

The new **Run Script** action runs a short JavaScript snippet in a sandbox to transform or compute data. An output schema setting describes the script's result, so later steps can bind to it. For more information, see [Actions](concepts/actions.md).

#### Media actions

The new **Get Media**, **Get Media Property**, and **Find Media** actions read media items and their property values.

#### Step settings

Every step now has a name, an alias, an error behavior, and retry controls [#213](https://github.com/umbraco/Umbraco.Automate/issues/213). For more information, see [Actions](concepts/actions.md).

#### Run Now for more triggers

Any trigger can now support **Run now**, including custom triggers. The Webhook trigger shows its URL in its settings, and runs on demand with a saved test request. For more information, see [Running a Trigger On Demand](concepts/triggers.md#running-a-trigger-on-demand).

#### Other

* Content Triggers: Report only the cultures that changed for each document.
* Automations: Warn when saving or publishing an automation with steps that aren't connected to the trigger.
* HTTP Request: Edit the body, headers, and message fields in a code editor, and stop flagging valid JSON bodies as invalid.
* Runs: Cancel pending approvals and stuck steps when a run is terminated.
* Parallel: Stop a **Parallel** container's branches running once per branch.
* Scheduled Trigger: Start only the automation a scheduled event is due for.
* Canvas: Fix upside-down connection labels, and wrap long approval prompts.

### [18.3.0](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.2.0...Umbraco.Automate@18.3.0) (August 19th 2026)

* Canvas: Add **Body** and **Done** handles to the **For Each**, **While**, and **Parallel** control flow nodes. See [Control Flow](concepts/control-flow.md).
* Canvas: Allow more than one branch from a **Parallel** node's **Body** handle.
* Canvas: Warn when a container step has more than one **Done** connection.
* Workspaces: Drop user groups that no longer exist from a workspace.
* Startup: Start without an error when no connection string is configured yet.

### [18.2.0](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.1.0...Umbraco.Automate@18.2.0) (August 10th 2026)

{% hint style="warning" %}

**Request Approval** changes how rejections work:

* A rejection no longer stops the run when the step's error behavior is **Terminate**. The run follows the **Rejected** path, or completes if nothing is connected there, and reports **Rejected** instead of **Failed**.
* The step's `outcome` output is now `Approved` or `Rejected` instead of `0` or `1`. Update any conditions written against the number.

{% endhint %}

#### Approved and Rejected paths

The **Request Approval** node has separate **Approved** and **Rejected** handles, and declares its output so the decision appears in the binding picker. For more information, see [Use Approvals](backoffice/approvals.md).

#### Other

* Settings: Show sensitive settings in a masked field.
* Content Actions: Read published property values with the correct culture and segment.
* Database: Use the ambient Umbraco transaction when Automate shares the Umbraco database.
* Deploy: Create Automate's tables before Umbraco Deploy restores content at startup.
* Performance: Store large trigger outputs outside the workflow data [#193](https://github.com/umbraco/Umbraco.Automate/pull/193).

### [18.1.0](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.0.0...Umbraco.Automate@18.1.0) (July 22nd 2026)

* Scheduled Trigger: Allow **Run now** on automations with a Scheduled trigger.
* Startup: Wait for Automate's database migrations to finish before writing, and report a clear error when they fail.
* Scheduled Trigger: Fill in the trigger output when its schedule fires.
* Bindings: Resolve step output bindings regardless of property name casing.
* Configuration References: Resolve references inside longer text values.
* Canvas: Discard a new trigger or action when its settings dialog is closed without saving.

### [18.0.0](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@18.0.0-beta...Umbraco.Automate@18.0.0) (July 8th 2026)

{% hint style="warning" %}

HTTP Request steps whose responses are larger than 10 MB now fail with a clear error. Raise `Execution:MaxHttpResponseBodyBytes` to allow larger responses. See [Configuration](getting-started/configuration.md).

{% endhint %}

* HTTP Request: Limit response bodies to a configurable size.
* Runs: Refresh the runs views automatically, and list runs across automations.
* Dashboard: Load the overview dashboard faster, scoped to the workspaces you can access.
* Approvals: Check workspace access and the identity of the user deciding.
* Runs: Stop the workflow when a run is cancelled.
* Performance: Fewer database round trips per step, and large step outputs stored outside the workflow data.
* Content Triggers: Keep the affected cultures when content is copied [#113](https://github.com/umbraco/Umbraco.Automate/issues/113).

### [18.0.0-beta](https://github.com/umbraco/Umbraco.Automate/compare/Umbraco.Automate@17.0.0-beta...Umbraco.Automate@18.0.0-beta) (June 24th 2026)

The first release of Umbraco Automate for Umbraco CMS 18. It includes everything in Umbraco Automate 17.0.0-beta, and these changes:

* Search: Find automations from the backoffice search.
* Find Content: Make the **Contains** match mode produce a valid search query.
* Search: Make automation, connection, and workspace search case-insensitive.
* Bindings: Apply binding filters, and resolve bindings inside list settings.
* Settings: Validate required fields in the trigger and step settings dialogs.
* Member Saved Trigger: Skip saves that only record a member logging in.
* Canvas: Show every case of a **Switch** node.
