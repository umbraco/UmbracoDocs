---
description: Build powerful backoffice automations with no coding required, only drag, drop, and connect.
---

# Getting Started for Editors

Umbraco Automate is an event-driven automation engine that lives natively inside your CMS. Think of it like a personal assistant. It watches your website for specific events, like publishing new content. Then, it automatically triggers actions, like sending a Slack message to your team.

## Before You Start

Your site administrator handles the primary infrastructure. Before you begin building, make sure they have:

- **Assigned you to a Workspace**: Workspaces control who can view and edit specific automations.
- **Configured Connections**: Connections are reusable sets of credentials for external services (like Slack or an email provider).  

If you cannot access the Workspace or see your team's external services, ask your administrator to invite your user group to the workspace.

## Key Concepts

- **Trigger:** The specific event that starts an automation. Examples: `When content is published`, `When a form is submitted`, `At a specific time each day`.
- **Action:** What happens automatically after a trigger executes Examples: `Send an email`, `Post a message to Slack`, `Publish another piece of content`.
- **Logic Block:** Structural tools like `If`, `For Each` nodes that allow your workflow to branch down different paths based on rules you define.
- **Bindings:** Dynamic placeholders using `${ ... }` syntax. They pass live data from a trigger (like a customer's name or form entry) down to later action steps in the workflow.

## Accessing Automation in the Backoffice

1. Log into the Umbraco Backoffice.
2. Locate and click **Automation** in the top navigation bar.

![Automation section in the Backoffice](../.gitbook/assets/automate-toolbar.png).

## Build Your First Automation

If you are brand new to the product, start with the [Create Your First Automation](../getting-started/first-automation.md) article, which walks you through:

- Creating your first automation
- Adding triggers and actions
- Publishing and testing

## Inspirational Blueprints (Real-World Use Cases)

The value of Umbraco Automate lies in its flexibility. The scenarios listed below are not the only workflows you can build, nor are you limited to these specific configurations. Think of them as inspirational blueprints. They show how you can mix and match basic triggers with advanced logic blocks, automated AI actions to handle your day-to-day operations.

### Example 1: The Automated AI Multi-Language Translator

This workflow uses an AI Agent to automatically translate new press releases into multiple languages, eliminating hours of manual copy-pasting.

- Trigger: `Content Published` (Filtered for the "Press Release" Document Type)
- Action 1: `Run AI Agent` (Requires the `Umbraco.AI.Automate` add-on package)
- Action 2: `Update Content Property` (Core)

#### Setup

1. Click the empty trigger slot on the canvas, choose `Content Published` trigger from the picker. Filter it to your "Press Release" Document Type.
2. Click the **+** button below the trigger and add a `Run AI` Agent action block. In its prompt text box, use a binding to pass your text: `Translate the following text into professional Spanish: ${trigger.bodyText}.`
3. Click the next **+** button and attach an `Update Content Property` action step. Map the output variable from the AI step directly into your target language variant fields to save it instantly as a localized draft.

### Example 2: VIP Lead Routing and Dynamic CRM Injection

This workflow routes high-value form submissions to Slack for instant executive alerts, while sending standard inquiries to a default helpdesk.

- Trigger: `Form Submitted` (Requires the `Umbraco.Forms.Automate` add-on package)
- Logic Block: `If` (Control Flow)
- Branch A (True): `Send Slack Message` (Requires the `Umbraco.Automate.Slack` add-on package)
- Branch B (False): `Send Email` (Core)

#### Setup

1. Click the trigger slot, select `Form Submitted` and pick your "Request a Quote" form.
2. Click the **+** button below the trigger and add an **If** control flow node.
3. Add a condition rule to evaluate your form's budget field using a binding: `${trigger.estimatedBudget} is greater than 10000`.
4. On the **True** Branch, add a `Send Slack Message` action targeting your `#vip-sales-alert-channel`. Type `${` to use autocomplete bindings to pull in the information.
5. On the **False** Branch, add a standard `Send Email` action to drop the submission info into your default general helpdesk queue.

### Example 3: Bulk Content Expiry & Archiving Audit

This workflow operates entirely in the background while your team sleeps. It runs on a fixed weekly schedule, checks for expired marketing campaign pages, automatically unpublishes them, and moves them to an archive vault.

- Trigger: `Scheduled Trigger` (Core)
- Action: `Find Content` (Content)
- Logic Block: `For Each` (Control Flow)
- Action: `Unpublish Content` (Core)

#### Setup

1. Add a `Scheduled Trigger` to the top of your canvas. Configure it to run weekly by inputting a standard **Cron Expression** (for example, `0 6 * * 1` to run every Monday morning at 6:00 AM).
2. Click the **(+)** button below the trigger block and select **Find Content** under the **Content** section.
3. Drag a `For Each` control flow block beneath the query. This creates a visual loop block on your canvas that cycles through the items found in the previous step.
4. Drag or add an **Unpublish Content** action block inside that visual loop container. This will safely turn off the live view for those expired pages one by one automatically.

### Example 4: The Low Stock Slack Alert & Supplier Reorder

This workflow monitors your storefront for inventory shifts, instantly alerting team members or suppliers if stock falls below a safe threshold.

- Trigger: `Stock Changed` (Requires the `Umbraco.Commerce.Automate` add-on package)
- Logic Block: `If` (Control Flow)
- Branch A (True): `Send Slack Message` (Requires the `Umbraco.Automate.Slack` add-on package)

#### Setup

1. Add a `Stock Changed` from the picker and select your target store instance.
2. Click the **(+)** button below the trigger and add an **If** logic block.
3. In the condition settings panel, evaluate the stock output property: `${trigger.newStockLevel} is less than 5`.
4. On the **True** branch, add a `Send Slack Message` action targeting your internal `#inventory-alerts` or supplier tracking channel. Use automated bindings to pull the item's info dynamically: `Critical low stock alert: ${trigger.productName} is down to ${trigger.newStockLevel} items left! Please evaluate a reorder`.

{% hint style="info" %}
Umbraco Commerce supports SQLite for testing, but it is not recommended to use it in a live environment. For more information, see the [Configure SQLite support article in the Commerce Documentation](https://docs.umbraco.com/umbraco-commerce/how-to-guides/configure-sqlite-support).
{% endhint %}

### Example 5: Personalization Booster & Account Management Flag

This workflow bridges customer behavioral analytics into direct sales action. When a visitor shifts to a target audience segment based on their browsing behavior, Automate instantly alerts their account executive.

- Trigger: `Persona Scored` (Requires the `Umbraco.Engage.Automate` add-on package)
- Logic Block: `If` (Control Flow)
- Branch A (True): `Send Email` (Core)

### Set up

1. Select the `Persona Scored` trigger from your canvas picker, which listens directly to the real-time behavioral telemetry running inside your CMS tracking layers.
2. Connect an `If` logic block underneath the trigger node.
3. Configure the rule condition to evaluate the primary audience alignment target: `${trigger.highestPersonaAlias} equals enterprise-buyer`.
4. On the True branch, add a standard `Send Email` action block directed straight to your B2B account management team, passing along the visitor's anonymized tracking ID or form lookup payload so they can customize their next outreach strategy.

{% hint style="info" %}
Umbraco Engage does not support SQL CE and SQLite. For more information, see the [System Requirements in the Engage Documentation](https://docs.umbraco.com/umbraco-engage/installation/system-requirements).
{% endhint %}

## Common Questions & Troubleshooting

### How do I temporarily pause an automation?

To stop an automation from running without deleting it:

1. Open your target workflow canvas.
2. Click **Unpublish** in the footer menu.
3. The automation status will change to *Draft* and will no longer listen for live events.

### How do I edit a published automation?

1. Open your workflow workspace.
2. Alter the trigger parameters, conditions, or action configurations directly on the canvas grid.
3. Click **Save and Publish** to instantly activate the changes.

### Can I undo a mistake?

Yes. Umbraco Automate features native version control tracking. If a change breaks your workflow layout:

1. Navigate to the **Info** dashboard tab on the right side of the screen.
2. Select **Compare**.
3. Locate a successful prior timestamp and click **Rollback to version x**.

## Next Steps

- Choose one of the blueprints above and map it out on a test canvas.
- Review your automation activity by clicking the **Runs** history dashboard tab.
- Explore our comprehensive guides on available [Triggers](../concepts/triggers.md) and [Actions](../concepts/actions.md).

Happy Automating!
