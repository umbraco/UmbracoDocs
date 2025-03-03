# What is Umbraco Heartcore?

Umbraco Heartcore is a headless Software As A Service (SAAS) offered by Umbraco. The service enables you to create and manage content and media in the Umbraco backoffice and make it available to any platforms, devices, channels and so forth.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Getting started</strong></td><td>Get started working with Umbraco Heartcore</td><td><a href="../generic/images/headless.png">headless.png</a></td><td><a href="api-documentation/content-delivery/content.md">content.md</a></td></tr><tr><td><strong>Umbraco Heartcore APIs</strong></td><td>See the different APIs available in Umbraco Heartcore</td><td><a href="../generic/images/code (1) (1) (1).png">code (1) (1) (1).png</a></td><td><a href="api-documentation/">api-documentation/</a></td></tr><tr><td><strong>Client libraries</strong></td><td>Test out your Umbraco Heartcore project with the pre-made client libraries</td><td><a href="../generic/images/devices.png">devices.png</a></td><td><a href="client-libraries/">client-libraries/</a></td></tr></tbody></table>

{% embed url="https://www.youtube.com/embed/Rujaw1VWUaQ?rel=0" %}
How to create a Heartcore Trial
{% endembed %}

{% content-ref url="api-documentation/" %}
[api-documentation](api-documentation/)
{% endcontent-ref %}

{% content-ref url="api-documentation/graphql/" %}
[graphql](api-documentation/graphql/)
{% endcontent-ref %}

{% content-ref url="getting-started/deployment-workflow/" %}
[deployment-workflow](getting-started/deployment-workflow/)
{% endcontent-ref %}

All Umbraco Heartcore projects include a Content Delivery Network (CDN) using CloudFlare. This CDN is used for caching content and media fetched through the Content Delivery API. Additionally, the media CDN (media.umbraco.io) allows for resizing and cropping options, which improves both performance and stability.

You can read more about all the features and benefits on the [Umbraco Heartcore product page](https://umbraco.com/products/umbraco-heartcore/). You can also look at the pricing, plans, and features on the [Umbraco Heartcore Pricing](https://umbraco.com/products/umbraco-heartcore/pricing/) page.

There are 3 ways to get your hands on an Umbraco Heartcore project:

* [Take a 14-day free trial](https://try.umbraco.com/heartcore)
* [Purchase a Heartcore from Umbraco.com](https://umbraco.com/umbraco-heartcore-pricing/)
* [Setup a project directly from the Umbraco Cloud Portal](https://umbraco.io) - requires that you already have an account

In this section, you will find documentation on how to work with Umbraco Heartcore.

It includes REST API documentation, the basics of how to get started, and how to work with the available Client Libraries. Please note that Umbraco Heartcore is a specific type of project only available via Umbraco Cloud.

## [API Documentation for the Umbraco Heartcore REST API endpoints](api-documentation/)

Reference documentation for the APIs available, as well as details about common HTTP headers, versioning, REST Standard, and how to work with authentication and authorization.

* [Authentication and Authorization](api-documentation/#authentication-and-authorization)
* [Content Delivery API](api-documentation/content-delivery/)
* [Content Management API](api-documentation/content-management/)

## GraphQL

Reference documentation and tutorials for the GraphQL API.

* [GraphQL API Documentation](api-documentation/graphql/)
* [GraphQL Filter and Ordering Documentation](api-documentation/graphql/#filtering-and-ordering)

## [Versions and updates](versions-and-updates.md)

Learn more about how we handle versioning and updates of Heartcore projects.

## [Frequently asked questions](https://umbraco.com/products/umbraco-heartcore/heartcore-faq/)

Do you have questions that are not covered by this documentation? Please create an issue on our [Documentation Issue Tracker](https://github.com/umbraco/UmbracoDocs/issues) or get in touch with Umbraco Support using the chat in the portal or write a mail to support@umbraco.com.
