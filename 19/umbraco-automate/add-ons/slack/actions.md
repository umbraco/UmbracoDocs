---
description: >-
  Reference for the actions contributed by the Umbraco.Automate.Slack add-on.
---

# Actions

The Slack add-on contributes the following actions.

## Send Slack Message

Alias: `slack.sendMessage`. Posts a message to a Slack channel. Requires a Slack connection with the `chat:write` scope.

| Setting | Description |
| ------- | ----------- |
| **Connection** | The Slack connection to use. |
| **Channel** | The channel name (for example, `#general`) or channel ID. |
| **Message** | The message text. Supports [bindings](../../concepts/bindings.md). |

### Output

| Field | Description |
| ----- | ----------- |
| `channel` | The channel ID the message was posted to. |
| `ts` | The Slack timestamp of the posted message. |

### Example

A trigger fires on **Content Published** and the next step is **Send Slack Message** with:

```
Channel: #content-updates
Message: ":rocket: ${ trigger.contentName } (${ trigger.contentTypeAlias }) was just published."
```

When the trigger fires, the resolved message is posted to the chosen channel.
