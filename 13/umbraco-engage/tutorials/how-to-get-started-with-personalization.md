---
description: >-
  To personalize the content on your website you need to get to know your target
  audience better. Follow this tutorial to get started.
---

# How to Get Started with Personalization

Personalization in Umbraco Engage, and in general, requires building personas, segmenting visitors, and collecting lots of data. Follow this tutorial to get started with all of this.

{% hint style="info" %}
A big part of personalizing your website content is collecting data to use as a base for personalization. Steps 1-4 take you through setting Enage up to collect the required data. You need to collect enough data to move on to step 5.
{% endhint %}

## Tutorial Content

* [Step 1: Define Your Target Audience](how-to-get-started-with-personalization.md#step-1-define-your-target-audience)
* [Step 2: Score Your Content](how-to-get-started-with-personalization.md#step-2-score-your-content)
* [Step 3: Build Segments](how-to-get-started-with-personalization.md#step-3-build-segments)
* [Step 4: Collect Data](how-to-get-started-with-personalization.md#step-4-collect-data)
* [Step 5: Create Personalized Content](how-to-get-started-with-personalization.md#step-5-create-personalized-content)
* [Next Steps](how-to-get-started-with-personalization.md#next-steps)

## Step 1: Define Your Target Audience

Before starting to personalize your website, you need to define personas. These are the types of visitors you want to target through the content on your website.

Try to narrow down the visitors into smaller puzzle pieces that can be combined within a persona group. This can be ‘Profiles’, ‘Job titles’, ‘Industry types’, and the like. The groups are the ingredients that will be used to personalize your content.

Follow the [How to Create Personas tutorial](how-to-create-a-persona.md) before moving on to the next step.

## Step 2: Score Your Content

With the Persona groups and Personas in place, it is time to evaluate and score your content for each persona. Giving content a high score for a persona means that this content is especially relevant for that persona. By scoring your content, you will be able to find the true intention of your visitor. [Learn more about content scoring in the Personalization section](../marketers-and-editors/personalization/implicit-and-explicit-personalization/content-scoring.md).

1. Navigate to the **Content** section.
2. Open a content item that you want to score.
3. Select the **Personalization** content app.

<figure><img src="../.gitbook/assets/enage-personalization-content-scoring (1).png" alt=""><figcaption><p>Score content for each Persona from the Personalization Content App on each content item.</p></figcaption></figure>

4. Go to **Content scoring**.
5. Use the sliders to give the content a score of 1-10 for each persona.
6. Click **Save scoring** when you are done.
7. Repeat steps 2-5 for each content item you want to score based on your personas.

{% hint style="info" %}
Avoid scoring generic content, such as the main landing page, as it does not help identify the website visitors intention.
{% endhint %}

## Step 3: Build Segments

When you have decided which groups to focus on, it is time to build the segments. You segment visitors based on implicit or explicit scoring of their behavior and personas.

These ingredients can be implicitly scored, explicitly scored, or a combination. With implicit scores, you try to find out why someone visits your website. In the CMS, the pages are scored based on the created personas.

1. Navigate to the **Engage** section.
2. Open the **Personalization** dashboard and select **Segments**.

<figure><img src="../.gitbook/assets/engage-personalization-segments (1).png" alt=""><figcaption><p>Create segments from the Personalization dashboard in the Umbraco Engage section of the backoffice.</p></figcaption></figure>

3. Click **Add new segment**.
4. Choose a parameter to base the segment on.

<figure><img src="../.gitbook/assets/engage-personalization-segments-choose-parameter (1).png" alt=""><figcaption><p>Choose which parameter you want to base your new segment on.</p></figcaption></figure>

3. Set up the parameter with the relevant configuration.

<figure><img src="../.gitbook/assets/engage-personalization-segments-choose-persona (1).png" alt=""><figcaption><p>Select the specific persona and whether they should be included or excluded.</p></figcaption></figure>

4. Click **Save parameter** to apply the parameter to the segment.
5. Repeat steps 2-4 to add more parameters if needed.
6. Give the segment a title/name and add a description.
7. Decide whether the segment will be temporary or not.
8. Adjust the size of the control group under the **Advanced settings** if relevant.
9. Click **Add segment** when you are done.

As soon as you set up a segment, data collection will start. You can create and set up more segments depending on your target audiences.

Repeat steps 3-9 above to create and set up additional segments.

## Step 4: Collect Data

When collecting data, it is essential to know if segments are activating and if visitors align with the segments you have set up. With the reporting features within Umbraco Engage, you can measure how a certain segment performs. You can measure the following:

* How many sessions a certain segment has had compared to the total number of sessions?
* How many page views does a certain segment have?
* How many sessions does someone need to fall into a certain segment?

You can use these insights to optimize your segments.

### When is enough data collected?

Data will be collected continuously and you will not have to do anything further until enough data has been collected. However, it is recommended to watch the segment reporting as you might want to optimize segments if they are not performing well.

Once visitors fall into the segments you have set up, you will have enough data to personalize your website content.

## Step 5: Create Personalized Content

When enough data has been collected it is time to create personalized variants of your content page. This can be done directly on the content item you want to personalize. Follow the steps below to personalize your content.

{% hint style="warning" %}
Only content that uses Document Types which allows property segmentation can be personalized. See the **For Developers** box below for more details.
{% endhint %}

<details>

<summary>For Developers: Allow segmentation on Document Types and Properties</summary>

To personalize content, segmentation needs to be allowed on the Document Types and properties used to create it. Follow the steps below to allow segmentation.

1. Open the Document Type that needs to allow segmentation.
2. Access the **Permissions** view.
3. Check the **Allow segmentation** option.
4. **Save** the Document Types.
5. Access the **Design** view for the same Document Type.
6. Click on ⚙️ next to the property where segmentation should be allowed.
7. Check the **Allow segmentation** option.
8. **Submit** the changes.
9. Repeat steps 6-8 for each property that should allow segmentation.
10. **Save** the Document Type.

</details>

1. Navigate to the content item you want to personalize.
2. Open the **Personalization** dashboard.

<figure><img src="../.gitbook/assets/engage-personalization-create-variants (1).png" alt=""><figcaption><p>Create personalized versions of content items from the Personalization dashboard.</p></figcaption></figure>

3. Select **Add personalized variant** to get started with the personalization.
4. Select the **Segment** you want to target with this new variant.
5. Give the variant a **Name**.
6. Add a **Description**.

<figure><img src="../.gitbook/assets/engage-personalization-add-new-variant (1).png" alt=""><figcaption><p>To add a new personalization variant you need to select a segment and add a name and a description.</p></figcaption></figure>

7. Click on **Add new variant** to start editing the variant.

The content opens in a split-view format when all configuration required for the new variant is added. You can add content to the variant while seeing what is currently available by default.

Only fields allowed for segmentation can be edited in the variant. Fields not configured for segmentation will use the values from the default content. When you leave a field blank on the variant, it automatically uses the values from the default content.

<figure><img src="../.gitbook/assets/engage-personalization-split-view (1).png" alt=""><figcaption><p>Use the split-view to personalize the fields in the variant that has been configured for segmentation.</p></figcaption></figure>

8. Add content for the new variant.
9. Select **Save and publish...** when you are done editing.
10. Select the variants you want to publish and click **Save and publish**.

The first personalized variant of your content has now been published. Your visitors will now start getting personalized content when visiting your website.

## Next steps

Now that you have collected data and the first personalized variant published, you can start expanding the personalization further. Personalization is a continuous process and you can always make adjustments to improve your website performance. Monitor the performance of your segments, add more variants, and keep personalizing your website content.

Find some guides below to make adjustments to your personalized content.

### Edit an existing variant

After setting up a personalized variant of a content item, you can add custom CSS and JavaScript. Follow the steps below to learn how.

1. Navigate to the content item with the variant you want to edit.
2. Open the **Personalization** view.
3. Select **Edit** on the variant you want to make changes to.
4. Click on the **Edit variant** button below the Page Title.
5. Add your custom CSS and/or JavaScript.

<figure><img src="../.gitbook/assets/engage-personalization-add-custom-code-to-variant (1).png" alt=""><figcaption><p>Edit the variant to add custom CSS and/or JavaScript to the variant.</p></figcaption></figure>

6. **Save and close** to persist the changes.
7. **Save and publish** the content item.

### Configure the status of a variant

In some cases, you might want to change the status of a variant. Follow the steps below to set a variant status to _inactive_.

1. Navigate to the content item with the variant you want to edit.
2. Open the **Personalization** view.
3. Select **Edit** on the variant you want to edit.
4. Click on the **Edit variant** button below the Page Title.
5. Use the toggle at the bottom of the pop-up to change the variant status.

<figure><img src="../.gitbook/assets/engage-personalization-variant-status (1).png" alt=""><figcaption><p>Edit the variant to toggle the status in case you want to make a variant active/inactive.</p></figcaption></figure>

6. **Save and close** to persist the changes.
7. **Save and publish** the content item.
