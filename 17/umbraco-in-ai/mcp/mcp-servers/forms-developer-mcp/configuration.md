---
description: Configuration options for the Forms Developer MCP server
---

# Configuration Options

The Forms Developer MCP Server uses the same configuration fields as any Umbraco MCP server built on the Base MCP SDK. For authentication, environment variables, CLI arguments, precedence rules, and all built-in fields, see the [SDK Configuration reference](../../custom-mcp-server/sdk/configuration.md).

For a complete reference of CLI flags, runtime modes (readonly and dry-run), introspection commands, and input sanitization, see the [CLI Reference](../../custom-mcp-server/sdk/cli.md).

This page lists the specific tool modes and slices that the Forms Developer MCP ships with. It also covers the connection, Delivery API, and chaining fields it adds on top of the SDK defaults.

## Connection

| Variable | CLI Flag | Purpose |
| --- | --- | --- |
| `UMBRACO_CLIENT_ID` | `--umbraco-client-id` | OAuth2 client ID of the Umbraco API user |
| `UMBRACO_CLIENT_SECRET` | `--umbraco-client-secret` | OAuth2 client secret of the Umbraco API user |
| `UMBRACO_BASE_URL` | `--umbraco-base-url` | URL of the Umbraco instance running Umbraco Forms |
| `UMBRACO_FORMS_API_KEY` | `--umbraco-forms-api-key` | API key for the Forms Delivery API. Only needed for the `form-submission` tools. See [Forms Delivery API](#forms-delivery-api). |
| `UMBRACO_EXPECTED_MAJOR` | `--umbraco-expected-major` | Overrides the Umbraco major version the server expects. See [Version Check](#version-check). |

{% hint style="warning" %}
Set the client secret and the Forms API key as environment variables, not as CLI flags. CLI arguments can show up in process lists and shell history.
{% endhint %}

### Version Check

When the server starts, it compares the Umbraco major version of the connected instance with the version it targets. The Umbraco 17 line targets `17`.

If the versions do not match, the server logs a warning, and the first tool call returns the warning instead of running. Calling the tool again runs it.

Set `UMBRACO_EXPECTED_MAJOR` only when you deliberately connect to a different Umbraco major version. Otherwise, install the package that matches your site. See [Umbraco Forms Version Support](README.md#umbraco-forms-version-support).

## Tool Filtering

The Forms Developer MCP Server uses the SDK [tool filtering system](../../custom-mcp-server/sdk/tool-filtering.md) to control which tools are registered. Filtering is built around three concepts: **modes**, **collections**, and **slices**. See the SDK documentation for how these compose and the available configuration keys.

### Available Modes

The Forms Developer MCP ships with the following modes:

| Mode | Collections | Description |
| --- | --- | --- |
| `forms-authoring` | `form`, `form-template`, `field-type`, `picker`, `folder`, `theme` | Building and structuring forms. |
| `data-sources` | `data-source`, `data-source-type`, `prevalue-source`, `prevalue-source-type` | Data sources and prevalue sources that populate form fields. |
| `submissions` | `record`, `analytics`, `workflow-type` | Submitted records, submission analytics, and workflow types. |
| `admin` | `config`, `licensing`, `updates`, `member`, `email-template`, `export`, `acceptance-tests`, `media` | Server-wide configuration, licensing, updates, members, email templates, and exports. |
| `forms-management-all` | All 21 Forms Management API collections | Every collection except `umbraco-server` and `form-submission`. |
| `umbraco-server` | `umbraco-server` | Umbraco server information. |

Set `UMBRACO_TOOL_MODES` (or `--umbraco-tool-modes`) to one or more comma-separated mode names to enable all collections in those modes at once. See [Available Tools](available-tools.md) for the full list of collections and the tools within each.

For example, the following configuration registers the tools for building forms and reviewing submissions, in read-only mode:

{% code title=".mcp.json" %}

```json
"env": {
  "UMBRACO_TOOL_MODES": "forms-authoring,submissions",
  "UMBRACO_READONLY": "true"
}
```

{% endcode %}

{% hint style="info" %}
The `form-submission` collection is not part of any mode. When you set `UMBRACO_TOOL_MODES`, also set `UMBRACO_INCLUDE_TOOL_COLLECTIONS=form-submission` to keep the Delivery API tools.

Collections from modes and from `UMBRACO_INCLUDE_TOOL_COLLECTIONS` are combined.
{% endhint %}

### Available Slices

The Forms Developer MCP ships with the following slices, used with `UMBRACO_INCLUDE_SLICES` / `UMBRACO_EXCLUDE_SLICES`:

| Slice | Description |
| --- | --- |
| `create` | Create entities. |
| `read` | Get single items, or check the state of an item. |
| `update` | Update entities. |
| `delete` | Delete entities. |
| `list` | List items. |
| `search` | Search forms and records. |
| `tree` | Tree navigation (root, children, and ancestors). |
| `move` | Move forms and folders. |
| `copy` | Copy forms and workflows. |
| `scaffold` | Get default structures for new data sources and prevalue sources. |
| `export` | Generate and download exports. |
| `import` | Import forms from export files. |
| `validate` | Validate field and workflow settings without saving. |
| `action` | Run record actions and retry workflows. |
| `workflow` | Workflow history and retries for records. |
| `other` | Catch-all for tools that do not map to any of the slices above. |

For example, `UMBRACO_EXCLUDE_SLICES=delete` hides the tools that delete forms, form fields, folders, data sources, and prevalue sources.

{% hint style="warning" %}
`execute-record-action` can also delete records, and belongs to the `action` slice rather than `delete`. To block every write operation, use `UMBRACO_READONLY=true` instead.
{% endhint %}

## Forms Delivery API

The `form-submission` tools, `get-form-definition` and `submit-form-entry`, use the public Umbraco Forms Delivery API instead of the Management API. They read a form the way a front end sees it, including field aliases, and submit entries to it.

The Delivery API is disabled by default, and authenticates with an API key instead of OAuth. To use the tools:

1. Enable the API and set an API key in the `appsettings.json` file of your Umbraco project:

    {% code title="appsettings.json" %}

    ```json
    {
      "Umbraco": {
        "Forms": {
          "Options": {
            "EnableFormsApi": true
          },
          "Security": {
            "EnableAntiForgeryTokenForFormsApi": false,
            "FormsApiKey": "<a long random string>"
          }
        }
      }
    }
    ```

    {% endcode %}

2. Restart the Umbraco site.
3. Set `UMBRACO_FORMS_API_KEY` in the MCP Server configuration to the same value as `FormsApiKey`.

The settings do the following:

* `EnableFormsApi` turns on the Delivery API. The default value is `false`.
* `FormsApiKey` is the shared secret that the MCP Server sends in the `Api-Key` header.
* `EnableAntiForgeryTokenForFormsApi` must be `false` for server-to-server calls. With the default value of `true`, the API expects an antiforgery token issued to a browser, which the MCP Server can't obtain.

{% hint style="warning" %}
Treat the API key as a credential. Turning off the antiforgery token disables Cross-Site Request Forgery (CSRF) protection for the Forms API on that instance.

Anyone with the `FormsApiKey` value can submit entries to any form on the instance.
{% endhint %}

If the Delivery API tools fail, check the following:

| Error | Likely cause |
| --- | --- |
| `403` | `UMBRACO_FORMS_API_KEY` is missing or does not match `FormsApiKey`, or `EnableAntiForgeryTokenForFormsApi` is still `true`. |
| `404` for a form that exists | `EnableFormsApi` is not `true`, or the site has not been restarted. |

For more information about the Delivery API, see the [Headless/AJAX Forms](https://docs.umbraco.com/umbraco-forms/developer/ajaxforms) article in the Umbraco Forms documentation.

## CMS MCP Server Chaining

The Forms Developer MCP Server automatically chains to the [Umbraco CMS Developer MCP Server](../cms-developer-mcp/README.md). The Umbraco 17 line starts `@umbraco-cms/mcp-dev@17`, reusing the same `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, and `UMBRACO_BASE_URL` credentials. All CMS tools are proxied with a `cms--` prefix (for example, `cms--get-document-by-id`, `cms--get-media-by-id`).

This means a single MCP connection gives your AI agent access to both Forms and CMS capabilities. It is useful when you work with forms and content together, such as adding a new form to a content page.

Any mode, collection, and slice filter configuration set on the Forms MCP Server is passed through to the chained CMS server. Filtering therefore also narrows which `cms--` tools are registered.

| Variable | CLI Flag | Purpose |
| --- | --- | --- |
| `DISABLE_MCP_CHAINING` | `--disable-mcp-chaining` | Disable chaining to the CMS MCP Server. Only Forms tools are registered. |

{% hint style="info" %}
Disabling chaining is useful when you already run a separate CMS Developer MCP connection in your host.

It avoids registering duplicate `cms--` tools.
{% endhint %}
