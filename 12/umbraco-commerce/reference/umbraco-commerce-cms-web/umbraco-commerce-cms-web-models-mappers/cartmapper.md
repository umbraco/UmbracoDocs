---
title: CartMapper
description: API reference for CartMapper in Umbraco Commerce
---
## CartMapper

```csharp
public static class CartMapper
```

**Namespace**
* [Umbraco.Commerce.Cms.Web.Models.Mappers](README.md)

### Methods

#### CartEntitiesToBasicDtos

```csharp
public static IEnumerable<CartBasicDto> CartEntitiesToBasicDtos(IEnumerable<OrderReadOnly> entities)
```


---

#### CartEntityToBasicDto

```csharp
public static CartBasicDto CartEntityToBasicDto(OrderReadOnly entity, CartBasicDto dto = null)
```


---

#### CartEntityToEditDto

```csharp
public static CartEditDto CartEntityToEditDto(OrderReadOnly entity, CurrencyBasicDto currency, 
    PaymentMethodBasicDto paymentMethod, CountryBasicDto paymentCountry, 
    RegionBasicDto paymentRegion, ShippingMethodBasicDto shippingMethod, 
    CountryBasicDto shippingCountry, RegionBasicDto shippingRegion, CartEditDto dto = null)
```


---

#### CartSaveDtoToEntity

```csharp
public static Order CartSaveDtoToEntity(CartSaveDto dto, Order entity)
```


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Cms.Web.dll -->
