---
title: IProductPriceFreezerService
description: API reference for IProductPriceFreezerService in Umbraco Commerce
---
## IProductPriceFreezerService

Defines the Product Price Freezer service

```csharp
public interface IProductPriceFreezerService
```

**Namespace**
* [Umbraco.Commerce.Core.Services](README.md)

### Methods

#### FreezeProductPrice (1 of 2)

Freezes a products price

```csharp
public void FreezeProductPrice(Guid storeId, Guid orderId, string productReference, 
    ProductPrice price)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| price | The [`ProductPrice`](../umbraco-commerce-core-models/productprice.md) to freeze |

---

#### FreezeProductPrice (2 of 2)

Freezes a products price

```csharp
public void FreezeProductPrice(Guid storeId, Guid orderId, string productReference, 
    string productVariantReference, ProductPrice price)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| price | The [`ProductPrice`](../umbraco-commerce-core-models/productprice.md) to freeze |


---

#### GetOrCreateFrozenProductPrice (1 of 2)

Get or creates a frozen price for a given product

```csharp
public ProductPrice GetOrCreateFrozenProductPrice(Guid storeId, Guid orderId, 
    string productReference, Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price |

**Returns**

A frozen [`ProductPrice`](../umbraco-commerce-core-models/productprice.md)

---

#### GetOrCreateFrozenProductPrice (2 of 2)

Get or creates a frozen price for a given product

```csharp
public ProductPrice GetOrCreateFrozenProductPrice(Guid storeId, Guid orderId, 
    string productReference, string productVariantReference, Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price |

**Returns**

A frozen [`ProductPrice`](../umbraco-commerce-core-models/productprice.md)


---

#### GetProductPrice (1 of 4)

Get the price of a product, either frozen if one exists, otherwise direct from the product source

```csharp
public ProductPrice GetProductPrice(Guid storeId, Guid orderId, string productReference, 
    Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price to freeze |

**Returns**

A [`ProductPrice`](../umbraco-commerce-core-models/productprice.md)

---

#### GetProductPrice (2 of 4)

Get the price of a product, either frozen if one exists, otherwise direct from the product source

```csharp
public ProductPrice GetProductPrice(Guid storeId, Guid orderId, string productReference, 
    string productVariantReference, Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price to freeze |

**Returns**

A [`ProductPrice`](../umbraco-commerce-core-models/productprice.md)

---

#### GetProductPrice (3 of 4)

Get the price of a product, either frozen if one exists, otherwise direct from the product source

```csharp
public ProductPrice GetProductPrice(Guid storeId, Guid orderId, string productReference, 
    Guid currencyId, out bool isFrozen)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price to freeze |
| isFrozen | Boolean indicating if the price returned is a frozen price or not |

**Returns**

A [`ProductPrice`](../umbraco-commerce-core-models/productprice.md)

---

#### GetProductPrice (4 of 4)

Get the price of a product, either frozen if one exists, otherwise direct from the product source

```csharp
public ProductPrice GetProductPrice(Guid storeId, Guid orderId, string productReference, 
    string productVariantReference, Guid currencyId, out bool isFrozen)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price to freeze |
| isFrozen | Boolean indicating if the price returned is a frozen price or not |

**Returns**

A [`ProductPrice`](../umbraco-commerce-core-models/productprice.md)


---

#### HasFrozenProductPrice (1 of 2)

Checks to see if there is a frozen product price for the given reference

```csharp
public bool HasFrozenProductPrice(Guid storeId, Guid orderId, string productReference, 
    Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price to freeze |

**Returns**

True if a frozen price exists, otherwise false

---

#### HasFrozenProductPrice (2 of 2)

Checks to see if there is a frozen product price for the given reference

```csharp
public bool HasFrozenProductPrice(Guid storeId, Guid orderId, string productReference, 
    string productVariantReference, Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price to freeze |

**Returns**

True if a frozen price exists, otherwise false


---

#### ThawFrozenProductPrice (1 of 2)

Thaws a frozen price for a given product

```csharp
public void ThawFrozenProductPrice(Guid storeId, Guid orderId, string productReference, 
    Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price |

---

#### ThawFrozenProductPrice (2 of 2)

Thaws a frozen price for a given product

```csharp
public void ThawFrozenProductPrice(Guid storeId, Guid orderId, string productReference, 
    string productVariantReference, Guid currencyId)
```

**Parameters**

| Parameter | Description |
| --- | --- |
| storeId | The ID of the [`Store`](../umbraco-commerce-core-models/store.md) the price is associated with |
| orderId | The ID of the [`Order`](../umbraco-commerce-core-models/order.md) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../umbraco-commerce-core-models/currency.md) of the price |


<!-- DO NOT EDIT: generated by xmldocmd for Umbraco.Commerce.Core.dll -->
