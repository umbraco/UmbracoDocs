---
versionFrom: 8.0.0
meta.Title: "Umbraco Heartcore"
meta.Description: "An introduction to Umbraco Heartcore"
---

# Umbraco Heartcore

In this section you will find documentation on how to work with Umbraco Heartcore.

It includes REST API documentation, the basics on how to get started and how to work with the available Client Libraries. Please note that Umbraco Heartcore is a specific type of project only available via Umbraco Cloud.

## What is Umbraco Heartcore?

Umbraco Heartcore is a headless SaaS (Software as a Service) offered by Umbraco. The service enables you to create and manage content and media in the Umbraco backoffice and make it available to any - and multiple - platforms, devices, channels etc. in order to distribute your content.

The product comes with a set of API endpoints that enables you to provide content through Umbraco to websites, apps, smartwatches or any other platform you can think of. The idea is that you create, manage and work with content in the Umbraco backoffice and then you use the API endpoints to distribute the content wherever you want.

All Umbraco Heartcore projects includes a Content Delivery Network (CDN) using CloudFlare. This CDN is used for caching content and media fetched through the Content Delivery API. Additionally, the media CDN (media.umbraco.io) ensures resizing and cropping options, which improves both performance and stability.

You can read more about all the features and benefits on the [Umbraco Heartcore product page](https://umbraco.com/products/umbraco-heartcore/).

There are 3 ways to get your hands on an Umbraco Heartcore project:

- [Take a 14 day free trial](https://umbraco.com/try-umbraco-heartcore)
- [Purchase a Heartcore from Umbraco.com](https://umbraco.com/umbraco-heartcore-pricing)
- [Setup a project directly from the Umbraco Cloud Portal](https://umbraco.io) - requires that you already have an account

## [Getting Started with Umbraco Heartcore](Getting-Started-Cloud/)

In order to get started with Umbraco Heartcore you will need to create a new project via the Umbraco Cloud Portal and familiarize yourself with the features available. This includes the Headless section in the backoffice and creating API Keys for authentication and authorization purposes.

In this article you will learn how to create your first Umbraco Heartcore project and go through the steps needed to get your first content published in order to start using the APIs.

### Setup a Trial project

<iframe width="800" height="450" src="https://www.youtube.com/embed/VL87NCz5Dwg?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## [API Documentation for the Umbraco Heartcore REST API endpoints](API-Documentation/)

Reference documentation for the two APIs available, as well as details about common HTTP headers, versioning, REST Standard and how to work with authentication and authorization.

- [Authentication and Authorization](API-Documentation/#authentication-and-authorization)
- [GraphQL API](API-Documentation/GraphQL)
- [Content Delivery API](API-Documentation/Content-Delivery)
- [Content Management API](API-Documentation/Content-Management)

## [Client libraries](Client-Libraries)

In order to test your Umbraco Heartcore project against the REST API endpoints, you can use one of the samples we provide with the client libraries for .NET Core and Node JS.

## [Versions and updates](Versions-and-updates)

Learn more about how we handle versioning and updates of Heartcore projects.

## [Frequently asked questions](https://umbraco.com/products/umbraco-heartcore/faq/)

Have questions that is not covered by this documentation? Please create an issue on our [Documentation Issue Tracker](https://github.com/umbraco/UmbracoDocs/issues) or get in touch with Umbraco Support using the chat in the portal or write support@umbraco.com.
