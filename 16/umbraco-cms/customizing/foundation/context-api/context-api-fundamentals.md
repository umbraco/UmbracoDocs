-----
New structure:

Page 1: Introduction to the Context API

•	Section 1: What is the Context API
•	Why it exists (loose coupling, shared state management)
•	Key terminology (Context, Provider, Consumer, Token)

•	Section 2: Core Concepts
•	The parent-child request pattern
•	Context tokens as unique identifiers (expanded to cover both string aliases and proper tokens)
•	Event-driven communication (high level)
•	Context lifecycle (availability/unavailability)
-----

# Context API fundamentals
This article...#TODO#!

## What is the Context API?
The Context API in Umbraco is a communication system that allows backoffice extensions to share data and functionality through their hierarchy. Parent extensions can provide contexts (such as workspace state, content data, or specialized services) that their descendant extensions can request and use. When a child extension needs access to something like the current content being edited or workspace tools, it requests the appropriate context by its identifier and the system finds the nearest provider up the extension hierarchy. This creates loose coupling between extensions because children don't need direct references to their dependencies - they just declare what type of context they need and the system handles the connection. The approach is similar to dependency injection in a sense that it manages dependencies automatically, but it works specifically through the extension structure rather than a central container. For example, a custom property editor can request the `workspace context` to access information about the current document being edited, such as its name, content type, or publication status.

The Context API exists to solve common problems in complex user interfaces:

* Avoiding prop drilling: Instead of passing data through multiple layers of components, child extensions can directly request what they need from any ancestor.
* Loose coupling: Extensions don't need direct references to their dependencies, making the codebase more modular and maintainable.
* Shared state management: Multiple extensions can access and react to the same piece of state without complex wiring.

## Terminology
To understand the Context API, it's important to understand the terminology that is used in the rest of the documentation.

### Context
A service or piece of data that can be shared between extensions. A context represents a specific capability or state that multiple extensions might need to access. Examples include workspace state (what content is currently being edited), content data (the actual values and metadata), user permissions, or specialized services like validation or navigation. Contexts encapsulate both data and the methods to interact with that data, making them more than just simple data containers.

### Context provider
An extension that creates and makes a context available to its child extensions. The provider is responsible for the context's lifecycle - creating it when needed, updating it when state changes, and cleaning it up when no longer required. One extension can provide multiple different contexts if needed.

### Context consumer
Any extension that requests and uses a context provided by one of its ancestor extensions in the hierarchy. An extension becomes a consumer simply by requesting a context - it doesn't need to know which specific ancestor provides the context or implement any special interfaces. The consuming extension receives callbacks when the requested context becomes available or unavailable, allowing it to react appropriately to changes in the extension hierarchy.

### Context Token
A unique identifier used to request specific contexts. Context tokens serve as contracts between providers and consumers - they define exactly which context is being requested and ensure that the right provider responds. This prevents conflicts when multiple contexts might have similar names and makes it clear what functionality is being shared.

## Core concepts
Remember that Umbraco is a collection of extensions. 
- Context type + conditions determine where context is available.
- Context at different levels: globalContext, sectionContext, workspaceContext, propertyContext

Split

- Example top down
- Screenshot with entity context and workspace context
- Global contexts examples
    - Notification context -> notification in Umbraco
    - Current user context -> the currently logged in user