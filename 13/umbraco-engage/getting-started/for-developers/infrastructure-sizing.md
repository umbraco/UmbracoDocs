---
description: Learn more about recommendation when is comes to infrastructure and database.
---

# Infrastructure sizing

The number of page views and Peak Load are two important metrics for determining the optimal infrastructure sizing for a project.

The following presents recommendations based on the environment and the number of expected page views.

## Non-cloud

* **100.000 page views per month or less:** Database: CPU 2, 4-8 GB RAM, 50GB disk
* **500.000 page views per month or less:** Database: CPU 4, 8-16 GB RAM, 100GB SSD disk
* **1.000.000 page views per month or less:** Database: CPU 8, 16-32 GB RAM, 250GB SSD disk
* **1.000.000 page views per month or more:** Please [contact our Expert Services](mailto:support@umbraco.com) team to discuss the infrastructure requirements.

## Cloud environments

Due to the rapidly changing naming and sizing of Azure instances, we recommend using the appropriate supplier tools to determine the exact sizing. Base the sizing on the non-cloud recommendations above.

In general, for Azure SQL, use at least a S3 instance for production purposes.

## Umbraco Cloud

* **100.000 page views per month or less:** Professional
* **500.000 page views per month or less:** Professional (with dedicated resources)
* **500.000 page views per month or more:** Professional / Enterprise (with dedicated resources)

Always discuss the exact requirements with your agency or the Umbraco Cloud team. Discuss Prioritized Cloud Computing, Prioritized Database Performance, and Dedicated Resources based on the expected load.

{% hint style="info" %}
Above you will find general recommendations on which infrastructure parameters to use. While these should work well for most cases, you may need to adjust the infrastructure parameters to suit your page view processing workload. Large or heavily trafficked websites may have higher requirements. If you expect high page view peaks it is recommended to scale to a tier higher than normal.
{% endhint %}
