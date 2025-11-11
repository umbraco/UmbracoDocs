---
description: >-
  Learn about the core framework of the Umbraco Backoffice, including how to
  integrate, communicate, and build reactive UIs for your extensions.
---

# Foundation

In this section, you will find comprehensive resources about the foundational concepts and tools for building Backoffice extensions. These topics cover everything from basic terminology to advanced patterns for data management and UI development.

## Core Concepts

### [Terminology](terminology.md)

Get an overview of the general terms used in the Umbraco Backoffice and what they represent.

### [Umbraco Element](umbraco-element/)

The Umbraco Element provides the foundation you need to integrate your custom UI components.

### [Umbraco Controller](umbraco-controller/)

Contain or reuse logic across elements. Controllers enable you to separate business logic while remaining connected to the element life cycle.

### [Lit Element](lit-element.md)

Learn about Lit Element, the Web Component framework that most examples and the majority of the Backoffice are built upon.

## Communication and Data Management

### [Context API](context-api/)

Learn how to communicate with the rest of the application, whether you want to retrieve data or manipulate it.

### [Contexts](contexts/)

Explore specific context implementations, including the Property Dataset Context that connects Property Editors with Workspaces.

### [Fetching Data](fetching-data/)

Learn how to request data when extending the Backoffice, using either the Fetch API or the Umbraco HTTP Client.

### [Repositories](repositories/)

Discover how to use repositories to manage data operations in a structured way, abstracting the data access layer for easier maintenance and scalability.

## UI Development

### [States — Make Reactive UI](states.md)

Bring life to your UI by ensuring it stays up to date with the current data through reactive state management.

### [Icons](icons.md)

Learn how to use icons in the Umbraco Backoffice, based on Lucide Icons and Simple Icons.

### [Localization](localization.md)

Discover how to manage and use Backoffice UI localization files to translate your extensions into different languages.

### [Integrate Validation](integrate-validation.md)

Learn how to bind and use the validation system when working with Form Controls and custom Property Editors.

### [Sorting](sorting.md)

Create a UI that users can sort via drag and drop functionality.

### [Routes](routes.md)

Implement routes in your UI, enabling users to deep link directly into your custom interfaces.

## Additional Resources

### [Community Resources](https://github.com/umbraco/Umbraco.Packages/tree/main/bellissima)

An overview of community articles and packages related to the Umbraco Backoffice.

### [Next-Level  Backoffice](https://www.youtube.com/watch?v=P0xxTIlHayg)

Watch Niels Lyngsø's Codegarden 2025 talk about next-level Umbraco Backoffice
