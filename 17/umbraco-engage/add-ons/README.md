---
description: >-
  Add-on packages connect Umbraco Engage to other Umbraco products and add new
  capabilities like AI.
---

# Overview

Add-ons are NuGet packages that extend Umbraco Engage. Most add-ons connect Umbraco Engage to another Umbraco product. Install only the add-ons you need.

## Available Add-ons

| Add-on                  | What it adds                                                                                                      |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------- |
| [Forms](forms.md)       | Links Umbraco Forms submissions to visitors: a submission goal type and visitor profile insights.                 |
| [Commerce](commerce.md) | Order tracking per visitor and shopping-based segment rules for Umbraco Commerce.                                 |
| [Deploy](deploy.md)     | Transfers Umbraco Engage configuration items, like goals and A/B tests, between environments with Umbraco Deploy. |
| [AI](ai.md)             | A marketing-focused Copilot that answers questions about your Umbraco Engage data in plain language.              |

## Installing an Add-on

Each add-on is installed by adding its NuGet package to your Umbraco project. For example, to install the Forms add-on, use the following command:

```bash
dotnet add package Umbraco.Engage.Forms
```

See each add-on's page for prerequisites, installation steps, and verification.
