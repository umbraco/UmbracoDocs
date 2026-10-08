---
description: >-
  Install the Umbraco.UIBuilder.Automate add-on alongside Umbraco UI Builder.
---

# Installation

## Prerequisites

* Umbraco Automate installed and configured
* Umbraco UI Builder installed and configured, with at least one collection registered

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.UIBuilder.Automate
```
{% endcode %}

Restart your Umbraco site. The UI Builder triggers and actions appear in the catalogue under the **UI Builder** group.

## Next Steps

{% content-ref url="triggers.md" %}
[Triggers](triggers.md)
{% endcontent-ref %}
