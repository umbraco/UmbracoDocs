---
description: >-
  An Umbraco API Controller is an ASP.NET WebApi controller that is used for
  creating REST services.
---

# Controllers

Umbraco contains different types of controllers to perform different tasks:

* [Render MVC Controllers](controllers.md#render-mvc-controllers)
* [Surface Controllers](controllers.md#surface-controllers)
* [Public API Controllers](controllers.md#umbraco-api-controllers)
* [Backoffice API Controllers](controllers.md#backoffice-api-controllers)

## Render MVC Controllers

When you make a page request to the MVC application, a controller is responsible for returning the response to that request. The controller can perform one or more actions.

By default, all front-end requests to an Umbraco site are auto-routed via the _Index_ action of a core Controller: `Umbraco.Cms.Web.Common.Controllers.RenderController`.

For details on using Render MVC Controllers, see the [Controller & Action Selection](default-routing/controller-selection.md) article.

## Surface Controllers

A SurfaceController is an MVC controller that interacts with the front-end rendering of an UmbracoPage. They can be used for rendering view components and for handling Form data submissions. SurfaceControllers are auto-routed which means you don't have to add/create your own routes for these controllers to work.

All implementations of Surface Controllers inherit from the base class: `Umbraco.Cms.Web.Website.Controllers.SurfaceController`.

For details on using Surface Controllers, see the [Surface Controllers](../reference/routing/surface-controllers/) article.

## Public API Controllers

A public API Controller is an ASP.NET Core API controller that is used for creating publicly available REST services. For details on implementing public API Controllers, see the [Umbraco API Controllers](../reference/routing/umbraco-api-controllers/) article.

## Backoffice API Controllers

Read the [Creating a Backoffice API article](../tutorials/creating-a-backoffice-api/) for a comprehensive guide to writing APIs for the Management API.

{% hint style="info" %}
The Umbraco Backoffice API is also known as the Management API. Thus, a Backoffice API Controller is often referred to as a Management API Controller.
{% endhint %}

***

## Umbraco Training

Umbraco HQ offers a full-day training course covering everything you need to know about working with MVC in an Umbraco context. The course targets anyone who's interested in learning how to utilize Umbraco´s built-in features and basic functionality with standard MVC.

[Explore the MVC and Umbraco training course](https://umbraco.com/training/course-details/mvc-and-umbraco/) to learn more about the topics covered and how it can enhance your Umbraco development skills.
