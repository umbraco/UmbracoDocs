---
title: MicrosoftLogger<T>
description: API reference for MicrosoftLogger<T> in Umbraco Commerce
---
## MicrosoftLogger&lt;T&gt;

```csharp
public class MicrosoftLogger<T> : ILogger<T>
```

**Inheritance**

* interface [ILogger&lt;!0&gt;](../../umbraco-commerce-common/umbraco-commerce-common-logging/ilogger-1.md)

**Namespace**
* [Umbraco.Commerce.Infrastructure.Logging](README.md)

### Constructors

#### MicrosoftLogger&lt;T&gt;

```csharp
public MicrosoftLogger(ILogger<T> logger)
```


### Methods

#### Debug (1 of 2)

```csharp
public void Debug(string message)
```

---

#### Debug (2 of 2)

```csharp
public void Debug(string messageTemplate, params object[] propertyValues)
```


---

#### Error (1 of 5)

```csharp
public void Error(Exception exception, string message)
```

---

#### Error (2 of 5)

```csharp
public void Error(Exception exception)
```

---

#### Error (3 of 5)

```csharp
public void Error(string message)
```

---

#### Error (4 of 5)

```csharp
public void Error(Exception exception, string messageTemplate, params object[] propertyValues)
```

---

#### Error (5 of 5)

```csharp
public void Error(string messageTemplate, params object[] propertyValues)
```


---

#### Fatal (1 of 5)

```csharp
public void Fatal(Exception exception, string message)
```

---

#### Fatal (2 of 5)

```csharp
public void Fatal(Exception exception)
```

---

#### Fatal (3 of 5)

```csharp
public void Fatal(string message)
```

---

#### Fatal (4 of 5)

```csharp
public void Fatal(Exception exception, string messageTemplate, params object[] propertyValues)
```

---

#### Fatal (5 of 5)

```csharp
public void Fatal(string messageTemplate, params object[] propertyValues)
```


---

#### Info (1 of 2)

```csharp
public void Info(string message)
```

---

#### Info (2 of 2)

```csharp
public void Info(string messageTemplate, params object[] propertyValues)
```


---

#### IsEnabled

```csharp
public bool IsEnabled(LogLevel level)
```


---

#### Verbose (1 of 2)

```csharp
public void Verbose(string message)
```

---

#### Verbose (2 of 2)

```csharp
public void Verbose(string messageTemplate, params object[] propertyValues)
```


---

#### Warn (1 of 4)

```csharp
public void Warn(string message)
```

---

#### Warn (2 of 4)

```csharp
public void Warn(string messageTemplate, params object[] propertyValues)
```

---

#### Warn (3 of 4)

```csharp
public void Warn(Exception exception, string message)
```

---

#### Warn (4 of 4)

```csharp
public void Warn(Exception exception, string messageTemplate, params object[] propertyValues)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Infrastructure.dll -->
