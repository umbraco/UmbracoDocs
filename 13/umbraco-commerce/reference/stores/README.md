---
description: Information on Umbraco Commerce Stores
---

# Stores

Stores represent a single shop / commercial entity and contain all the settings a configuration specific to that particular store. They are the root entity from which all other Umbraco Commerce entities are connected. They are also able to be linked to content nodes to connect a store to a site.

## Store Settings

General settings for a store can be accessed via the UI by clicking on a store node in the `Settings > Commerce` section.

### General

```
</tr>
<tr>
  <td>Default Location</td>
  <td>Defines the main location of the store and is used by shipping calculators to work out shipping rates.</td>
</tr>
<tr>
  <td>Default Country</td>
  <td>Defines the default country of the store and is used to set the default payment/shipping country of newly created orders.</td>

</tr>
<tr>
  <td>Default Order Status</td>
  <td>Defines the order status to assign newly created orders to.</td>
</tr>
<tr>
  <td>Error Order Status</td>
  <td>Defines the order status to assign orders to when an error occurs during order processing.</td>

</tr>
<tr>
  <td>Measurement System</td>
  <td>Defines whether to use a Metric or Imperial measurement system when capturing product measurement.</td>

</tr>
<tr>
  <td>Prices Include Tax</td>
  <td>Defines whether all prices entered into the system are inclusive or exclusive of tax.</td>
</tr>
<tr>
  <td>Use Cookies</td>
  <td>Defines whether cookies should be used for tracking a customers current order, allowing them to last between browser sessions.</td>
</tr>
<tr>
  <td>Cookie Timeout</td>
  <td>If using cookies, defines the length of time in minutes the cookie should be persisted for.</td>
</tr>
```

<table><thead><tr><th width="200">Name</th><th>Description</th></tr></thead><tbody><tr><td>Base Currency</td><td>Defines the base currency a store operates in and for which all order values will be converted for the basis of reporting and analytics.</td></tr></tbody></table>

### Notification Settings

<table><thead><tr><th width="200">Name</th><th>Description</th></tr></thead><tbody><tr><td>Confirmation Email</td><td>Defines the email to send to customers when an order is successfully completed.</td></tr><tr><td>Error Email</td><td>Defines the email to send to customers when an error occurs completing their order.</td></tr></tbody></table>

### Order Settings

<table><thead><tr><th width="200">Name</th><th>Description</th></tr></thead><tbody><tr><td>Cart Number Template</td><td>Defines a string formatting template to use when generating a Cart Number, eg: 'CART-{0}'.</td></tr><tr><td>Order Number Template</td><td>Defines a string formatting template to use when generating an Order Number, eg: 'ORDER-{0}'.</td></tr><tr><td>Order Rounding Method</td><td>Defines At what level in the order calculation process prices should be rounded. Can be either `Unit` where prices are rounded at the item level, `Line` where prices are rounded at the order line level after quantity multiplication or `Total` where prices are rounded at the order total level.</td></tr></tbody></table>

### Product Settings

```
</tr>
```

<table><thead><tr><th width="200">Name</th><th>Description</th></tr></thead><tbody><tr><td>Product Property Aliases</td><td>Defines a comma-separated list of property aliases to be copied to the order line when added to the cart. See the [Properties concept documentation](../../key-concepts/properties.md#automatic-properties) for more details.</td></tr><tr><td>Product Uniqueness Property Aliases</td><td>Defines a comma-separated list of property aliases to be used to define product uniqueness. See the [Properties concept documentation](../../key-concepts/properties.md#product-uniqueness-properties) for more details.</td></tr></tbody></table>

### Gift Card Settings

<table><thead><tr><th width="200">Name</th><th>Description</th></tr></thead><tbody><tr><td>Code Length</td><td>Defines the length of a gift card code when auto-generated.</td></tr><tr><td>Code Template</td><td>Defines a string formatting template to use when auto-generating a gift card code, eg: 'GIFTCARD-{0}'.</td></tr><tr><td>Valid For</td><td>Defines the number of days gift cards should be valid for by default.</td></tr><tr><td>Gift Card Property Aliases</td><td>Defines a comma-separated list of property aliases to be copied to the gift card from the order line.</td></tr><tr><td>Activation Method</td><td>Defines the method by which gift cards become active. Can be `Manual` where the store owner must manually active the gift card, `Automatic` where the gift card automatically becomes active after purchase or `Order Status` where the gift card becomes active when the purchase order moves into a specific order status.</td></tr><tr><td>Activation Order Status</td><td>When the activation method is `Order Status`, it defines the order status that activates the gift card.</td></tr><tr><td>Default Gift Card Email</td><td>Defines the email to be sent to customers if an order contains a gift card item.</td></tr></tbody></table>

## Store Configuration

Further store configuration can be achieved by setting up different categories of configuration that can be accessed as child nodes to the store node.

The available configuration options are:

* **Locations** - Defines different locations for a store.
* **Order Statuses** - Defines the order statuses to be used by a store.
* **Shipping Methods** - Defines the different shipping options available in the store. See [Shipping reference documentation](../shipping/) for more details.
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
