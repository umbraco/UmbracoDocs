---
description: >-
  A Workspace is the editor for a specific entity type. It can either be a
  simple view of data or a complex editor with multiple views.
---

# Workspace

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}



* A workspace is based on an entity type (e.g. content, media, member, etc.) and a unique string (ex: key).
* Most workspaces hold a draft state of an entity. It is a copy of the entity data that can be modified at runtime and sent to the server to be saved.
* A workspace can be a single view or consist of multiple views.
* A workspace should host a workspace context, with which anything within can communicate.

<figure><img src="../../../.gitbook/assets/workspace.svg" alt=""><figcaption><p>Workspace</p></figcaption></figure>

```ts
// TODO: get typescript interface
interface UmbWorkspaceElement {}
```

## The Workspace Context

Read more about [Workspace Context](workspace-context.md)

### Examples of workspaces

TODO: link to all workspaces in storybook. Can we somehow auto-generate this list?
