---
description: >-
  Install the Umbraco.AI.Automate add-on alongside Umbraco.AI and
  Umbraco.AI.Agent.
---

# Installation

## Prerequisites

* Umbraco Automate installed and configured
* Umbraco.AI installed with at least one AI provider configured
* Umbraco.AI.Agent installed with at least one agent available to automations

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.AI.Automate
```
{% endcode %}

Restart your Umbraco site. The AI triggers and actions appear in the catalogue under the **AI** group.

## Next Steps

{% content-ref url="triggers.md" %}
[Triggers](triggers.md)
{% endcontent-ref %}
