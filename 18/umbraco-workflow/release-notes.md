---
description: Get an overview of the changes and fixes in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow that were released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
Check the [Version Specific Upgrade Notes](upgrading/version-specific.md) article for breaking changes when upgrading to a new major version.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 18, including all changes for this version.

### 18.1.2 (August 31 2026)

* Fixes culture resolution for external approval using an invariant workflow on a culture-variant document.
* Further improvements to segment display in the change description element.

### [18.1.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.1.1)  (August 25 2026)

* Fixes a bug where segments associated with a workflow process could be truncated [#170](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/170)
* Improves display of segments associated with a workflow process, handling documents with multiple segments. Segments are now mapped to their name, rather than displaying the alias only.

### [18.1.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.1.0)  (August 20 2026)

#### Adds approval by magic link and email reply

Reviewers can now approve or reject a workflow task directly from the notification email. 

Tasks can be approved in two ways:
* By opening a secure, time-limited link without logging in to the backoffice
* By replying to the email with an approve or reject instruction

New health checks validate the action-by-email and external approval configuration.

This feature requires a license. Check the [External Approval](getting-started/external-approval.md) article for more information.

#### Adds Date mode for content reviews

Content review due dates can be set to a specific date instead of only a recurring period. When editing an existing configuration, the due date can be regenerated from the current date or from the content's last published date.

#### Workflow actions moved to extensions

Approve, reject, cancel, and resubmit actions, along with the preview, diff, and attachment buttons, are now implemented as extensions. This lays the groundwork for third-party actions to be registered alongside the built-in ones.

#### Bug fixes and other changes

* Fixes a SQL syntax error when loading approval groups under cultures whose negative sign is not the ASCII hyphen, such as `sv-SE` [#165](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/165)
* Fixes errors when opening Settings > Workflow > Content approvals > Configuration on an unlicensed install, including a settings tree node incorrectly labeled `workflow_workflow` [#164](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/164)
* Fixes advanced search so toggle properties can be searched and read-only label properties correctly show a search input [#163](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/163)
* Fixes a bug where licensed settings values were reset to their defaults when saved from an unlicensed install
* Fixes tooltip positioning in the Advanced Search dashboard
* Fixes the reject dialog showing a "reject to group" option when rejecting at the first stage of a workflow
* Fixes the workflow modal breaking when SignalR triggers a rebuild of its host element
* Adds health checks for email notification configuration, action-by-email configuration, email template integrity, and external approval configuration
* Localizes email templates at render time instead of maintaining a separate template per culture
* Normalizes stored content review culture values for invariant content
* Fixes orphaned data rows left behind when deleting an alternate version

### 18.0.3 (July 24 2026)

* Fixes a bug where teardown of a required context was not correctly guarded in a specific code path, leaving Workflow unresponsive.

## [18.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.2) (July 17 2026)

* Ensures approval group language is unwrapped from JSON array when sending notifications to a group email [#162](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/162)

### [18.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.1) (July 9 2026)

#### Improvements to reminder email notifications
* Emails correctly follow rejection target in rejected workflows [#154](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/154)
* Reminders skip recycled content
* Hardens cancel-on-delete paths that were potentially leaving active workflows after content deletion

### Extends permissions for initiating approval workflows
* Fallback permissions are considered when setting action state
* Adds optional setting to require publish permission, or default to requiring update permission (legacy behaviour)

### Bug fixes and other changes

* Fixes a bug where the workspace view never loaded for segmented culture-invariant documents [#159](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/159)
* Fixes a bug where Document Type content review configuration was not properly persisted [#158](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/158)
* Fixes a bug where the `Lock active content` setting was not correctly applied [#161](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/161)

### 18.0.0 (June 25 2026)

* All changes from 18.0.0-rc1

### 18.0.0-rc1 (June 4 2026)

* Compatibility with Umbraco 18-rc.

#### Element type workflow support

Extends Workflows' multi-stage approval workflow model to the new element content type introduced in Umbraco 18. Element folders are also supported, allowing workflow configuration inheritance down nested element folder hierarchies.

#### Workflow actions

A new extensible action system allows configuring pre-approval and post-approval actions per Document Type. Actions execute automatically before or after a workflow completes, and can optionally block the workflow on failure.

Developers can create custom actions by implementing `IWorkflowAction` or extending `WorkflowActionBase<TConfig>`, and register them via `WorkflowActionCollectionBuilder`. A built-in Webhook action ships as the first implementation, sending a POST request with workflow instance details to a configured URL.

Actions are managed from a dedicated "Document Type Actions" section in the content approvals settings sidebar.

#### Unified configuration model

The permissions system has been consolidated: the split `NodeId`/`ContentTypeId` columns on the permissions table are replaced by a single `EntityId` column paired with an `EntityType` discriminator. The separate config update models (`DocumentConfigUpdateRequestModel`, `DocumentTypeConfigUpdateRequestModel`) are replaced by a unified `ConfigUpdateRequestModel`.

This simplification enables element type support and provides a single API surface for all entity-type configurations.

#### Standalone settings workspaces

Content Approvals, Content Reviews, and Release Sets settings have been converted to standalone workspaces with dedicated URL routes. The previous settings tree is replaced with a menu and sidebar pattern, providing a cleaner, more focused navigation experience.

#### Frontend performance

* Static JavaScript imports replace lazy loading across manifest files, reducing the chunk count by 225 and total JavaScript file size by 21%.
* Core implementations (conditions, contexts, modals, components) are now embedded rather than loaded as lazy chunks, reducing the number of HTTP requests at startup.
* TypeScript enums have been replaced with string-union types, eliminating additional emitted JavaScript.

#### Backend modernization

* Feature-slice namespace reorganization: models and view models previously in flat `Umbraco.Workflow.Core.Models`/`ViewModels` namespaces are now organized into feature-specific namespaces (for example, `ContentApprovals`, `ApprovalGroups`, `Settings`).
* All previously `[Obsolete]` members from v17 have been removed.
* Legacy migrations (pre-v17) removed. Fresh installs use a single `InitialCreate` migration.
* SwaggerGen replaced with `Microsoft.AspNetCore.OpenApi`.

#### Other improvements

* Auto-save before submit: dirty variants are automatically saved before initiating a workflow submission.
* Validate before submit: form validation runs before workflow submission is allowed.
* Localization keys for task statuses updated from integer-based (`status1`-`status10`) to camelCase equivalents matching the `TaskStatusModel` enum names.
* Conditional frontend package registration: licensed features (Alternate Versions, Release Sets) are gated by license state, preventing UI loading for unlicensed features.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)
