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

With the introduction of Engage version 16, several breaking changes have been introduced to accommodate the transitions between multiple major versions of the core CMS.

#### Clientside Analytics

Engage includes various optional scripts that can be included in the front-end, which interact with various API endpoints. Some of these endpoints have changed. If any firewall rules are in place involving the front-end reaching Umbraco APIs, the following paths need to be allowed through:

```
/umbraco/engage/pagedata/collect
/umbraco/engage/pagedata/collect-event
/umbraco/engage/pagedata/ping
```

#### Umbraco Member Detection & Storage

The detection and storage of logged-in Umbraco Members have changed significantly between versions 13 and 16 of Engage. In older versions of v13, any kind of login claim would be detected as a valid member, causing the visitor to be marked as 'Identified' and get linked to any member claim ID. This has changed over various minor versions of v13 to only allow for Umbraco Members to prevent other login methods from interfering with Engage.&#x20;

Engage v16 will strictly enforce the storage of Umbraco Members only, attempting to update any existing pageview data that detects a logged-in member.  This migration includes switching from integer IDs to GUID keys, validating the GUIDs against the existing Umbraco Members, and enforcing the datatype to a unique identifier.&#x20;

This **will** result in data loss if non-Umbraco members or no longer existing members were stored in the `MembershipProviderKey` column in the `umbracoEngageAnalyticsPageview` table.
