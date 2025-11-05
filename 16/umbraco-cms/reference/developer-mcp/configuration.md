---
description: Configuration options for the Developer MCP server
---

# Configration Options

The Developer MCP Server can be configured in mutliple ways to manage authentication, tool access, and security settings. These settings control how the server connects to Umbraco and how it operates within your development environment. Configuration can be applied using configuration keys, environment variables, or CLI arguments, depending on your workflow.

## Configuration Keys

### Authentication Configuration Keys

| Key | Description |
| --- | --- |
| `UMBRACO_CLIENT_ID` | The username of the Umbraco API user. |
| `UMBRACO_CLIENT_SECRET` | The client secret for the Umbraco API user. |
| `UMBRACO_BASE_URL` | The base URL of your Umbraco instance (e.g. `https://localhost:44391`). |
| `NODE_TLS_REJECT_UNAUTHORIZED` | Set to `"0"` to disable TLS certificate validation when connecting to HTTP URLs or self-signed certificates. |

{% hint style="warning" %}
If you are connecting to the secure endpoint of Umbraco locally then **always** set the NODE_TLS_REJECT_UNAUTHORIZED to 0
{% endhint %}

### Tool and Tool Collection configuration

| Key | Description |
| --- | --- |
| `UMBRACO_EXCLUDE_TOOLS` | Specifies tool names to **exclude** from the usable tools list. Useful when certain agents cannot handle a large number of tools. |
| `UMBRACO_INCLUDE_TOOLS` | Specifies tool names to **include** in the usable tools list. When defined, **only** these tools will be available. |
| `UMBRACO_INCLUDE_TOOL_COLLECTIONS` | Specifies collections by name to **include**. Only tools from these collections will be available. |
| `UMBRACO_EXCLUDE_TOOL_COLLECTIONS` | Specifies collections by name to **exclude** from the usable tools list. |

{% hint style="info" %}
Use these keys to fine-tune which tools or tool collections are exposed to your LLM. This improves performance and clarity in your conversations.
{% endhint %}

#### Working with Tool Collections

When configuring tools for the Developer MCP Server, you can fine-tune which tools and collections are available by using comma-separated values.

- **Comma-delimited configuration**  
Tools and tool collections are specified using a comma-separated list.
For example:
```bash
UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,document-type,data-type"
```

- **Combining tool configurations**  
You can combine configuration options to include entire tool collections while excluding specific tools.
For example, you might enable the document and media collections but exclude a single tool within them.

```bash
UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,media"
UMBRACO_EXCLUDE_TOOLS="document-move,media-delete"
```

### Security Configuration Keys

| Key | Description |
| --- | --- |
| `UMBRACO_ALLOWED_MEDIA_PATHS` | *(Optional, security feature)* <br> Defines a **comma-separated list of absolute directory paths** allowed for media uploads using the `filePath` source type. This prevents unauthorized file system access by restricting uploads to specific, trusted directories. <br><br> **Required for:** Local file path uploads <br> **Default:** If not configured, all `filePath` uploads are rejected with an error. <br><br> **Example:** <br> `UMBRACO_ALLOWED_MEDIA_PATHS="/tmp/uploads,/var/media,/home/user/assets"` |

{% hint style="info" %}
URL-based and base64 media uploads work without this configuration.  
{% endhint %}


## Environment Configuration Options

The **Umbraco Developer MCP Server** supports configuration through multiple methods, allowing flexibility across different environments and workflows:

1. **Environment variables** defined in the MCP client configuration (e.g., Claude Desktop, Visual Studio Code, Cursor)  
2. A local **`.env` file** for development
3. **CLI arguments** when running the MCP Server directly  

**Configuration precedence:**  
`CLI arguments` → `Environment variables` → `.env` file  

---

### Using a `.env` File (Recommended for Development)

For local development, create a `.env` file in your project root directory and set your connection details:

```bash
# Example .env configuration
UMBRACO_CLIENT_ID=your-api-user-id
UMBRACO_CLIENT_SECRET=your-api-secret
UMBRACO_BASE_URL=http://localhost:56472
UMBRACO_INCLUDE_TOOL_COLLECTIONS=document,media,document-type,data-type
```

{% hint style="info" %}
The .env file is included in .gitignore by default to prevent sensitive credentials from being committed to source control.
{% endhint %}

### Using CLI Arguments

You can also provide configuration values directly via CLI arguments, which override any .env or environment variable settings:

```bash
npx @umbraco-cms/mcp-dev@beta \
  --umbraco-client-id="your-id" \
  --umbraco-client-secret="your-secret" \
  --umbraco-base-url="http://localhost:56472" \
  --env="/path/to/custom/.env"
```