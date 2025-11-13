---
description: Hooking into validation events within Umbraco Commerce.
---

# List of Validation Events

## Umbraco.Commerce.Core.Events.Validation

### Order Payment Events

| **Event** | **Description** |
|---|---|
| ValidateCancelOrderPayment | Triggered to validate the cancellation of an order payment. Developers can use this event to enforce rules or validations related to the cancellation process, ensuring it meets specified criteria or conditions. |
| ValidateCaptureOrderPayment | Triggered to validate the capture of an order payment. Developers can use this event to enforce rules or validations related to the payment capture process, ensuring it meets specified criteria or conditions. |

### Country Payment Events

| **Event** | **Description** |
|---|---|
| ValidateCountryCodeChange | Triggered to validate changes to the country code. Developers can use this event to enforce rules or validations related to the modification of country codes, ensuring adherence to specified standards or requirements. |
| ValidateCountryCreate | Triggered to validate the creation of a new country entry. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateCountryDefaultCurrencyChange | Triggered to validate changes to the default currency of a country. Developers can use this event to enforce rules or validations related to default currency changes for countries, ensuring proper configuration and management. |
| ValidateCountryDefaultPaymentMethodChange | Triggered to validate changes to the default payment method of a country. Developers can use this event to enforce rules or validations related to default payment method changes for countries, ensuring proper configuration and management. |
| ValidateCountryDefaultShippingMethodChange | Triggered to validate changes to the default shipping method of a country. Developers can use this event to enforce rules or validations related to default shipping method changes for countries, ensuring proper configuration and management. |
| ValidateCountryDelete | Triggered to validate the deletion of a country entry. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateCountryNameChange | Triggered to validate changes to the name of a country. Developers can use this event to enforce rules or validations related to the modification of country names, ensuring clarity and consistency in country identification. |
| ValidateCountrySave | Triggered to validate the saving of changes to a country entry. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateCountryUpdate | Triggered to validate updates to a country entry. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Currency Payment Events

| **Event** | **Description** |
|---|---|
| ValidateCurrencyAllowInCountry | Triggered to validate allowing a currency in a specific country. Developers can use this event to enforce rules or validations related to currency permissions in countries, ensuring proper configuration and management. |
| ValidateCurrencyCodeChange | Triggered to validate changes to the currency code. Developers can use this event to enforce rules or validations related to the modification of currency codes, ensuring adherence to specified standards or requirements. |
| ValidateCurrencyCreate | Triggered to validate the creation of a new currency. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateCurrencyCultureChange | Triggered to validate changes to the culture associated with a currency. Developers can use this event to enforce rules or validations related to currency culture changes, ensuring consistency and compatibility within the system. |
| ValidateCurrencyCustomFormatTemplateChange | Triggered to validate changes to the custom format template of a currency. Developers can use this event to enforce rules or validations related to custom formatting changes for currencies, ensuring adherence to specified templates or standards. |
| ValidateCurrencyDelete | Triggered to validate the deletion of a currency. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateCurrencyDisallowInCountry | Triggered to validate disallowing a currency in a specific country. Developers can use this event to enforce rules or validations related to currency permissions in countries, ensuring proper configuration and management. |
| ValidateCurrencyNameChange | Triggered to validate changes to the name of a currency. Developers can use this event to enforce rules or validations related to the modification of currency names, ensuring clarity and consistency in currency identification. |
| ValidateCurrencySave | Triggered to validate the saving of changes to a currency. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateCurrencyUpdate | Triggered to validate updates to a currency. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Discount Payment Events

| **Event** | **Description** |
|---|---|
| ValidateDiscountActiveChange | Triggered to validate changes to the active status of a discount. Developers can use this event to enforce rules or validations related to the activation or deactivation of discounts, ensuring consistency and adherence to business rules. |
| ValidateDiscountAliasChange | Triggered to validate changes to the alias of a discount. Developers can use this event to enforce rules or validations related to the modification of discount aliases, ensuring clarity and consistency in identification. |
| ValidateDiscountCodeAdd | Triggered to validate the addition of a discount code. Developers can use this event to enforce rules or validations related to the addition process, ensuring codes meet specified criteria or conditions. |
| ValidateDiscountCodeChange | Triggered to validate changes to a discount code. Developers can use this event to enforce rules or validations related to the modification of discount codes, ensuring adherence to specified standards or requirements. |
| ValidateDiscountCodeRemove | Triggered to validate the removal of a discount code. Developers can use this event to enforce rules or validations related to the removal process, ensuring it meets specified criteria or conditions. |
| ValidateDiscountCreate | Triggered to validate the creation of a new discount. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateDiscountDateRangeChange | Triggered to validate changes to the date range of a discount. Developers can use this event to enforce rules or validations related to date range changes for discounts, ensuring proper configuration and management. |
| ValidateDiscountDelete | Triggered to validate the deletion of a discount. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateDiscountNameChange | Triggered to validate changes to the name of a discount. Developers can use this event to enforce rules or validations related to the modification of discount names, ensuring clarity and consistency in identification. |
| ValidateDiscountRewardsChange | Triggered to validate changes to the rewards associated with a discount. Developers can use this event to enforce rules or validations related to reward changes for discounts, ensuring adherence to specified rules or conditions. |
| ValidateDiscountRulesChange | Triggered to validate changes to the rules associated with a discount. Developers can use this event to enforce rules or validations related to rule changes for discounts, ensuring adherence to specified rules or conditions. |
| ValidateDiscountSave | Triggered to validate the saving of changes to a discount. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateDiscountTypeChange | Triggered to validate changes to the type of a discount. Developers can use this event to enforce rules or validations related to discount type changes, ensuring consistency and adherence to business rules. |
| ValidateDiscountUpdate | Triggered to validate updates to a discount. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Email Template Payment Events

| **Event** | **Description** |
|---|---|
| ValidateEmailTemplateAliasChange | Triggered to validate changes to the alias of an email template. Developers can use this event to enforce rules or validations related to the modification of email template aliases, ensuring clarity and consistency in identification. |
| ValidateEmailTemplateBccAddressChange | Triggered to validate changes to the Blind Carbon Copy (BCC) addresses of an email template. Developers can use this event to enforce rules or validations related to BCC address changes for email templates, ensuring proper configuration and management. |
| ValidateEmailTemplateCategoryChange | Triggered to validate changes to the category of an email template. Developers can use this event to enforce rules or validations related to category changes for email templates, ensuring proper categorization and organization. |
| ValidateEmailTemplateCcAddressChange | Triggered to validate changes to the Carbon Copy (CC) addresses of an email template. Developers can use this event to enforce rules or validations related to CC address changes for email templates, ensuring proper configuration and management. |
| ValidateEmailTemplateCreate | Triggered to validate the creation of a new email template. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateEmailTemplateDelete | Triggered to validate the deletion of an email template. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions.  |
| ValidateEmailTemplateNameChange | Triggered to validate changes to the name of an email template. Developers can use this event to enforce rules or validations related to the modification of email template names, ensuring clarity and consistency in identification. |
| ValidateEmailTemplateReplyToAddressChange | Triggered to validate changes to the reply-to address of an email template. Developers can use this event to enforce rules or validations related to reply-to address changes for email templates, ensuring proper configuration and management. |
| ValidateEmailTemplateSave | Triggered to validate the saving of changes to an email template. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateEmailTemplateSenderChange | Triggered to validate changes to the sender of an email template. Developers can use this event to enforce rules or validations related to sender changes for email templates, ensuring proper configuration and management. |
| ValidateEmailTemplateSendToCustomerChange | Triggered to validate changes to the recipient (send-to) settings of an email template. Developers can use this event to enforce rules or validations related to recipient changes for email templates, ensuring proper configuration and management. |
| ValidateEmailTemplateSubjectChange | Triggered to validate changes to the subject of an email template. Developers can use this event to enforce rules or validations related to subject changes for email templates, ensuring clarity and consistency in communication. |
| ValidateEmailTemplateToAddressChange | Triggered to validate changes to the TO addresses of an email template. Developers can use this event to enforce rules or validations related to TO address changes for email templates, ensuring proper configuration and management. |
| ValidateEmailTemplateUpdate | Triggered to validate updates to an email template. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidateEmailTemplateViewChange | Triggered to validate changes to the view settings of an email template. Developers can use this event to enforce rules or validations related to view changes for email templates, ensuring proper configuration and management. |

### Export Template Payment Events

| **Event** | **Description** |
|---|---|
| ValidateExportTemplateAliasChange | Triggered to validate changes to the alias of an export template. Developers can use this event to enforce rules or validations related to the modification of export template aliases, ensuring clarity and consistency in identification. |
| ValidateExportTemplateCategoryChange | Triggered to validate changes to the category of an export template. Developers can use this event to enforce rules or validations related to category changes for export templates, ensuring proper categorization and organization. |
| ValidateExportTemplateCreate | Triggered to validate the creation of a new export template. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateExportTemplateDelete | Triggered to validate the deletion of an export template. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateExportTemplateExportStrategyChange | Triggered to validate changes to the export strategy of an export template. Developers can use this event to enforce rules or validations related to export strategy changes for export templates, ensuring proper configuration and management. |
| ValidateExportTemplateFileExtensionChange | Triggered to validate changes to the file extension of an export template. Developers can use this event to enforce rules or validations related to file extension changes for export templates, ensuring proper configuration and management. |
| ValidateExportTemplateFileMimeTypeChange | Triggered to validate changes to the file Multipurpose Internet Mail Extensions (MIME) type of an export template. Developers can use this event to enforce rules or validations related to file MIME type changes for export templates, ensuring proper configuration and management. |
| ValidateExportTemplateNameChange |Triggered to validate changes to the name of an export template. Developers can use this event to enforce rules or validations related to the modification of export template names, ensuring clarity and consistency in identification.  |
| ValidateExportTemplateSave | Triggered to validate the saving of changes to an export template. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic.  |
| ValidateExportTemplateUpdate | Triggered to validate updates to an export template. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic.  |
| ValidateExportTemplateViewChange | Triggered to validate changes to the view settings of an export template. Developers can use this event to enforce rules or validations related to view changes for export templates, ensuring proper configuration and management. |

### Fetch Order Payment Events

| **Event** | **Description** |
|---|---|
| ValidateFetchOrderPaymentStatus | Triggered to validate the process of fetching the payment status of an order. Developers can use this event to enforce rules or validations related to how payment statuses are retrieved and handled for orders. |

### Gift Card Events

| **Event** | **Description** |
|---|---|
| ValidateGiftCardActiveChange | Triggered to validate changes to the active status of a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card activation, ensuring proper control and management of gift card statuses. |
| ValidateGiftCardAmountsChange | Triggered to validate changes to the amounts associated with a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card amounts, ensuring accuracy and consistency in financial transactions involving gift cards. |
| ValidateGiftCardCodeChange | Triggered to validate changes to the code (identifier) of a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card codes, ensuring uniqueness and integrity of gift card identifiers. |
| ValidateGiftCardCreate | Triggered to validate the creation of a new gift card. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateGiftCardCurrencyChange | Triggered to validate changes to the currency associated with a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card currencies, ensuring compatibility and accuracy in financial transactions involving different currencies. |
| ValidateGiftCardDelete | Triggered to validate the deletion of a gift card. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateGiftCardExpiryDateChange | Triggered to validate changes to the expiry date of a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card expiry dates, ensuring proper management and utilization of gift card validity periods. |
| ValidateGiftCardOrderChange | Triggered to validate changes to the order associated with a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card orders, ensuring proper tracking and management of gift card transactions. |
| ValidateGiftCardPropertyChange | Triggered to validate changes to properties (attributes) of a gift card. Developers can use this event to enforce rules or validations related to the modification of gift card properties, ensuring consistency and adherence to business rules. |
| ValidateGiftCardSave | Triggered to validate the saving of changes to a gift card. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateGiftCardUpdate | Triggered to validate updates to a gift card. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Location Events

| **Event** | **Description** |
|---|---|
| ValidateLocationAddressChange | Triggered to validate changes to the address of a location. Developers can use this event to enforce rules or validations related to the modification of location addresses, ensuring accuracy and consistency in location data. |
| ValidateLocationAliasChange | Triggered to validate changes to the alias (identifier) of a location. Developers can use this event to enforce rules or validations related to the modification of location aliases, ensuring uniqueness and integrity in identifying locations. |
| ValidateLocationCreate | Triggered to validate the creation of a new location. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateLocationDelete | Triggered to validate the deletion of a location. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateLocationNameChange | Triggered to validate changes to the name of a location. Developers can use this event to enforce rules or validations related to the modification of location names, ensuring clarity and consistency in identifying locations. |
| ValidateLocationSave | Triggered to validate the saving of changes to a location. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateLocationTypeChange | Triggered to validate changes to the type (category) of a location. Developers can use this event to enforce rules or validations related to the modification of location types, ensuring proper categorization and organization of locations. |
| ValidateLocationUpdate | Triggered to validate updates to a location. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Order Events

| **Event** | **Description** |
|---|---|
| ValidateOrderAssignToCustomer | Triggered to validate the assignment of an order to a customer. Developers can use this event to enforce rules or validations related to customer assignments for orders, ensuring proper association and management of customer orders. |
| ValidateOrderCodeEvent | Triggered to validate events related to order codes. Developers can use this event to enforce rules or validations related to the handling or modification of order codes, ensuring uniqueness and adherence to business rules regarding order identifiers. |
| ValidateOrderCreate | Triggered to validate the creation of a new order. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateOrderCurrencyChange | Triggered to validate changes to the currency associated with an order. Developers can use this event to enforce rules or validations related to the modification of order currencies, ensuring accuracy and consistency in financial transactions involving different currencies. |
| ValidateOrderDelete | Triggered to validate the deletion of an order. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateOrderDiscountCodeRedeem | Triggered to validate the redemption of a discount code on an order. Developers can use this event to enforce rules or validations related to the application and validation of discount codes, ensuring proper handling and application of discounts on orders. |
| ValidateOrderDiscountCodeUnredeem | Triggered to validate the unredeeming of a discount code on an order. Developers can use this event to enforce rules or validations related to the removal or cancellation of discount codes, ensuring proper handling and adjustment of discounts on orders. |
| ValidateOrderFinalize | Triggered to validate the finalization of an order. Developers can use this event to enforce rules or validations related to the finalization process, ensuring completeness and accuracy before an order is considered finalized. |
| ValidateOrderGiftCardRedeem | Triggered to validate the redemption of a gift card on an order. Developers can use this event to enforce rules or validations related to the application and validation of gift cards, ensuring proper handling and application of gift cards on orders. |
| ValidateOrderGiftCardUnredeem | Triggered to validate the unredeeming of a gift card on an order. Developers can use this event to enforce rules or validations related to the removal or cancellation of gift cards, ensuring proper handling and adjustment of gift cards on orders. |
| ValidateOrderLanguageChange | Triggered to validate changes to the language associated with an order. Developers can use this event to enforce rules or validations related to the modification of order languages, ensuring proper localization and communication preferences are maintained. |
| ValidateOrderLinePropertyChange | Triggered to validate changes to properties (attributes) of an order line. Developers can use this event to enforce rules or validations related to the modification of order line properties, ensuring consistency and adherence to business rules. |
| ValidateOrderLineQuantityChange | Triggered to validate changes to the quantity of items in an order line. Developers can use this event to enforce rules or validations related to the modification of order line quantities, ensuring accuracy and consistency in order fulfillment and inventory management.  |
| ValidateOrderLineRemove | Triggered to validate the removal of an order line. Developers can use this event to enforce rules or validations related to the removal process, ensuring it meets specified criteria or conditions. |
| ValidateOrderLineTaxClassChange | Triggered to validate changes to the tax class associated with an order line. Developers can use this event to enforce rules or validations related to the modification of tax classes for order lines, ensuring accurate tax calculations and compliance with tax regulations. |
| ValidateOrderPaymentCountryRegionChange | Triggered to validate changes to the payment country/region associated with an order. Developers can use this event to enforce rules or validations related to the modification of payment country/region settings for orders, ensuring proper handling and compliance with payment regulations. |
| ValidateOrderPaymentMethodChange | Triggered to validate changes to the payment method associated with an order. Developers can use this event to enforce rules or validations related to the modification of payment methods for orders, ensuring proper handling and security of payment transactions. |
| ValidateOrderProductAdd | Triggered to validate the addition of a product to an order. Developers can use this event to enforce rules or validations related to the addition process, ensuring product availability, pricing accuracy, and adherence to business rules. |
| ValidateOrderPropertyChange | Triggered to validate changes to properties (attributes) of an order. Developers can use this event to enforce rules or validations related to the modification of order properties, ensuring consistency and adherence to business rules.  |
| ValidateOrderSave | Triggered to validate the saving of changes to an order. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateOrderShippingCountryRegionChange | Triggered to validate changes to the shipping country/region associated with an order. Developers can use this event to enforce rules or validations related to the modification of shipping country/region settings for orders, ensuring accurate shipping calculations and compliance with shipping regulations. |
| ValidateOrderShippingMethodChange | Triggered to validate changes to the shipping method associated with an order. Developers can use this event to enforce rules or validations related to the modification of shipping methods for orders, ensuring proper handling and accuracy in order fulfillment. |
| ValidateOrderStatusAliasChange | Triggered to validate changes to the alias (identifier) of an order status. Developers can use this event to enforce rules or validations related to the modification of order status aliases, ensuring uniqueness and integrity in identifying order statuses. |
| ValidateOrderStatusChange | Triggered to validate changes to the status of an order. Developers can use this event to enforce rules or validations related to the modification of order statuses, ensuring proper handling and management of order lifecycle transitions. |
| ValidateOrderStatusColorChange | Triggered to validate changes to the color associated with an order status. Developers can use this event to enforce rules or validations related to the modification of order status colors, ensuring visual clarity and consistency in status representations. |
| ValidateOrderStatusCreate | Triggered to validate the creation of a new order status. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateOrderStatusDelete | Triggered to validate the deletion of an order status. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateOrderStatusNameChange | Triggered to validate changes to the name of an order status. Developers can use this event to enforce rules or validations related to the modification of order status names, ensuring clarity and consistency in identifying order statuses. |
| ValidateOrderStatusSave | Triggered to validate the saving of changes to an order status. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateOrderStatusUpdate | Triggered to validate updates to an order status. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidateOrderTagAdd | Triggered to validate the addition of a tag to an order. Developers can use this event to enforce rules or validations related to the tagging process, ensuring proper categorization and organization of orders. |
| ValidateOrderTagRemove | Triggered to validate the removal of a tag from an order. Developers can use this event to enforce rules or validations related to the tag removal process, ensuring it meets specified criteria or conditions. |
| ValidateOrderTaxClassChange | Triggered to validate changes to the tax class associated with an order. Developers can use this event to enforce rules or validations related to the modification of tax classes for orders, ensuring accurate tax calculations and compliance with tax regulations. |
| ValidateOrderTransactionUpdate | Triggered to validate updates to order transactions. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidateOrderUpdate | Triggered to validate updates to an order. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidateRefundOrderPayment | Triggered to validate the process of refunding an order payment. Developers can use this event to enforce rules or validations related to the refunding process, ensuring accuracy and adherence to business logic. |

### Payment Method Events

| **Event** | **Description** |
|---|---|
| ValidatePaymentMethodAliasChange | Triggered to validate changes to the alias (identifier) of a payment method. Developers can use this event to enforce rules or validations related to the modification of payment method aliases, ensuring uniqueness and integrity in identifying payment methods. |
| ValidatePaymentMethodAllowInCountryRegion | Triggered to validate whether a payment method is allowed in a specific country/region. Developers can use this event to enforce rules or validations related to the availability and eligibility of payment methods in different geographic locations.  |
| ValidatePaymentMethodClearPrices | Triggered to validate the clearing of prices associated with a payment method. Developers can use this event to enforce rules or validations related to the modification or removal of pricing information for payment methods, ensuring accuracy and consistency in financial transactions. |
| ValidatePaymentMethodCreate | Triggered to validate the creation of a new payment method. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidatePaymentMethodDelete | Triggered to validate the deletion of a payment method. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidatePaymentMethodDisallowInCountryRegion | Triggered to validate whether a payment method is disallowed in a specific country/region. Developers can use this event to enforce rules or validations related to the restriction and eligibility of payment methods in different geographic locations. |
| ValidatePaymentMethodImageChange | Triggered to validate changes to the image associated with a payment method. Developers can use this event to enforce rules or validations related to the modification of payment method images, ensuring visual consistency and adherence to branding guidelines. |
| ValidatePaymentMethodNameChange | Triggered to validate changes to the name of a payment method. Developers can use this event to enforce rules or validations related to the modification of payment method names, ensuring clarity and consistency in identifying payment methods. |
| ValidatePaymentMethodPriceChange | Triggered to validate changes to the price or cost associated with a payment method. Developers can use this event to enforce rules or validations related to the modification of payment method pricing, ensuring accurate financial calculations and compliance with pricing policies. |
| ValidatePaymentMethodSave | Triggered to validate the saving of changes to a payment method. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidatePaymentMethodSettingChange | Triggered to validate changes to settings or configurations of a payment method. Developers can use this event to enforce rules or validations related to the modification of payment method settings, ensuring functionality and compliance with operational requirements. |
| ValidatePaymentMethodSkuChange | Triggered to validate changes to the Stock Keeping Unit (SKU) associated with a payment method. Developers can use this event to enforce rules or validations related to the modification of payment method SKUs, ensuring inventory tracking and consistency in product identification. |
| ValidatePaymentMethodTaxClassChange | Triggered to validate changes to the tax class associated with a payment method. Developers can use this event to enforce rules or validations related to the modification of tax classes for payment methods, ensuring accurate tax calculations and compliance with tax regulations. |
| ValidatePaymentMethodToggleFeatures | Triggered to validate toggling or enabling/disabling features of a payment method. Developers can use this event to enforce rules or validations related to the management and configuration of payment method features, ensuring functionality and compliance with operational requirements. |
| ValidatePaymentMethodUpdate | Triggered to validate updates to a payment method. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Print Template Events

| **Event** | **Description** |
|---|---|
| ValidatePrintTemplateAliasChange | Triggered to validate changes to the alias (identifier) of a print template. Developers can use this event to enforce rules or validations related to the modification of print template aliases, ensuring uniqueness and proper identification. |
| ValidatePrintTemplateCategoryChange | Triggered to validate changes to the category of a print template. Developers can use this event to enforce rules or validations related to the categorization of print templates, ensuring accurate organization and management. |
| ValidatePrintTemplateCreate | Triggered to validate the creation of a new print template. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidatePrintTemplateDelete | Triggered to validate the deletion of a print template. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidatePrintTemplateNameChange | Triggered to validate changes to the name of a print template. Developers can use this event to enforce rules or validations related to the modification of print template names, ensuring clarity and consistency in identifying print templates. |
| ValidatePrintTemplateSave | Triggered to validate the saving of changes to a print template. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidatePrintTemplateUpdate | Triggered to validate updates to a print template. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidatePrintTemplateViewChange | Triggered to validate changes to the view configuration of a print template. Developers can use this event to enforce rules or validations related to the modification of how print templates are displayed or accessed, ensuring user experience consistency and functionality. |

### Product Attribute Events

| **Event** | **Description** |
|---|---|
| ValidateProductAttributeAliasChange | Triggered to validate changes to the alias (identifier) of a product attribute. Developers can use this event to enforce rules or validations related to the modification of product attribute aliases, ensuring uniqueness and proper identification. |
| ValidateProductAttributeCreate | Triggered to validate the creation of a new product attribute. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateProductAttributeDelete | Triggered to validate the deletion of a product attribute. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateProductAttributeNameChange | Triggered to validate changes to the name of a product attribute. Developers can use this event to enforce rules or validations related to the modification of product attribute names, ensuring clarity and consistency in identifying product attributes. |
| ValidateProductAttributePresetAliasChange | Triggered to validate changes to the alias (identifier) of a product attribute preset. Developers can use this event to enforce rules or validations related to the modification of product attribute preset aliases, ensuring uniqueness and proper identification. |
| ValidateProductAttributePresetAllowAttribute | Triggered to validate allowing an attribute in a product attribute preset. Developers can use this event to enforce rules or validations related to the configuration of product attribute presets, ensuring proper association and functionality. |
| ValidateProductAttributePresetCreate | Triggered to validate the creation of a new product attribute preset. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateProductAttributePresetDelete | Triggered to validate the deletion of a product attribute preset. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateProductAttributePresetDescriptionChange | Triggered to validate changes to the description of a product attribute preset. Developers can use this event to enforce rules or validations related to the modification of product attribute preset descriptions, ensuring clarity and consistency in information provided. |
| ValidateProductAttributePresetDisallowAttribute | Triggered to validate disallowing an attribute in a product attribute preset. Developers can use this event to enforce rules or validations related to the configuration of product attribute presets, ensuring proper association and functionality. |
| ValidateProductAttributePresetIconChange | Triggered to validate changes to the icon associated with a product attribute preset. Developers can use this event to enforce rules or validations related to the modification of product attribute preset icons, ensuring visual consistency and adherence to design guidelines. |
| ValidateProductAttributePresetNameChange | Triggered to validate changes to the name of a product attribute preset. Developers can use this event to enforce rules or validations related to the modification of product attribute preset names, ensuring clarity and consistency in identifying product attribute presets. |
| ValidateProductAttributePresetSave | Triggered to validate the saving of changes to a product attribute preset. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateProductAttributePresetUpdate | Triggered to validate updates to a product attribute preset. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidateProductAttributeSave | Triggered to validate the saving of changes to a product attribute. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateProductAttributeUpdate | Triggered to validate updates to a product attribute. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |
| ValidateProductAttributeValueAdd | Triggered to validate the addition of a value to a product attribute. Developers can use this event to enforce rules or validations related to the addition process, ensuring data integrity and adherence to product attribute specifications. |
| ValidateProductAttributeValueNameChange | Triggered to validate changes to the name of a value associated with a product attribute. Developers can use this event to enforce rules or validations related to the modification of product attribute value names, ensuring clarity and consistency in identifying product attribute values. |
| ValidateProductAttributeValueRemove | Triggered to validate the removal of a value from a product attribute. Developers can use this event to enforce rules or validations related to the removal process, ensuring it meets specified criteria or conditions and maintains data integrity.  |

### Region Events

| **Event** | **Description** |
|---|---|
| ValidateRegionCodeChange | Triggered to validate changes to the code of a region. Developers can use this event to enforce rules or validations related to the modification of region codes, ensuring uniqueness and proper identification. |
| ValidateRegionCreate | Triggered to validate the creation of a new region. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateRegionDefaultPaymentMethodChange | Triggered to validate changes to the default payment method of a region. Developers can use this event to enforce rules or validations related to the modification of default payment methods for regions, ensuring proper configuration and functionality. |
| ValidateRegionDefaultShippingMethodChange | Triggered to validate changes to the default shipping method of a region. Developers can use this event to enforce rules or validations related to the modification of default shipping methods for regions, ensuring proper configuration and functionality. |
| ValidateRegionDelete | Triggered to validate the deletion of a region. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions.  |
| ValidateRegionNameChange | Triggered to validate changes to the name of a region. Developers can use this event to enforce rules or validations related to the modification of region names, ensuring clarity and consistency in identifying regions. |
| ValidateRegionSave | Triggered to validate the saving of changes to a region. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic.  |
| ValidateRegionUpdate | Triggered to validate updates to a region. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Shipping Method Events

| **Event** | **Description** |
|---|---|
| ValidateShippingMethodAliasChange | Triggered to validate changes to the alias of a shipping method. Developers can use this event to enforce rules or validations related to the modification of shipping method aliases, ensuring uniqueness and proper identification. |
| ValidateShippingMethodAllowInCountryRegion | Triggered to validate whether a shipping method is allowed in a specific country or region. Developers can use this event to enforce rules or validations related to the availability of shipping methods in different geographical areas. |
| ValidateShippingMethodCalculationConfigChange | Triggered to validate changes to the calculation configuration of a shipping method. Developers can use this event to enforce rules or validations related to how shipping costs are calculated, ensuring accuracy and consistency in pricing. |
| ValidateShippingMethodClearPrices | Triggered to validate the process of clearing prices associated with a shipping method. Developers can use this event to enforce rules or validations related to price adjustments or resets for shipping methods. |
| ValidateShippingMethodCreate | Triggered to validate the creation of a new shipping method. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateShippingMethodDelete | Triggered to validate the deletion of a shipping method. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateShippingMethodDisallowInCountryRegion | Triggered to validate whether a shipping method is disallowed in a specific country or region. Developers can use this event to enforce rules or validations related to restricting shipping methods in different geographical areas. |
| ValidateShippingMethodImageChange | Triggered to validate changes to the image associated with a shipping method. Developers can use this event to enforce rules or validations related to visual content updates for shipping methods. |
| ValidateShippingMethodNameChange | Triggered to validate changes to the name of a shipping method. Developers can use this event to enforce rules or validations related to the modification of shipping method names, ensuring clarity and consistency in identifying shipping methods.  |
| ValidateShippingMethodPriceChange | Triggered to validate changes to the price of a shipping method. Developers can use this event to enforce rules or validations related to price adjustments or updates for shipping methods, ensuring accurate pricing information.  |
| ValidateShippingMethodSave | Triggered to validate the saving of changes to a shipping method. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateShippingMethodSettingChange | Triggered to validate changes to the settings of a shipping method. Developers can use this event to enforce rules or validations related to configuration updates for shipping methods, ensuring proper functionality and integration with other systems. |
| ValidateShippingMethodSkuChange | Triggered to validate changes to the Stock Keeping Unit (SKU) of a shipping method. Developers can use this event to enforce rules or validations related to product identification and tracking for shipping methods. |
| ValidateShippingMethodTaxClassChange | Triggered to validate changes to the tax class associated with a shipping method. Developers can use this event to enforce rules or validations related to tax rate adjustments or updates for shipping methods. |
| ValidateShippingMethodUpdate | Triggered to validate updates to a shipping method. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Stock Events

| **Event** | **Description** |
|---|---|
| ValidateStockChange | Triggered to validate changes made to the stock levels of products or inventory items. Developers can use this event to enforce business logic related to stock adjustments, ensuring accuracy and adherence to inventory management policies. |

### Store Events

| **Event** | **Description** |
|---|---|
| ValidateStoreAddGiftCardPropertyAlias | Triggered to validate adding an alias for a gift card property in a store. Developers can use this event to enforce rules or validations related to gift card property aliases, ensuring uniqueness and proper identification. |
| ValidateStoreAddProductPropertyAlias | Triggered to validate adding an alias for a product property in a store. Developers can use this event to enforce rules or validations related to product property aliases, ensuring uniqueness and proper identification. |
| ValidateStoreAddProductUniquenessPropertyAlias | Triggered to validate adding an alias for a uniqueness property of a product in a store. Developers can use this event to enforce rules or validations related to uniqueness property aliases, ensuring uniqueness and proper identification. |
| ValidateStoreAliasChange | Triggered to validate changes to the alias of a store. Developers can use this event to enforce rules or validations related to the modification of store aliases, ensuring uniqueness and proper identification. |
| ValidateStoreAllowUser | Triggered to validate allowing a user in a store. Developers can use this event to enforce rules or validations related to user permissions and access control within a store. |
| ValidateStoreAllowUserRole | Triggered to validate allowing a user role in a store. Developers can use this event to enforce rules or validations related to user role permissions and access control within a store. |
| ValidateStoreBaseCurrencyChange | Triggered to validate changes to the base currency of a store. Developers can use this event to enforce rules or validations related to the modification of base currencies, ensuring compatibility and consistency in financial operations. |
| ValidateStoreCookiesChange | Triggered to validate changes to cookie settings in a store. Developers can use this event to enforce rules or validations related to privacy and tracking policies associated with cookies in a store. |
| ValidateStoreCreate | Triggered to validate the creation of a new store. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateStoreDefaultCountryChange | Triggered to validate changes to the default country of a store. Developers can use this event to enforce rules or validations related to the modification of default countries, ensuring proper localization and operational settings. |
| ValidateStoreDefaultLocationChange | Triggered to validate changes to the default location of a store. Developers can use this event to enforce rules or validations related to the modification of default locations, ensuring accurate fulfillment and logistical operations. |
| ValidateStoreDefaultTaxClassChange |Triggered to validate changes to the default tax class of a store. Developers can use this event to enforce rules or validations related to tax handling and rate adjustments in a store.  |
| ValidateStoreDelete | Triggered to validate the deletion of a store. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateStoreDisallowUser | Triggered to validate disallowing a user in a store. Developers can use this event to enforce rules or validations related to user permissions and access control within a store. |
| ValidateStoreDisallowUserRole | Triggered to validate disallowing a user role in a store. Developers can use this event to enforce rules or validations related to user role permissions and access control within a store. |
| ValidateStoreGiftCardSettingsChange | Triggered to validate changes to gift card settings in a store. Developers can use this event to enforce rules or validations related to gift card management and configuration in a store. |
| ValidateStoreMeasurementSystemChange | Triggered to validate changes to the measurement system used in a store. Developers can use this event to enforce rules or validations related to units of measurement and standardization in a store. |
| ValidateStoreNameChange | Triggered to validate changes to the name of a store. Developers can use this event to enforce rules or validations related to the modification of store names, ensuring clarity and consistency in store identification.  |
| ValidateStoreNotificationEmailTemplatesChange | Triggered to validate changes to notification email templates in a store. Developers can use this event to enforce rules or validations related to email template management and communication in a store. |
| ValidateStoreOrderNumberTemplatesChange | Triggered to validate changes to order number templates in a store. Developers can use this event to enforce rules or validations related to order numbering and format specifications in a store.  |
| ValidateStoreOrderRoundingMethodChange | Triggered to validate changes to the rounding method used for orders in a store. Developers can use this event to enforce rules or validations related to financial calculations and accuracy in a store. |
| ValidateStoreOrderStatusesChange | Triggered to validate changes to order statuses in a store. Developers can use this event to enforce rules or validations related to order status management and workflow customization in a store. |
| ValidateStorePriceTaxInclusivityChange | Triggered to validate changes to price tax inclusivity settings in a store. Developers can use this event to enforce rules or validations related to tax calculation methods and pricing policies in a store. |
| ValidateStoreRemoveGiftCardPropertyAlias | Triggered to validate removing an alias for a gift card property in a store. Developers can use this event to enforce rules or validations related to gift card property aliases, ensuring proper management and identification. |
| ValidateStoreRemoveProductPropertyAlias | Triggered to validate removing an alias for a product property in a store. Developers can use this event to enforce rules or validations related to product property aliases, ensuring proper management and identification. |
| ValidateStoreRemoveProductUniquenessPropertyAlias | Triggered to validate removing an alias for a uniqueness property of a product in a store. Developers can use this event to enforce rules or validations related to uniqueness property aliases, ensuring proper management and identification. |
| ValidateStoreSave | Triggered to validate the saving of changes to a store. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateStoreShareStockFromStoreChange | Triggered to validate changes to the shared stock setting between stores. Developers can use this event to enforce rules or validations related to stock management and synchronization across multiple stores. |
| ValidateStoreUpdate | Triggered to validate updates to a store. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

### Tax Class Events

| **Event** | **Description** |
|---|---|
| ValidateTaxClassAliasChange | Triggered to validate changes to the alias of a tax class. Developers can use this event to enforce rules or validations related to the modification of tax class aliases, ensuring uniqueness and proper identification.  |
| ValidateTaxClassClearTaxRates | Triggered to validate clearing tax rates associated with a tax class. Developers can use this event to enforce rules or validations related to tax rate adjustments or resets for tax classes. |
| ValidateTaxClassCreate | Triggered to validate the creation of a new tax class. Developers can use this event to enforce rules or validations related to the creation process, ensuring data integrity and adherence to business logic. |
| ValidateTaxClassDelete | Triggered to validate the deletion of a tax class. Developers can use this event to enforce rules or validations related to the deletion process, ensuring it meets specified criteria or conditions. |
| ValidateTaxClassNameChange | Triggered to validate changes to the name of a tax class. Developers can use this event to enforce rules or validations related to the modification of tax class names, ensuring clarity and consistency in tax classification. |
| ValidateTaxClassSave | Triggered to validate the saving of changes to a tax class. Developers can use this event to enforce rules or validations related to the save process, ensuring data integrity and adherence to business logic. |
| ValidateTaxClassTaxRateChange | Triggered to validate changes to tax rates associated with a tax class. Developers can use this event to enforce rules or validations related to tax rate adjustments or updates for tax classes.  |
| ValidateTaxClassUpdate | Triggered to validate updates to a tax class. Developers can use this event to enforce rules or validations related to the update process, ensuring data integrity and adherence to business logic. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Country

| **Event** | **Description** |
|---|---|
| ValidateCountryCodeFormat | Triggered to validate the format of a country code. Developers can use this event to enforce rules or validations related to the correct formatting of country codes, ensuring adherence to specified standards. |
| ValidateDefaultCurrencyBelongsToCountryStore | Triggered to ensure that the default currency belongs to the country store. Developers can use this event to enforce validation rules specific to default currencies and country stores. |
| ValidateDefaultPaymentMethodBelongsToCountryStore | Triggered to ensure that the default payment method belongs to the country store. Developers can use this event to enforce validation rules specific to default payment methods and country stores. |
| ValidateDefaultShippingMethodBelongsToCountryStore | Triggered to ensure that the default shipping method belongs to the country store. Developers can use this event to enforce validation rules specific to default shipping methods and country stores. |
| ValidateNotStoreDefaultCountry | Triggered to ensure that the country being validated is not the default country for the store. Developers can use this event to enforce validation rules specific to countries and store defaults, ensuring proper configuration and management of default countries. |
| ValidateUniqueCountryCode | Triggered to ensure that the country code is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of country codes within the system, preventing conflicts and ensuring clarity in country identification. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Currency

| **Event** | **Description** |
|---|---|
| ValidateAllowedCountryBelongsToCurrencyStore | Triggered to validate if the country is allowed in the currency store. Developers can use this event to enforce rules or validations related to countries allowed within specific currency stores. |
| ValidateCulture | Triggered to validate the culture. Developers can use this event to enforce rules or validations related to the culture settings, ensuring compatibility and consistency within the system. |
| ValidateCurrencyCodeFormat | Triggered to validate the format of a currency code. Developers can use this event to enforce rules or validations related to the correct formatting of currency codes, ensuring adherence to specified standards. |
| ValidateNotCountryDefaultCurrency | Triggered to ensure that the country is not the default currency. Developers can use this event to enforce rules or validations related to default currency settings for specific countries. |
| ValidateNotStoreBaseCurrency | Triggered to ensure that the currency is not the base currency for the store. Developers can use this event to enforce rules or validations related to base currency settings for specific stores. |
| ValidateUniqueCurrencyCode | Triggered to ensure that the currency code is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of currency codes within the system, preventing conflicts and ensuring clarity in currency identification. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Discount

| **Event** | **Description** |
|---|---|
| ValidateUniqueAlias | Triggered to ensure that the alias is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of aliases within the system, preventing conflicts and ensuring clarity in identification. |
| ValidateUniqueDiscountCode | Triggered to ensure that the discount code is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of discount codes within the system, preventing duplicate codes from being issued. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.EmailTemplate

| **Event** | **Description** |
|---|---|
| ValidateNotStoreDefaultEmailTemplate | Triggered to ensure that the email template being validated is not the default email template for the store. Developers can use this event to enforce validation rules specific to email templates and store defaults, ensuring proper configuration and management of default email templates. |
| ValidateUniqueEmailTemplateAlias | Triggered to ensure that the alias for an email template is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of email template aliases within the system, preventing conflicts and ensuring clarity in template identification. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.ExportTemplate

| **Event** | **Description** |
|---|---|
| ValidateUniqueExportTemplateAlias | Triggered to ensure that the alias for an export template is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of export template aliases within the system, preventing conflicts and ensuring clarity in template identification. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.GiftCard

| **Event** | **Description** |
|---|---|
| ValidateUniqueGiftCardCode | Triggered to ensure that the code for a gift card is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of gift card codes within the system, preventing duplicate codes from being issued. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Location

| **Event** | **Description** |
|---|---|
| ValidateNotStoreDefaultLocation | Triggered to ensure that the location being validated is not the default location for the store. Developers can use this event to enforce validation rules specific to locations and store defaults, ensuring proper configuration and management of default locations. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Order

| **Event** | **Description** |
|---|---|
| ValidateCurrencyBelongsToOrderStore | Triggered to ensure that the currency belongs to the order's store. Developers can use this event to enforce validation rules specific to currencies and order stores. |
| ValidateDiscountCodeValid | Triggered to validate the validity of a discount code. Developers can use this event to enforce rules or validations related to discount codes, ensuring they are valid and applicable. |
| ValidateGiftCardPropertyIsWritable | Triggered to validate whether a specific property of a gift card is writable. Developers can use this event to enforce rules or validations related to the writability of gift card properties. |
| ValidateGiftCardValid | Triggered to validate the validity of a gift card. Developers can use this event to enforce rules or validations related to gift cards, ensuring they are valid and can be applied. |
| ValidateOrderPaymentCountryRegionAllowedByOrderCurrency | Triggered to validate if the payment country or region is allowed by the order currency. Developers can use this event to enforce rules or validations related to payment countries or regions based on the order currency. |
| ValidateOrderPaymentCountryRegionBelongsToOrderStore | Triggered to ensure that the payment country or region belongs to the order's store. Developers can use this event to enforce validation rules specific to payment countries or regions and order stores. |
| ValidateOrderPropertyIsWritable | Triggered to validate whether a specific property of an order is writable. Developers can use this event to enforce rules or validations related to the writability of order properties. |
| ValidateOrderShippingCountryRegionBelongsToOrderStore | Triggered to ensure that the shipping country or region belongs to the order's store. Developers can use this event to enforce validation rules specific to shipping countries or regions and order stores. |
| ValidateOrderStatusBelongsToOrderStore | Triggered to ensure that the order status belongs to the order's store. Developers can use this event to enforce validation rules specific to order statuses and order stores. |
| ValidateOrderStatusCode | Triggered to validate the order status code. Developers can use this event to enforce rules or validations related to order status codes, ensuring they adhere to specified formats or requirements. |
| ValidatePaymentMethodAllowedInPaymentCountryRegion | Triggered to validate if the payment method is allowed in the payment country or region. Developers can use this event to enforce rules or validations related to payment methods based on payment countries or regions. |
| ValidatePaymentMethodBelongsToOrderStore | Triggered to ensure that the payment method belongs to the order's store. Developers can use this event to enforce validation rules specific to payment methods and order stores. |
| ValidateProductAddHasPrice | Triggered to validate that a product being added to an order has a price. Developers can use this event to enforce rules or validations related to product prices when adding them to orders. |
| ValidateProductAddQuantityPositive | Triggered to validate that the quantity of a product being added to an order is positive. Developers can use this event to enforce rules or validations related to product quantities when adding them to orders. |
| ValidateShippingMethodAllowedInShippingCountryRegion | Triggered to validate if the shipping method is allowed in the shipping country or region. Developers can use this event to enforce rules or validations related to shipping methods based on shipping countries or regions. |
| ValidateShippingMethodBelongsToOrderStore | Triggered to ensure that the shipping method belongs to the order's store. Developers can use this event to enforce validation rules specific to shipping methods and order stores. |
| ValidateTaxClassBelongsToOrderStore | Triggered to ensure that the tax class belongs to the order's store. Developers can use this event to enforce validation rules specific to tax classes and order stores. |
| ValidateTransactionInitialized | Triggered to validate that a transaction is initialized. Developers can use this event to enforce rules or validations related to transaction initialization, ensuring transactions are properly prepared before proceeding. |
| ValidateUniqueBundleId | Triggered to ensure that the bundle ID is unique. Developers can use this event to enforce rules or validations to maintain the uniqueness of bundle IDs within the system. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.OrderLine

| **Event** | **Description** |
|---|---|
| ValidateOrderLinePropertyIsWritable | Triggered to validate whether a specific property of an order line can be modified. Developers can use this event to enforce rules or validations related to the writability of order line properties, ensuring data integrity and adherence to business logic when modifying order line properties. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.OrderStatus

| **Event** | **Description** |
|---|---|
| ValidateNotStoreDefaultOrderStatus | Triggered to ensure that the order status being validated is not the default order status for the store. Developers can use this event to enforce validation rules specific to order statuses and stores, ensuring proper configuration and management of default statuses. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.PaymentMethod

| **Event** | **Description** |
|---|---|
| ValidateAllowedInPriceCountryRegion | **OBSOLETE:** Use `ValidateFixedRateAllowedInPriceCountryRegion` instead. This event was originally used to validate whether a price is allowed in the specified country or region, enabling developers to enforce this rule through custom actions or validations. |
| ValidateNotCountryDefaultPaymentMethod | Triggered to ensure that the payment method being validated is not the default payment method for the country. Developers can use this event to enforce validation rules specific to payment methods and countries. |
| ValidateNotRegionDefaultPaymentMethod | Triggered to ensure that the payment method being validated is not the default payment method for the region. Developers can use this event to enforce validation rules specific to payment methods and regions. |
| ValidateUniquePaymentMethodAlias | Triggered to ensure that the alias for a payment method is unique. Developers can use this event to enforce uniqueness of payment method aliases within the system. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.PrintTemplate

| **Event** | **Description** |
|---|---|
| ValidateUniquePrintTemplateAlias | Triggered to ensure that the alias for a print template is unique. Developers can use this event to enforce uniqueness of print template aliases within the system, preventing conflicts and ensuring clarity in template identification. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.ProductAttribute

| **Event** | **Description** |
|---|---|
| ValidateUniqueProductAttributeAlias | Triggered to ensure that the alias for a product attribute is unique. Allows developers to enforce uniqueness of product attribute aliases within the system. |
| ValidateUniqueProductAttributePresetAlias | Triggered to ensure that the alias for a product attribute preset is unique. Allows developers to enforce uniqueness of product attribute preset aliases within the system. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Region

| **Event** | **Description** |
|---|---|
| ValidateDefaultPaymentMethodBelongsToRegionStore | Triggered to ensure that the default payment method belongs to the region's store. Developers can use this event to enforce validation rules related to payment methods specific to regions and stores. |
| ValidateDefaultShippingMethodBelongsToRegionStore | Triggered to ensure that the default shipping method belongs to the region's store. Developers can use this event to enforce validation rules related to shipping methods specific to regions and stores. |
| ValidateUniqueRegionCode | Triggered to ensure that the region code is unique. Developers can use this event to enforce validation rules to maintain unique region codes within the system.  |

## Umbraco.Commerce.Core.Events.Validation.Handlers.ShippingMethod

| **Event** | **Description** |
|---|---|
| ValidateAllowedInPriceCountryRegion | **OBSOLETE:** Use `ValidateFixedRateAllowedInPriceCountryRegion` instead. This event was originally used to validate whether a price is allowed in the specified country or region, enabling developers to enforce this rule through custom actions or validations. |
| ValidateCalculationModeConfigType | Triggered to ensure that the calculation mode configuration type is valid. Allows developers to perform actions or validations to enforce this rule. |
| ValidateFixedRateAllowedInPriceCountryRegion | Triggered to ensure that a fixed rate is allowed in the specified price country or region. Allows developers to perform actions or validations to enforce this rule. |
| ValidateNotCountryDefaultShippingMethod | Triggered to ensure that the shipping method being validated is not the default shipping method for the country. Allows developers to perform actions or validations to enforce this rule. |
| ValidateNotRegionDefaultShippingMethod | Triggered to ensure that the shipping method being validated is not the default shipping method for the region. Allows developers to perform actions or validations to enforce this rule. |
| ValidateUniqueShippingMethodAlias | Triggered to ensure that the alias for a shipping method is unique. Allows developers to perform actions or validations to enforce the uniqueness of shipping method aliases. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.Store

| **Event** | **Description** |
|---|---|
| ValidateDefaultCountryBelongsToStore | Triggered to ensure that the default country being validated belongs to the store. Allows developers to perform actions or validations to enforce this rule. |
| ValidateDefaultTaxClassBelongsToStore | Triggered to ensure that the default tax class being validated belongs to the store. Allows developers to perform actions or validations to enforce this rule. |
| ValidateNotificationEmailTemplatesBelongsToStore | Triggered to ensure that the notification email templates being validated belong to the store. Allows developers to perform actions or validations to enforce this rule. |
| ValidateOrderStatusesBelongsToStore | Triggered to ensure that the order statuses being validated belong to the store. Allows developers to perform actions or validations to enforce this rule.  |
| ValidateUniqueStoreAlias | Triggered to ensure that the alias for a store is unique. Allows developers to perform actions or validations to enforce the uniqueness of store aliases. |

## Umbraco.Commerce.Core.Events.Validation.Handlers.TaxClass

| **Event** | **Description** |
|---|---|
| ValidateNotStoreDefaultTaxClass | Triggered to ensure that the tax class being validated is not the default tax class for the store. Allows developers to perform actions or validations to enforce this rule. |
| ValidateUniqueTaxClassAlias | Triggered to ensure that the alias for a tax class is unique. Allows developers to perform actions or validations to enforce the uniqueness of tax class aliases. |
