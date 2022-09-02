---
meta.Title: "Umbraco Plumber Approval Groups"
meta.Description: "Umbraco Plumber's Approval groups and their settings"
versionFrom: 8.0.0
versionTo: 10.0.0
---

# Approval Groups

Umbraco Plumber uses a separate groups model from the rest of your website. It is different, but looks familiar.

Add users to approval groups to determine which users will be responsible for approving content changes.

The Approval groups view in the Workflow section lists the active groups, their membership, permissions, and a quick link to email the group. Select a group from the list to edit settings, permissions and membership.

Total groups is limited to 5 on unlicensed install. The paid license removes this restriction.

## Settings

- **Group email:** sometimes it's more appropriate to send workflow notifications to a generic inbox rather than the individual group members. Add a value here to do exactly that.
- **Description:** it is not used anywhere other than the group view. It is a note to remind you why the group exists.
- **Offline approval:** allow this group to approve changes without logging in to the Backoffice. Refer to [Offline approval](#offline-approval) for more information.

## Roles

Provides an overview of the current workflow roles for the group, both node-based and Document Type based.

## Members

Manage the membership for the given user group. Members can be explicitly added to the group, or inherited from existing Umbraco groups. Ideally group members are set explicitly to ensure changes made to Umbraco groups do not cause unexpected changes to workflow permissions.

## History

Provides an overview of the workflow activity for the current group.
