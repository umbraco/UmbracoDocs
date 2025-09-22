---
description: >-
  Version-specific documentation for upgrading to new major versions of Umbraco
  Engage.
---

# Version specific Upgrade Notes

This article provides specific upgrade instructions and breaking changes introduced when migrating from major version 13 of Umbraco Engage to version 16.

{% hint style="info" %}
When upgrading to a new minor or patch version, learn about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Breaking changes

### v16.0.0 (Umbraco Engage v16 Launch)

With the introduction of Engage version 16, breaking changes have been introduced to accommodate the transitions between multiple major versions of the core CMS.

#### Clientside Analytics

Engage includes different optional scripts that can be included in the front-end, which interact with different API endpoints. Some of these endpoints have changed. If any firewall rules are in place involving the front-end reaching Umbraco APIs, the following paths need to be allowed through:

```
/umbraco/engage/pagedata/collect
/umbraco/engage/pagedata/collect-event
/umbraco/engage/pagedata/ping
```

#### Umbraco Member Detection & Storage

The detection and storage of logged-in Umbraco Members have changed between versions 13 and 16 of Engage. In older v13 versions, any login claim was detected as a valid member. This caused visitors to be marked as 'Identified' and linked to the claim ID. This has changed over minor versions of v13 to only allow for Umbraco Members to prevent other login methods from interfering with Engage.

Engage v16 will strictly enforce the storage of Umbraco Members only, attempting to update any existing pageview data that detects a logged-in member. This migration switches from integer IDs to GUID keys. It validates the GUIDs against existing Umbraco Members and enforces the datatype as a unique identifier.

This **will** result in data loss if non-Umbraco members or no longer existing members were stored in the `MembershipProviderKey` column in the `umbracoEngageAnalyticsPageview` table.

**GUIDs and Numeric IDs**

Starting with version 16, Engage is aligning with the Core CMS by transitioning from numeric IDs to GUIDs. Many internal APIs have been updated to use GUIDs instead of numeric IDs for fetching, updating, and deleting data. This transition is ongoing and will continue in version 17 and beyond, which will also include public-facing APIs.

**Extending the Backoffice**

The Engage backoffice has been rebuilt to run on Umbraco’s new Web component–based backoffice. This opens up new possibilities for extensions, which will be documented over time. However, the previous AngularJS-based extension approach (used in version 13 and earlier) is no longer supported.
