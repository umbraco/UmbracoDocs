---
description: >-
  Install the Umbraco.Commerce.Automate add-on alongside Umbraco Commerce.
---

# Installation

## Prerequisites

* Umbraco Automate installed and configured
* Umbraco Commerce installed and configured with at least one store

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.Commerce.Automate
```
{% endcode %}

Restart your Umbraco site. The Commerce triggers and actions appear in the catalogue under the **Commerce** group.

## Next Steps

{% content-ref url="triggers.md" %}
[Triggers](triggers.md)
{% endcontent-ref %}
