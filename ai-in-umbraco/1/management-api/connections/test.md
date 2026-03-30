---
description: >-
    Test a connection to verify credentials are valid.
---

# Test Connection

Test a connection by attempting to communicate with the AI provider. This verifies that credentials are valid and the provider is reachable.

## Endpoint

```
POST /connections/{idOrAlias}/test
```

## Path Parameters

| Parameter   | Type   | Description              |
| ----------- | ------ | ------------------------ |
| `idOrAlias` | string | Connection GUID or alias |

## Request

No request body required.

## Response

### Success (200 OK)

{% code title="Success Response" %}

```json
{
    "success": true,
    "errorMessage": null
}
```

{% endcode %}

### Test Failed (200 OK)

{% code title="Failure Response" %}

```json
{
    "success": false,
    "errorMessage": "Invalid API key provided"
}
```

{% endcode %}

### 404 Not Found

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Connection not found"
}
```

## How Testing Works

The test operation:

1. Resolves the connection and its settings
2. Gets the first available capability from the provider
3. Attempts to fetch the list of available models
4. Returns success if the provider responds successfully

{% hint style="info" %}
A successful test confirms the API key is valid and the provider is reachable. It does not guarantee all models will work or that you have sufficient quota.
{% endhint %}

## Examples

### cURL

{% code title="cURL" %}

```bash
curl -X POST "https://localhost:44331/umbraco/ai/management/api/v1/connections/openai-prod/test"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
async function testConnection(idOrAlias) {
    const response = await fetch(`/umbraco/ai/management/api/v1/connections/${idOrAlias}/test`, {
        method: "POST",
        credentials: "include",
    });

    if (!response.ok) {
        if (response.status === 404) {
            return { success: false, errorMessage: "Connection not found" };
        }
        throw new Error("Failed to test connection");
    }

    return await response.json();
}

// Usage
const result = await testConnection("openai-prod");
if (result.success) {
    console.log("Connection is working!");
} else {
    console.error("Connection failed:", result.errorMessage);
}
```

{% endcode %}

### Test After Creation

{% code title="JavaScript" %}

```javascript
async function createAndTestConnection(connectionData) {
    // Create the connection
    const connection = await createConnection(connectionData);

    // Test it immediately
    const testResult = await testConnection(connection.id);

    if (!testResult.success) {
        // Optionally delete if test fails
        await deleteConnection(connection.id);
        throw new Error(`Connection test failed: ${testResult.errorMessage}`);
    }

    return connection;
}
```

{% endcode %}
