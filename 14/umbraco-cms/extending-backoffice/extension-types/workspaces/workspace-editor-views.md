---
description: Append a view to any Workspace
---

# Workspace Views

Previously known as Content Apps, now generalized with the ability to take place in any workspace.

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

**Manifest**

<pre class="language-json"><code class="lang-json">{
	"type": "workspaceView",
	"alias": "My.WorkspaceView",
	"name": "My Workspace View",
	"meta": {
		"label": "My View",
		"pathname": "/my-view",
		"icon": "document",
	}
<strong>	"conditions": [
</strong>		{
			"alias": "Umb.Condition.WorkspaceAlias",
			"match": workspace.alias,
		},
	],
}
</code></pre>
