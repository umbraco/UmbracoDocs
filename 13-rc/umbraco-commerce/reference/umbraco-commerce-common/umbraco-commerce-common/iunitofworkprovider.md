---
title: IUnitOfWorkProvider
description: API reference for IUnitOfWorkProvider in Umbraco Commerce
---
## IUnitOfWorkProvider

Defines a Provider that can create a [`IUnitOfWork`](iunitofwork.md)

```csharp
public interface IUnitOfWorkProvider
```

**Namespace**
* [Umbraco.Commerce.Common](README.md)

### Properties

#### Current

Gets the current ambient Unit of Work

```csharp
public IUnitOfWork Current { get; }
```


### Methods

#### Create

Creates a new [`IUnitOfWork`](iunitofwork.md) instance

```csharp
public IUnitOfWork Create()
```

**Returns**

The newly created [`IUnitOfWork`](iunitofwork.md) instance


---

#### Create (1 of 2)

Creates a new [`IUnitOfWork`](iunitofwork.md) instance

```csharp
public IUnitOfWork Create(bool autoComplete)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| autoComplete | Boolean flag defining whether to auto complete the unit of work |

**Returns**

The newly created [`IUnitOfWork`](iunitofwork.md) instance

---

#### Create (2 of 2)

Creates a new [`IUnitOfWork`](iunitofwork.md) instance

```csharp
public IUnitOfWork Create(IUnitOfWorkOptions options)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| options | Options for the Unit of Work |

**Returns**

The newly created [`IUnitOfWork`](iunitofwork.md) instance


---

#### Execute (1 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md)

```csharp
public void Execute(Action<IUnitOfWork> action)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| action | The action to execute |

---

#### Execute (2 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md)

```csharp
public void Execute(bool autoComplete, Action<IUnitOfWork> action)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| autoComplete | Boolean flag defining whether to auto complete the unit of work |
| action | The action to execute |

---

#### Execute (3 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md)

```csharp
public void Execute(IUnitOfWorkOptions options, Action<IUnitOfWork> action)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| options | Options for the Unit of Work |
| action | The action to execute |


---

#### Execute&lt;T&gt; (1 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md) returning the given typed result

```csharp
public T Execute<T>(Func<IUnitOfWork, T> action)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The result type |
| action | The action to execute |

---

#### Execute&lt;T&gt; (2 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md) returning the given typed result

```csharp
public T Execute<T>(bool autoComplete, Func<IUnitOfWork, T> action)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The result type |
| autoComplete | Boolean flag defining whether to auto complete the unit of work |
| action | The action to execute |

---

#### Execute&lt;T&gt; (3 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md) returning the given typed result

```csharp
public T Execute<T>(IUnitOfWorkOptions options, Func<IUnitOfWork, T> action)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The result type |
| options | Options for the Unit of Work |
| action | The action to execute |


---

#### ExecuteAsync (1 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md)

```csharp
public Task ExecuteAsync(Func<IUnitOfWork, CancellationToken, Task> action, 
    CancellationToken cancellationToken = default(CancellationToken))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| action | The action to execute |
| cancellationToken | Async task cancellation token |

---

#### ExecuteAsync (2 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md)

```csharp
public Task ExecuteAsync(bool autoComplete, Func<IUnitOfWork, CancellationToken, Task> action, 
    CancellationToken cancellationToken = default(CancellationToken))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| autoComplete | Boolean flag defining whether to auto complete the unit of work |
| action | The action to execute |
| cancellationToken | Async task cancellation token |

---

#### ExecuteAsync (3 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md)

```csharp
public Task ExecuteAsync(IUnitOfWorkOptions options, 
    Func<IUnitOfWork, CancellationToken, Task> action, 
    CancellationToken cancellationToken = default(CancellationToken))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| options | Options for the Unit of Work |
| action | The action to execute |
| cancellationToken | Async task cancellation token |


---

#### ExecuteAsync&lt;T&gt; (1 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md) returning the given typed result

```csharp
public Task<T> ExecuteAsync<T>(Func<IUnitOfWork, CancellationToken, Task<T>> action, 
    CancellationToken cancellationToken = default(CancellationToken))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The result type |
| action | The action to execute |
| cancellationToken | Async task cancellation token |

---

#### ExecuteAsync&lt;T&gt; (2 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md) returning the given typed result

```csharp
public Task<T> ExecuteAsync<T>(bool autoComplete, 
    Func<IUnitOfWork, CancellationToken, Task<T>> action, 
    CancellationToken cancellationToken = default(CancellationToken))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The result type |
| autoComplete | Boolean flag defining whether to auto complete the unit of work |
| action | The action to execute |
| cancellationToken | Async task cancellation token |

---

#### ExecuteAsync&lt;T&gt; (3 of 3)

Executes the given action within a [`IUnitOfWork`](iunitofwork.md) returning the given typed result

```csharp
public Task<T> ExecuteAsync<T>(IUnitOfWorkOptions options, 
    Func<IUnitOfWork, CancellationToken, Task<T>> action, 
    CancellationToken cancellationToken = default(CancellationToken))
```

**Parameters**

| Parameter | Description |
| --- | --- |
| T | The result type |
| options | Options for the Unit of Work |
| action | The action to execute |
| cancellationToken | Async task cancellation token |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Common.dll -->
