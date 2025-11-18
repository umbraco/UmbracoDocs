---
title: SessionManager
description: API reference for SessionManager in Umbraco Commerce
---
## SessionManager

```csharp
public class SessionManager : ISessionManager
```

**Inheritance**

* interface [ISessionManager](isessionmanager.md)

**Namespace**
* [Umbraco.Commerce.Core.Session](README.md)

### Constructors

#### SessionManager

```csharp
public SessionManager(IStoreService storeService, IOrderService orderService, 
    ICurrencyService currencyService, ICountryService countryService, 
    IPaymentMethodService paymentMethodService, IShippingMethodService shippingMethodService, 
    ITaxService taxService, ISessionStore sessionStore, ITempStore tempStore, 
    IUnitOfWorkProvider uowProvider)
```


### Methods

#### CheckAndMoveSessionOrders

```csharp
public void CheckAndMoveSessionOrders()
```


---

#### ClearCurrentAdminOrder

```csharp
public void ClearCurrentAdminOrder(Guid storeId)
```


---

#### ClearCurrentFinalizedOrder

```csharp
public void ClearCurrentFinalizedOrder(Guid storeId)
```


---

#### ClearCurrentOrder

```csharp
public void ClearCurrentOrder(Guid storeId)
```


---

#### ClearDefaultCurrency

```csharp
public void ClearDefaultCurrency(Guid storeId)
```


---

#### ClearDefaultPaymentCountry

```csharp
public void ClearDefaultPaymentCountry(Guid storeId)
```


---

#### ClearDefaultPaymentMethod

```csharp
public void ClearDefaultPaymentMethod(Guid storeId)
```


---

#### ClearDefaultPaymentRegion

```csharp
public void ClearDefaultPaymentRegion(Guid storeId)
```


---

#### ClearDefaultShippingCountry

```csharp
public void ClearDefaultShippingCountry(Guid storeId)
```


---

#### ClearDefaultShippingMethod

```csharp
public void ClearDefaultShippingMethod(Guid storeId)
```


---

#### ClearDefaultShippingRegion

```csharp
public void ClearDefaultShippingRegion(Guid storeId)
```


---

#### ClearDefaultTaxClass

```csharp
public void ClearDefaultTaxClass(Guid storeId)
```


---

#### GetCurrentAdminOrder

```csharp
public OrderReadOnly GetCurrentAdminOrder(Guid storeId)
```


---

#### GetCurrentFinalizedOrder

```csharp
public OrderReadOnly GetCurrentFinalizedOrder(Guid storeId)
```


---

#### GetCurrentOrder (1 of 2)

```csharp
public OrderReadOnly GetCurrentOrder(Guid storeId)
```

---

#### GetCurrentOrder (2 of 2)

```csharp
public OrderReadOnly GetCurrentOrder(Guid storeId, string customerReference)
```


---

#### GetDefaultCurrency

```csharp
public CurrencyReadOnly GetDefaultCurrency(Guid storeId)
```


---

#### GetDefaultPaymentCountry

```csharp
public CountryReadOnly GetDefaultPaymentCountry(Guid storeId)
```


---

#### GetDefaultPaymentMethod

```csharp
public PaymentMethodReadOnly GetDefaultPaymentMethod(Guid storeId)
```


---

#### GetDefaultPaymentRegion

```csharp
public RegionReadOnly GetDefaultPaymentRegion(Guid storeId)
```


---

#### GetDefaultShippingCountry

```csharp
public CountryReadOnly GetDefaultShippingCountry(Guid storeId)
```


---

#### GetDefaultShippingMethod

```csharp
public ShippingMethodReadOnly GetDefaultShippingMethod(Guid storeId)
```


---

#### GetDefaultShippingRegion

```csharp
public RegionReadOnly GetDefaultShippingRegion(Guid storeId)
```


---

#### GetDefaultTaxClass

```csharp
public TaxClassReadOnly GetDefaultTaxClass(Guid storeId)
```


---

#### GetOrCreateCurrentOrder (1 of 2)

```csharp
public OrderReadOnly GetOrCreateCurrentOrder(Guid storeId)
```

---

#### GetOrCreateCurrentOrder (2 of 2)

```csharp
public OrderReadOnly GetOrCreateCurrentOrder(Guid storeId, string customerReference)
```


---

#### SetCurrentAdminOrder (1 of 2)

```csharp
public void SetCurrentAdminOrder(Guid storeId, Guid orderId, string currentUserId, 
    IEnumerable<string> currentUserRoles)
```

---

#### SetCurrentAdminOrder (2 of 2)

```csharp
public void SetCurrentAdminOrder(Guid storeId, OrderReadOnly order, string currentUserId, 
    IEnumerable<string> currentUserRoles)
```


---

#### SetCurrentFinalizedOrder

```csharp
public void SetCurrentFinalizedOrder(Guid storeId, Guid id)
```


---

#### SetCurrentOrder (1 of 2)

```csharp
public void SetCurrentOrder(Guid storeId, Guid orderId)
```

---

#### SetCurrentOrder (2 of 2)

```csharp
public void SetCurrentOrder(Guid storeId, OrderReadOnly entity)
```


---

#### SetDefaultCurrency (1 of 2)

```csharp
public void SetDefaultCurrency(Guid storeId, Guid currencyId, bool applyToCurrentOrder = false)
```

---

#### SetDefaultCurrency (2 of 2)

```csharp
public void SetDefaultCurrency(Guid storeId, CurrencyReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultPaymentCountry (1 of 2)

```csharp
public void SetDefaultPaymentCountry(Guid storeId, Guid id, bool applyToCurrentOrder = false)
```

---

#### SetDefaultPaymentCountry (2 of 2)

```csharp
public void SetDefaultPaymentCountry(Guid storeId, CountryReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultPaymentMethod (1 of 2)

```csharp
public void SetDefaultPaymentMethod(Guid storeId, Guid id, bool applyToCurrentOrder = false)
```

---

#### SetDefaultPaymentMethod (2 of 2)

```csharp
public void SetDefaultPaymentMethod(Guid storeId, PaymentMethodReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultPaymentRegion (1 of 2)

```csharp
public void SetDefaultPaymentRegion(Guid storeId, Guid countryId, Guid id, 
    bool applyToCurrentOrder = false)
```

---

#### SetDefaultPaymentRegion (2 of 2)

```csharp
public void SetDefaultPaymentRegion(Guid storeId, RegionReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultShippingCountry (1 of 2)

```csharp
public void SetDefaultShippingCountry(Guid storeId, Guid id, bool applyToCurrentOrder = false)
```

---

#### SetDefaultShippingCountry (2 of 2)

```csharp
public void SetDefaultShippingCountry(Guid storeId, CountryReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultShippingMethod (1 of 2)

```csharp
public void SetDefaultShippingMethod(Guid storeId, Guid id, bool applyToCurrentOrder = false)
```

---

#### SetDefaultShippingMethod (2 of 2)

```csharp
public void SetDefaultShippingMethod(Guid storeId, ShippingMethodReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultShippingRegion (1 of 2)

```csharp
public void SetDefaultShippingRegion(Guid storeId, Guid countryId, Guid id, 
    bool applyToCurrentOrder = false)
```

---

#### SetDefaultShippingRegion (2 of 2)

```csharp
public void SetDefaultShippingRegion(Guid storeId, RegionReadOnly entity, 
    bool applyToCurrentOrder = false)
```


---

#### SetDefaultTaxClass (1 of 2)

```csharp
public void SetDefaultTaxClass(Guid storeId, Guid id, bool applyToCurrentOrder = false)
```

---

#### SetDefaultTaxClass (2 of 2)

```csharp
public void SetDefaultTaxClass(Guid storeId, TaxClassReadOnly entity, 
    bool applyToCurrentOrder = false)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
