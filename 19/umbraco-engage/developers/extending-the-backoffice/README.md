---
description: >-
  Learn how to extend the Umbraco Engage backoffice with your own screens,
  segment parameters, and profile extensions.
---

# Extending the Backoffice

Umbraco Engage builds on the Umbraco backoffice extension system. You register your own extensions in an `umbraco-package.json` file, the same way as for the Umbraco CMS. Umbraco Engage adds extension types of its own on top of the CMS extension types.

This article gives an overview of the extension points and of the `@umbraco-engage/backoffice` package.

{% hint style="info" %}
New to backoffice extensions? Read the [Creating your first extension](https://docs.umbraco.com/umbraco-cms/extend-your-project/tutorials/creating-your-first-extension) and [Vite Package Setup](https://docs.umbraco.com/umbraco-cms/extend-your-project/backoffice-extensions/development-flow/vite-package-setup) articles first.
{% endhint %}

## Extension points

| Extension | Type | Article |
| --- | --- | --- |
| A screen in the sidebar of the Engage section | `menuItem` and `workspace` | [Custom Screens](custom-screens.md) |
| A parameter in the segment builder | `engageSegmentRule` | [Implement your own segment parameters](../personalization/implement-your-own-segment-parameters.md) |
| Content on the **External data** tab of a profile | `engageExternalDataComponent` | [External Profile Data](../profiling/external-profile-data.md) |
| A box on the **Insights** tab of a profile | `engageProfileInsight` | [Profile Insights and Tabs](../profiling/profile-insights-and-tabs.md) |
| A tab on a profile | `workspaceView` with kind `engageProfileDetailWorkspaceView` | [Profile Insights and Tabs](../profiling/profile-insights-and-tabs.md) |

Your extensions can read the state of Umbraco Engage, such as the licensed features. See the [Using the Engage Context](engage-context.md) article.

Follow the [Naming Rules](naming-rules.md) when you choose aliases and element names.

## The backoffice package

The `@umbraco-engage/backoffice` package on npm contains the types, base classes, and context tokens of the Umbraco Engage backoffice.

You need the package when you build your extension with TypeScript or a bundler. Install the package as a development dependency. Replace `x.x.x` with the Umbraco Engage version installed on your site:

```text
npm install -D @umbraco-engage/backoffice@x.x.x
```

{% hint style="warning" %}
The package version must match the installed Umbraco Engage version.
{% endhint %}

### Importing from the package

The package has no root import. Import from a sub-path instead:

```typescript
import { ENGAGE_CONTEXT } from "@umbraco-engage/backoffice/core";
import { UeSegmentRuleBaseElement } from "@umbraco-engage/backoffice/segment-rules";
```

### Bundler configuration

The backoffice loads the Umbraco Engage code from your site at runtime. Your bundle must not include a copy of the package. Mark all `@umbraco` imports as external in your bundler configuration.

For Vite, the configuration looks like this:

```typescript
import { defineConfig } from "vite";

export default defineConfig({
    build: {
        lib: {
            entry: "src/my-element.ts",
            formats: ["es"],
        },
        rollupOptions: {
            external: [/^@umbraco/],
        },
    },
});
```

### Without a build step

A JavaScript file without a build step can import from the same sub-paths. The backoffice resolves `@umbraco-engage/backoffice/...` imports in the browser. In that case, you do not need to install the package.
