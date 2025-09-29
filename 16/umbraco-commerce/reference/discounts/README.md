---
description: Discount options in Umbraco Commerce.
---

# Discounts

The discounts system in Umbraco Commerce is a powerful and flexible way to apply various types of discounts to orders based on a wide range of conditions. Discounts can be configured to apply automatically or via a discount code, and can be targeted to specific products, categories, member groups, and more.

![Discount Management Interface](images/discount-management.png)

## Overview

Discounts in Umbraco Commerce provide a comprehensive solution for promotional pricing strategies. Whether you need simple percentage-off campaigns or complex multi-tier discount structures, the system supports both automated discounts that apply based on conditions and manual discount codes that customers can enter during checkout.

The discount system consists of three main components:
- **Rules** - Define the conditions that must be met for a discount to apply
- **Rewards** - Specify what discount should be given when rules are satisfied
- **Configuration** - Control when, how, and to whom discounts are available

## Creating a Discount

To create a new discount, navigate to the Commerce section in the Umbraco backoffice and select **Discounts** from the sidebar. Click the **Create** button to open the discount creation interface.

![Create Discount Button](images/create-discount-button.png)

## Basic Configuration

### Name and Alias
Every discount requires a unique **Name** for display purposes and an **Alias** for programmatic reference. The name appears in the backoffice and on customer receipts, while the alias is used internally by the system.

![Discount Name and Alias](images/discount-name-alias.png)

### Discount Types

Discounts can be configured as one of two types:

#### Automatic Discounts
Automatic discounts apply immediately when their rules are satisfied, without requiring customer input. These are ideal for promotional campaigns like "Free shipping on orders over $50" or "10% off all electronics."

#### Code-Based Discounts
Code-based discounts require customers to enter a specific discount code during checkout. These provide more control over discount distribution and are perfect for targeted marketing campaigns.

![Discount Type Selection](images/discount-type-selection.png)

For code-based discounts, you can configure:
- **Discount Code** - The code customers must enter
- **Usage Limit** - Maximum number of times the code can be used
- **Unlimited Usage** - Allow the code to be used without restriction

![Discount Code Configuration](images/discount-code-config.png)

### Date Range and Status

Control when your discounts are active using the date range settings:
- **From Date** - When the discount becomes available
- **To Date** - When the discount expires
- **Is Active** - Toggle to enable/disable the discount

![Discount Date Range](images/discount-date-range.png)

## Rules System

The rules system determines when a discount should be applied. Rules can be simple single conditions or complex multi-layered logic structures.

### Rule Builder Interface
The visual rule builder allows you to construct discount conditions using a drag-and-drop interface. Rules can be combined using logical operators to create sophisticated discount scenarios.

![Rule Builder Interface](images/rule-builder.png)

### Logical Operators
Rules can be grouped using three types of logic:
- **ALL** - Every rule in the group must be satisfied
- **ANY** - At least one rule in the group must be satisfied
- **FUNNEL** - Rules are applied sequentially, with matching items passed to the next rule

![Rule Logic Options](images/rule-logic.png)

### Funnel Logic
Funnel logic is particularly powerful for product-specific discounts. Order lines that match the first rule are passed to subsequent rules for additional filtering. This enables scenarios like "Buy 2 shirts and get 20% off pants" where the system first identifies shirt purchases, then applies discounts to pants.

![Funnel Logic Diagram](images/funnel-logic.png)

### Blocking Options
Rules can include blocking conditions to prevent discount stacking:
- **Block Further Discounts** - Prevent other discounts from applying if this one is used
- **Block if Other Discounts Apply** - Don't apply this discount if others are already active

![Rule Blocking Options](images/rule-blocking.png)

For detailed information about available rules and their configuration, see the [Rules Reference](rules/).

## Rewards System

Rewards define what discount should be applied when rules are satisfied. The system supports various reward types for different discount scenarios.

![Reward Builder Interface](images/reward-builder.png)

### Reward Types
- **Order Amount Rewards** - Apply discounts to order subtotal, shipping, payment, or total
- **Order Line Rewards** - Apply discounts to specific order lines or products
- **Free Product Rewards** - Add free products to qualifying orders

![Reward Type Selection](images/reward-types.png)

### Discount Methods
Most rewards support multiple discount methods:
- **Percentage** - Apply a percentage discount (e.g., 10% off)
- **Fixed Amount** - Apply a fixed monetary discount (e.g., $5 off)
- **Free** - Make the item or shipping completely free

![Discount Methods](images/discount-methods.png)

For detailed information about available rewards and their configuration, see the [Rewards Reference](rewards/).

## Discount Ordering and Priority

Discounts are processed in the order they appear in the discount list. This ordering can significantly impact how multiple discounts interact with each other.

![Discount Order List](images/discount-order.png)

### Reordering Discounts
You can change the processing order by:
1. Selecting a discount in the list
2. Using the sort menu option to move it up or down
3. Saving the new order

![Discount Reorder Menu](images/discount-reorder.png)

### Best Practices for Ordering
- Place percentage-based discounts before fixed-amount discounts
- Order more restrictive discounts before general ones
- Consider how blocking rules interact with discount order

## Common Examples

### Free Shipping Promotion
Offer free shipping for orders over a certain amount:

**Rule Configuration:**
- Order Amount rule: Greater than $50

**Reward Configuration:**
- Order Amount Reward: Free Shipping

![Free Shipping Example](images/example-free-shipping.png)

### Buy One Get One (BOGO)
Create a buy-one-get-one promotion for specific products:

**Rule Configuration:**
- Order Line Quantity: Product "T-Shirt" quantity greater than 1

**Reward Configuration:**
- Order Line Product Reward: 50% off "T-Shirt"

![BOGO Example](images/example-bogo.png)

### Seasonal Sale
Apply a site-wide discount during a specific time period:

**Rule Configuration:**
- No specific rules (applies to all orders)

**Reward Configuration:**
- Order Amount Reward: 15% off subtotal

**Date Configuration:**
- From: December 1st
- To: December 31st

![Seasonal Sale Example](images/example-seasonal.png)

### Member Discount
Provide exclusive discounts to specific member groups:

**Rule Configuration:**
- Member Group rule: "VIP Members"
- Order Amount rule: Greater than $25

**Reward Configuration:**
- Order Amount Reward: 20% off subtotal

![Member Discount Example](images/example-member.png)

## Advanced Scenarios

### Multi-Tier Discounts
Create escalating discounts based on order value:

**Discount 1 (Bronze Tier):**
- Rule: Order Amount $100-$199
- Reward: 5% off subtotal

**Discount 2 (Silver Tier):**
- Rule: Order Amount $200-$299
- Reward: 10% off subtotal

**Discount 3 (Gold Tier):**
- Rule: Order Amount $300+
- Reward: 15% off subtotal

![Multi-Tier Discounts](images/example-multi-tier.png)

### Category-Specific Bundles
Encourage cross-category purchases:

**Rule Configuration:**
- Funnel Logic Group:
  - Order Line Product Category: "Electronics"
  - Order Line Product Category: "Accessories"

**Reward Configuration:**
- Order Line Amount Reward: 25% off "Accessories" category

![Category Bundle Example](images/example-category-bundle.png)

## Testing and Validation

### Preview Mode
Use the preview functionality to test discount behavior before making them live:

![Discount Preview](images/discount-preview.png)

### Analytics Integration
Monitor discount performance through built-in analytics:
- Usage statistics
- Revenue impact
- Popular discount codes

![Discount Analytics](images/discount-analytics.png)

## Troubleshooting

### Common Issues
- **Discount not applying**: Check rule conditions and date ranges
- **Multiple discounts conflicting**: Review discount ordering and blocking settings
- **Code not working**: Verify usage limits and code spelling

### Debugging Tools
The system provides debugging information to help identify why discounts may not be applying:

![Discount Debugging](images/discount-debugging.png)

## Integration and Extensibility

The discount system is built with extensibility in mind. Developers can create custom rules and rewards to meet specific business requirements.

For information on extending the discount system, see the [Developer Documentation](/developer-guides/discounts/).

## Related Topics

- [Rules Reference](rules/) - Detailed documentation of all available discount rules
- [Rewards Reference](rewards/) - Comprehensive guide to discount rewards
- [Orders](/reference/orders/) - Understanding how discounts affect order processing
- [Payment Processing](/reference/payment/) - How discounts interact with payment flows
