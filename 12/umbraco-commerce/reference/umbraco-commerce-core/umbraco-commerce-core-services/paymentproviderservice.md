---
title: PaymentProviderService
description: API reference for PaymentProviderService in Umbraco Commerce
---
## PaymentProviderService

```csharp
public class PaymentProviderService : IPaymentProviderService
```

**Inheritance**

* interface [IPaymentProviderService](ipaymentproviderservice.md)

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Constructors

#### PaymentProviderService

```csharp
public PaymentProviderService(PaymentProviderCollection paymentProviders)
```


### Methods

#### GetPaymentProvider

```csharp
public IPaymentProvider GetPaymentProvider(string alias)
```


---

#### GetPaymentProviderDefinitions

```csharp
public IEnumerable<PaymentProviderDefinition> GetPaymentProviderDefinitions()
```


---

#### GetPaymentProviderScaffold

```csharp
public PaymentProviderScaffold GetPaymentProviderScaffold(string alias)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
