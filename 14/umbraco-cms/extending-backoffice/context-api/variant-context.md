---
description: The Variant Context is a context that holds the data for a set of properties.
---

# Variant Context

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

Property Editors UIs require the Variant Context to be present to work. This enables Property Editor UIs to have a generic relation with its ownership.

The Variant context holds a name and a set of properties. What makes a property can vary but an alias and a value are required.

### Variant Context concerning Property Editors and Workspaces

A Variant Context is the connection point between a Property Editor and a Workspace.

The hierarchy is as follows:

* Workspace Context
  * Variant Context
    * Property Editor UIs

A variant context covers a set of properties, in some cases a workspace then needs to have multiple variants. An example of such is Document Workspace. Each variant has its own set of properties and a name.

### Setup a Variant Context

It would be good to have examples for developers to see how to set up a Variant Context, in code. (This might need to be a tutorial demonstrating implementing a workspace with a variant with Property Editor UIs)
