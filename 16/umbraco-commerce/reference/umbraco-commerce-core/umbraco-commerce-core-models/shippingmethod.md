---
title: ShippingMethod
description: API reference for ShippingMethod in Umbraco Commerce
---
## ShippingMethod

```csharp
public class ShippingMethod : ShippingMethodReadOnly, IHasWritableServicePrices<ShippingMethod>, 
    IHasWrtiableAllowedCountries<ShippingMethod>, IHasWrtiableAllowedCountryRegions<ShippingMethod>
```

**Inheritance**

* Class [ShippingMethodReadOnly](shippingmethodreadonly.md)
* interface [IHasWritableServicePrices&lt;TAggregate&gt;](ihaswritableserviceprices-1.md)
* interface [IHasWrtiableAllowedCountries&lt;TAggregate&gt;](ihaswrtiableallowedcountries-1.md)
* interface [IHasWrtiableAllowedCountryRegions&lt;TAggregate&gt;](ihaswrtiableallowedcountryregions-1.md)

**Namespace**
* [Umbraco.Commerce.Core.Models](README.md)

### Methods

#### Create (1 of 2)

```csharp
public static ShippingMethod Create(IUnitOfWork uow, Guid storeId, string alias, string name)
```

---

#### Create (2 of 2)

```csharp
public static ShippingMethod Create(IUnitOfWork uow, Guid id, Guid storeId, string alias, 
    string name)
```


---

#### AllowInCountry (1 of 2)

```csharp
public ShippingMethod AllowInCountry(CountryReadOnly country)
```

---

#### AllowInCountry (2 of 2)

```csharp
public ShippingMethod AllowInCountry(Guid countryId)
```


---

#### AllowInRegion (1 of 2)

```csharp
public ShippingMethod AllowInRegion(RegionReadOnly region)
```

---

#### AllowInRegion (2 of 2)

```csharp
public ShippingMethod AllowInRegion(Guid countryId, Guid regionId)
```


---

#### ClearCountryPriceForCurrency (1 of 2)

```csharp
public ShippingMethod ClearCountryPriceForCurrency(CountryReadOnly country, 
    CurrencyReadOnly currency)
```

---

#### ClearCountryPriceForCurrency (2 of 2)

```csharp
public ShippingMethod ClearCountryPriceForCurrency(Guid countryId, Guid currencyId)
```


---

#### ClearDefaultPriceForCurrency (1 of 2)

```csharp
public ShippingMethod ClearDefaultPriceForCurrency(CurrencyReadOnly currency)
```

---

#### ClearDefaultPriceForCurrency (2 of 2)

```csharp
public ShippingMethod ClearDefaultPriceForCurrency(Guid currencyId)
```


---

#### ClearPricesForCountry (1 of 2)

```csharp
public ShippingMethod ClearPricesForCountry(CountryReadOnly country, 
    CurrencyReadOnly currency = null)
```

---

#### ClearPricesForCountry (2 of 2)

```csharp
public ShippingMethod ClearPricesForCountry(Guid countryId, Guid? currencyId = default(Guid?))
```


---

#### ClearPricesForCurrency (1 of 2)

```csharp
public ShippingMethod ClearPricesForCurrency(CurrencyReadOnly currency)
```

---

#### ClearPricesForCurrency (2 of 2)

```csharp
public ShippingMethod ClearPricesForCurrency(Guid currencyId)
```


---

#### ClearPricesForRegion (1 of 2)

```csharp
public ShippingMethod ClearPricesForRegion(RegionReadOnly region, CurrencyReadOnly currency = null)
```

---

#### ClearPricesForRegion (2 of 2)

```csharp
public ShippingMethod ClearPricesForRegion(Guid countryId, Guid regionId, 
    Guid? currencyId = default(Guid?))
```


---

#### ClearRegionPriceForCurrency (1 of 2)

```csharp
public ShippingMethod ClearRegionPriceForCurrency(RegionReadOnly region, CurrencyReadOnly currency)
```

---

#### ClearRegionPriceForCurrency (2 of 2)

```csharp
public ShippingMethod ClearRegionPriceForCurrency(Guid countryId, Guid regionId, Guid currencyId)
```


---

#### ClearTaxClass

```csharp
public ShippingMethod ClearTaxClass()
```


---

#### DisallowInCountry (1 of 2)

```csharp
public ShippingMethod DisallowInCountry(CountryReadOnly country)
```

---

#### DisallowInCountry (2 of 2)

```csharp
public ShippingMethod DisallowInCountry(Guid countryId)
```


---

#### DisallowInRegion (1 of 2)

```csharp
public ShippingMethod DisallowInRegion(RegionReadOnly region)
```

---

#### DisallowInRegion (2 of 2)

```csharp
public ShippingMethod DisallowInRegion(Guid countryId, Guid regionId)
```


---

#### SetAlias

```csharp
public ShippingMethod SetAlias(string alias)
```


---

#### SetCountryPriceForCurrency (1 of 2)

```csharp
public ShippingMethod SetCountryPriceForCurrency(CountryReadOnly country, 
    CurrencyReadOnly currency, decimal value)
```

---

#### SetCountryPriceForCurrency (2 of 2)

```csharp
public ShippingMethod SetCountryPriceForCurrency(Guid countryId, Guid currencyId, decimal value)
```


---

#### SetDefaultPriceForCurrency (1 of 2)

```csharp
public ShippingMethod SetDefaultPriceForCurrency(CurrencyReadOnly currency, decimal value)
```

---

#### SetDefaultPriceForCurrency (2 of 2)

```csharp
public ShippingMethod SetDefaultPriceForCurrency(Guid currencyId, decimal value)
```


---

#### SetImage

```csharp
public ShippingMethod SetImage(string id)
```


---

#### SetName (1 of 2)

```csharp
public ShippingMethod SetName(string name)
```

---

#### SetName (2 of 2)

```csharp
public ShippingMethod SetName(string name, string alias)
```


---

#### SetRegionPriceForCurrency (1 of 2)

```csharp
public ShippingMethod SetRegionPriceForCurrency(RegionReadOnly region, CurrencyReadOnly currency, 
    decimal value)
```

---

#### SetRegionPriceForCurrency (2 of 2)

```csharp
public ShippingMethod SetRegionPriceForCurrency(Guid countryId, Guid regionId, Guid currencyId, 
    decimal value)
```


---

#### SetSku

```csharp
public ShippingMethod SetSku(string sku)
```


---

#### SetSortOrder

```csharp
public ShippingMethod SetSortOrder(int sortOrder)
```


---

#### SetTaxClass (1 of 2)

```csharp
public ShippingMethod SetTaxClass(TaxClass taxClass)
```

---

#### SetTaxClass (2 of 2)

```csharp
public ShippingMethod SetTaxClass(Guid? taxClassId)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
