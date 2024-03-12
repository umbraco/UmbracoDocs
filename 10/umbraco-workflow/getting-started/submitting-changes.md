---
description: >-
  Learn how to submit content changes for Workflow approval
---

# Submitting Content for Approval

{% hint style="info" %}
This article applies to versions 10.6.0 and higher.
{% endhint %}

When requesting workflow approval for content changes, editors must provide additional information detailing the change.

This is done by clicking the 'Request publish' button in the editor footer:

![Buttons](../images/Buttons%20(1).png)

The button opens the request approval overlay:

![Request approval overlay](./images/approval-request-overlay-detailed.png)

Depending on the Document Type and Workflow settings, the overlay will provide inputs for:

- A comment describing the changes
- A selector for choosing the workflow type - either publish or unpublish
  - Only visible when 'Use Workflow for unpublish' is set to true
- A selector for choosing the variants to publish
  - Only visible on variant content
- A media picker for choosing a media attachment
  - Only visible when 'Allow attachments' is set to true
- A date picker for setting a scheduled publishing date
  - Only visible when 'Allow scheduling' is set to true, and the workflow type is publish
- A date picker for setting a scheduled unpublishing date
  - Only visible when 'Allow scheduling' is true

It is not possible to schedule a publish date in an unpublish workflow. It is possible to schedule both publish and unpublish dates in a publish workflow. Once content has been unpublish, a new workflow process is required to republish the content.

## Variant workflows

If the document varies by culture, the editor must select one or more variants to submit for approval.

When a document is invariant, the variants selector is not displayed, and the approval flow follows the [default permissions inheritence pattern](./workflow-content-app#approval-flow-types).

![Request approval overlay](./images/approval-request-overlay-variants.png)

The editor will not be able to select variants where:
- They do not have permission to edit the language, or
- The variant is already in a workflow.

When submitting multiple variants, a workflow process is started for each variant, using the [default permissions inheritence pattern](./workflow-content-app#approval-flow-types). Newly created variants are automatically assigned the configuration from the default language.

Alternatively, all variants can be submitted in an invariant workflow, where they will be approved in a single workflow process. Invariant workflows use the permissions set on the default language. Editors must have permission to edit all the current node's variants to be able to initiate an invariant workflow.

The invariant workflow will publish all variants not already in workflows, regardless of the node state. This means that previously unpublished variants will be republished when using invariant workflows. Given that, in most cases selecting the individual variants is probably the desired approach.

## Content validation and pending changes

When submitting for approval, Workflow will automatically save variants with pending changes.

Validation errors are reported in the UI using Umbraco's validation messages.