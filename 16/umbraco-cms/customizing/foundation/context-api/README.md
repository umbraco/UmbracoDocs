---
description: >-
  Learn about using the Context API for sharing data and functionality between
  backoffice extensions through the component hierarchy.
---

# Context API

The Context API is a powerful communication system in Umbraco's backoffice. It enables extensions to share data and functionality through the component hierarchy without tight coupling. Think of it as a way for different parts of your UI to talk to each other and access shared services.

Contexts are used throughout the Umbraco backoffice to provide access to workspace data, notifications, user information, and many other services. When building custom extensions, you will often need to consume existing contexts or create your own to share functionality between your components.

## Key Concepts

The Context API is built on a few core principles:

* **Provider-Consumer Pattern**: Parent elements provide contexts that descendant elements can consume
* **Loose Coupling**: Components don't need direct references to each other
* **Hierarchical**: Contexts flow down through the DOM tree
* **Type-Safe**: Context Tokens ensure you get the right context

The Context API provides a structured way to access and share functionality when building property editors, workspace extensions, dashboards, or any other backoffice UI.

## [Context API Fundamentals](context-api-fundamentals.md)

Learn the core concepts, terminology, and flow mechanisms of the Context API. Understand how contexts are provided and consumed through the element hierarchy, and explore common context types used throughout Umbraco.

## [Consume a Context](consume-a-context.md)

Learn how to consume contexts in your extensions using one-time references or subscriptions. This guide covers consuming contexts in UI elements, services, and non-UI classes, with practical code examples for each scenario.

## [Provide a Context](provide-a-context.md)

Learn how to create and provide your own custom contexts. Make your data and functionality available to descendant elements in the component hierarchy.

