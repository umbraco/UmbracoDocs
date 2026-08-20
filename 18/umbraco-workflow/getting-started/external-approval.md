---
description: >-
  Allow editors to participate in workflow processes without accessing the CMS.
---

# External Approval

{% hint style="info" %}
External Approval is available in Workflow 18.1 and above. This feature requires a license. Learn more about [Workflow's licensing model](https://umbraco.com/products/umbraco-workflow).
{% endhint %}

External Approval allows editors to participate in workflow processes without accessing the Umbraco Backoffice. This allows content stakeholders to approve content changes without needing to know how to use Umbraco.

There are two ways for an approval group member to action a pending task from the notification email, instead of logging in to the Backoffice:

* **External approval** - a secure, time-limited link in the email opens a standalone approval page.
* **Email reply approval** - replying to the notification email with `APPROVE` or `REJECT` actions the task directly.

Both are optional, licensed features and are enabled independently, per approval group.

## External approval

When External approval is enabled for a group, the notification email includes a link to a standalone approval page. Opening the link:

* Signs the recipient in as the user the link was generated for, without a Backoffice login.
* Shows a preview of the content change, alongside the task detail (workflow stage, comments, and any attachment).
* Lets the recipient switch between configured preview environments and device sizes.
* Presents **Approve** and **Reject** actions that call the same API used by the Backoffice.

The link is only included for a recipient when all of the following are true:

* The group has **External approval** enabled.
* The group does not have a **Group Email** set. The link identifies the individual it was generated for, so it cannot be issued for a shared mailbox.
* There is an active (incomplete) task for the recipient to action.

## Email reply approval

When Email reply approval is enabled for a group, the notification email for a pending task includes a `Reply-To` address. A recipient can use the buttons embedded in the notification email to generate a reply message, or reply directly to the notification.

The task is actioned automatically once the reply is processed, and the recipient then receives a plain-text confirmation. If the reply cannot be actioned, the recipient receives an explanation instead - for example, an expired token or an unrecognized keyword.

Quoted history in the reply (previous message text, signatures added by common mail clients) is stripped automatically before the keyword is read.

Email reply approval is only available for the single, active-task notification, not for the reminder digest email. A digest can bundle unrelated tasks together and a plain reply cannot say which one it applies to.

## Enabling the feature

Both channels are enabled per approval group, from the group's **Settings** tab in the **Workflow** section:

* **Allow external approval** - enables the magic-link channel for members of the group.
* **Allow approval by email reply** - enables the email-reply channel for members of the group.

Neither option is available for a group with a **Group Email** address set, since both channels issue a credential to a single, known individual.

{% hint style="warning" %}
The link and the reply address both act as a bearer credential for the duration of their validity. Anyone holding the link, or able to reply from the recipient's mailbox, can approve or reject the task as that user. Treat them with the same care as a password, and keep the token expiry (see below) as short as practical for your approval process.
{% endhint %}

## Configuration requirements

### General

| Setting                       | Default        | Description                                                                                                                                                                    |
| ------------------------------ | -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SiteUrl`                       | -              | Required for external approval. The approval link is built from this URL. Refer to [Configuration](configuration.md#settingscustomization) for details.                                             |
| `EditUrl`                       | -              | Required for both channels. If not set, no workflow notification email is generated at all, so no approval link or reply address is delivered.                                                     |
| `SendNotifications`             | -              | Must be `true`. If workflow notification emails are disabled, no approval links or reply addresses are ever sent.                                                                                    |
| `ExternalApprovalTokenExpiry`   | `2.00:00:00` (48 hours) | A `TimeSpan` controlling how long an external approval link or a reply-approval token remains valid after it is generated, for both channels.                                              |

`SiteUrl`, `EditUrl`, and `SendNotifications` are configured from the Workflow settings dashboard, or via `SettingsCustomization` in `appsettings.json` - see [Configuration](configuration.md). `ExternalApprovalTokenExpiry` is set directly under `Umbraco:Workflow` in `appsettings.json`:

```json
{
  "Umbraco": {
    "Workflow": {
      "ExternalApprovalTokenExpiry": "2.00:00:00"
    }
  }
}
```

The CMS must also be able to send email (SMTP server, pickup directory, or a custom email notification handler configured under `Umbraco:CMS:Global:Smtp`. Neither channel can deliver a link or a reply address otherwise.

{% hint style="info" %}
Approval tokens are protected using the ASP.NET Data Protection key ring. In a load-balanced environment confirm the key ring is persisted and shared between servers. Otherwise, a link generated on one server is rejected as invalid by another and every outstanding link breaks on the next deployment.
{% endhint %}

### Email reply approval

Email reply approval additionally requires an IMAP mailbox to be polled for replies. This is configured under `Umbraco:Workflow:EmailReplyApproval` in `appsettings.json`. There is no Backoffice settings UI for this configuration, consistent with how other outbound email credentials are handled in Workflow.

```json
{
  "Umbraco": {
    "Workflow": {
      "EmailReplyApproval": {
        "Enabled": false,
        "Host": null,
        "Port": 993,
        "UseSsl": true,
        "Username": null,
        "Password": null,
        "Mailbox": "INBOX",
        "ReplyAddress": null,
        "PollingPeriod": "0.00:05:00"
      }
    }
  }
}
```

| Setting          | Default            | Description                                                                                                                                                                                            |
| ----------------- | ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Enabled`          | `false`             | Enables polling the configured mailbox for approval replies. Must be `true` for this channel to have any effect, even if it is enabled for one or more approval groups.                              |
| `Host`             | -                   | IMAP host of the mailbox that receives approval replies.                                                                                                                                               |
| `Port`             | `993`               | IMAP port. Defaults to the standard implicit-TLS port.                                                                                                                                                 |
| `UseSsl`           | `true`              | Connect using implicit TLS. When `false`, the connection uses STARTTLS instead. There is no unencrypted fallback.                                                                                     |
| `Username`         | -                   | IMAP authentication username.                                                                                                                                                                          |
| `Password`         | -                   | IMAP authentication password.                                                                                                                                                                          |
| `Mailbox`          | `INBOX`             | Mailbox folder to poll for replies.                                                                                                                                                                    |
| `ReplyAddress`     | -                   | The base address replies are sent to. The approval token is carried by plus-addressing the local part of this address, for example `workflow-reply@yourdomain.com` becomes `workflow-reply+<token>@yourdomain.com`. |
| `PollingPeriod`    | `0.00:05:00` (5 minutes) | A `TimeSpan` controlling how often the mailbox is polled for new replies. Must be shorter than `ExternalApprovalTokenExpiry`, or a reply can arrive after its token has already expired.        |

{% hint style="warning" %}
`Username` and `Password` are credentials. Provide them via user secrets, environment variables, or a key vault provider rather than committing them to `appsettings.json`.
{% endhint %}

Mail sent to `ReplyAddress` (including plus-addressed variants) must be delivered into the polled `Mailbox`. If the reply address is an alias of, or is routed to, a different mailbox than the one being polled, replies are never seen.

## Health checks

Workflow adds two health checks to help diagnose configuration issues for these features:

* **External Approval Configuration** - checks licensing, notification and site URL configuration, and the token expiry. It also flags any group with external approval enabled that also has a group email set.
* **Action-by-Email Configuration** - checks licensing, the IMAP connection settings, the reply address, and the polling period against the token expiry. It also flags any group with email reply approval enabled that also has a group email set.

Both checks are found in the **Settings > Health Check** dashboard, under the **Workflow** group.
