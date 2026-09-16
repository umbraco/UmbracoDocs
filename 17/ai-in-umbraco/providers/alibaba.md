---
description: >-
    Configure Alibaba Cloud Model Studio as an AI provider for Qwen chat and embedding models.
---

# Alibaba Cloud Model Studio

Alibaba Cloud Model Studio provides access to Qwen models, supporting the Chat and Embedding capabilities.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Alibaba
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Alibaba
```

{% endcode %}

## Connection Settings

| Setting  | Required | Description                                                                                                            |
| -------- | -------- | ------------------------------------------------------------------------------------------------------------------------ |
| API Key  | Yes      | Your Alibaba Cloud Model Studio API key from [bailian.console.alibabacloud.com](https://bailian.console.alibabacloud.com/) |
| Endpoint | No       | Custom endpoint URL (defaults to `https://dashscope-intl.aliyuncs.com/compatible-mode/v1`, the international region)     |

![Alibaba Cloud Model Studio connection detail showing API Key and Endpoint fields](../.gitbook/assets/alibaba-create-connection.png)

### Getting an API Key

1. Sign up at [bailian.console.alibabacloud.com](https://bailian.console.alibabacloud.com/).
2. Navigate to **API Key Management**.
3. Create a new API key.
4. Copy the key (it won't be shown again).

{% hint style="warning" %}
Keep your API key secure. Never commit it to source control or expose it in client-side code.
{% endhint %}

### China Region

Model Studio also serves a China (Beijing) region. To use it, set **Endpoint** to `https://dashscope.aliyuncs.com/compatible-mode/v1`.

{% hint style="info" %}
The default model is `qwen-plus` for chat and `text-embedding-v4` for embeddings. Model Studio's catalog also includes other vendors' models behind the same endpoint; this provider only surfaces Qwen models.
{% endhint %}

## Related

- [Providers Overview](README.md).
- [Managing Connections](../backoffice/managing-connections.md).
