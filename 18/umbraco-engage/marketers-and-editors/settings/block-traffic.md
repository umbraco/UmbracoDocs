---
description: Use block rules to keep unwanted traffic out of your Engage analytics.
---

# Block traffic

Block traffic helps you keep your analytics clean. Visits you do not want in your reports, such as your own team, an agency, or automated bots, inflate your numbers. A block rule stops matching requests from being counted, so your reports reflect real visitors.

Block traffic does **not** stop anyone from using your website. The page still loads normally. A blocked request is only left out of your Engage analytics.

{% hint style="info" %}

If you used **IP filtering** before, nothing is lost. Your existing filters were moved over automatically and now appear here as **IP address** rules.

{% endhint %}

## Where to find it

Open the Engage section and go to **Settings** > **Block traffic**. The overview lists every rule you have set up. If you don't have any rule set up, it shows "No rules have been added yet."

<figure><img src="../../.gitbook/assets/Settings-BlockTraffic.png" alt="The Block traffic overview listing configured rules"><figcaption><p>The Block traffic overview</p></figcaption></figure>

## Deciding what to block

The **Suspicious Activity** view, next to Block traffic in Settings, surfaces requests that behave differently from normal visitors, such as automated browsers. Use that view to spot candidates worth turning into a block rule.

## Creating a rule

Select **Create rule**, fill in the below mentioned fields, and select **Save and close**:

* **Name**: A short name for the rule.
* **Description**: A short note about what the rule is for.
* **Type**: What part of the request the rule looks at. See [Rule types](#rule-types).
* **Condition**: How the value is compared. See [Conditions](#conditions).
* **Value**: What to match against, for example an IP address or part of a user agent. With the **List** condition this becomes a **Values** field where you add entries one by one.
* **Active**: Whether the rule is switched on. A new rule is active by default, and you can switch a rule off later without deleting it.

The new rule then appears in the overview.

**Example: Exclude your own visits**

1. Set **Type** to *IP address* and **Condition** to *Equals*.
2. Put your office IP address in **Value** (your IT team can tell you the public one).
3. Leave **Active** on.
4. Select **Save and close**.

From now on, visits from that address will stay out of your reports.

<figure><img src="../../.gitbook/assets/Settings-BlockTraffic-CreateRule.png" alt="Creating a block rule with the name, description, type, condition and value fields"><figcaption><p>Creating a rule</p></figcaption></figure>

## Rule types

* **IP address**: The visitor's IP address. Enter a single address (for example `203.0.113.10`) or a range that covers a whole network (for example `203.0.113.0/24`). Ask your IT team if you are unsure which to use.
* **User agent**: The text a browser or bot sends to identify itself. Useful for keeping out automated clients.
* **Country**: The country a visit comes from, based on the visitor's detected location. The **Location** report under Analytics shows the country values Engage records.

## Conditions

When you choose a **Type**, the **Condition** list updates to show only the options that apply to it.

| Type | List | Equals | Contains | Regular expression |
|---|---|---|---|---|
| IP address | ✓ | ✓ | | ✓ |
| User agent | ✓ | ✓ | ✓ | ✓ |
| Country | ✓ | ✓ | ✓ | ✓ |

* **List**: Matches when the value is one of the entries you add.
* **Equals**: Matches when the value is exactly what you provide.
* **Contains**: Matches when the value contains the text you provide.
* **Regular expression**: Matches the value against a pattern. This option is advanced; leave it to a developer if you are not familiar with regular expressions.

## Managing rules

Select a rule's name in the overview to open and edit it. To switch a rule off without deleting it, open it and turn **Active** off. To delete a rule, tick its checkbox in the overview and select **Delete**.

{% hint style="info" %}

**Active applies from the moment you switch it on.** Turning a rule on does not remove data that was already collected. Turning a rule off does not bring back visits that were left out while it was active.

{% endhint %}

## What to expect

Blocked requests do not appear in your reports, so you will not see them there. To check a rule is doing its job, make sure it is **Active** and that the **Value** is correct. The **Suspicious Activity** view is a good place to see what is still coming through.
