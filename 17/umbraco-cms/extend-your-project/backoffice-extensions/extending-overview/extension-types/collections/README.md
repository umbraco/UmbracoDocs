---
description: >-
  Learn how to register a Collection extension, connect it to a Collection Repository and configure Collection Views to display entity lists.
---

# Collections

A Collection is an extension that fetches and exposes a list of entities in the Umbraco backoffice. It connects a **Collection Repository**, for fetching data, and one or more **Collection Views** (the display layer).

The Collection itself does not render anything. It manages pagination, filtering, and selection state — the Collection Views decide how items are presented.

## How the parts relate

| Part | Role |
|---|---|
| **Collection** | Registers the extension and points to a repository alias |
| **Collection Repository** | Fetches and returns items |
| **Collection View** | Bound to the collection via its alias; renders the items |

## Articles

* [Collection](collection.md)
* [Collection View](collection-view/README.md)
