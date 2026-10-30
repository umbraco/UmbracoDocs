---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Deploy.
---

# Release notes

This section summarizes the changes to Umbraco Deploy and [Deploy Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) released in each version. Each version is presented with a link to the [Deploy issue tracker](https://github.com/umbraco/Umbraco.Deploy.Issues/issues) showing a list of issues resolved in the release. The individual issues are also linked from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find the details about the breaking changes in the [version-specific updates](upgrading/version-specific.md) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Deploy 18, including all changes for this version.

### [18.2.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.2.0) (October 30th 2026)

* Show the **Queue for Transfer** and restore actions on Umbraco Forms and Umbraco Commerce entities [#355](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/355). Entity types that packages register for these actions are now added when the action loads after the package.
* Delete the `.uda` files and signatures of the descendants when deleting a dictionary item [#356](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/356). Previously, the next schema deployment failed with `ParentNotFound`. If you already committed the `.uda` files of these descendants, remove them manually.
* Include the log in the schema deployment status report again. Deploy no longer writes the `deploy.log` file, which stayed empty.
* Report a schema deployment that fails without an error message as failed instead of completed. A failure recorded right after a completed deployment now stays visible.
* Show the Deploy dashboard status as ready instead of an error when the Deploy folder doesn't exist yet.
* Remove the double slash from remote tree and content comparison requests when a workspace URL ends with a slash.

### [18.2.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.2.0) (October 13th 2026)

* Pick any item from the remote environment in the **Partial Restore** dialog, including members. Items that don't exist on the local environment are included too ([discussion #321](https://github.com/umbraco/Umbraco.Deploy.Issues/discussions/321)). The picker pages through the remote tree and you can search it by name. Members also match on username and email. Elements and element folders can be picked, and element folders can be restored with their descendants. A remote environment running an older Deploy version returns the items as before.
  * Service connectors in packages can provide this tree by implementing the new [`ITreeServiceConnector`](extending/extending.md#partial-restore-of-remote-items) interface. The `RemoteTreeDetail` parameter used to register a remote tree is obsolete and will be removed in Deploy 19.
* Offer to include descendants when you queue or export an item from a collection [#353](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/353). Previously, the **Include subitems** option was missing and the descendants were left out.
* Create redirects for moved and renamed documents on the receiving environment when transferring or restoring them [#354](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/354). Redirects had not been created on the receiving environment since Deploy 15.
* Restore a trashed document or media item without its trashed descendants when running Umbraco CMS 18.2.0 or later. The descendants stay in the recycle bin until they are transferred or restored themselves [#267](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/267). Earlier CMS versions still restore the whole trashed subtree ([umbraco/Umbraco-CMS#23417](https://github.com/umbraco/Umbraco-CMS/issues/23417)).
* Add the [`DiskMode`](getting-started/deploy-settings.md#disk-mode) setting with the values `ReadWrite` (default) and `ReadOnly`. Use `ReadOnly` when the deployed build is the only source of schema, for example in CI/CD pipelines or containers. Deploy then doesn't write to its folder on disk.
* Add the [`StartupOperations`](getting-started/deploy-settings.md#startup-operations) setting to run schema operations in the background after startup, without a trigger file. The flags are `None` (default), `DeploySchema`, and `CleanSchema`.
* Use the environment alias as the type of an Umbraco Cloud environment: `dev`, `stage`, `live`, or the alias of a flexible environment. Previously, the types were `development`, `staging`, and `live`. Update any code that checks `ICurrentEnvironmentInfo.Type`. The backoffice now labels environments by their name.
* Queue a schema deployment requested through `extract/start` after the one already running on the server, instead of skipping it. The changed schema files are now always deployed. On load-balanced environments, the status report returns `Unknown` instead of an error for a deployment running on another server.
* Report a cancelled deployment operation as failed instead of completed, for example when the environment shuts down. A new operation clears the `deploy-failed` status of the previous one when it starts.
* Export the schema on the first boot after an unattended install of Umbraco Deploy Cloud when there are no schema files to import. The schema created by the install, such as the default Data Types, now gets `.uda` files.
* Restore the separate **Schema files** checkbox in the import dialog. Clearing the **Schema** checkbox now excludes schema from the import.
* Fix the 500 error when exporting a single dictionary item with `TransferDictionaryAsContent` enabled.
* Add the [`BaselineUrl`](getting-started/deploy-settings.md#baseline-settings) setting to configure the Baseline project. The setting replaces the Umbraco Cloud-only `Upstream` project setting, which is now obsolete. On-Premises installations offer the Baseline workspace on the first configured workspace.
* Add the [`BaselineApiSecret` and `ChildApiSecrets`](getting-started/deploy-settings.md#baseline-settings) settings. A Child project signs its requests to the Baseline project with its Baseline secret. The Baseline project accepts the secret of each Child project on the endpoints used by a restore. Without a Baseline secret, the Child project uses its project secret and logs a warning.
* Match environment URLs on their scheme, host, port, and path segments. Only ping back and pull files from hosts of a configured workspace. A source environment whose application URL isn't a configured workspace URL pushes its files to the target instead.
* Reject transfers to the Baseline workspace. The Baseline project is only available for restores.

### [18.1.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.1.1) (September 24th 2026)

* Skip property values for a culture or segment the property type no longer varies by, fixing `Variation "<culture>,<segment>" is not supported by the property type` during transfers and restores [#8](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/8).
* Encode item and environment names shown in the restore and schema comparison dialogs, and in the progress log.

### [18.1.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.1.0) (September 17th 2026)

* All items from 18.1.0-rc1 and 18.1.0-rc2.

### [18.1.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.1.0) (September 11th 2026)

* Keep property types that are not in a property group when deploying changes to document, media, and member types. Previously, deploying a changed type deleted the content stored in those properties. The data loss affected all Deploy versions since 14.0 and became visible with Umbraco CMS 17.2.0 after [umbraco/Umbraco-CMS#21585](https://github.com/umbraco/Umbraco-CMS/pull/21585).
* Interpret the release date in the **Queue for transfer** dialog in the editor's time zone instead of the server's time zone [#350](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/350). The transfer queue dashboard and the compare dialog show schedule dates in the editor's local time. Items queued before the upgrade were stored in the source server's local time and are read as UTC after upgrading. Their release date shifts unless the source server runs in UTC.
* Reject bearer tokens with a timestamp outside the [`SessionTimeout`](getting-started/deploy-settings.md#timeout-settings) setting (20 minutes by default). Environment clocks must be roughly in sync. Every request uses a new token, so long-running operations are not affected.
* Authenticate environment API requests with an ASP.NET Core authentication scheme instead of middleware. Packages that register endpoints early in the request pipeline no longer cause every environment request to fail with a 403 error. Authentication failures now return a 401 status code instead of a 500.
* Keep the relations returned by a remote environment when updating or reviewing a manifest, so restores from a remote environment create relations again.
* Show the schema mismatch details instead of a "Could not retrieve artifact" error when an artifact does not exist in the remote environment.
* Fail a transfer or restore when a file is missing on the source environment. Previously, the target created the item without its file when it pulled the files from the source. The error message lists all missing files.
* Add OpenAPI documents for the Deploy Environment API and Deploy Schema API to the OpenAPI UI at `/umbraco/openapi`, next to the Deploy Management API. The `umbracodeploy/extract` and `umbracodeploy/statusreport` routes are documented in lowercase. The URLs stay case-insensitive.

### [18.1.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.1.0) (September 4th 2026)

* Register dependencies for rich text local links in the `{localLink:<guid>}` format, so linked documents and media are transferred with the content [#348](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/348).
* Start the operations on the Deploy dashboard from the Management API, fixing operations that could remain pending indefinitely and reporting the progress of every operation.
* Add granular user permissions for the **Queue for Transfer**, **Partial Restore**, and **Export** actions on elements and element folders.
* Report the cause of unexplained 403 errors returned by the environment API. Redirects are no longer followed when calling a remote environment, because a redirect strips the authorization header.
* Reduce the memory used while setting cached signatures, using the new `ExpandRangePageSize` and `SetSignaturesBatchSize` settings.
* Apply Deploy configuration changes without restarting the site. Invalid configuration no longer prevents the site from starting.
* Run start-up operations while the license validation result is still unknown, so triggers like `deploy-on-start` are no longer skipped on newly created environments.
* Load the Deploy backoffice code on demand, reducing the amount loaded on every backoffice page.

### [18.0.1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.1) (July 21st 2026)

* Update public access role rules when a member group is renamed during a deploy.
* Map Deploy endpoints when booting during an unattended upgrade (`RuntimeLevel.Upgrading`).
* Transfer invariant properties when deploying the default culture [#249](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/249).
* Fix restore of trashed content leaving a stale recycle bin path and level [#267](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/267).
* Normalize document culture code casing on import to prevent duplicate culture variation rows [#271](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/271) [#280](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/280).
* Improve condition lifecycle management, fixing the Deploy dashboard occasionally loading blank on init and refresh [#346](https://github.com/umbraco/Umbraco.Deploy.Issues/issues/346).

### [18.0.0](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 25th 2026)

* Compatibility with Umbraco CMS 18.0.0.
* Fix `umbracodeploy` trigger route URLs broken by the Umbraco 18 routing migration. POST endpoints under `/umbraco/umbracodeploy/...` now resolve correctly.
* Register Deploy routes and SignalR hubs during the Upgrading runtime level.
* Fix the partial restore progress display and restore the work completion view.
* Fix the partial restore modal not auto-selecting the only available restore environment.
* Disambiguate queue root items by entity type, so each tree's root can be queued independently.
* Gate the **Open Umbraco Cloud project** action to Cloud projects only, and link directly to the project URL.

### [18.0.0-rc3](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 19th 2026)

* Compatibility with Umbraco CMS 18.0.0-rc3.
* Throw a clear error when the API key or secret is not configured on the environment.

### [18.0.0-rc2](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 5th 2026)

* Compatibility with Umbraco CMS 18.0.0-rc2.
* Restrict Deploy SignalR hubs to WebSockets when the `Umbraco:CMS:SignalR:ClientShouldSkipNegotiation` CMS setting is enabled.

### [18.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F18.0.0) (June 5th 2026)

* Compatibility with Umbraco CMS 18.0.0-rc1.
  * See full details of breaking changes under [Version Specific Upgrade Details](upgrading/version-specific.md).
* Add support for transferring, restoring, importing, and exporting elements (publishable, versioned content items in the new Library section).
* Migrate Nested Content (when `MaxItems = 1`) and single-block-mode Block List configurations to the new `Umbraco.SingleBlock` editor at import time.
* Major UI/UX overhaul of the Deploy experience in the backoffice. See [Backoffice UX refresh](release-notes.md#backoffice-ux-refresh) below for details.
* Improved support for running Deploy on load-balanced backoffice instances:
  * Prevent `ARRAffinity` cookie loss on load-balanced targets by disabling `HttpClient` handler rotation, so long-running restores stay routed to the same target instance.
  * Add a cluster-wide Deploy worker lock to prevent concurrent deploys across load-balanced backoffice instances.
  * Process Deploy disk triggers on a single load-balanced server instead of racing on every node.

#### Backoffice UX refresh

Version 18 introduces a redesigned Deploy experience in the backoffice:

* A new sidebar workspace, launched from the environment name header app, replaces the transfer queue dashboard in the Content section. The workspace provides a single overview of the transfer queue, export queue, import, and restore environment operations.
* Redesigned transfer, queue, restore, compare, and export modals with consistent styling, improved error surfacing, and a cleaner status and operation layout.
* Refreshed status, schema, and configuration views in the management dashboard.

## Umbraco.Deploy.Contrib

### [18.0.0](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-18.0.0) (June 25th 2026)

* Compatibility with Umbraco 18.0.0 and Deploy 18.0.0.

### [18.0.0-rc1](https://github.com/umbraco/Umbraco.Deploy.Contrib/releases/tag/release-18.0.0-rc1) (June 24th 2026)

* Compatibility with Umbraco 18.0.0-rc3 and Deploy 18.0.0-rc3.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-deploy/release-notes.md) and [Umbraco Deploy Package page](https://our.umbraco.com/packages/developer-tools/umbraco-deploy/).
