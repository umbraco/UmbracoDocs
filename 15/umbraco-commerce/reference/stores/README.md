---
description: Information on Umbraco Commerce Stores
---

# Stores

Stores represent a single shop / commercial entity and contain all the settings a configuration specific to that particular store. They are the root entity from which all other Umbraco Commerce entities are connected. They are also able to be linked to content nodes to connect a store to a site.

## Store Settings

General settings for a store can be accessed via the UI by clicking on a store node in the `Settings > Commerce` section.

### General

| Name | Description |
| -- | -- |
| Base Currency | Defines the base currency a store operates in and for which all order values will be converted for the basis of reporting and analytics. |
| Default Location | Defines the main location of the store and is used by shipping calculators to work out shipping rates. |
| Default Country | Defines the default country of the store and is used to set the default payment/shipping country of newly created orders. |
| Default Order Status | Defines the order status to assign newly created orders to. |
| Error Order Status | Defines the order status to assign orders to when an error occurs during order processing. |
| Measurement System | Defines whether to use a Metric or Imperial measurement system when capturing product measurement. |
| Prices Include Tax | Defines whether all prices entered into the system are inclusive or exclusive of tax. |
| Use Cookies | Defines whether cookies should be used for tracking a customer's current order, allowing them to last between browser sessions. |
| Cookie Timeout | If using cookies, define the length of time in minutes the cookie should be persisted for. |

### Notification Settings

| Name | Description |
| -- | -- |
| Confirmation Email | Defines the email to send to customers when an order is successfully completed. |
| Error Email | Defines the email to send to customers when an error occurs when completing their order. |

### Order Settings

| Name | Description |
| -- | -- |
| Cart Number Template | Defines a string formatting template to use when generating a Cart Number, eg: 'CART-{0}'. |
| Order Number Template | Defines a string formatting template to use when generating an Order Number, eg: 'ORDER-{0}'. |
| Order Rounding Method | Defines At what level in the order calculation process prices should be rounded. Can be either `Unit` where prices are rounded at the item level, `Line` where prices are rounded at the order line level after quantity multiplication or `Total` where prices are rounded at the order total level. |

### Product Settings

| Name | Description |
| -- | -- |
| Product Property Aliases | Defines a comma-separated list of property aliases to be copied to the order line when added to the cart. For more details, see the [Automatic Properties](../../key-concepts/properties.md#automatic-properties) section. |
| Product Uniqueness Property Aliases | Defines a comma-separated list of property aliases to be used to define product uniqueness. For more details, see the [Product Uniqueness Properties](../../key-concepts/properties.md#product-uniqueness-properties) section. |

### Gift Card Settings

| Name | Description |
| -- | -- |
| Code Length | Defines the length of a gift card code when auto-generated. |
| Code Template | Defines a string formatting template to use when auto-generating a gift card code, eg: 'GIFTCARD-{0}'. |
| Valid For | Defines the number of days gift cards should be valid for by default. |
| Gift Card Property Aliases | Defines a comma-separated list of property aliases to be copied to the gift card from the order line. |
| Activation Method | Defines the method by which gift cards become active. Can be `Manual` where the store owner must manually active the gift card, `Automatic` where the gift card automatically becomes active after purchase or `Order Status` where the gift card becomes active when the purchase order moves into a specific order status. |
| Activation Order Status | When the activation method is `Order Status`, it defines the order status that activates the gift card. |
| Default Gift Card Email | Defines the email to be sent to customers if an order contains a gift card item. |

## Store Configuration

Further store configuration can be achieved by setting up different categories of configuration that can be accessed as child nodes to the store node.

The available configuration options are:

* **Locations** - Defines different locations for a store. See [Locations reference documentation](../locations/README.md) for more details.
* **Order Statuses** - Defines the order statuses to be used by a store.
* **Shipping Methods** - Defines the different shipping options available in the store. See [Shipping reference documentation](../shipping/README.md) for more details.
* **Payment Methods** - Defines the different payment options available in the store.
* **Countries** - Defines the different shipping countries supported by the store.
* **Currencies** - Defines the different currencies accepted by the store.
* **Taxes** - Defines the different rates supported by the store.
* **Templating** - Defines the different email, print, and export templates available to the store.

## Store Permissions

When editing a store, the permissions app allows you to control who can access the store management interface. The options are:

* **User Groups** - A set of toggles to allow/deny access to members of a particular user group.
* **Users** - A set of toggles to allow/deny access to explicit individuals.

In both cases, a positive access control will always override a deny control setting.

Once a user has access to the Commerce section, they also need access to the specific **store** they need to manage. This permission needs to be granted here in the Permissions Workspace View when configuring a Store.

## Further information

* Information on [configuration](../umbraco-commerce/getting-started/umbraco-configuration)
* Accessing store [permissions](../umbraco-commerce/tutorials/getting-started-with-commerce#accessing-store-permissions-in-umbraco-commerce)
