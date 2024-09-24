---
description: Learn more about recommendation when is comes to infrastructure and database.
---

# Infrastructure sizing

To determine the optimal infrastructure sizing the most important metric is the number of page views you need to process. Peak load is also an important factor.

The following presents recommendations based on environment as well as the number of expected page views.

## Non-cloud

- **100.000 page views per month or less:** Database: CPU 2, 4-8 GB RAM, 50GB disk
- **500.000 page views per month or less:** Database: CPU 4, 8-16 GB RAM, 100GB SSD disk
- **1.000.000 page views per month or less:** Database: CPU 8, 16-32 GB RAM, 250GB SSD disk
- **1.000.000 page views per month or more:** Please [contact our Expert Services](mailto:info@umarketingsuite.com) team to discuss the infrastructure requirements.

## Cloud environments

Due to the rapidly changing naming and sizing of Azure instances we recommend using the appropriate supplier tools to determine the exact sizing. Base the exact sizing on the non-cloud recommendations above.  

In general, for Azure SQL use at least a S3 instance for production purposes.

## Umbraco Cloud

- **100.000 page views per month or less:** Standard / Professional
- **500.000 page views per month or less:** Professional
- **500.000 page views per month or more:** Professional / Enterprise

Always discuss the exact requirements with your agency or the Umbraco Cloud team. If needed discuss Prioritized Cloud Computing, Prioritized Database Performance and Dedicated Resources based on the expected load.

{% hint style="info" %}
Above you will find general recommendations on which infrastructure parameters to use. While these should work well for most cases, you may need to adjust the infrastructure parameters to suit your page view processing workload. Large or heavily trafficked websites may have higher requirements. If you expect high page view peaks it is recommended to scale to a tier higher then normally.
{% endhint %}
