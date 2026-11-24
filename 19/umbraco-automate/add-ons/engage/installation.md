---
description: >-
  Install the Umbraco.Engage.Automate add-on alongside Umbraco Engage.
---

# Installation

## Prerequisites

* Umbraco Automate installed and configured
* Umbraco Engage installed and configured

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.Engage.Automate
```
{% endcode %}

Restart your Umbraco site. The Engage triggers and actions appear in the catalogue under the **Engage** group.

## Next Steps

{% content-ref url="triggers.md" %}
[Triggers](triggers.md)
{% endcontent-ref %}
