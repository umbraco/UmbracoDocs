---
description: On this page, you can learn how you can set up the Personas in Umbraco Engage.
---

# How to Create a Persona

## Introduction

Before setting up a Persona, we recommend you read the [Personas article](../marketers-and-editors/personalization/implicit-and-explicit-personalization/setting-up-personas.md) in the **Implicit and Explicit Personalization** section.

Below you can find some resources on how to define a persona:

* [How to create a Persona in five steps](https://www.figma.com/resource-library/how-to-create-a-persona/) by Figma

Once you have defined your persona, you can create it in Umbraco Engage.

## Creating your Personas

To create your Personas in Umbraco Engage, follow the steps below:

1. Go to the **Engage** menu in the top navigation.
2. Go to **Personalization** in the Umbraco Engage menu.

<figure><img src="../.gitbook/assets/engage-tutorial-how-to-persona (1).png" alt=""><figcaption></figcaption></figure>

3. Go to **Personas** in the menu under **Personalization**.

<figure><img src="../.gitbook/assets/engage-tutorials-how-to-persona (1).png" alt="Personas menu."><figcaption><p>Personas menu.</p></figcaption></figure>

4. Click **Add New Persona Group**.

<figure><img src="../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

5. Add the details for the **Persona Group.**
   1. Add a **Title.**
   2. Add a **Description.**
   3. Set the[ Advanced settings](how-to-create-a-persona.md#advanced-persona-group-parameters) to fit your needs.

<figure><img src="../.gitbook/assets/image (3) (1).png" alt=""><figcaption></figcaption></figure>

6. Click **Create persona group**.
7. Click **Add persona** to add a new Persona.
   1. Add a **Title/Name** to the Persona.
   2. Add a **description** of the Persona.
   3. Select a **Color** for the Persona.
   4. Select an **image** for the Persona
      * You can upload your own image or use one of the default ones.

<figure><img src="../.gitbook/assets/image (4) (2).png" alt=""><figcaption></figcaption></figure>

7. Click **Add Persona**.

You have now set up your personas and can score your [content](../marketers-and-editors/personalization/implicit-and-explicit-personalization/content-scoring.md), [campaigns](../marketers-and-editors/personalization/implicit-and-explicit-personalization/campaign-scoring.md), and [referrals](../marketers-and-editors/personalization/implicit-and-explicit-personalization/referral-scoring.md) against these personas.

## Advanced persona group parameters

If you want to tweak the working of the persona scoring in-depth, you can go to the advanced settings of a persona group.

Here you have the option to set different parameters:

* **Threshold value**. This threshold value needs to be reached before a persona can become active. In this case, a persona needs to have 25 points at least before a visitor can be this persona.
* **The minimal deviation**. This setting specifies the minimal deviation between the persona with the highest and second-highest scores. This can be specified in an absolute value or a percentage.
* **The minimal deviation percentage**. The percentage specifies the minimum difference between the highest and second-highest scores before a Persona becomes active. In this case, the difference between the first and second persona should be at least 25%.
* **The absolute value deviation**. The absolute value specifies the minimum difference between the highest and second-highest scores before a persona becomes active.
* **The expiration type**. Specify whether the implicit persona scoring expires. This can be set to 'never' when it does not expire or can be set to a number of days or sessions.
* **The maximum points to score**. Specify the maximum number of points that can be scored per persona per item.

By adjusting these settings, you can tweak the performance of the Umbraco Engage algorithm.
