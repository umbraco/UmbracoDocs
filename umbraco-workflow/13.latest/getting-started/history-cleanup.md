# History Cleanup

Every new workflow stores multiple records in the database - one for the workflow instance and one for each task in the workflow. In a multi-lingual site, depending on how you use Workflow, there may also be records generated for each culture variation. These records are used to build the workflow history views in the Umbraco backoffice.

Depending on your requirements, this information may not be required or may only be useful for a short period of time.

{% hint style="info" %}
The workflow History exists in addition to Umbraco's audit trail information. It will always show the identity of the user who completes the workflow.
{% endhint %}

Umbraco Workflow 11.1.0 introduces a history cleanup feature similar to those already available in Umbraco CMS and Umbraco Forms.

## How it works

The History Cleanup feature is disabled by default. Applying the default history cleanup policy will:

* Delete history older than 28 days. See the `KeepHistoryForDays` setting.
* Only delete history where the workflow status is `Approved`, `Cancelled`, `CancelledByThirdParty`, or `Errored`. See the `StatusesToDelete` setting.

The feature can be enabled in the `appSettings.json`:

```json
{
  "Umbraco": {
    "Workflow": {
      "HistoryCleanupPolicy": {
        "EnableCleanup": true,
        // Below settings are optional
        "FirstRunTime": string; the time to first run the scheduled cleanup task, in crontab format
        "Period": string; how often to run the task, in timespan format
        "KeepHistoryForDays": int; delete history after this many days
        "StatusesToDelete": refer to StatusesToDelete configuration below
        "CleanupRules": refer to Configuration examples below
      }
    }
  }
}
```

## Overriding global settings

For sites with stricter or more complex requirements, it is possible to override the global settings for individual content nodes and Document Types. This is also managed through `appSettings.json` configuration. Configuration rules defined in application settings are prioritized over any rules set via the backoffice. It allows the developers to restrict clean up of critical history, while allowing site administrators flexibility to manage non-critical history.

## Configuration examples

The below example will apply the following policies:

* History cleanup is enabled globally.
* History items with `Approved` or `Cancelled` status are deleted after 90 days.
* Workflow history for node `dcf18a51-6919-4cf8-89d1-36b94ce4d963` will never be deleted.
* Workflow history for node `31523089-f648-4883-9087-ef9a0b83129f` will be deleted after 10 days for the statuses defined in the global `StatusesToDelete` property.
* Workflow history for all nodes using the `ContentPage` Document Type will never be deleted.
* Workflow history with `Cancelled` status for all nodes using the `NewsItem` Document Type will be deleted after 100 days (see also [StatusesToDelete configuration](history-cleanup.md#statusestodelete-configuration)).

```json
{
  "Umbraco": {
    "Workflow": {
      "HistoryCleanupPolicy": {
        "EnableCleanup": true,
        "KeepHistoryForDays": 90,
        "StatusesToDelete": {
          "Approved": true,
          "Cancelled": true,
          "CancelledByThirdParty": false,
          "Errored": false
        }
        "CleanupRules": {
          "dcf18a51-6919-4cf8-89d1-36b94ce4d963": {
            "EnableCleanup": false         
          }, 
          "31523089-f648-4883-9087-ef9a0b83129f": {
            "KeepHistoryForDays": 10
          },
          "ContentPage": {
            "EnableCleanup": false
          },
          "NewsItem": {
            "KeepHistoryForDays": 100,
            "StatusesToDelete": {
              "Approved": false,
              "Cancelled": true,
              "CancelledByThirdParty": false,
              "Errored": false
            }
          }
        }
      }
    }
  }
}
```

When calculating node and Document Type policies, the Document Type rules will not be processed if the current workflow instance matches a node rule. Using the above configuration as an example, consider both nodes in the `CleanupRules` dictionary are using the Document Type `ContentPage`. In this case, the Document Type rules will not be applied as the node rules are prioritized.

If a value is omitted from the node or Document Type policy, the global value will be used instead. In the above example, the node policy for `31523089-f648-4883-9087-ef9a0b83129f` uses the `StatusesToDelete` value from the global policy that is deleting `Approved` or `Cancelled` workflow history.

### StatusesToDelete configuration

`StatusesToDelete` uses a dictionary built from the `WorkflowStatus` enum type. The default configuration is:

```json
  "HistoryCleanupPolicy": { 
    "StatusesToDelete": {
      "Approved": true,
      "Cancelled": true,
      "CancelledByThirdParty": true,
      "Errored": true,
      "PendingApproval": false,
      "Rejected": false,
      "NotRequired": false,
      "Resubmitted": false
    }
  }
```

It is possible for a cleanup rule (or the global configuration) to declare a `StatusesToDelete` property without the full set of status keys. This will not modify the default values.

For example, adding `"Approved": false` will remove `Approved` from the deletable statuses, but all other default values will remain. Therefore, to delete approved workflows only, the configuration would look like below, where the default values have been negated:

```json
  "HistoryCleanupPolicy": { 
    "EnableCleanup": true,
    "StatusesToDelete": {
      "Approved": true,
      "Cancelled": false,
      "CancelledByThirdParty": false,
      "Errored": false
    }
  }
```

## Backoffice configuration

Backoffice users with access to the Workflow section will have permission to modify history cleanup rules, while all backoffice users have read-only access.

Rules for content items and their Document Type are set from the History tab of the Workflow content app. The History view in the Workflow section provides a read-only overview of all the history cleanup rules and global configuration.

Content items with no custom cleanup rules defined will display the global defaults.

![Workflow History Cleanup Modal](../.gitbook/assets/workflow-history-cleanup-modal.png)
