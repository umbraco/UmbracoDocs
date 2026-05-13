# What is Patching

The Management API includes a PATCH endpoint for making partial updates to content. Instead of sending the entire payload back to the server like a PUT request, you describe only the specific changes you want to make. The server applies those changes to existing content and saves it.

This is particularly valuable when working with complex content structures where a full PUT requires you to reconstruct the entire document for a single value. Deeply nested block editors is an example of complex content structures.

Patching is currently only supported for documents.

## How Umbraco Patching Differs from Standard JSON Patch

The PATCH endpoint draws inspiration from [JSON Patch](https://datatracker.ietf.org/doc/html/rfc6902) but is tailored specifically for Umbraco content. The key differences are:

### Targeted operations

Umbraco supports three operations: **replace**, **add**, and **remove**. The `move`, `copy`, and `test` operations from the JSON Patch specification are not included.

### Array filters instead of index-only addressing

Standard JSON Patch addresses array elements by index only (such as `/values/0`). This is fragile — if the array order changes between your GET and PATCH calls, you may update the wrong element.

Umbraco extends the path syntax with **array filters** that let you match elements by their properties:

```
/values[alias=title,culture=en-US,segment=null]/value
```

This targets the value entry where `alias` is `title`, `culture` is `en-US`, and `segment` is null — regardless of its position in the array. Filters use `and` logic (all conditions must match), and the first matching element is used.

## What Happens Behind the Scenes

When you send a PATCH request, the server processes it through a pipeline that ultimately feeds into the same save flow as a PUT request. This means your changes go through the same validation, notifications, and persistence logic.

Here is what happens step by step:

1. **Authorization** — The server checks that the authenticated user has update permission on the document. If not, a `403 Forbidden` response is returned.

2. **Load** — The document is retrieved from the database and converted into its JSON update representation. This is the same JSON shape you would send in a PUT request.

3. **Parse and apply** — Each operation in the request is processed in order:
   - The path string is parsed into segments (property names, array filters, indices, or the append marker `/-`).
   - The segments are resolved against the current JSON tree to locate the target.
   - The operation (replace, add, or remove) is applied as a mutation to the JSON.
   - Each subsequent operation sees the result of all previous ones, so operations can build on each other.

4. **Deserialize** — The modified JSON is deserialized back into an update model. If the JSON is structurally invalid at this point (such as a malformed block editor value), a `400 Bad Request` is returned.

5. **Validate and save** — The update model is passed through the standard document update flow. This includes limited validation for allowed cultures and allowed property updates. If validation fails, the appropriate error response is returned. Any configured notification handlers on save will also trigger.

Because the patch layer is thin and delegates to the standard save pipeline, you get the same guarantees as a PUT: property editor rules are enforced, notifications fire, and the document is saved transactionally.

## Further Reading

- [Document PATCH Endpoint Guide](document-endpoint-guide.md) — Detailed path syntax, document structure reference, block editor guidance, and step-by-step recipes for common tasks.
- [Document PATCH Endpoint Specification](document-endpoint-spec.md) — Machine-readable technical specification for tooling and AI agents, including formal path grammar, JSON schemas, and error conditions.
