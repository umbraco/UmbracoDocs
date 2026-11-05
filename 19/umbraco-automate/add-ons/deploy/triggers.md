---
description: >-
  Reference for the triggers contributed by the Umbraco.Deploy.Automate add-on.
---

# Triggers

The Deploy add-on contributes the following triggers. The triggers fire on Umbraco Deploy lifecycle events.

## Common Triggers

| Display Name | Alias |
| ------------ | ----- |
| Deployment Succeeded | `umbracoDeploy.taskCompleted` |
| Deployment Failed | `umbracoDeploy.taskFailed` |
| Content Exported | `umbracoDeploy.artifactExported` |
| Content Imported | `umbracoDeploy.artifactImported` |

## Filesystem Triggers

| Display Name | Alias |
| ------------ | ----- |
| Files Written to Disk | `umbracoDeploy.filesWritten` |
| Files Deleted from Disk | `umbracoDeploy.filesDeleted` |

## Remote and Disk Triggers

| Display Name | Alias |
| ------------ | ----- |
| Remote Deploy Completed | `umbracoDeploy.remoteCompleted` |
| Disk Deploy Completed | `umbracoDeploy.diskTriggered` |

## Advanced Triggers

| Display Name | Alias |
| ------------ | ----- |
| Content Exporting | `umbracoDeploy.artifactExporting` |
| Content Importing | `umbracoDeploy.artifactImporting` |
| Artifact Import Validation | `umbracoDeploy.validateArtifactImport` |
| User Files Updated | `umbracoDeploy.userUpdated` |
| Deploy Work Context Preparing | `umbracoDeploy.workContextPreparing` |

{% hint style="info" %}
The advanced triggers fire before the underlying Deploy operation runs. The automation observes the event but cannot cancel the Deploy operation through Automate.
{% endhint %}
