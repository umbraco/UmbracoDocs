---
title: ExecutionResult<TResult>
description: API reference for ExecutionResult<TResult> in Umbraco Commerce
---
## ExecutionResult&lt;TResult&gt;

```csharp
public class ExecutionResult<TResult>
```

**Namespace**
* [Umbraco.Commerce.Common.Resiliency](README.md)

### Constructors

#### ExecutionResult&lt;TResult&gt;

Creates a new instance of [`ExecutionResult`](executionresult-1.md).

```csharp
public ExecutionResult(bool successful, TResult result)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| successful | `true` if the operation succeeded. |
| result | The result of the operation if successful. |


### Properties

#### IsSuccessful

Indicates whether the operation succeeded.

```csharp
public virtual bool IsSuccessful { get; }
```


---

#### Result

The result of the operation if successful.

```csharp
public virtual TResult Result { get; }
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Common.dll -->
