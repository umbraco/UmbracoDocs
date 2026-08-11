---
description: Learn more about recommendation when is comes to infrastructure and database.
---

# Infrastructure sizing

The number of page views and Peak Load are two important metrics for determining the optimal infrastructure sizing for a project.

The following presents recommendations based on the environment and the number of expected page views.

## Umbraco Cloud

* **100.000 page views per month or less:** Professional
* **500.000 page views per month or less:** Professional (with dedicated resources)
* **500.000 page views per month or more:** Professional / Enterprise (with dedicated resources)

Always discuss the exact requirements with your Umbraco Partner or the Umbraco Cloud team. Discuss Prioritized Cloud Computing, Database Performance, and Dedicated Resources based on the expected load and peak traffic.

Umbraco Engage will run on Umbraco Cloud Standard, but for optimal performance, we recommend Professional. Umbraco Cloud Starter is currently not supported.

## Cloud environments

Due to the wide variety of cloud providers, we recommend using the appropriate supplier tools to determine the exact sizing. For the non-cloud recommendations below, use the sizing as input.

### **Microsoft Azure**

For Azure SQL, use at least a **S3 tier (100 DTUs)** or higher.

{% hint style="warning" %}
Umbraco Engage requires **columnstore index support** for optimal performance. Azure SQL tiers lower than S3 (such as S0, S1, S2) do not support **creating** columnstore indexes. The initial installation will fail on these lower tiers.

**Workaround:** You can temporarily scale up to S3 for the initial installation, then scale back down. Lower tiers can still **query** columnstore indexes once created. However, this configuration is not recommended for production due to potential performance issues. See [Troubleshooting Installations](troubleshooting-installations.md) for details.
{% endhint %}

## Non-cloud

* **100.000 page views per month or less:** Database: CPU 2, 4-8 GB RAM, 50GB disk
* **500.000 page views per month or less:** Database: CPU 4, 8-16 GB RAM, 100GB SSD disk
* **1.000.000 page views per month or less:** Database: CPU 8, 16-32 GB RAM, 250GB SSD disk
* **1.000.000 page views per month or more:** [Contact our Expert Services](mailto:support@umbraco.com) team to discuss the infrastructure requirements.

{% hint style="info" %}
Above you will find general recommendations on which infrastructure parameters to use. While these should work well for most cases, you may need to adjust the infrastructure parameters to suit your page view processing workload. Large or heavily trafficked websites may have higher requirements. If you expect high page view peaks it is recommended to scale to a tier higher than normal.
{% endhint %}
