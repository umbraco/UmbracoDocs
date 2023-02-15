# What is Umbraco Heartcore?

Umbraco Heartcore is a headless Software As A Service (SAAS) offered by Umbraco. The service enables you to create and manage content and media in the Umbraco backoffice and make it available to any platforms, devices, channels etc.

The product comes with a set of API endpoints that enables you to provide content through Umbraco to any platform you can think of. The idea is that you create content in the Umbraco backoffice and you use the API endpoints to distribute the content wherever you want.

All Umbraco Heartcore projects includes a Content Delivery Network (CDN) using CloudFlare. This CDN is used for caching content and media fetched through the Content Delivery API. Additionally, the media CDN (media.umbraco.io) allows for resizing and cropping options, which improves both performance and stability.

You can read more about all the features and benefits on the [Umbraco Heartcore product page](https://umbraco.com/products/umbraco-heartcore/).

There are 3 ways to get your hands on an Umbraco Heartcore project:

* [Take a 14 day free trial](https://umbraco.com/try-umbraco-heartcore/)
* [Purchase a Heartcore from Umbraco.com](https://umbraco.com/umbraco-heartcore-pricing/)
* [Setup a project directly from the Umbraco Cloud Portal](https://umbraco.io) - requires that you already have an account

In this section you will find documentation on how to work with Umbraco Heartcore.

It includes REST API documentation, the basics on how to get started and how to work with the available Client Libraries. Please note that Umbraco Heartcore is a specific type of project only available via Umbraco Cloud.

## [API Documentation for the Umbraco Heartcore REST API endpoints](../api-documentation/)

Reference documentation for the APIs available, as well as details about common HTTP headers, versioning, REST Standard and how to work with authentication and authorization.

* [Authentication and Authorization](../api-documentation/#authentication-and-authorization)
* [Content Delivery API](../api-documentation/content-delivery/)
* [Content Management API](../api-documentation/content-management/)
* [GraphQL API](../api-documentation/graphql/)

## GraphQL

Reference documentation and tutorials for the GraphQL API.

* [GraphQL API Documentation](../api-documentation/graphql/)
* [GraphQL Filter and Ordering Documentation](../api-documentation/graphql/filtering-and-ordering.md)

### Tutorials

* [Querying With GraphQL](../tutorials/querying-with-graphql.md) - Learn how to query Umbraco Heartcore with GraphQL

## [Getting Started with Umbraco Heartcore](../getting-started/)

In order to get started with Umbraco Heartcore you will need to create a new project via the Umbraco Cloud Portal and familiarize yourself with the features available. This includes the Headless section in the backoffice and creating API Keys for authentication and authorization purposes.

In this article you will learn how to create your first Umbraco Heartcore project and go through the steps needed to get your first content published in order to start using the APIs.

### Setup a Trial project

{% embed url="https://www.youtube.com/embed/Rujaw1VWUaQ?rel=0" %}
How to create a Heartcore Trial
{% endembed %}

## [Client libraries](../client-libraries/)

In order to test your Umbraco Heartcore project against the REST API endpoints, you can use one of the samples we provide with the client libraries for .NET Core and Node JS.

## [Versions and updates](../versions-and-updates.md)

Learn more about how we handle versioning and updates of Heartcore projects.

## [Frequently asked questions](https://umbraco.com/products/umbraco-heartcore/heartcore-faq/)

Do you have questions that are not covered by this documentation? Please create an issue on our [Documentation Issue Tracker](https://github.com/umbraco/UmbracoDocs/issues) or get in touch with Umbraco Support using the chat in the portal or write a mail to support@umbraco.com.
