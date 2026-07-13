---
description: >-
  Create collections of content to publish according to multi-stage scheduling
  rules.
---

# Release Sets

{% hint style="info" %}
This feature requires a license. Learn more about [Workflow's licensing model](https://umbraco.com/products/umbraco-workflow).
{% endhint %}

Release Sets are collections of [Alternate Versions](../alternate-versions/alternate-versions.md), where each version can be scheduled independently. Release Sets provides a holistic overview of scheduled content and enables building and managing content schedules to drive digital campaigns.

Release Sets is currently (v16.0.0) available behind a feature flag. To enable the feature, add the following to the `appsettings.json` file:

```json
"Umbraco": {
    "Workflow": {
        ... // other settings
        "FeatureFlags": ["ReleaseSets"]
    }
}
```

## Working with Release Sets

1. Ensure the User Group permissions are set to allow appropriate access.

<div align="center"><figure><img src="images/release-set-permissions.png" alt=""><figcaption></figcaption></figure></div>

2. Navigate to the **Release Sets** dashboard in the **Content** section.

<figure><img src="images/release-sets-dashboard.png" alt=""><figcaption></figcaption></figure>

3. Click the **Create** button to open a workspace modal to create a new set.

<figure><img src="images/release-set-workspace-editor.png" alt=""><figcaption></figcaption></figure>

A Release Set is comprised of document versions and (optionally) tasks. Tasks are like to-dos that should be tracked alongside the Release Set, but are not necessarily CMS activities.

For example, a task might be to finalize digital advertising. It is not a CMS activity, but it is a requirement that must be met before publishing the Release Set.

### Adding documents

1. Click the **Add document** button.
2. Select the document node from the picker.
3. Add or create a new version of the selected document in the version editor.

<figure><img src="images/versions-editor.png" alt=""><figcaption></figcaption></figure>

Adding an existing version opens the version picker. Creating a new version opens the [Alternate Version](../alternate-versions/alternate-versions.md) workspace editor.

<figure><img src="images/version-picker.png" alt=""><figcaption></figcaption></figure>

Add an existing version or create a version to display it in the version editor.

<figure><img src="images/version-editor-2.png" alt=""><figcaption></figcaption></figure>

4. Enter the date and time in the **Publish at** field.&#x20;
5. Click **Schedule publish** to schedule the selected version.

<figure><img src="images/version-scheduling.png" alt=""><figcaption></figcaption></figure>

You can add multiple versions of the same document and schedule them in sequence.

<figure><img src="images/version-editor-3.png" alt=""><figcaption></figcaption></figure>

After submitting the modal, the updated versions are displayed in the overlay.&#x20;

The documents list shows the selected documents, while the calendar shows the Release Set and its components.

<figure><img src="images/release-set-overview.png" alt=""><figcaption></figcaption></figure>

6. Select a day in the calendar to display the scheduled content changes for that date.

<figure><img src="images/calendar-day.png" alt=""><figcaption></figcaption></figure>

7. Click the **Add** button in the calendar dialog to add items to the Release Set.

### Publishing a Release Set

A Release Set can be published immediately or scheduled for future publication. To publish a Set, all assigned versions and tasks must be either `Ready to publish` (versions) or `Complete` (tasks). If all components in the Set are in the required status, it can be published by a user with the appropriate permission.

Publishing content within the Release Set is managed by a recurring hosted service, similar to scheduled content publishing.

As publishing progresses, each document version is promoted to be the current backoffice draft, and then published as normal. A version of the original backoffice draft is preserved as an Alternate Version and can be republished or edited in the future.

When a Release Set has no further changes to publish, the status is updated to `Complete`. The Set can then be deleted, or updated and republished. Content published within the Set is preserved and can be further edited or included in a new Release Set.
