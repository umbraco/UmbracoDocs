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
- **Logic Block:** Structural tools like `If`, `For Each` nodes that allow your automation to branch down different paths based on rules you define.
- **Bindings:** Dynamic placeholders using `${ ... }` syntax. They pass live data from a trigger (like a customer's name or form entry) down to later action steps in the automation.

## Accessing Automation in the Backoffice

1. Log into the Umbraco Backoffice.
2. Locate and click **Automation** in the top navigation bar.

![Automation section in the Backoffice](../.gitbook/assets/automate-toolbar.png)

## Build Your First Automation

If you are brand new to the product, start with the [Create Your First Automation](../getting-started/first-automation.md) article, which walks you through:

- Creating your first automation
- Adding triggers and actions
- Publishing and testing

## Inspirational Blueprints (Real-World Use Cases)

The value of Umbraco Automate lies in its flexibility. The scenarios listed below are not the only automations you can build, nor are you limited to these specific configurations. Think of them as inspirational blueprints. They show how you can mix and match basic triggers with advanced logic blocks, automated AI actions to handle your day-to-day operations.

### Example 1: The Automated AI Multi-Language Translator

This automation uses an AI Agent to automatically translate new press releases into multiple languages, eliminating hours of manual copy-pasting.

- Trigger: `Content Published` (Filtered for the "Press Release" Document Type)
- Action 1: `Get Content` (Core). This step is required to explicitly fetch the page fields and make your text properties accessible to the next steps.
- Action 2: `Run AI Agent` (Requires the `Umbraco.AI.Automate` add-on package)
- Action 3: `Update Content Property` (Core)

#### Setup

1. Navigate to the **Automation** section.
2. Create an automation and name it **Press release Translation Pipeline**.
3. Click the empty trigger block and select `Content Published` trigger from the picker.
4. Filter it to your *Press Release* Document Type.
5. Click the **+** button below the trigger and add the `Get Content` action block.
6. Bind its key field dynamically: `${trigger.contentKey}`.
7. Click **+** below the content fetch block and choose `Run AI Agent`.
8. In the **Agent** field, select your pre-configured agent profile.
9. In the **Message** field, click **Insert Binding** to open the **Insert Binding Expression** panel. Scroll down to the **Get Content** section, select `properties` (this inserts `${ steps.getContent.properties }`). Append a dot and your specific text field's code alias inside the brackets (for example, `.bodyText`).
10. Click **+** and add an `Update Content Property` block. Populate its fields using your specific document schema setup:
    1. **Content Key**: Select `${trigger.contentKey}` from the binding picker.
    2. **Property Alias**: Type the alias of your destination field.

### Example 2: Milestone Submission Alerts and Routing

This automation routes form traffic to an alert channel once submission volume crosses a specific metric threshold, keeping standard initial entries managed separately.

- Trigger: `Form Submitted` (Requires the `Umbraco.Forms.Automate` add-on package)
- Action 1: `Export Form Entries`
- Logic Block: `If` (Control Flow)
    - Branch A (True):  `Send Slack Message` (Requires the `Umbraco.Automate.Slack` add-on package)
    - Branch B (False): `Send Email` (Core)

#### Setup

1. Click the trigger slot. Select `Form Submitted` and choose your *Request a Quote* form.
2. Click the **+** button below the trigger and add an **Export Form Entries** action block. Choose your *Request a Quote* form.
3. Click **+** and add an **If** control flow block.
4. Click **Add condition**. Select **<>** next to the **Left value** field to open the **Insert Binding Expression** panel.
5. Navigate to the **Export Form Entries** section and select `totalCount`. This will insert `${ steps.exportEntries.totalCount }` into the **Left Value** field.
6. Set the **Operator** dropdown selection to **Greater Than**.
7. Type your target threshold (for example, `1000`) into the **Right Value** field.
8. On the **True** Branch, add a `Send Slack Message` action targeting your designated alerts channel.
9. On the **False** Branch, add a standard `Send Email` action block to route normal submission traffic to your default queue.

### Example 3: Bulk Content Expiry & Archiving Audit

This automation operates entirely in the background while your team sleeps. It runs on a fixed weekly schedule, checks for expired marketing campaign pages, automatically unpublishes them, and moves them to an archive vault.

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

This automation monitors your storefront for inventory shifts, instantly alerting team members or suppliers if stock falls below a safe threshold.

- Trigger: `Stock Changed` (Requires the `Umbraco.Commerce.Automate` add-on package)
- Logic Block: `If` (Control Flow)
- Branch A (True): `Send Slack Message` (Requires the `Umbraco.Automate.Slack` add-on package)

#### Setup

1. Click the empty trigger slot and add a `Stock Changed` from the picker. Select your target store instance.
2. Click the **(+)** button below the trigger and add an **If** logic block.
3. Click Add condition. Click **<>** next to the Left value field to open the **Insert Binding Expression** panel.
4. Under the **Stock Changed** section, select `newStock`. This inserts `${ trigger.newStock }` value into the Left value field.
5. Set the **Operator** dropdown selection to **less than**.
6. Type your minimum buffer threshold (for example, `5`) into the **Right Value** field.
7. On the **True** branch, add a `Send Slack Message` action targeting your internal `#inventory-alerts` or supplier tracking channel.
8. In the Message field, click the binding button (...) to pull in your trigger's available reference properties: `Critical low stock alert: Product reference ${trigger.productReference} has dropped below the safety threshold. Please evaluate a supplier reorder.`.

{% hint style="info" %}
Umbraco Commerce supports SQLite for testing, but it is not recommended to use it in a live environment. For more information, see the [Configure SQLite support article in the Commerce Documentation](https://docs.umbraco.com/umbraco-commerce/how-to-guides/configure-sqlite-support).
{% endhint %}

### Example 5: Personalization Booster & Account Management Flag

This automation bridges backoffice marketing operations into direct sales action. When a visitor profile is manually advanced to a new stage in your customer journey funnel, Automate instantly loops in your account management team.

- Trigger: `Customer Journey Step Explicitly Assigned` (Requires the `Umbraco.Engage.Automate` add-on package)
- Logic Block: `If` (Control Flow)
- Branch A (True): `Send Email` (Core)

#### Set up

1. Select the `Customer Journey Step Explicitly Assigned` trigger from your canvas picker.
2. Connect an `If` logic block underneath the trigger node.
3. Click Add condition. Click **<>** next to the Left value field to open the **Insert Binding Expression** panel.
4. Under the **Customer Journey Step Explicitly Assigned** section, select `customerJourneyStepId`. This will insert: `${ trigger.customerJourneyStepId }`.
5. Set the **Operator** dropdown selection to **greater than**.
6. Type `0` into the **Right Value** input box.
7. On the True branch, add a standard `Send Email` action block directed straight to your B2B account management team.
8. Use the binding button (...) inside the email **Body** to pass along the visitor metadata: `Marketing Update: Visitor ID ${ trigger.visitorId } has been successfully advanced to your high-value tracking funnel step.`

{% hint style="info" %}
Umbraco Engage does not support SQL CE and SQLite. For more information, see the [System Requirements in the Engage Documentation](https://docs.umbraco.com/umbraco-engage/installation/system-requirements).
{% endhint %}

## Common Questions & Troubleshooting

### How do I temporarily pause an automation?

To stop an automation from running without deleting it:

1. Open your target automation canvas.
2. Click **Unpublish** in the footer menu.
3. The automation status will change to *Draft* and will no longer listen for live events.

### How do I edit a published automation?

1. Open your automation workspace.
2. Alter the trigger parameters, conditions, or action configurations directly on the canvas grid.
3. Click **Save and Publish** to instantly activate the changes.

### Can I undo a mistake?

Yes. Umbraco Automate features native version control tracking. If a change breaks your automation layout:

1. Navigate to the **Info** dashboard tab on the right side of the screen.
2. Select **Compare**.
3. Locate a successful prior timestamp and click **Rollback to version x**.

## Next Steps

- Choose one of the blueprints above and map it out on a test canvas.
- Review your automation activity by clicking the **Runs** history dashboard tab.
- Explore our comprehensive guides on available [Triggers](../concepts/triggers.md) and [Actions](../concepts/actions.md).

Happy Automating!
