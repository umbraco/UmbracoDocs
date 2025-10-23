---
description: This section describes how to work with and create Property Editors.
---

# Property Editors Composition

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A property editor is an editor used to insert content into Umbraco. A Property Editor is composed of two extensions. To form a full Property Editor you will need a:

* [Property Editor Schema](property-editor-schema.md)
* [Property Editor UI](property-editor-ui.md)

A Property Editor UI is utilizing a Property Editor Schema, and you can have multiple Property Editor UIs for one Schema. This means you can find a Schema that solves your needs. You only need to build a Property Editor UI.

* Each Property Editor can have multiple Property Editor UIs.
* Both a Property Editor Schema and Property Editor UI can define the Settings used for their configuration.

### Configuration

* Data Type Settings for a Property Editor or Property Editor UI is defined in the manifests.
* They both use the same format for their settings.

## Property Editor Data Sources
A Property Editor Data Source is an optional way to provide data to a Property Editor UI. This allows for reuse of the same Property Editor UI but with different data sources.

* [Property Editor Data Source](property-editor-data-source.md)
