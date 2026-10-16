---
description: >-
  Information on configuring Templates (Views) and Partials (Partial Views) 
---

# Templating

Templating in Umbraco consists of 3 larger concepts, namely Templates (Views) and Partials (Partial Views).

* Templates are used for the HTML layout of your pages.&#x20;
* Partials can be included in your templates for shared functionality across different page templates.&#x20;

## Templating technology

Umbraco uses ASP.Net MVC Views for implementing templates.

{% hint style="info" %}
The WebForms (masterpages) and Dynamic Razor approaches to templating are still available in Umbraco version 7 but have been removed in Umbraco version 8.
{% endhint %}

### [Working with MVC (views, razor, etc...)](mvc/)

Describes how to work with MVC views, the razor syntax and APIs available. It also describes how to create forms, has some step-by-step guides and other advanced techniques.

## [Models Builder](modelsbuilder/)

A tool that can generate a complete set of strongly-typed published content models for Umbraco. Models are available in controllers, views, anywhere. Runs either from the Umbraco UI, from the command line, or from Visual Studio.
