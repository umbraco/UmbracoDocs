---
description: >-
    Delete an AI provider connection.
---

# Delete Connection

Delete a connection permanently.

## Endpoint

```
DELETE /connections/{id}
```

## Path Parameters

| Parameter | Type | Description                          |
| --------- | ---- | ------------------------------------ |
| `id`      | guid | Connection ID (GUID only, not alias) |

## Response

### Success (200 OK)

Returns empty response on successful deletion.

### 404 Not Found

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Connection with ID '3fa85f64-5717-4562-b3fc-2c963f66afa6' not found"
}
```

## Considerations

{% hint style="danger" %}
Deleting a connection will break any profiles that depend on it. Consider deactivating the connection instead by setting `isActive: false`.
{% endhint %}

Before deleting a connection:

1. Check if any profiles reference this connection
2. Update or delete dependent profiles
3. Or deactivate instead of deleting

## Examples

### cURL

{% code title="cURL" %}

```bash
curl -X DELETE "https://localhost:44331/umbraco/ai/management/api/v1/connections/3fa85f64-5717-4562-b3fc-2c963f66afa6"
```

{% endcode %}

### JavaScript

{% code title="JavaScript" %}

```javascript
async function deleteConnection(id) {
    const response = await fetch(`/umbraco/ai/management/api/v1/connections/${id}`, {
        method: "DELETE",
        credentials: "include",
    });

    if (!response.ok) {
        if (response.status === 404) {
            throw new Error("Connection not found");
        }
        const error = await response.json();
        throw new Error(error.detail);
    }

    return true;
}

// Usage
await deleteConnection("3fa85f64-5717-4562-b3fc-2c963f66afa6");
```

{% endcode %}

### Safe Delete Pattern

{% code title="JavaScript" %}

```javascript
async function safeDeleteConnection(id) {
    // First, deactivate
    await updateConnection(id, { isActive: false });

    // Wait/verify no issues
    // Then delete if confirmed
    await deleteConnection(id);
}
```

{% endcode %}
