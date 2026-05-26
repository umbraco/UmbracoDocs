---
description: >-
    Configure Amazon Bedrock as an AI provider for chat and embedding capabilities.
---

# Amazon Bedrock

Amazon Bedrock provides access to multiple AI models from Amazon, Anthropic, Meta, Mistral, and others through AWS infrastructure, supporting both Chat and Embedding capabilities.

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
Use IAM roles with least-privilege permissions. Attach the policy shown in [Required IAM Policy](#required-iam-policy) to the user or role.
{% endhint %}

### Required IAM Policy

The IAM principal needs permission to invoke Bedrock models and to subscribe to AWS Marketplace products. The Marketplace actions are used by Bedrock to auto-enable foundation models on first use.

{% code title="bedrock-policy.json" %}

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "bedrock:InvokeModel",
                "bedrock:InvokeModelWithResponseStream"
            ],
            "Resource": "arn:aws:bedrock:*::foundation-model/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "aws-marketplace:Subscribe",
                "aws-marketplace:Unsubscribe",
                "aws-marketplace:ViewSubscriptions"
            ],
            "Resource": "*"
        }
    ]
}
```

{% endcode %}

The AWS managed policy [AmazonBedrockFullAccess](https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonBedrockFullAccess.html) covers all of these actions if you prefer to attach a managed policy.

### Enabling Models

In commercial AWS regions, foundation model access is enabled automatically. The first time you invoke a third-party model in an account, Amazon Bedrock initiates the subscription in the background. Auto-enablement can take up to 15 minutes, during which calls may return `AccessDeniedException`.

{% hint style="info" %}
The **Manage model access** page in the Bedrock console was retired in October 2025. You no longer need to opt-in to individual models before using them.
{% endhint %}

#### Anthropic models

Anthropic models require a one-time use-case form per AWS account or organization. Submit the form by selecting an Anthropic model from the model catalog in the Bedrock console, or by calling the [PutUseCaseForModelAccess](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_PutUseCaseForModelAccess.html) API. Access is granted immediately after submission.

#### AWS GovCloud (US)

GovCloud accounts in `us-gov-west-1` still use the **Model access** page in the Bedrock console for manual enablement. Third-party models also need to be enabled in the linked commercial account. For full details, see the AWS guide on [Request access to models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html#model-access-govcloud).

![Amazon Bedrock connection detail showing Region and Access Key fields](../.gitbook/assets/amazon-bedrock-create-connection.png)

## Related

- [Providers Overview](README.md)
- [Managing Connections](../backoffice/managing-connections.md)
