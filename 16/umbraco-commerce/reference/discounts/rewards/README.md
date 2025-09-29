---
description: Discount reward options in Umbraco Commerce.
---

# Discount Rewards

Discount rewards define what discount should be applied when discount rules are satisfied. The reward system in Umbraco Commerce supports various types of discounts, from simple percentage reductions to complex product-specific offers and free shipping promotions.

![Discount Rewards Overview](../images/rewards-overview.png)

## How Rewards Work

When discount rules are satisfied, the associated rewards are applied to the order. Rewards can target different aspects of an order, including the overall order value, specific order lines, shipping costs, or payment fees.

## Reward Types

### Order Amount Reward
Applies discounts to various aspects of the overall order amount, including subtotal, shipping, payment fees, or the complete order total.

**Configuration:**
- **Target** - Choose what to discount (subtotal, shipping, payment, or total)
- **Discount Type** - Percentage, fixed amount, or free
- **Discount Value** - The amount or percentage to discount

![Order Amount Reward Configuration](../images/reward-order-amount-config.png)

**Discount Targets:**
- **Subtotal** - The total of all order line amounts before shipping and fees
- **Shipping** - The shipping cost for the order
- **Payment** - Payment processing fees
- **Total** - The complete order total including all fees

**Use Cases:**
- Site-wide sales and promotions
- Free shipping offers
- Payment method incentives
- Volume-based discounts

![Order Amount Reward Examples](../images/reward-order-amount-examples.png)

### Order Line Amount Reward
Applies discounts to specific order lines based on various criteria such as product categories, sections, or custom properties.

**Configuration:**
- **Line Selection** - Define which order lines should receive the discount
- **Discount Type** - Percentage, fixed amount, or free
- **Discount Value** - The amount or percentage to discount
- **Application Method** - Per line or cumulative

![Order Line Amount Reward Configuration](../images/reward-order-line-amount-config.png)

**Line Selection Criteria:**
- **Product Categories** - Target products from specific categories
- **Product Sections** - Target products from specific site sections
- **Product Properties** - Target products with specific custom properties
- **Price Range** - Target products within certain price ranges

**Use Cases:**
- Category-specific sales
- Clearance discounts
- Brand promotions
- Seasonal offers

![Order Line Amount Reward Examples](../images/reward-order-line-amount-examples.png)

### Order Line Product Reward
Applies discounts to specific order lines containing particular products. This reward type provides precise control over which products receive discounts.

**Configuration:**
- **Target Products** - Select specific products to discount
- **Discount Type** - Percentage, fixed amount, or free
- **Discount Value** - The amount or percentage to discount
- **Quantity Limitations** - Optional limits on how many items receive the discount

![Order Line Product Reward Configuration](../images/reward-order-line-product-config.png)

**Advanced Options:**
- **Maximum Quantity** - Limit the number of discounted items
- **Application Order** - Control which items are discounted first (cheapest, most expensive, etc.)
- **Cumulative Limits** - Set maximum total discount amounts

**Use Cases:**
- Product-specific promotions
- Inventory clearance
- Cross-selling incentives
- Bundle discounts

![Order Line Product Reward Examples](../images/reward-order-line-product-examples.png)

## Discount Methods

### Percentage Discounts
Apply a percentage reduction to the target amount.

**Configuration:**
- **Percentage Value** - The percentage to discount (e.g., 15 for 15% off)
- **Maximum Discount** - Optional cap on the discount amount
- **Minimum Order Value** - Optional minimum order requirement

![Percentage Discount Configuration](../images/discount-percentage-config.png)

**Benefits:**
- Scales with order value
- Easy for customers to understand
- Effective for percentage-based promotions

**Considerations:**
- Can result in unexpected discount amounts for high-value orders
- May need maximum discount limits for protection

### Fixed Amount Discounts
Apply a specific monetary amount as a discount.

**Configuration:**
- **Discount Amount** - The fixed amount to discount
- **Currency** - The currency for the discount amount
- **Minimum Order Value** - Optional minimum order requirement

![Fixed Amount Discount Configuration](../images/discount-fixed-config.png)

**Benefits:**
- Predictable discount amounts
- Clear value proposition for customers
- Easy budget control for businesses

**Considerations:**
- May not be proportional to order value
- Currency considerations for international sales

### Free Discounts
Make the target completely free (100% discount).

**Configuration:**
- **Application Scope** - What becomes free (shipping, products, fees, etc.)
- **Conditions** - Optional additional conditions for the free offer

![Free Discount Configuration](../images/discount-free-config.png)

**Benefits:**
- Strong promotional appeal
- Simple to communicate
- High conversion potential

**Use Cases:**
- Free shipping promotions
- Buy one, get one free offers
- Loyalty program benefits
- First-time customer incentives

## Advanced Reward Scenarios

### Graduated Discount Structure
Create multiple rewards with different discount levels:

**Bronze Level (5% off):**
- Order Amount Reward: 5% off subtotal
- Minimum order: $100

**Silver Level (10% off):**
- Order Amount Reward: 10% off subtotal
- Minimum order: $200

**Gold Level (15% off):**
- Order Amount Reward: 15% off subtotal
- Minimum order: $500

![Graduated Discount Structure](../images/advanced-graduated.png)

### Buy X Get Y Free
Implement complex buy-and-get promotions:

**Example: Buy 2 T-shirts, get 1 free**
- Rule: Order Line Quantity ≥ 3 for "T-shirts"
- Reward: Order Line Product Reward - 33% off "T-shirts" (limited to cheapest item)

![Buy X Get Y Example](../images/advanced-buy-get.png)

### Category Cross-Promotion
Encourage purchases across different categories:

**Example: Buy electronics, get 50% off accessories**
- Rule Group (FUNNEL):
  - Order Line Product Category: "Electronics" (any quantity)
  - Order Line Product Category: "Accessories" (for discount targeting)
- Reward: Order Line Amount Reward - 50% off targeted accessories

![Category Cross-Promotion](../images/advanced-cross-promotion.png)

### Shipping Tier Rewards
Create shipping discounts based on order characteristics:

**Standard Shipping Discount:**
- Rule: Order Amount ≥ $50
- Reward: Order Amount Reward - 50% off shipping

**Free Express Shipping:**
- Rule: Order Amount ≥ $150
- Reward: Order Amount Reward - Free shipping

![Shipping Tier Rewards](../images/advanced-shipping-tiers.png)

## Reward Stacking and Interaction

### Discount Stacking
Control how multiple rewards interact when applied together:

**Stacking Options:**
- **Additive** - Discounts are added together
- **Compound** - Discounts are applied sequentially
- **Best Value** - The best discount for the customer is applied
- **Exclusive** - Only one discount can be applied

![Reward Stacking Configuration](../images/reward-stacking.png)

### Blocking Mechanisms
Prevent certain rewards from being combined:

- **Block Further Discounts** - This reward prevents others from applying
- **Block if Other Discounts** - This reward won't apply if others are active
- **Category Exclusions** - Certain discount types cannot be combined

![Reward Blocking Options](../images/reward-blocking.png)

### Priority and Ordering
Control the order in which rewards are evaluated and applied:

1. **Evaluation Order** - The sequence rewards are checked
2. **Application Priority** - Which rewards take precedence
3. **Customer Benefit** - Ensuring the best deal for customers

![Reward Priority Settings](../images/reward-priority.png)

## Reward Performance and Analytics

### Tracking Reward Usage
Monitor how rewards are being used:

- **Application Frequency** - How often each reward is triggered
- **Revenue Impact** - The financial effect of rewards
- **Customer Behavior** - How rewards influence purchasing patterns

![Reward Analytics Dashboard](../images/reward-analytics.png)

### Performance Optimization
Optimize reward performance:

- **Calculation Efficiency** - Streamline discount calculations
- **Memory Usage** - Minimize resource consumption
- **Database Queries** - Optimize data retrieval for reward evaluation

![Reward Performance Metrics](../images/reward-performance.png)

## Custom Reward Development

The reward system is extensible, allowing developers to create custom rewards for specific business needs.

### Creating Custom Rewards
Custom rewards must implement the `IDiscountReward` interface:

```csharp
public class CustomProductReward : IDiscountReward
{
    public DiscountRewardResult CalculateReward(DiscountRewardContext context)
    {
        // Custom reward calculation logic
        return new DiscountRewardResult
        {
            DiscountAmount = calculatedAmount,
            Description = "Custom reward applied"
        };
    }
}
```

### Registration
Register custom rewards in your startup configuration:

```csharp
services.AddTransient<IDiscountReward, CustomProductReward>();
```

### Advanced Custom Scenarios
Examples of custom rewards:
- **Loyalty Points Integration** - Award points based on purchase amounts
- **Dynamic Pricing** - Adjust prices based on real-time data
- **Third-Party Integration** - Connect with external promotional systems
- **Time-Based Discounts** - Apply different discounts based on time of day

For detailed information on custom reward development, see the [Developer Documentation](/developer-guides/discounts/custom-rewards/).

## Testing and Validation

### Reward Testing Strategies
Ensure rewards work correctly:

- **Unit Testing** - Test individual reward calculations
- **Integration Testing** - Test reward interactions with rules
- **End-to-End Testing** - Test complete discount scenarios
- **Performance Testing** - Verify reward calculation speed

![Reward Testing Interface](../images/reward-testing.png)

### Validation Tools
Built-in tools to help validate reward behavior:

- **Preview Mode** - Test rewards before going live
- **Calculation Debugger** - Step through reward calculations
- **Impact Simulator** - Project the financial impact of rewards

![Reward Validation Tools](../images/reward-validation.png)

### Common Testing Scenarios
Important scenarios to test:

1. **Edge Cases** - Unusual order configurations
2. **Boundary Conditions** - Minimum and maximum order values
3. **Multiple Rewards** - How rewards interact when stacked
4. **Performance** - Large orders with many applicable rewards

## Troubleshooting Rewards

### Common Issues
Frequent reward-related problems and solutions:

**Reward Not Applying:**
- Check that associated rules are satisfied
- Verify reward configuration settings
- Ensure no blocking conditions are preventing application

**Incorrect Discount Amount:**
- Validate calculation logic
- Check for rounding issues
- Verify currency settings

**Performance Issues:**
- Review complex reward calculations
- Check for inefficient database queries
- Consider caching expensive operations

![Reward Troubleshooting Guide](../images/reward-troubleshooting.png)

### Debugging Tools
Built-in debugging features:

- **Calculation Trace** - Step-by-step calculation breakdown
- **Rule-Reward Mapping** - See which rules trigger which rewards
- **Performance Profiler** - Identify slow reward calculations

![Reward Debugging Interface](../images/reward-debugging.png)

### Best Practices
Guidelines for effective reward implementation:

- **Keep Calculations Simple** - Avoid overly complex reward logic
- **Test Thoroughly** - Validate rewards across various scenarios
- **Monitor Performance** - Watch for calculation bottlenecks
- **Document Custom Logic** - Maintain clear documentation for custom rewards
- **Regular Review** - Periodically assess reward effectiveness

## Integration Examples

### E-commerce Platform Integration
Common integration patterns:

**Product Catalog Integration:**
```csharp
// Example: Integrate with product categories
var categoryReward = new OrderLineAmountReward
{
    TargetCategory = "Electronics",
    DiscountType = DiscountType.Percentage,
    DiscountValue = 15
};
```

**Customer Loyalty Integration:**
```csharp
// Example: Integrate with loyalty points
var loyaltyReward = new CustomLoyaltyReward
{
    PointsMultiplier = 2.0,
    MinimumOrderValue = 100
};
```

**Inventory Management Integration:**
```csharp
// Example: Clearance item rewards
var clearanceReward = new OrderLineProductReward
{
    TargetProducts = GetClearanceProducts(),
    DiscountType = DiscountType.Percentage,
    DiscountValue = 40
};
```

For more integration examples, see the [Integration Guide](/integration-guides/discounts/).

## Related Topics

- [Discount Rules](../rules/) - Understanding how rules work with rewards
- [Main Discounts Documentation](../) - Overview of the entire discount system
- [Order Processing](/reference/orders/) - How discounts affect order processing
- [Developer Guide](/developer-guides/discounts/) - Technical implementation details
- [API Reference](/api-reference/discounts/) - Programmatic discount management

