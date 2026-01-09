---
description: >-
  This article shows how to personalize content using the Umbraco Engage
  Headless API and Umbraco’s Content Delivery API.
---

# Headless Example

This article shows how to use the Umbraco Engage Headless API with Umbraco Content Delivery API.

## Setting up a Personalization Segment

1. Go to the **Engage** > **Personalization** section.
2. Navigate to the **Segments** tab.
3. Click **Add new Segment**.
   * Give the segment a name. For example: _Morning People_.
   * And a description such as _For people who like to visit us in the morning_.
   * Set the segment type to **Core** as this is not temporary and is tied to an end date for a campaign.
   * Select the **Time of day** parameter and configure it to **Include** times from **00:00** to **12:00** as it is a 24-hour clock.

For more information, see the [Personalization](../personalization/) documentation.

<figure><img src="../../.gitbook/assets/Personalization-add-new-segment-v16 (1).png" alt="Edit segment view."><figcaption><p>Add new segment</p></figcaption></figure>

### Creating a Document Type for Personalization

1. Navigate to **Settings**.
2. Click **Create a New Document Type**.
3. Enable **Allow Segmentation** under **Settings**.
4. Save the Document Type.
5. Add a new property, such as a **Header**, using a **Textstring** property editor.
   * Ensure **Shared across segments** is enabled for this property.
6. Create a piece of content using this new Document Type to query and request it using the Umbraco Content Delivery API
   * For this example, create this piece of content at the root.

### Creating Personalized Content

1. Open the created content and go to **Personalization**.
2. Click **Add personalized variant**.
3. Set the following in the **Add a new variant** dialog:
   * Choose the segment **Morning People** we added earlier.
   * Give it a name and a meaningful description such as **Home Page for Morning People**.

<figure><img src="../../.gitbook/assets/image (4) (4) (1).png" alt="Add new variant."><figcaption><p>Add new variant.</p></figcaption></figure>

4. After adding the variant we will return to the content node in split-view mode.
5. We can then add a different piece of content we want to return in our Header property specific to morning people such as _Hello you early risers._
6. Save and publish the node with the variant content.

<figure><img src="../../.gitbook/assets/image (5) (4) (1).png" alt="split-view."><figcaption><p>split-view.</p></figcaption></figure>

### Using the Content Delivery API

Let us use the Swagger development tool to make requests to the Umbraco Content Delivery API and Umbraco Engage Headless API.

1. Navigate to the swagger endpoint of your site **/umbraco/swagger**.
2. Select **Umbraco Delivery API** from the dropdown.
3. Expand `/umbraco/delivery/api/v1/content/item/{path}`:
   * Click **Try it out**.
   * For the path parameter, enter `/` for the example piece of content we created at the root of our site - alternatively, specify the correct URL path to the content.
   * Set the **API-Key** parameter if your Umbraco application requires [Public Access](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#additional-configuration) this can be toggled with the configuration value `Umbraco:CMS:DeliveryAPI:PublicAccess`
4. You should view the JSON result of the content node, including the default header value.
5. Navigate to **Umbraco Engage Marketing API** from the definitions dropdown.
6. Expand `/umbraco/engage/api/v1/analytics/pageview/trackpageview/client`:
   * Click **Try it out**.
   * Modify the JSON body, setting the URL to the page visited earlier. With the content delivery API above, leave the other property **referrerUrl** empty.
   * Repeat the earlier steps to fetch the content by its path. The JSON of the content node and the header property now contains our personalized content **Hello you early risers**
     * Remember it will only show different content if we view the page before midday.

<figure><img src="../../.gitbook/assets/image (6) (4) (1).png" alt="Response body."><figcaption><p>Response body.</p></figcaption></figure>

{% hint style="info" %}
Umbraco Engage is licensed to individual domains. It requires the Host Header to match one of the registered licensed domains for personalization and A/B Testing to work.
{% endhint %}
