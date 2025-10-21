# Context API fundamentals
This article...#TODO#!

## What is the Context API?
The Umbraco backoffice is just like any web application a collection of DOM elements. Elements can be anything: a button, a property editor, a section, a menu option or a tree. These element have a hierarchy: a button can be a child of a property editor, which is in turn a descendant of a workspace. These DOM elements are part of an entire DOM tree that makes up the Umbraco application.

The Context API in Umbraco is a communication system that allows these elements to share data and functionality through their hierarchy. Parent elements can provide contexts (such as workspace state, content data, or specialized services) that their descendant element can request and use. 

When a child element needs access to something like the current content being edited, it requests the appropriate context by its identifier and the system finds the nearest provider up the element hierarchy. This creates loose coupling between elements because descendants don't need direct references to their dependencies - they just declare what type of context they need and the system handles the connection. 

The approach is similar to dependency injection in a sense that it manages dependencies automatically, but it works specifically through the element structure rather than a central container. For example, a custom property editor can request the `workspace context` to access information about the current document being edited, such as its name, content type, or publication status.

The Context API exists to solve common problems in complex user interfaces:

* Avoiding prop drilling: Instead of passing data through multiple layers of components, child element can directly request what they need from any ancestor.
* Loose coupling: Extensions don't need direct references to their dependencies, making the codebase more modular and maintainable.
* Shared state management: Multiple elements can access and react to the same piece of state without complex wiring.

## Terminology
To understand the Context API, it's important to understand the terminology that is used in the rest of the documentation.

### Context
A service or piece of data that can be shared between elements. A context represents a specific capability or state that multiple elements might need to access. Examples include workspace state (what content is currently being edited), content data (the actual values and metadata), user permissions, or specialized services like validation or navigation. Contexts encapsulate both data and the methods to interact with that data, making them more than just simple data containers. In contrast to repositories, a context - it's in the name - is always only available in the context of a certain element.

### Context provider
An element that creates and makes a context available to its child elements. The provider is responsible for the context's lifecycle - creating it when needed, updating it when state changes, and cleaning it up when no longer required. One extension can provide multiple different contexts if needed.

### Context consumer
Any extension that requests and uses a context provided by one of its ancestor elements in the hierarchy. An extension becomes a consumer simply by requesting a context - it doesn't need to know which specific ancestor provides the context or implement any special interfaces. The consuming extension receives callbacks when the requested context becomes available or unavailable, allowing it to react appropriately to changes in the extension hierarchy.

### Context Token
A unique identifier used to request specific contexts. Context tokens serve as contracts between providers and consumers - they define exactly which context is being requested and ensure that the right provider responds. This prevents conflicts when multiple contexts might have similar names and makes it clear what functionality is being shared.

## Context consume flow
Each DOM element can be a context provider and each descendant of that DOM element can consume that context if desired. When an element want to consume a context, the following happends:

1. An element requests a context by it's token from the Context API.
2. The Context API dispatches an event that starts at the element that requested the context. The event bubbles up the DOM tree to each parent element until an element is found that responds to the event.
3. An instance of the context is provided back by the provider the element that requested the context.

![Context API Flow](images/umbraco_context_api_flow.png)

If no context could be found and the event reaches the top level element (the document), no context is provided.

## Common contexts
Although every element can be a Context Provider, the most important context that you'll come in contact with are registered at four levels in the hierarchy. These four levels are also explicit extension points in the Umbraco manifest. 

#### Global
Global contexts are always available and are registered at the highest level. Examples of context at this level are:
* The `Notification context`, which is used for displaying the notifications in the backoffice of Umbraco. This means that you can consume this context in elements anywhere in the DOM tree and provide notifications.
* The `Current user context`, which has information about the currently logged in user. This means that you can consume this context in elements anywhere in the DOM tree and get information about the logged in user.

#### Section
Section contexts are available in the context of a section. That's everything in the backoffice of Umbraco except the menubar. An example of this level is:
* The `Entity context`, which holds information about the currently selected entity. An entity is generic Umbraco node, which can be a document, media item, settings item etc.

#### Workspace
Workspace contexts work on a workspace; the part of Umbraco that's next to the tree. An example of this level is:
* The `Workspace context`, which holds information about the current entity that's being edited in the workspace. This holds minimal information about an entity and the type of the entity. There are specific workspace context per entity type. For instance, the `Document workspace context` for documents and `Media workspace context` for media.

#### Properties
Property context are contexts that work at the property level. They can work on one or more property editors. An is the clipboard functionality where you can copy and paste blocks between block grids and block lists is a property context. Because these contexts are scoped at the property level, you'll probably not consume those directly.