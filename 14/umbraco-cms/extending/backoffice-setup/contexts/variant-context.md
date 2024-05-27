---
description: The Variant Context is a context that holds the data for a set of properties.
---

# Property Dataset Context

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

Property Editors UIs require the Dataset Context to be present to work. This enables Property Editor UIs to have a generic relation with its ownership.

The Dataset Context holds a name and a set of properties. What makes a property can vary but an alias and a value are required.

### Dataset Context Concerning Property Editors and Workspaces

A Dataset Context is the connection point between a Property Editor and a Workspace.

The hierarchy is as follows:

* Workspace Context
  * Dataset Context
    * Property Editor UIs

A dataset context covers a set of properties, in some cases a workspace then needs to have multiple variants. An example of such is Document Workspace. Each variant has its own set of properties and a name.

### Setup a Dataset Context

It would be good to have examples for developers to see how to set up a Dataset Context, in code. (This might need to be a tutorial demonstrating implementing a workspace with a variant with Property Editor UIs)
