---
description: >-
  Names that are reserved for Umbraco Engage, and how to name your own
  backoffice extensions.
---

# Naming Rules

Umbraco Engage does not validate the names of your extensions. An extension with a name that is already in use can fail with no message in the backoffice. Follow the rules in this article to avoid conflicts.

## Aliases

Use your own prefix for the `alias` of every extension, for example `My.ProfileView.Loyalty`.

{% hint style="warning" %}
The `Engage.` alias prefix is reserved for Umbraco Engage. Do not use the prefix for your own extensions.
{% endhint %}

## Element names

Use your own prefix for the names of your web components, for example `my-loyalty-tab`.

The `ue-` element prefix is reserved for Umbraco Engage.

## Segment rule types

The `meta.type` of a segment rule must match the `RuleType` of your segment rule factory in C#. The value must be unique. When two factories share a rule type, Umbraco Engage uses the first factory.

The following rule types are in use:

| Rule type | Used by |
| --- | --- |
| `Browser` | Umbraco Engage |
| `Campaign` | Umbraco Engage |
| `CustomerJourney` | Umbraco Engage |
| `Device` | Umbraco Engage |
| `Goal` | Umbraco Engage |
| `Location` | Umbraco Engage |
| `MemberLoggedIn` | Umbraco Engage |
| `MemberRegistered` | Umbraco Engage |
| `NumberOfSessions` | Umbraco Engage |
| `PageEvent` | Umbraco Engage |
| `Persona` | Umbraco Engage |
| `TimeOfDay` | Umbraco Engage |
| `VisitedPages` | Umbraco Engage |
| `OrderCompleted` | Umbraco Engage Commerce |
| `ProductsInCart` | Umbraco Engage Commerce |
