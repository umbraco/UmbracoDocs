This will show a simple tutorial to use the uMarketingSuite Headless API with Umbraco Content Delivery API.

## Setting up a simple Personalization Segment

- With uMarketingSuite goto the **Marketing** Section and the **Personalization** section
- Navigate to the **Segments** tab and click **Add new Segment**
    - Give the segment a name such as **Morning People** or similar
    - And a description such as **For people who like to visit us in the morning**
    - Set the segment type to **Core** as we don't wish this to be temporary and tied to end date for a campaign
    - Choose the parameter **Time of day** and set its configuration values to **Include** **00:00** to **12:00** as it is a 24 hour clock

Refer to the [documentation on Personalization to learn more](/personalization/) what can be done.

![](?width=767&amp;height=437&amp;mode=max)

## Creating a Document Type to Personalize

- Navigate to **Settings** and **Create a New Document Type**
- Ensure the setting **Allow Segmentation** is enabled under **Permissions** and Save the Document Type
- Add a new property to the document type such as **Header** using a **Textstring property editor**
    - Ensure the property added has the **Allow Segmentation** value enabled
- Create a piece of content using this new Document Type so we can query and request it using the Umbraco Content Delivery API
    - *For this example lets create this piece of content at the root*

## Creating Content that is personalized

- With a simple piece of content created click the **Personalization** content app
- Click the **Add personalized variant** button
- In the Add a new variant dialog we can set the following
    - Choose our segment **Morning People** we added earlier
    - Give it a name and a meaningful descriptions such as **Home Page for Morning People**

![]()

- After adding the variant we will return to the content node in split view mode
- We can then add a different piece of content we want to return in our Header property specific to morning people such as **Hello you EARLY risers**
- Save and publish the node with the variant content

![](?width=763&amp;height=434&amp;mode=max)

## Using the Content Delivery API

We will do the reminder of this tutorial using the Swagger development tool, so we can easily create requests against Umbraco Content Delivery API and uMarketingSuite Headless

- Navigate to the swagger endpoint of your site **/umbraco/swagger**
- From the dropdown select the **Umbraco Delivery API**
- Expand the **/umbraco/delivery/api/v1/content/item/{path}**request
    - Click the **Try it out** button
    - For the path parameter enter / for the example piece of content we created at the root of our site - alternatively specify the correct URL path to the content
    - You may need to set the **Api-Key** parameter depending if your Umbraco application has been [setup to allow Public Access](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#additional-configuration) this can be toggled with the configuration value *Umbraco:CMS:DeliveryAPI:PublicAccess*
- If everything is working correctly we should see the JSON result of the content node and see the default value for our header
- Next from the definitions dropdown navigate to **uMarketingSuite Marketing API**
- Expand the **/umbraco/umarketingsuite/api/v1/analytics/pageview/trackpageview/client**request
    - Click the **Try it out** button
    - Modify the JSON body, we need to set the url property to be the page we have just visited with the content delivery api above and we can leave the other property **referrerUrl** empty
- Repeat the earlier steps to fetch the content by it's path and you should note that the JSON of the content node and the header property now contains our personalized content **Hello you EARLY risers**
    - Remember it will only show us different content if we are to view the page before midday

![](?width=746&amp;height=467&amp;mode=max)

**Disclaimer**: Due to the way uMarketingSuite is licenced to individual domains, it is required that the Host Header matches one of the registered licenced domains in order for personalisation and A/B Testing on the Content Delivery API to work

TADA that's it you can see how easy it is.