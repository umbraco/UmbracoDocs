# Workspaces

{% hint style="warning" %}
This page is a work in progress and may undergo further revisions, updates, or amendments. The information contained herein is subject to change without notice.
{% endhint %}

A Workspace is the editor for a specific entity type. It can either be a simple view of data or a complex editor with multiple views.

* A workspace is based on an entity type (e.g. content, media, member, etc.) and a unique string (ex: key).
* Most workspaces hold a draft state of an entity. It is a copy of the entity data that can be modified at runtime and sent to the server to be saved.
* A workspace can be a single view or consist of multiple views.
* A workspace should host a workspace context, with which anything within can communicate.

<figure><img src="../.gitbook/assets/workspace.svg" alt=""><figcaption><p>Workspace</p></figcaption></figure>

```ts
interface UmbWorkspaceElement {}
```

## [Workspace Context](extending-overview/extension-types/workspaces/workspace-context.md)

## [Workspace Views](extending-overview/extension-types/workspaces/workspace-views.md)

## [Workspace Actions](extending-overview/extension-types/workspaces/workspace-editor-actions.md)
