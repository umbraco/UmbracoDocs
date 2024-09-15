## **Infrastructure sizing**

To determine the optimal infrastructure sizing the most important metric is the number of page views you will need to process. Also peak load is an important factor.

uMarketingSuite recommends the following (database) infrastructure sizes when using the following environments.

**Non-cloud**

- **100.000 page views per month or less:** Database: CPU 2, 4-8 GB RAM, 50GB disk
- **500.000 page views per month or less:** Database: CPU 4, 8-16 GB RAM, 100GB SSD disk
- **1.000.000 page views per month or less:** Database: CPU 8, 16-32 GB RAM, 250GB SSD disk
- **1.000.000 page views per month or more:** Please [contact our Expert Services](mailto:info@umarketingsuite.com) team to discuss the infrastructure requirements.

**Cloud environments (Microsoft Azure, Amazon AWS)**

Because of the rapidly changing naming and sizing of Azure and AWS instances we recommend to use the appropriate supplier tools to determine the exact sizing based on the above non-cloud recommendations.  
In general for Azure SQL use at least a S3 instance for production purposes.

**Umbraco Cloud**

- **100.000 page views per month or less:** Standard / Professional
- **500.000 page views per month or less:** Professional
- **500.000 page views per month or more:** Professional / Enterprise

Always discuss the exact requirements with your agency and/or the Umbraco Cloud team and if needed discuss Prioritized Cloud Computing, Prioritized Database Performance and/or Dedicated Resources based on the expected load.

*Note: above you will find general recommendations which infrastructure parameters to use. While these should work well for most cases, you may need to adjust the infrastructure parameters to suit your page view processing workload. Very large or heavily trafficked websites may have significantly higher requirements. If you expect high page view peaks it is recommended to scale to a tier higher then normally.*