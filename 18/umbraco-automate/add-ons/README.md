---
description: >-
  Add-on packages expand Umbraco Automate with extra triggers, actions, and
  connection types.
---

# Overview

Add-ons are NuGet packages that add new triggers and actions to Umbraco Automate. Install only the add-ons you need.

## Available Add-ons

| Add-on                | What it adds                                                                                                                           |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| [Slack](slack/)       | Slack connection type and **Send Slack Message** action.                                                                               |
| [AI](ai/)             | Triggers for AI agent run lifecycle events. Actions for running AI agents and transcribing audio.                                      |
| [Forms](forms/)       | Triggers for form submission and approval. Actions for submitting and exporting form entries.                                          |
| [Commerce](commerce/) | Triggers and actions for orders, payments, stock, discounts, and gift cards.                                                           |
| [Engage](engage/)     | Triggers for A/B tests, segments, personas, and customer journeys. Actions for goals, persona scoring, and journey scoring.            |
| [Deploy](deploy/)     | Deploy lifecycle triggers, plus Umbraco Deploy support for transferring automations, workspaces, and connections between environments. |

## Installing an Add-on

Each add-on is installed by adding its NuGet package to your Umbraco project. For example, to install the Slack add-on, use the following command:

```bash
dotnet add package Umbraco.Automate.Slack
```

The package's triggers, actions, and connection types are auto-discovered at startup. They appear in the catalogue picker when you next build or edit an automation.

See each add-on's own **Installation** page for prerequisites and configuration.
