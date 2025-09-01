---
description: >-
  The Extension types have some general features and some are provide
  specifically to a type.
---

# Extension Types

### General features <a href="#package-manifest" id="package-manifest"></a>

The general features of all Extension Types can be read as part of the [Extension Manifest Article](../extension-registry/extension-manifest.md)

### General Extension Type <a href="#package-manifest" id="package-manifest"></a>

The system provides Extension Types for certain needs and then there is a few that has a general purpose.

### [Bundle](bundle.md) <a href="#package-manifest" id="package-manifest"></a>

The `bundle` type enables you to gather many extension manifests into one. These will be registered at startup.

### [Backoffice Entry Point](backoffice-entry-point.md) <a href="#entry-point" id="entry-point"></a>

The `backofficeEntryPoint` type is used to execute the method of a JavaScript file when the backoffice is initialized. This file can be used to do anything, this enables more complex logic to take place on startup.

### [Extension Conditions](condition.md) <a href="#conditions" id="conditions"></a>

Most Extension Types support conditions. Defining conditions enables you to control when and where the Extension is available. This Type enables you to bring your own Conditions for the system.

### [Kinds](kind.md) <a href="#kinds" id="kinds"></a>

The Kind-type enables you to base your Extension registration on a preset manifest. A kind provides the base manifest that your manifest will be amending. A typical Kind declaration would provide a default Element, making it posible for you to only configure the Element via properties of the Manifest.
