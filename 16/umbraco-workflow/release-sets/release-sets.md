---
description: >-
    Create collections of content to publish according to multi-stage scheduling rules.
---

# Release Sets

{% hint style="info" %}
This feature requires a license - learn more about [Workflow's licensing model](https://umbraco.com/products/umbraco-workflow)
{% endhint %}

Release Sets are collections of [Alternate Versions](../alternate-versions/alternate-versions.md), where each version can be scheduled independently. Release Sets provides a holisitic overview of scheduled content, and enables building and managing content schedules to drive digital campaigns.

Release Sets is currently (v16.0.0) available behind a feature flag. To enable the feature, add the following to app settings:

```json
"Umbraco": {
    "Workflow": {
        ... // other settings
        "FeatureFlags": ["ReleaseSets"]
    }
}
```

## Working with Release Sets

-   Ensure the User Group permissions are set to allow appropriate access.
    ![Release Set permissions](images/release-set-permissions.png)
-   Navigate to the Release Sets dashboard in the Content section
    ![Release Set dashboard view](images/release-sets-dashboard.png)
-   Clicking the `Create` button opens a workspace modal to create a new set.
    ![Version workspace](images/release-set-workspace-editor.png)

A Release Set is comprised of document versions and (optionally) tasks. Tasks are like to-dos that should be tracked alongside the Release Set, but are not necessarily CMS activities.

For example, a task might be to finalise digital advertising. It is not a CMS activity, but it is a requirement that must be met before publishing the Release Set.

### Adding documents

-   Click the `Add document` button
-   Select the document node from the picker
-   In the versions editor, either add or create a new version of the selected document
![Version editor](images/versions-editor.png)
-   Adding an existing version opens the version picker. Adding a new version opens the [Alternate Version](../alternate-versions/alternate-versions.md) workspace editor
![Version picker](images/version-picker.png)
- After selecting or creating a version, it is displayed in the version editor
![Version editor](images/version-editor-2.png)
- The selected version can then be scheduled.
![Version scheduling](images/version-scheduling.png)
- Multiple versions of the same document can be added and scheduled in sequence.
![Multiple selected versions](images/version-editor-3.png)
- After submitting the modal, the updated versions are displayed in the overlay. The documents list shows the selected documents, while the calendar shows the Release Set and its components.
![Release Set overview](images/release-set-overview.png)
- Selecting a day in the calendar displays the content changes scheduled for that date.
![Calendar day](images/calendar-day.png)
- The `Add` button in the calendar day dialog allows adding items to the Release Set, similar to the `Add document` button in the main overview.

### Publishing a Release Set

A Release Set can be published immediately or scheduled for future publication. To publish a Set, all assigned versions and tasks must be either `Ready to publish` (versions) or `Complete` (tasks). If all components in the Set are in the required status, it can be published by a use with the appropriate permission.

Publishing content within the a Release Set is managed by a recurring hosted service, similar to scheduled content publishing.

As publishing progresses, each document version is promoted to be the current backoffice draft, and then published as normal. A version of the original backoffice draft is preserved as an Alternate Version and can be republished or edited in the future.

When a Release Set has no further changes to publish, the status is updated to `Complete`. The Set can then be deleted, or updated and republished. Content published within the Set is preserved and can be further edited or included in a new Release Set.