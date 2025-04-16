---
description: Get started with the Storefront API.
---

# Storefront API

The Storefront API delivers headless capabilities built directly into Umbraco Commerce. It allows you to retrieve and manage orders and other store-related entities in a JSON format. It lets you connect with them in different channels, using your preferred technology stack. This feature preserves the friendly editing experience of Umbraco, while also ensuring performant cart management facilities in a headless fashion. With its different extension points, you can tailor this API to fit a broad range of requirements.

## Getting Started

As the Storefront API works alongside the Content Delivery API you must first have the [Content Delivery API setup and enabled](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#register-the-content-delivery-api-dependencies).

When the Content Delivery API is enabled, you will need to explicitly opt-in to the Storefront API. Below you will find the steps you need to take in order to configure it for your Umbraco project.

### Register the Storefront API dependencies

1. Open your project's `Program.cs` file.
2. Register the API dependencies by adding `.AddStorefrontApi()` inside a `.AddUmbracoCommerce()` call:

{% code title="Program.cs" %}
```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddUmbracoCommerce(builder => {
            builder.AddStorefrontApi();
    })
    .AddComposers()
    .Build();
```
{% endcode %}

### Enable the Storefront API

1. Open your project's `appsettings.json`.
2. Insert the `StorefrontApi` configuration section under `Umbraco:Commerce`.
3. Add the `Enabled` key and set its value to `true`:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "Commerce": {
            "StorefrontApi": {
                "Enabled": true
            }
        }
    }
}
```
{% endcode %}

### Securing the Storefront API

In order to work with the Storefront API many of the endpoints require authorization. The authorization is implemented by means of an API Key that must be passed in the header of these requests. The API Key is defined as an additional app setting and can be any value you decide:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "Commerce": {
            "StorefrontApi": {
                "Enabled": true,
                "ApiKey": "ZUynC149dD2N5efs6HN6dCdXlgOVASs6"
            }
        }
    }
}
```
{% endcode %}

## Concepts

Before exploring the API endpoints detailed below, there are a few concepts to keep in mind.

<details>

<summary>Session</summary>

When working with Umbraco Commerce's C# Api, Umbraco Commerce will normally keep track of a series of items for you. This could be the current Order ID or the current Language, which it tracks in a cookie. When working in a headless manner however we can no longer rely on cookies for this behavior. It becomes the implementor's responsibility to remember these items and pass them as Headers to the endpoints that need to use them for context.

The following is a list of supported headers used for session management:

* `Store` - The ID or Alias of the store the given operation is being performed against.
* `Current-Order` - The ID of any current "in-progress" order.
* `Customer-Reference` - A unique reference for the current customer.
* `Accept-Language` - The ISO Culture Code of the current front-end language.
* `Currency` - The ID or ISO Code of the current currency. If not supplied, will fall back to the default currency of the default country defined on the store.
* `Tax-Class` - The ID or Alias of the default tax class. If not supplied, will fall back to the default defined on the store.
* `Billing-Country` - The ID or ISO Code of the default billing country. If not supplied, falls back to the default country defined on the store.
* `Billing-Region` - The ID or ISO Code of the default billing region.
* `Shipping-Country` - The ID or ISO Code of the default shipping country. If not supplied, falls back to either the supplied billing country or the default country defined on the store.
* `Shipping-Region` - The ID or ISO Code of the default billing region.

</details>

<details>

<summary>Expansion</summary>

**Expansion** allows you to retrive additional data about related entities in the API output for a given resource.

By default, where a resource is connected with another resource, such as an Order holding a reference to it's Currency, the Storefront API will return those connected resources as "Reference" objects which usually only contain the resources ID and Alias/Code.

```json
{
    "cartNumber": "CART-01280-054677-RP4L9",
    "createDate": "2023-07-03T15:11:17.9220005",
    "currency": {
        "$type": "CurrencyRef",
        "code": "GBP",
        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
    },
    "customerInfo": { ... },
    "discountCodes": [],
    ...
}
```

Should you wish to retrieve the connected resource, you could perform an additional get operation against that resources own endpoint, however this could result in multiple wasteful network requests. To help with this, you can pass an `expand` query parameter with a path to properties you wish to expand, which for those targeted properties will return the full resource object instead of the reference entity.

**Request**

```http
GET /umbraco/commerce/storefront/api/v1/order/af697207-d370-4aee-824c-15711d43a9f2?expand=currency
```

**Response**

```json
{
    "cartNumber": "CART-01280-054677-RP4L9",
    "createDate": "2023-07-03T15:11:17.9220005",
    "currency": {
        "$type": "Currency",
        "allowedCountries": [
            {
                "country": {
                    "$type": "CountryRef",
                    "code": "GB",
                    "id": "af697207-d370-4aee-824c-15711d43a9f2"
                }
            }
        ],
        "code": "GBP",
        "culture": "en-GB",
        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a",
        "name": "GBP"
    },
    "customerInfo": { ... },
    "discountCodes": [],
    ...
}
```

The `expand` query parameter can accept a comma seperated list of property keys to expand for properties at the same level, and can also expand nested objects using a `[...]` syntax. In the following example we retrieve a Country entity, expanding it's `defaultCurrency` and `defaultPaymentMethod` whilst at the same time expanding the `allowedCountries.country` properties within the `defaultCurrency`.

```http
GET /umbraco/commerce/storefront/api/v1.0/country/GB?expand=defaultCurrency[allowedCountries[country]],defaultPaymentMethod
```

**Response**

```json
{
    "code": "GB",
    "defaultCurrency": {
        "$type": "Currency",
        "allowedCountries": [
            {
                "country": {
                    "$type": "Country",
                    "code": "GB",
                    "defaultCurrency": {
                        "$type": "CurrencyRef",
                        "code": "GBP",
                        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
                    },
                    "defaultPaymentMethod": {
                        "$type": "PaymentMethodRef",
                        "alias": "invoicing",
                        "id": "e35677ac-a544-45a0-ba4a-a78dd43dbaf2"
                    },
                    "defaultShippingMethod": {
                        "$type": "ShippingMethodRef",
                        "alias": "pickup",
                        "id": "2ecb73ed-1b13-4ca4-8502-c1c4a8df533d"
                    },
                    "id": "af697207-d370-4aee-824c-15711d43a9f2",
                    "name": "United Kingdom"
                }
            }
        ],
        "code": "GBP",
        "culture": "en-GB",
        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a",
        "name": "GBP"
    },
    "defaultPaymentMethod": {
        "$type": "PaymentMethod",
        "alias": "invoicing",
        "id": "e35677ac-a544-45a0-ba4a-a78dd43dbaf2",
        "imageUrl": "https://localhost:44313/media/k4apjvbo/logo.png",
        "name": "Invoicing",
        "sku": "4815"
    },
    "defaultShippingMethod": {
        "$type": "ShippingMethodRef",
        "alias": "pickup",
        "id": "2ecb73ed-1b13-4ca4-8502-c1c4a8df533d"
    },
    "id": "af697207-d370-4aee-824c-15711d43a9f2",
    "name": "United Kingdom"
}
```

#### Shortcuts

As well as expanding explicit properties, the Storefront API supports shortcut expansion keys that when passed will expand all entities of a given type. Shortcut keys are idenfitied by a `$` prefix. There is currently only one supported shortcut key which is `$prices`.

**$prices**

Prices in Umbraco Commerce can contain a lot of meta data, such as listing applied discounts/adjustments and all values including or excluding those discounts. These are useful when displaying a full order breakdown, but when only needing to present an orders total value, are not necesarry. By default, the Storefront API will only return the final `value` property of a price object, but should you wish to receive this full pricing breakdown you can pass the `$prices` shortcut key to expand all price values to include this extra meta data.

**Request**

```http
GET /umbraco/commerce/storefront/api/v1/order/af697207-d370-4aee-824c-15711d43a9f2?expand=$prices
```

**Response**

```json
{
    ...
    "totalPrice": {
        "previousAdjustments": {
            "currency": {
                "$type": "CurrencyRef",
                "code": "GBP",
                "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
            },
            "formatted": {
                "tax": "-£0.45",
                "withTax": "-£2.60",
                "withoutTax": "-£2.15"
            },
            "tax": -0.45,
            "withTax": -2.60,
            "withoutTax": -2.15
        },
        "totalAdjustment": {
            "currency": {
                "$type": "CurrencyRef",
                "code": "GBP",
                "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
            },
            "formatted": {
                "tax": "-£0.45",
                "withTax": "-£2.60",
                "withoutTax": "-£2.15"
            },
            "tax": -0.45,
            "withTax": -2.60,
            "withoutTax": -2.15
        },
        "value": {
            "currency": {
                "$type": "CurrencyRef",
                "code": "GBP",
                "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
            },
            "formatted": {
                "tax": "£5.80",
                "withTax": "£33.40",
                "withoutTax": "£27.60"
            },
            "tax": 5.80,
            "withTax": 33.40,
            "withoutTax": 27.60
        },
        "withPreviousAdjustments": {
            "currency": {
                "$type": "CurrencyRef",
                "code": "GBP",
                "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
            },
            "formatted": {
                "tax": "£5.80",
                "withTax": "£33.40",
                "withoutTax": "£27.60"
            },
            "tax": 5.80,
            "withTax": 33.40,
            "withoutTax": 27.60
        }
    },
    ...
}
```

</details>

<details>

<summary>Fields</summary>

A common pitfall of REST APIs is the problem of over-fetching, which is where an endpoint returns more information than you need. The Storefront API supports the passing of `fields` which allows you to define exactly which properties of an object you wish to return. This will reduce the payload size.

For example, when implementing a cart count feature to show the total number of items in a shopping cart, rather than fetching an entire order for a single `totalQuantity` field, we can return only that field:

**Request**

```http
GET /umbraco/commerce/storefront/api/v1/order/af697207-d370-4aee-824c-15711d43a9f2
```

**Response**

```json
{
    "cartNumber": "CART-01280-054677-RP4L9",
    "createDate": "2023-07-03T15:11:17.9220005",
    "currency": {
        "$type": "CurrencyRef",
        "code": "GBP",
        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
    },
    "finalizedDate": "2023-07-04T10:25:37.1471415",
    "id": "832b2f79-915c-49dd-a20a-01891c4edd7c",
    "isFinalized": true,
    "languageIsoCode": "en-GB",
    "orderLines": [
        {
            "basePrice": {
                "value": {
                    "currency": {
                        "$type": "CurrencyRef",
                        "code": "GBP",
                        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
                    },
                    "formatted": {
                        "tax": "£4.51",
                        "withTax": "£26.00",
                        "withoutTax": "£21.49"
                    },
                    "tax": 4.51,
                    "withTax": 26.00,
                    "withoutTax": 21.49
                }
            },
            "id": "e9ec1305-1844-4a72-a343-01891c4f09d8",
            "name": "Good and Proper - Breakfast Tea Set",
            "properties": {
                "giftMessage": "Hey Tom, found this and thought you'd love it."
            },
            "quantity": 1,
            "sku": "GP002",
            "taxRate": 0.21,
            "totalPrice": {
                "value": {
                    "currency": {
                        "$type": "CurrencyRef",
                        "code": "GBP",
                        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
                    },
                    "formatted": {
                        "tax": "£4.51",
                        "withTax": "£26.00",
                        "withoutTax": "£21.49"
                    },
                    "tax": 4.51,
                    "withTax": 26.00,
                    "withoutTax": 21.49
                }
            },
            "unitPrice": {
                "value": {
                    "currency": {
                        "$type": "CurrencyRef",
                        "code": "GBP",
                        "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
                    },
                    "formatted": {
                        "tax": "£4.51",
                        "withTax": "£26.00",
                        "withoutTax": "£21.49"
                    },
                    "tax": 4.51,
                    "withTax": 26.00,
                    "withoutTax": 21.49
                }
            }
        }
    ],
    "orderStatus": {
        "$type": "OrderStatusRef",
        "alias": "new",
        "id": "37cd2c8f-48d8-4416-bb37-b2c7d7bb992f"
    },
    "subtotalPrice": {
        "value": {
            "currency": {
                "$type": "CurrencyRef",
                "code": "GBP",
                "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
            },
            "formatted": {
                "tax": "£4.06",
                "withTax": "£23.40",
                "withoutTax": "£19.34"
            },
            "tax": 4.06,
            "withTax": 23.40,
            "withoutTax": 19.34
        }
    },
    "taxClass": {
        "$type": "TaxClassRef",
        "alias": "standard",
        "id": "17a2eca0-d21f-462a-8915-8b2606661efd"
    },
    "totalPrice": {
        "value": {
            "currency": {
                "$type": "CurrencyRef",
                "code": "GBP",
                "id": "30b62176-6a9e-4a51-b2f0-7ce6c80a461a"
            },
            "formatted": {
                "tax": "£5.80",
                "withTax": "£33.40",
                "withoutTax": "£27.60"
            },
            "tax": 5.80,
            "withTax": 33.40,
            "withoutTax": 27.60
        }
    },
    "totalQuantity": 1,
    "updateDate": "2023-07-06T14:20:26.1939545"
}
```

We can pass a `fields` query parameter to limit the response to only return that field we are interested in:

**Request**

```http
GET /umbraco/commerce/storefront/api/v1/order/af697207-d370-4aee-824c-15711d43a9f2?fields=totalQuantity
```

**Response**

```json
{
    "id": "832b2f79-915c-49dd-a20a-01891c4edd7c",
    "totalQuantity": 1
}
```

When using the `fields` query parameter to limit fields returned, `id` properties will always be included.

Inline with the expansion feature, the `fields` paramter can also retrieve multiple fields, and nested fields using comma seperate values and the `[...]` syntax.

**Request**

```http
GET /umbraco/commerce/storefront/api/v1/order/af697207-d370-4aee-824c-15711d43a9f2?fields=totalQuantity,orderLines[sku,quantity]
```

**Response**

```json
{
    "id": "832b2f79-915c-49dd-a20a-01891c4edd7c",
    "orderLines": [
        {
            "id": "e9ec1305-1844-4a72-a343-01891c4f09d8",
            "quantity": 1,
            "sku": "GP002"
        }
    ],
    "totalQuantity": 1
}
```

</details>

## Endpoints

The Storefront API is broken down into a number of endpoints grouped by resource type. Select a resource type below to review the available endpoints.

{% content-ref url="endpoints/order.md" %}
[order.md](endpoints/order.md)
{% endcontent-ref %}

{% content-ref url="endpoints/checkout.md" %}
[checkout.md](endpoints/checkout.md)
{% endcontent-ref %}

{% content-ref url="endpoints/product.md" %}
[product.md](endpoints/product.md)
{% endcontent-ref %}

{% content-ref url="endpoints/customer.md" %}
[customer.md](endpoints/customer.md)
{% endcontent-ref %}

{% content-ref url="endpoints/store.md" %}
[store.md](endpoints/store.md)
{% endcontent-ref %}

{% content-ref url="endpoints/currency.md" %}
[currency.md](endpoints/currency.md)
{% endcontent-ref %}

{% content-ref url="endpoints/country.md" %}
[country.md](endpoints/country.md)
{% endcontent-ref %}

{% content-ref url="endpoints/payment-method.md" %}
[payment-method.md](endpoints/payment-method.md)
{% endcontent-ref %}

{% content-ref url="endpoints/shipping-method.md" %}
[shipping-method.md](endpoints/shipping-method.md)
{% endcontent-ref %}

{% content-ref url="endpoints/content.md" %}
[content.md](endpoints/content.md)
{% endcontent-ref %}

## Swagger UI

You can access a Swagger document for the Storefront API at `{yourdomain}/umbraco/swagger`, selecting `Umbraco Commerce Storefront API` from the definitions dropdown in the top right. From here you can see a full list of supported APIs, the parameters they accept and the expected payloads and responses.

![Storefront API Swagger](../../media/uc\_storefront\_api\_swagger.png)

## Value Converters

As Umbraco Commerce uses content nodes as products, the Storefront API comes with some replacement value converters that automatically extend the default value converter functionality to return Storefront entities when accessed through the Content Delivery API. You don't need to do anything to enable these.

* **Store Picker** - Returns a Store "Reference" by default, or a complete Store response object if the store picker property is being expanded.
* **Store Entity Picker** - Returns an entity "Reference" by default, or a complete entity response object if the store entity picker property is being expanded.
* **Price** - Returns a price for the product based on session information passed through in headers. See the ["Session" concept detailed above](./#concepts).
* **Stock** - Returns the stock level of the given product.
* **Variants** - See notes on the [variants value converter](./#variants-value-converter) below.

### Variants Value Converter

To help with common scenarios when working with variants, the Variants value converter will return a series of data items used when building a relevant UI.

```json
{
    attributes: [
        {
            alias: "color",
            name: "Color",
            values: [
                {
                    alias: "red",
                    name: "Red"
                },
                {
                    alias: "blue",
                    name: "Blue"
                }
            ]
        },
        {
            alias: "size",
            name: "Size",
            values: [
                {
                    alias: "md",
                    name: "Medium"
                },
                {
                    alias: "lg",
                    name: "Large"
                }
            ]
        }
    ],
    items: [
        {
            attributes: {
                color: red,
                size: md
            },
            isDefault: true,
            content: { }
        },
        {
            attributes: {
                color: blue,
                size: lg
            },
            isDefault: false,
            content: { }
        }
    ],
    variantContentUrl: "https://{your_domain}/umbraco/delivery/api/v1/content/item/8df5c8bd-b524-4513-805a-c119fc8090e3/variant"
}
```

* `attributes` will contain a list of "in use" attributes which means there is at least one variant content item that makes use of that attribute. These should be used to build the attribute options UI.
* `items` returns a list of variant items. By default, this will return the attribute combinations, and whether it is the default combination but its content value will be empty. The content value can be populated by expanding the variants property through the Delivery API, however, it's important to know this could return a lot of data and be intensive. Instead, it is preferred to return the non-expanded value and use the `variantContentUrl` to fetch individual content items as they are requested. The `items` collection should also be used to check if a combination exists as whilst the root level `attributes` collection contains all in-use attributes, it doesn't mean every possible combination of those attributes exists so you can use the `items` collection to validate a combination.
* `variantContentUrl` as the URL to a specialized Delivery API route that can return a single variant item content based on a passed-in attribute combination.
