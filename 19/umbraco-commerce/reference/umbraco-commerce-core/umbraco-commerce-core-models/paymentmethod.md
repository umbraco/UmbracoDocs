---
title: PaymentMethod
description: API reference for PaymentMethod in Umbraco Commerce
---
## PaymentMethod

```csharp
public class PaymentMethod : PaymentMethodReadOnly, IHasWritableServicePrices<PaymentMethod>, 
    IHasWrtiableAllowedCountries<PaymentMethod>, IHasWrtiableAllowedCountryRegions<PaymentMethod>
```

**Inheritance**

* Class [PaymentMethodReadOnly](paymentmethodreadonly.md)
* interface [IHasWritableServicePrices&lt;TAggregate&gt;](ihaswritableserviceprices-1.md)
* interface [IHasWrtiableAllowedCountries&lt;TAggregate&gt;](ihaswrtiableallowedcountries-1.md)
* interface [IHasWrtiableAllowedCountryRegions&lt;TAggregate&gt;](ihaswrtiableallowedcountryregions-1.md)

**Namespace**
* [Umbraco.Commerce.Core.Models](README.md)

### Methods

#### Create (1 of 2)

```csharp
public static PaymentMethod Create(IUnitOfWork uow, Guid storeId, string alias, string name, 
    string paymentProviderAlias)
```

---

#### Create (2 of 2)

```csharp
public static PaymentMethod Create(IUnitOfWork uow, Guid id, Guid storeId, string alias, 
    string name, string paymentProviderAlias)
```


---

#### AllowInCountry (1 of 2)

```csharp
public PaymentMethod AllowInCountry(CountryReadOnly country)
```

---

#### AllowInCountry (2 of 2)

```csharp
public PaymentMethod AllowInCountry(Guid countryId)
```


---

#### AllowInRegion (1 of 2)

```csharp
public PaymentMethod AllowInRegion(RegionReadOnly region)
```

---

#### AllowInRegion (2 of 2)

```csharp
public PaymentMethod AllowInRegion(Guid countryId, Guid regionId)
```


---

#### ClearCountryPriceForCurrency (1 of 2)

```csharp
public PaymentMethod ClearCountryPriceForCurrency(CountryReadOnly country, 
    CurrencyReadOnly currency)
```

---

#### ClearCountryPriceForCurrency (2 of 2)

```csharp
public PaymentMethod ClearCountryPriceForCurrency(Guid countryId, Guid currencyId)
```


---

#### ClearDefaultPriceForCurrency (1 of 2)

```csharp
public PaymentMethod ClearDefaultPriceForCurrency(CurrencyReadOnly currency)
```

---

#### ClearDefaultPriceForCurrency (2 of 2)

```csharp
public PaymentMethod ClearDefaultPriceForCurrency(Guid currencyId)
```


---

#### ClearPricesForCountry (1 of 2)

```csharp
public PaymentMethod ClearPricesForCountry(CountryReadOnly country, 
    CurrencyReadOnly currency = null)
```

---

#### ClearPricesForCountry (2 of 2)

```csharp
public PaymentMethod ClearPricesForCountry(Guid countryId, Guid? currencyId = default(Guid?))
```


---

#### ClearPricesForCurrency (1 of 2)

```csharp
public PaymentMethod ClearPricesForCurrency(CurrencyReadOnly currency)
```

---

#### ClearPricesForCurrency (2 of 2)

```csharp
public PaymentMethod ClearPricesForCurrency(Guid currencyId)
```


---

#### ClearPricesForRegion (1 of 2)

```csharp
public PaymentMethod ClearPricesForRegion(RegionReadOnly region, CurrencyReadOnly currency = null)
```

---

#### ClearPricesForRegion (2 of 2)

```csharp
public PaymentMethod ClearPricesForRegion(Guid countryId, Guid regionId, 
    Guid? currencyId = default(Guid?))
```


---

#### ClearRegionPriceForCurrency (1 of 2)

```csharp
public PaymentMethod ClearRegionPriceForCurrency(RegionReadOnly region, CurrencyReadOnly currency)
```

---

#### ClearRegionPriceForCurrency (2 of 2)

```csharp
public PaymentMethod ClearRegionPriceForCurrency(Guid countryId, Guid regionId, Guid currencyId)
```


---

#### ClearTaxClass

```csharp
public PaymentMethod ClearTaxClass()
```


---

#### DisallowInCountry (1 of 2)

```csharp
public PaymentMethod DisallowInCountry(CountryReadOnly country)
```

---

#### DisallowInCountry (2 of 2)

```csharp
public PaymentMethod DisallowInCountry(Guid countryId)
```


---

#### DisallowInRegion (1 of 2)

```csharp
public PaymentMethod DisallowInRegion(RegionReadOnly region)
```

---

#### DisallowInRegion (2 of 2)

```csharp
public PaymentMethod DisallowInRegion(Guid countryId, Guid regionId)
```


---

#### RemoveSetting

```csharp
public PaymentMethod RemoveSetting(string alias)
```


---

#### SetAlias

```csharp
public PaymentMethod SetAlias(string alias)
```


---

#### SetCountryPriceForCurrency (1 of 2)

```csharp
public PaymentMethod SetCountryPriceForCurrency(CountryReadOnly country, CurrencyReadOnly currency, 
    decimal value)
```

---

#### SetCountryPriceForCurrency (2 of 2)

```csharp
public PaymentMethod SetCountryPriceForCurrency(Guid countryId, Guid currencyId, decimal value)
```


---

#### SetDefaultPriceForCurrency (1 of 2)

```csharp
public PaymentMethod SetDefaultPriceForCurrency(CurrencyReadOnly currency, decimal value)
```

---

#### SetDefaultPriceForCurrency (2 of 2)

```csharp
public PaymentMethod SetDefaultPriceForCurrency(Guid currencyId, decimal value)
```


---

#### SetImage

```csharp
public PaymentMethod SetImage(string id)
```


---

#### SetName (1 of 2)

```csharp
public PaymentMethod SetName(string name)
```

---

#### SetName (2 of 2)

```csharp
public PaymentMethod SetName(string name, string alias)
```


---

#### SetRegionPriceForCurrency (1 of 2)

```csharp
public PaymentMethod SetRegionPriceForCurrency(RegionReadOnly region, CurrencyReadOnly currency, 
    decimal value)
```

---

#### SetRegionPriceForCurrency (2 of 2)

```csharp
public PaymentMethod SetRegionPriceForCurrency(Guid countryId, Guid regionId, Guid currencyId, 
    decimal value)
```


---

#### SetSetting

```csharp
public PaymentMethod SetSetting(string alias, string value)
```


---

#### SetSettings

```csharp
public PaymentMethod SetSettings(IDictionary<string, string> settings, 
    SetBehavior setBehavior = SetBehavior.Merge)
```


---

#### SetSku

```csharp
public PaymentMethod SetSku(string sku)
```


---

#### SetSortOrder

```csharp
public PaymentMethod SetSortOrder(int sortOrder)
```


---

#### SetTaxClass (1 of 2)

```csharp
public PaymentMethod SetTaxClass(TaxClass taxClass)
```

---

#### SetTaxClass (2 of 2)

```csharp
public PaymentMethod SetTaxClass(Guid? taxClassId)
```


---

#### ToggleFeatures

```csharp
public PaymentMethod ToggleFeatures(bool fetchPaymentStatuses, bool capturePayments, 
    bool cancelPayments, bool refundPayments)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
