---
description: Learn how to configure the Umbraco Commerce Cart package.
---

# Configuration

The Cart package is configured using a JavaScript, CSS and data attributes based API.

## Initialization

Before adding items to a cart, it is required the the Cart package is first initialized with some default settings. This is done using the `UCC.init` global function which should be executed after the `umbraco-commerce-cart.js` file is loaded.

```javascript
<script src="/App_Plugins/UmbracoCommerceCart/umbraco-commerce-cart.js" defer></script>
<script>
    window.addEventListener('DOMContentLoaded', function() {
        UCC.init({
            store: 'blendid',
            checkoutUrl: '/checkout',
            showPricesIncludingTax: true
        });
    });
</script>
```

The core intialization settings are:

| Key | Description |
| -- | -- |
| `store` | The ID or alias of the store the cart should be associated with. |
| `checkoutUrl` | The URL of the checkout page the cart should redirect to on checkout. |
| `showPricesIncludingTax` | Define whether to show prices inclusive of exclusive of sales TAX. Defaults to `false`. |

Calling the `init` method will also automatically bind any UI elements configured using the following APIs.

## UI Elements

### Add to Cart Buttons

With Umbraco Commerce Cart, products that can be added to a cart are defined by adding attributes to HTML elements on your site. Most likely this will be a "buy" `<button>` element, however, any HTML element can become an add to cart component.

The first step when defining a add to cart component is to add the `ucc-add-to-cart` class to the  element. This informs Umbraco Commerce Cart that it should react to that element's click event.

```html
<button class="ucc-add-to-cart"
  data-ucc-product-reference="828c0bfe-c0e7-4891-a36b-187b658357fc">
  Add to cart
</button>
```

Along with the `ucc-add-to-cart` class we also use a series of data attributes to provide information about the product being added to the cart. At minimum a `data-ucc-product-reference` is required, but the following table outlines all the available configuration options.

| Key | Description |
| -- | -- |
| `data-ucc-product-reference` | The unique reference for the product being added. This is usually the Key of the product Umbraco node. |
| `data-ucc-product-variant-reference` | The unique reference for a variant of the primary product being added. This is usually either a child variant nodes Key or the Key of a complex variant item from the Variants property editor.
| `data-ucc-quantity` | The amount of the given product to be added. |
| `data-ucc-property1-key` | The key of a property to set on the added order line. |
| `data-ucc-property1-value` | The value of a property to set on the added order line. |
| `data-ucc-bundle-reference` | A unique reference to use to mark this item as a bundle. |
| `data-ucc-bundle-item1-product-reference` | The unique reference of a product to add as a bundle item. |
| `data-ucc-bundle-item1-product-variant-reference` | The unique reference of a product variant to add as a bundle item. |
| `data-ucc-bundle-item1-quantity` | The amount of the given product to add as a bundle item. |
| `data-ucc-bundle-item1-property1-key` | The key of a property to set on the added bundle item. |
| `data-ucc-bundle-item1-property1-value` | The value of a property to set on the added bundle item. |

Where an attribute ends with a number, this signifies that this attribute defines a collection and so multiple attributes can be defined with each distinct combination incrementing the number by `1`. It is important that these attributes start from `1` and must be sequential without gaps.

With an add to cart button defined, clicking on the button should now automatically add the given product to the cart and open the cart for display.

![Shopping cart modal.](../media/cart/cart.png)

### Open Cart Button

Whilst the cart will open automatically when an item is added to the cart, it's also likely that you will want the ability for customers to open their carts manually. To do this you can add a `ucc-cart` class to a link or button element and Umbraco Commerce Cart will automatically bind a click event handler to trigger opening the cart.

```html
<a href="#" class="ucc-cart">Cart</a>
```

### Cart Count Label

Another common feature on commerce sites is the ability to display a total number of items in the current cart. To do this you can define a html element with a `ucc-cart-count` class applied and Umbraco Commerce Cart will automatically update it's text value whenever the cart changes.

```html
<a href="#" class="ucc-cart">Cart (<span class="ucc-cart-count">0</span>)</a>
```

## Commands

As well as the automatic API defined above, it is also possible to trigger Umbraco Commerce Cart commands manually via a number of JavaScript functions.

```javascript
// Open the cart
UCC.openCart();

// Close the cart
UCC.closeCart();

// Re-bind UI API elements
UCC.bind();

// Update the store configuration
UCC.setStore('brewed');

// Update the checkout URL
UCC.setCheckoutUrl('/new-checkout');

// Set whether to display prices inclusive of exclusive of sales TAX
UCC.showPricesIncludingTax(true);

// Show a property in the cart
UCC.showProperty('myProp');

// Change the language of the cart UI
UCC.setLang('dk');

// Add or replace a localization dictionary
UCC.addLocale('en', {
   key: 'value',
   ...
});

// Set the error handler
UCC.setOnError(msg => {
    console.log(msg);
});
```

## Localization

The cart UI supports being translated into any language. Out of the box it comes with a default English translation, but additional locales can be configured.

Localization is controlled via the `lang` attribute in the `<html>` tag of your site.

```html
<!DOCTYPE html>
<html lang="fr">
    <head>
        <title></title>
    </head>
    <body></body>
</html>

```

In the above example, Umbraco Commerce Cart will look for a French locale. If a given locale can't be found, then it will default back to English.

Additional locales can be added either via the `UCC.init` method, or by calling the `UCC.addLocale` command.

```javascript
// Init command example
UCC.init({
    store: 'blendid',
    checkoutUrl: '/checkout',
    locales: {
        fr: {
            cart_title: 'Mon Panier',
            close_cart: 'Fermer le panier (ESC)',
            checkout: 'Vérifier',
            taxes: 'Impôts',
            subtotal: 'Total',
            total: 'Total',
            shipping_and_discounts_message: "Calculez les frais d'expédition et appliquez des remises lors du paiement",
            remove: 'Retirer',
            cart_empty: 'Votre panier est vide',
        }
    }
});

// Add locale command example
UCC.addLocale('fr', {
    cart_title: 'Mon Panier',
    close_cart: 'Fermer le panier (ESC)',
    checkout: 'Vérifier',
    taxes: 'Impôts',
    subtotal: 'Total',
    total: 'Total',
    shipping_and_discounts_message: "Calculez les frais d'expédition et appliquez des remises lors du paiement",
    remove: 'Retirer',
    cart_empty: 'Votre panier est vide',
})
```

The default English locale has the following values, and also defines the required keys for a locale.

```javascript
{
    cart_title: 'My Cart',
    close_cart: 'Close Cart (ESC)',
    checkout: 'Checkout',
    taxes: 'Taxes',
    subtotal: 'Subtotal',
    total: 'Total',
    shipping_and_discounts_message: 'Calculate shipping and apply discounts during checkout',
    remove: 'Remove',
    cart_empty: 'Your cart is empty',
}
```

To override a locale you can re-add it reusing the same language key

```javascript
// Init command example
UCC.init({
    store: 'blendid',
    checkoutUrl: '/checkout',
    locales: {
        en: {
            ...UCC.defaultLocales.en, // Clone the default locale
            remove: 'Remove item',    // Update the `remove` key value
        }
    }
});

// Add Locale command example
UCC.addLocale('en', {
    ...UCC.defaultLocales.en, // Clone the default locale
    remove: 'Remove item',    // Update the `remove` key value
})
```

## Displaying Properties

If you capture any custom properties, you may wish to display them within the cart. Displaying properties is achieved in two steps.

We first define the property keys we wish to display either via the `UCC.init` command, or the `UCC.showProperty` command.

```javascript
// Init command example
UCC.init({
    store: 'blendid',
    checkoutUrl: '/checkout',
    properties: [ 'message' ]
});

// Show property command example
UCC.showProperty('message');
```

Next we define a localization key to use as a label for each property.

```javascript
// Init command example
UCC.init({
    store: 'blendid',
    checkoutUrl: '/checkout',
    properties: [ 'message' ],
    locales: {
        en: {
            ...UCC.defaultLocales.en,    // Clone the default locale
            property_message: 'Message', // Provide a key translation prefixed with `property_`
        }
    }
});

// Show property + add locale command example
UCC.showProperty('message');
UCC.addLocale('en', {
    ...UCC.defaultLocales.en,    // Clone the default locale
    property_message: 'Message', // Provide a key translation prefixed with `property_`
})
```

Now when the cart is displayed, the defined properties will be displayed using the localization value as their label.

![Example property](../media/cart/property.png)

## Theming

In order to allow customization of the cart UI, CSS variables are used to allow easy overiding of the default styles.

The following details the default values, and the available keys to override.

```css
:root {
    
    /* Colors */
    --ucc-primary-color: #155dfc;
    --ucc-primary-color-light: #51a2ff;
    --ucc-primary-color-dark: #193cb8;
    --ucc-danger-text-color: #9f0712;
    --ucc-danger-background-color: #ffc9c9;

    /* Font */
    --ucc-font-family: ui-sans-serif, system-ui, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji', sans-serif;
    
    /* Text */
    --ucc-text-color: #364153;
    --ucc-text-color-light: #99a1af;
    --ucc-text-color-lighter: #c1c7d0;
    --ucc-text-color-dark: #101828;
    --ucc-text-lg: 20px;
    --ucc-text-md: 16px;
    --ucc-text-sm: 14px;
    
    /* Borders */
    --ucc-border-color: #ddd;
    --ucc-border-radius: 5px;
    
    /* Components */
    --ucc-button-background-color: var(--ucc-primary-color);
    --ucc-button-text-color: #fff;
    --ucc-button-background-color-hover: var(--ucc-primary-color-dark);
    --ucc-button-text-color-hover: #fff;
    --ucc-button-background-color-disabled: #d1d5dc;
    --ucc-button-text-color-disabled: #fff;
    --ucc-modal-width: 550px;
    --ucc-modal-background-color: #fff;
    --ucc-modal-overlay-color: rgba(0, 0, 0, 0.5);
}
```

Styles can be overridden by including a stylesheet after the Umbraco Commerce Cart stylesheet, replacing the desired keys.

```html
<link href="/App_Plugins/UmbracoCommerceCart/umbraco-commerce-cart.css" rel="stylesheet">
<style>
    :root {
        --ucc-button-background-color: #4FD1C5;
        --ucc-button-background-color-hover: #38B2AC;
    }
</style>
```

## Error Handling

By default Umbraco Commerce Cart will just log any request errors to the console. If you would like to display errors to your users, or handle them differently you can do so by providing an error handler function.

```javascript
// Init command example
UCC.init({
    store: 'blendid',
    checkoutUrl: '/checkout',
    onError: (msg) => console.log(msg)
});

// Set on error command example
UCC.setOnError(msg => console.log(msg));
```