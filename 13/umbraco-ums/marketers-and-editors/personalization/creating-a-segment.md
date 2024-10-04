---
description: >-
  Discover how to create and manage segments to personalize the website
  experience for specific visitor groups.
---

# Creating a Segment

To start personalizing the website experience of your visitor, you need to define groups of visitors, called **Segments** in the uMarketingSuite.

You must first define these segments and then you can start personalizing the website experience.

## Segment Builder

Segments are created via the uMarketingsuite segment builder, located under the **Personalization** and the **Segments** tab.

![]()

To create a new segment, follow these steps:

1. Navigate to the segment builder section.
2. Click **Add new segment**.

![]()

3. Give the new segment a **Name** and a short **Description**.
4. Select a segment type:

* **Core segments** are the fundamental building blocks of your personalization strategy
* **Temporary segments** are segments **with an end date**. If some sort of campaign is running and you want to overrule existing segments you can create a temporary segment. For doing this you need to specify an end date

### Segment Parameters

To specify which visitors are part of this segment you can setup one or more segment parameters. uMarketingSuite comes with out-of-the-box parameters, but you can also [implement your own segment parameters](extending-personalization/implement-your-own-segment-parameters.md).

By default, uMarketingSuite provides the following parameters:

* Persona
* Journey
* Browser
* Device type
* Time of day
* Number of sessions
* Logged in members
* Reached goals
* Campaigns

By clicking on the tile you will setup a parameter for the segment. For example, to implement a segment where you group **All visitors that use firefox after 15:00** in one segment. To do that:

1. Create a new segment with the name **My first segment**.
2. Click the **Browser** tile and **include** all visitors using the browser **Firefox**.

![]()

You see all browsers that have visited the website. So if you're missing a specific browser, that is because a visitor to your site has yet to use that browser.

You can save the parameter and the segment will show the parameter that is part of this segment.

![]()

3. Add a parameter for **Time of day** to select all visitors after "**15:00**". Enter **15:00** in **From** and leave **Until** empty.

![]()

Now we can save this parameter and add the segment.

We have now created a first segment and you will find that segment in the overview of your segments:

![]()

## Editing and Deleting Segments

You can edit or delete segments using the icons next to each segment in the overview. Segments can only be deleted if there is no personalization applied to the segment. The third column shows how often the segment is used:

![]()

By hovering over the icon you can see what kind of personalization is applied:

![]()

If you try to delete this segment, a popup notifies that personalization is applied and it is impossible to delete the segment at this moment.

![]()

The popup shows which pages the personalization is applied and you can click directly to these pages.

## Ordering Segments

The **order of the segments is really important** because **only one segment can be applied per visitor**. So if a visitor falls into multiple segments the segment with the highest priority is applied. It is only the case if there is an actual personalization available. If the highest ranking segment does not have any personalization applied, it will go to the next available segment that has personalization applied. If none of the segments has personalizaton applied, it will fallback to the default content.

The ordering of segment is based on:

* **Temporary versus Core segments**: Temporary segments are always applied first. Only if the temporary segments do not apply the core segments are being used.
* **Priority within each segment type**: Within the temporary and core segments the given priority is being used. The **highest segment** will be applied first.

You can adjust the segment order using the arrows in the segment overview.

![]()

Now that your segment is created, you can start [personalizing the website experience for visitors](setting-up-personalization.md).
