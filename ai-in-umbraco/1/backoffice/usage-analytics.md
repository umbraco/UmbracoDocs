---
description: >-
    Understand AI usage patterns with analytics dashboards.
---

# Usage Analytics

The Usage Analytics dashboard provides aggregated insights into AI operations, helping you understand usage patterns, costs, and performance.

## Accessing Analytics

1. Navigate to the **AI** section in the main navigation
2. Click **Analytics** (or **Usage**) in the tree

## Dashboard Overview

![The analytics dashboard showing usage metrics, success rate, and usage over time chart](../.gitbook/assets/backoffice-analytics-dashboard.png)

The analytics dashboard shows:

### Summary Metrics

| Metric         | Description                           |
| -------------- | ------------------------------------- |
| Total Requests | Number of AI operations in the period |
| Total Tokens   | Combined input and output tokens      |
| Success Rate   | Percentage of successful operations   |
| Avg Duration   | Average operation time                |

### Time Series Chart

A chart showing usage over time:

- **X-axis**: Time (hours, days, weeks, or months)
- **Y-axis**: Requests, tokens, or success rate
- **Granularity**: Adjustable based on date range

### Breakdowns

Pie or bar charts showing distribution:

- **By Provider** - Which providers are used most
- **By Model** - Which models consume most tokens
- **By Profile** - Which profiles are most active
- **By User** - Who uses AI features most

![Analytics breakdown tables by provider, model, profile, and user](../.gitbook/assets/backoffice-analytics-breakdowns.png)

## Date Range Selection

Select the time period to analyze:

| Range         | Best For             |
| ------------- | -------------------- |
| Last 24 hours | Real-time monitoring |
| Last 7 days   | Weekly trends        |
| Last 30 days  | Monthly analysis     |
| Custom range  | Specific period      |

## Reading the Charts

### Usage Trends

Look for patterns:

- **Peak hours** - When is usage highest?
- **Growth trends** - Is usage increasing?
- **Anomalies** - Sudden spikes or drops

### Provider Distribution

Understand cost drivers:

- Which providers handle most requests
- Token distribution across providers
- Opportunities to optimize costs

### User Distribution

Identify usage patterns:

- Power users who might benefit from training
- Unexpected usage that might indicate issues
- Opportunities for user education

## Cost Estimation

While exact costs depend on your provider contracts, you can estimate costs:

1. View the **By Model** breakdown
2. Note total tokens per model
3. Calculate based on provider pricing

{% hint style="info" %}
Analytics show token counts. Multiply by your provider's per-token pricing for cost estimates.
{% endhint %}

## Exporting Data

To export analytics data:

1. Set your desired date range
2. Click **Export**
3. Choose format (CSV, JSON)

## Use Cases

### Cost Optimization

1. Review the **By Model** breakdown
2. Identify high-cost models
3. Consider whether cheaper models could work for some use cases
4. Create separate profiles for different quality requirements

### Capacity Planning

1. Review the **Time Series** chart
2. Identify usage growth trends
3. Project future needs
4. Adjust rate limits or provider tiers accordingly

### User Training

1. Review the **By User** breakdown
2. Identify users with unusual patterns
3. Provide training to optimize usage
4. Identify effective usage patterns from active users

### Performance Monitoring

1. Monitor **Success Rate** over time
2. Alert on drops in success rate
3. Investigate **Avg Duration** increases
4. Correlate with system changes

## Configuration

### Data Retention

Analytics are derived from audit logs. Configure retention:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "AuditLog": {
                "RetentionDays": 90
            }
        }
    }
}
```

{% endcode %}

{% hint style="warning" %}
Analytics for periods older than the retention period will be incomplete or unavailable.
{% endhint %}

## Programmatic Access

For custom dashboards or integrations, use the [Analytics API](../management-api/analytics/README.md).

## Related

- [Audit Logs](audit-logs.md) - Raw operation data
- [Analytics API](../management-api/analytics/README.md) - Programmatic access
