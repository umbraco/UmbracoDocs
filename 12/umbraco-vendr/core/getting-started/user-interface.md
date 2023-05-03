---
title: User Interface
description: The User Interface for Vendr, the eCommerce solution for Umbraco
---

The Vendr user interface reuses a lot of design elements from the existing Umbraco UI in order to bring a level of consistency across the two products. At a basic level though, the Vendr UI consists of a number of key areas, split over  three sections within the Umbraco back-office: 

* **Settings** For managing the various store settings
* **Commerce** For managing store related content (orders, discounts, etc)
* **Content** For managing the Vendr products

## Settings Section

The **Settings** section is where the configuration of all Store settings will take place. From here you can manage how the Store works as well as what options will be available within the Store.

The UI for the **Settings** section consists of a Tree which lists all available Stores and their key areas available for configuration, as well as a right hand editor panel that can either act as an editor interface 

![Vendr Settings - Editor View](../media/vendr_settings_section_editor_view.png)

...or as a list view interface for listing items within that given configuration area.

![Vendr Settings - List View](../media/vendr_settings_section_list_view.png)

Each Store has 8 key areas of configuration accessible within the **Settings** section:

* **Store** The individual Store nodes contain Store level configuration settings.
* **Order Statuses** Contains the configuration of the different Statuses an order can be in. Think of these as an organisational structure for you Orders.
* **Shipping Methods** Contains the list of Shipping Methods available to a Store.
* **Payment Methods** Contains the list of Payment Methods available to a Store.
* **Countries** Contains the list of Countries the Store is able to trade with.
* **Currencies** Contains the list of accepted Currencies for the Store.
* **Taxes** Contains the list of Tax Classes and their Tax Rates for the Store.
* **Email Templates** Contains the list of Email Templates supported by the Store.

## Commerce Section

The **Commerce** section follows much the same structure of the **Settings** section, providing a Tree to access the Stores and their various features, as well as a right hand panel for both listing items and editing them.

![Vendr Orders View](../media/commerce_orders_view.png)

![Vendr Order Editor](../media/commerce_order_details.png)

## Content Section

The **Content** section is where Vendr product nodes are managed and uses the standard Umbraco content editing UI for this. Where Vendr has specific content requirements, it connects with Umbraco via it's various plugin architectures such as via Property Editors. What this means from a UI perspective is that Product management is ultimately regular old Umbraco content management.

![Vendr Store Picker Dialog](../media/content_store_picker.png)
