---
versionFrom: 8.0.0
---

# Umbraco Headless

In this section you will find documentation on how to manage, configure and work with Umbraco Headless.

It includes API documentation, the basics on how to get started and how to work with the available Client Libraries.

Please note that Umbraco Headless is a specific type of project only available via Umbraco Cloud.

## What is Umbraco Headless?

TODO

// This is supposed to be more of a general description of the project, right?
// We should also in this section link to Umbraco.com landing pages on the product.

## [API Documentation for the Umbraco Headless endpoints](API-Documentation/)

Reference documentation for the two APIs available, as well as details about common HTTP headers, versioning, REST Standard and how to work with authentication and authorization.

- [Authentication and Authorization](API-Documentation/#authentication-and-authorization)
- [Content Delivery API](API-Documentation/#content-delivery-api)
- [Content Management API](API-Documentation/#content-management-api)

## [Getting Started with Headless](Getting-Started-Cloud/)

In order to get started with Umbraco Headless you will need to create a new project via the Umbraco Cloud Portal and familiarize yourself with the features available. This includes the Headless section in the backoffice and creating API Keys for authentication and authorization purposes.

In this article you will learn how to create your first Umbraco Headless Project and go through the steps needed to get your first content published in order to start using the APIs.

## [Getting Started with the APIs](Getting-Started-API/)

Anything with access to the internet can use the REST APIs via HTTP to retrieve Content and Media through the Content Delivery API. Using the same approach it is also possible to create, update and delete Content, Media, Languages, Members and Relations through the Content Management API.

In this article you will learn how to use the two APIs through basic HTTP calls.

## [Getting Started with the .NET Core Client Library](Getting-Started-DotNetCore/)

The .NET Core Client Library is an easy and convenient way of working with the Umbraco Headless APIs when you are building apps, websites, Xamarin apps or other .NET based code. This library is based on NET Standard 2.0 meaning that it can be used for almost anything .NET based.

The .NET Core Client Library covers both the Content Delivery and Content Management APIs. Specifically for the Content Delivery API you can choose to build strongly typed models for your content and media. That way it becomes even more intuitive to work with.

The library is available via nuget and can be installed through Visual Studio.
