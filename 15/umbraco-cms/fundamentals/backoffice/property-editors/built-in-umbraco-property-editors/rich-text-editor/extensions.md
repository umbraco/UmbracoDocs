---
description: Information on how to work with Tiptap extensions in the rich text editor.
---

# Extensions

The Rich Text Editor (RTE) in Umbraco is based on the open-source editor [Tiptap](https://tiptap.dev/).

Out of the box, Tiptap has limited capabilities and everything is an extension by design. Basic text formatting features such as bold, italic, and underline are their own extensions. This offers great flexibility, making the rich text editor highly configurable. The implementation in Umbraco offers a wide range of built-in extensions to enhance the Tiptap editor capabilities.

Using the same extension points, this article will show you how to add a custom extension to the rich text editor.

## Native Tiptap extensions

Tiptap has a library of supported native extensions. You can find a list of these extensions on the [Tiptap website](https://tiptap.dev/docs/editor/extensions/overview). While many of these are open source, there are also [pro extensions](https://tiptap.dev/docs/guides/pro-extensions) available for commercial subscriptions.

### Tiptap extension types

There are two types of extension: `tiptapExtension` and `tiptapToolbarExtension`.

The `tiptapExtension` extension is used to register a native [Tiptap Extension](https://tiptap.dev/docs/editor/extensions/). These will enhance the capabilities of the rich text editor itself. For example, to enable text formatting, drag-and-drop functionality and spell-checking.

The `tiptapToolbarExtension` extension adds a toolbar action that interacts with the Tiptap editor (and native Tiptap extensions).


## Adding a native extension

{% hint style="info" %}
This example assumes that you will be creating an Umbraco package using the Vite/Lit/TypeScript setup.
You can learn how to do this [Vite Package Setup](../../../../../customizing/development-flow/vite-package-setup.md) article.
{% endhint %}

In this example, you will take the native Tiptap open-source extension [Task List](https://tiptap.dev/docs/editor/extensions/nodes/task-list). Then register it with the rich text editor and add a toolbar button to invoke the Task List action.

1. Install both the Task List and Task Item extensions from the npm registry.

```
npm install @tiptap/extension-task-list @tiptap/extension-task-item
```

2. Create the code to register the native Tiptap extensions in the rich text editor.

```js
import { UmbTiptapExtensionApiBase } from '@umbraco-cms/backoffice/tiptap';
import { TaskItem } from '@tiptap/extension-task-item';
import { TaskList } from '@tiptap/extension-task-list';

export default class UmbTiptapTaskListExtensionApi extends UmbTiptapExtensionApiBase {
    getTiptapExtensions = () => [TaskList, TaskItem];
}
```

3. Create the toolbar action to invoke the Task List extension.

```
import { UmbTiptapToolbarElementApiBase } from '@umbraco-cms/backoffice/tiptap';
import type { Editor } from '@umbraco-cms/backoffice/external/tiptap';

export default class UmbTiptapToolbarTaskListExtensionApi extends UmbTiptapToolbarElementApiBase {
    override execute(editor?: Editor) {
        editor?.chain().focus().toggleTaskList().run();
    }
}
```

Once you have the above code in place, they can be referenced in the [package manifest](../../../../../extending/property-editors/package-manifest.md) file.

{% code title="App_Plugins/MyTiptapTaskList/umbraco-package.json" lineNumbers="true" %}
```json
{
    "name": "My Tiptap Task List",
    "version": "1.0.0",
    "extensions": [
        {
            "type": "tiptapExtension",
            "alias": "My.Tiptap.TaskList",
            "name": "My Task List Tiptap Extension",
            "api": "/App_Plugins/MyTiptapTaskList/task-list.tiptap-api.js",
            "meta": {
                "icon": "icon-thumbnail-list",
                "label": "Task List",
                "group": "#tiptap_extGroup_interactive"
            }
        },
        {
            "type": "tiptapToolbarExtension",
            "alias": "My.Tiptap.Toolbar.TaskList",
            "name": "My Task List Tiptap Toolbar Extension",
            "api": "/App_Plugins/MyTiptapTaskList/task-list.tiptap-toolbar-api.js",
            "meta": {
                "alias": "taskList",
                "icon": "icon-thumbnail-list",
                "label": "Task List"
            }
        }
    ]
}
```
{% endcode %}

Upon restarting Umbraco, the new extension and toolbar action will be available in the Tiptap Data Type configuration settings.
