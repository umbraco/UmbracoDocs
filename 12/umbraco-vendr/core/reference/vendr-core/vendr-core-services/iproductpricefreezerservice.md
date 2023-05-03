---
title: IProductPriceFreezerService
description: API reference for IProductPriceFreezerService in Vendr, the eCommerce solution for Umbraco
---
## IProductPriceFreezerService

Defines the Vendr Product Price Freezer service

```csharp
public interface IProductPriceFreezerService
```

**Namespace**
* [Vendr.Core.Services](../)

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| price | The [`ProductPrice`](../../vendr-core-models/productprice/) to freeze |

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| price | The [`ProductPrice`](../../vendr-core-models/productprice/) to freeze |


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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price |

**Returns**

A frozen [`ProductPrice`](../../vendr-core-models/productprice/)

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price |

**Returns**

A frozen [`ProductPrice`](../../vendr-core-models/productprice/)


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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price to freeze |

**Returns**

A [`ProductPrice`](../../vendr-core-models/productprice/)

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price to freeze |

**Returns**

A [`ProductPrice`](../../vendr-core-models/productprice/)

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price to freeze |
| isFrozen | Boolean indicating if the price returned is a frozen price or not |

**Returns**

A [`ProductPrice`](../../vendr-core-models/productprice/)

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price to freeze |
| isFrozen | Boolean indicating if the price returned is a frozen price or not |

**Returns**

A [`ProductPrice`](../../vendr-core-models/productprice/)


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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price to freeze |

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price to freeze |

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price |

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
| storeId | The ID of the [`Store`](../../vendr-core-models/store/) the price is associated with |
| orderId | The ID of the [`Order`](../../vendr-core-models/order/) the price is associated with |
| productReference | The unique reference of the Product the price is associated with |
| productVariantReference | The unique reference of the Product variant the price is associated with |
| currencyId | The ID of the [`Currency`](../../vendr-core-models/currency/) of the price |


<!-- DO NOT EDIT: generated by xmldocmd for Vendr.Core.dll -->
