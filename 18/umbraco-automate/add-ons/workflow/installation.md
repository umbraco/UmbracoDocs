---
description: >-
  Install the Umbraco.Workflow.Automate add-on alongside Umbraco Workflow.
---

# Installation

## Prerequisites

* Umbraco Automate installed and configured
* Umbraco Workflow installed and configured

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.Workflow.Automate
```
{% endcode %}

Restart your Umbraco site. The Workflow triggers appear in the catalogue under the **Workflow** group.

## Next Steps

{% content-ref url="triggers.md" %}
[Triggers](triggers.md)
{% endcontent-ref %}
