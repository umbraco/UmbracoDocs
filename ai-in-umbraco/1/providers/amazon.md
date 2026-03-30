---
description: >-
    Configure Amazon Bedrock as an AI provider for chat and embedding capabilities.
---

# Amazon Bedrock

Amazon Bedrock provides a unified API for accessing multiple AI models from Amazon, Anthropic, Meta, Mistral, and others through AWS infrastructure.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Amazon
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Amazon
```

{% endcode %}

## Capabilities

| Capability | Supported | Description                                |
| ---------- | --------- | ------------------------------------------ |
| Chat       | Yes       | Amazon Nova, Claude, Llama, Mistral models |
| Embedding  | Yes       | Amazon Titan Embeddings, Cohere            |

## Connection Settings

| Setting           | Required | Description                             |
| ----------------- | -------- | --------------------------------------- |
| Region            | Yes      | AWS region (e.g., `us-east-1`)          |
| Access Key ID     | Yes      | Your AWS access key ID                  |
| Secret Access Key | Yes      | Your AWS secret access key              |
| Endpoint          | No       | Custom endpoint URL (for VPC endpoints) |

### Getting AWS Credentials

1. Sign in to the [AWS Console](https://console.aws.amazon.com)
2. Navigate to **IAM** > **Users**
3. Create or select a user
4. Create an access key under **Security credentials**
5. Copy the Access Key ID and Secret Access Key

{% hint style="warning" %}
Use IAM roles with least-privilege permissions. The user needs `bedrock:InvokeModel` permission.
{% endhint %}

### Required IAM Policy

{% code title="bedrock-policy.json" %}

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["bedrock:InvokeModel", "bedrock:InvokeModelWithResponseStream"],
            "Resource": "arn:aws:bedrock:*::foundation-model/*"
        }
    ]
}
```

{% endcode %}

## Available Models

### Chat Models

| Model Family     | Models                                                                                                                           | Context Window |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| Amazon Nova      | `amazon.nova-pro-v1:0`, `amazon.nova-lite-v1:0`, `amazon.nova-micro-v1:0`                                                        | 300K           |
| Anthropic Claude | `anthropic.claude-3-5-sonnet-20241022-v2:0`, `anthropic.claude-3-sonnet-20240229-v1:0`, `anthropic.claude-3-haiku-20240307-v1:0` | 200K           |
| Meta Llama       | `meta.llama3-2-90b-instruct-v1:0`, `meta.llama3-2-11b-instruct-v1:0`                                                             | 128K           |
| Mistral          | `mistral.mistral-large-2407-v1:0`, `mistral.mixtral-8x7b-instruct-v0:1`                                                          | 32K            |

### Embedding Models

| Model                          | Dimensions | Best For             |
| ------------------------------ | ---------- | -------------------- |
| `amazon.titan-embed-text-v2:0` | 1024       | General purpose      |
| `amazon.titan-embed-text-v1`   | 1536       | Legacy compatibility |
| `cohere.embed-english-v3`      | 1024       | English text         |
| `cohere.embed-multilingual-v3` | 1024       | Multilingual         |

{% hint style="info" %}
Model availability varies by AWS region. Check the [Bedrock model documentation](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html) for region-specific availability.
{% endhint %}

## Enabling Models

Before using a model, you must enable it in your AWS account:

1. Go to **Amazon Bedrock** in the AWS Console
2. Navigate to **Model access**
3. Click **Manage model access**
4. Select the models you want to use
5. Submit the request (some models require approval)

## Creating a Connection

### Via Backoffice

1. Navigate to the **AI** section > **Connections**
2. Click **Create Connection**
3. Select **Amazon Bedrock** as the provider
4. Enter your AWS credentials and region
5. Save the connection

### Via Code

{% code title="Example.cs" %}

```csharp
var connection = new AIConnection
{
    Alias = "bedrock-production",
    Name = "Amazon Bedrock Production",
    ProviderId = "amazon",
    Settings = new AmazonProviderSettings
    {
        Region = "us-east-1",
        AccessKeyId = "AKIA...",
        SecretAccessKey = "..."
    }
};

await _connectionService.SaveConnectionAsync(connection);
```

{% endcode %}

## Creating Profiles

### Chat Profile (Amazon Nova)

{% code title="Example.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "nova-assistant",
    Name = "Nova Assistant",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Model = new AIModelRef("amazon", "amazon.nova-pro-v1:0"),
    Settings = new AIChatProfileSettings
    {
        Temperature = 0.7f,
        MaxTokens = 4096,
        SystemPromptTemplate = "You are a helpful assistant."
    }
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

### Chat Profile (Claude via Bedrock)

{% code title="Example.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "claude-bedrock",
    Name = "Claude via Bedrock",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Model = new AIModelRef("amazon", "anthropic.claude-3-5-sonnet-20241022-v2:0"),
    Settings = new AIChatProfileSettings
    {
        Temperature = 0.7f,
        MaxTokens = 4096
    }
};
```

{% endcode %}

### Embedding Profile

{% code title="Example.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "bedrock-embeddings",
    Name = "Bedrock Embeddings",
    Capability = AICapability.Embedding,
    ConnectionId = connectionId,
    Model = new AIModelRef("amazon", "amazon.titan-embed-text-v2:0")
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

## VPC Endpoints

For enhanced security, use VPC endpoints:

{% code title="Example.cs" %}

```csharp
var connection = new AIConnection
{
    // ...
    Settings = new AmazonProviderSettings
    {
        Region = "us-east-1",
        AccessKeyId = "AKIA...",
        SecretAccessKey = "...",
        Endpoint = "https://vpce-xxx.bedrock-runtime.us-east-1.vpce.amazonaws.com"
    }
};
```

{% endcode %}

## Pricing Considerations

Amazon Bedrock uses pay-per-token pricing that varies by model:

| Model             | Input (1K tokens) | Output (1K tokens) |
| ----------------- | ----------------- | ------------------ |
| Amazon Nova Pro   | ~$0.0008          | ~$0.0032           |
| Amazon Nova Lite  | ~$0.00006         | ~$0.00024          |
| Claude 3.5 Sonnet | ~$0.003           | ~$0.015            |
| Claude 3 Haiku    | ~$0.00025         | ~$0.00125          |

{% hint style="info" %}
Prices are approximate and subject to change. Check [Amazon Bedrock pricing](https://aws.amazon.com/bedrock/pricing/) for current rates.
{% endhint %}

## Troubleshooting

### Access Denied

```
Error: AccessDeniedException
```

Verify:

- IAM user has `bedrock:InvokeModel` permission
- The model is enabled in your account
- You're using the correct region

### Model Not Enabled

```
Error: Model not available
```

Enable the model in the Bedrock console under **Model access**.

### Region Not Supported

```
Error: Service not available in region
```

Amazon Bedrock isn't available in all regions. Use a supported region like `us-east-1` or `eu-west-1`.

## Related

- [Providers Overview](README.md) - Compare all providers
- [Connections](../concepts/connections.md) - Managing credentials
- [Profiles](../concepts/profiles.md) - Configuring models
