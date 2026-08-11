---
description: >-
  Install the Umbraco.Deploy.Automate add-on alongside Umbraco Deploy.
---

# Installation

## Prerequisites

* Umbraco Automate installed and configured
* Umbraco Deploy installed and configured

## Install the Package

{% code title=".NET CLI" %}
```bash
dotnet add package Umbraco.Deploy.Automate
```
{% endcode %}

Install the package on both the **source** and **target** environments. Both ends need the service connectors and artifact types in order to round-trip Automate entities.

Restart your Umbraco site. The Deploy triggers appear in the catalogue under the **Deploy** group.

## Configuration

Connections are not transferred verbatim. The default policy is:

* Settings are transferred unless explicitly listed in `IgnoreSettings`.
* Values prefixed with `ENC:` (encrypted at rest) are skipped by default. Set `IgnoreEncrypted` to `false` to include them — only when source and target share the same data-protection keyring.

Configure under `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Deploy": {
      "Automate": {
        "Connections": {
          "IgnoreSettings": [],
          "IgnoreEncrypted": true
        }
      }
    }
  }
}
```
{% endcode %}

## Next Steps

{% content-ref url="transferring-automations.md" %}
[Transferring Automations](transferring-automations.md)
{% endcontent-ref %}
