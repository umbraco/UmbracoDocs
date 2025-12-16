---
description: >-
  Learn how to create and customize a popup with no coding required in just a
  few simple steps.
---

# Create a Personalized Popup in 5 minutes

In this tutorial, you will learn how to create and customize a popup using Umbraco Engage. We will walk you through creating a target segment, applying personalization, and setting up the popup with pre-defined templates.

Popups are powerful for capturing attention, promoting special offers, and encouraging visitors to take action. With a timed popup, you can boost and increase engagement on your website.

## Step 1: Create a Segment

Creating a segment allows you to define specific groups within your audience based on shared behaviors. By segmenting your audience, you can deliver tailored content that suits their interests and needs.

To create a segment, follow these steps:

1. Login to Umbraco.
2. Go to the **Engage** section.
3. Select **Personalization** **->** **Segments**.
4. Click on **Add new segment**.

<figure><img src="../.gitbook/assets/engage-tutorials-personalizaed-popup (1).png" alt=""><figcaption><p>Add New Segment</p></figcaption></figure>

5. Enter the **Title** in the Add new segment overlay. For example: _Popup targeted audience._
6. Provide a **Description**. For example: _Targeting visitors who haven't seen our popup._
7. Select **Temporary** as the **Segment Type**_._
8. Set the **End Time** to a date, ideally sometime in the future.

<figure><img src="../.gitbook/assets/Add-new-segment-overlay (1).png" alt=""><figcaption><p>Add new Segment Overlay</p></figcaption></figure>

9. Select **Number of sessions** in **Choose a parameter** tab.
10. Change _Exactly_ to **More than** in the **Applied parameters** field and set the number of sessions to **0**.

<figure><img src="../.gitbook/assets/Number-of-sessions (1).png" alt=""><figcaption><p>Number of Sessions parameter</p></figcaption></figure>

11. Click **Save parameter.**
12. Click **Add segment**.

You have now created a segment targeting all visitors with more than 0 sessions.

## Step 2: Apply Personalization

To target the segment with a popup, follow these steps:

1. Navigate to **Applied Personalization** in the **Personalization** tab.
2. Click on **Apply new personalization**.

<figure><img src="../.gitbook/assets/engage-tutorials-personalized-popup (1).png" alt=""><figcaption><p><strong>Apply new personalization</strong></p></figcaption></figure>

3. Enter a **Title**. For example: _A popup to inform visitors._
4. Provide a **Description.** For example: _This popup will grab visitors' attention with our great offer!_

<figure><img src="../.gitbook/assets/Personalization-screen (1).png" alt=""><figcaption><p>Personalization screen</p></figcaption></figure>

5. Choose **Multiple Pages** from the **Select personalization type** drop-down list\*\*.\*\*
6. Click **Add** in **Select multiple pages.**
7. Use the Umbraco page picker to pick one or more pages.
8. Click **Submit**.
9. Click on **Select segment.**
10. Select **Popup targeted audience** which is the segment created in [Step 1: Create a Segment](create-a-personalized-popup-in-5-minutes.md#step-1-create-a-segment).
11. Click **Save**.

## Step 3: Set Up the Popup

To include the popup template, follow these steps:

1. Click **Include CSS/JavaScript** in **Add/Edit code.**

<figure><img src="../.gitbook/assets/include-css-javascript (1).png" alt=""><figcaption><p>Stylesheet selection</p></figcaption></figure>

2. Copy and paste the CSS and JavaScript from the [**Generic popup overlay template**](marketing-resources/generic-popup-template.md) in these fields.

<figure><img src="../.gitbook/assets/stylesheet-fields (1).png" alt=""><figcaption><p>Add stylesheet to fields</p></figcaption></figure>

3. Click **Save and close**.

<figure><img src="../.gitbook/assets/setup-personalization-screen (1).png" alt=""><figcaption></figcaption></figure>

4. Click **Save & Start**.

Go to your website and visit the page(s) where you applied the popup personalization. The popup will appear.

{% hint style="info" %}
If the popup does not appear, check the **flush rate setting** in the `/config/uMarketingSuite/uMarketingSuite.config` file. Make sure the **Flush interval** is set to 1 second.
{% endhint %}

## Step 4: Change the Popup Content

To update the popup content, follow these steps:

1. Navigate to **Engage -> Personalization -> Applied Personalization**.
2. Click the **Edit** icon next to your popup.
3. Scroll down to the HTML/JavaScript code section.
4. Click **Edit** to update the content.
5. Click **Save and close**.
6. Click **Update & Start**.

You have now created and customized your first popup, and it is up and running.
