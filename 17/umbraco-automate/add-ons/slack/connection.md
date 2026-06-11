---
description: >-
  Create a Slack connection by authenticating with your Slack workspace via
  OAuth.
---

# Connection

Before an automation can post to Slack, you must create a **Slack** connection and allow it on the workspace that will use it. The connection is authenticated with Slack via the OAuth flow.

## Create the Connection

1. Open the **Automate** section in the backoffice.
2. Switch to the **Settings** sidebar.
3. Right-click **Connections** and select **Create connection**.
4. Pick **Slack** from the connection type picker.
5. Enter a name, for example `Team announcements`.
6. Click **Authenticate**. A popup opens to the Slack authorization page.
7. Pick the workspace and approve the requested scopes.
8. After the popup closes, click **Test connection** to confirm the access token works.
9. Click **Save**.

## Allow the Connection in a Workspace

1. Open the workspace that will own the automation that uses Slack.
2. On the **Settings** tab, find **Allowed Connections** and pick the Slack connection.
3. Save the workspace.

The Slack connection now appears in the connection picker on any **Send Slack Message** step inside that workspace.

## Re-authenticate

Slack access tokens are refreshed automatically. If a token is revoked from the Slack side, **Test connection** will fail. Click **Authenticate** again to re-authorise.

## Next Steps

{% content-ref url="actions.md" %}
[actions.md](actions.md)
{% endcontent-ref %}
