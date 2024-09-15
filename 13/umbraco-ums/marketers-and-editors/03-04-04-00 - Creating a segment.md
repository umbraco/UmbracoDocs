To start personalizing the website experience of your visitor you need to define groups of visitors that you want to give a personalized experience. These groups of visitors are called '**segments**' in the uMarketingSuite.

The first step is to define these segments and from there you can start personalizing the website experience.

## Segment builder

Segments are created via the unique uMarketingsuite segment builder. This segment builder can be found in the subsection "**Personalization**" and the tab "**Segments**".

![]()

You can create a segment by clicking "**Add new segment**" in the segment builder section. This will open up a popup.

![]()

First you have to give the new segment a name and a short description. You also have the option to specify the segment type:

- **Core segments** are the fundamental building blocks of your personalization strategy
- **Temporary segments** are segments **with an end date**. If some sort of campaign is running and you want to overrule existing segments  you can create a temporary segment. For doing this you need to specify an end date

### Segment parameters

To specify which visitors are part of this segment you can setup one or more segment parameters. The uMarketingSuite comes with several out-of-the-box parameters, but you can also [implement your own segment parameters](/personalization/extending-personalization/implement-your-own-segment-parameters/).

By default the uMarketingSuite gives you the following parameters:

- Persona
- Journey
- Browser
- Device type
- Time of day
- Number of sessions
- Logged in members
- Reached goals
- Campaigns

By clicking on the tile you will setup a parameter for the segment. You can for example want to implement a segment where you group "**All visitors that use firefox after 15:00**" in one segment. To do that you

1. Create a new segment with the name "**My first segment**"
2. Click on the "**Browser**" tile and "**include**" all visitors with the browser "**Firefox**"  
  
![]()  
  
You see all browsers that have visited the website. So if you're missing a specific browser, that is because a visitor to your site has yet to use that browser.  
  
You can save the parameter and the segment will show the parameter that is part of this segment.  
  
![]()
3. Now you can add a parameter for "**Time of day**" because we want to select all visitors after "**15:00**". By clicking on the segment tile "**Time of day**" we can setup the parameter. We put "**15:00**" in **From** and leave "**Until**" empty.  
  
![]()

Now we can save this parameter and add the segment.

We've now created a first segment and you will find that segment in the overview of your segments:

![]()

## Editing and deleting segments

By clicking on the icons at the end of the segment line you can edit the segment or delete the segment. **Please be aware that segments only can be deleted if there is no personalization applied for this segment.** You can see how often the segment is used in the 3rd column:

![]()

By hovering over the icon you see what kind of personalization is applied:

![]()

If you would try to delete this segment the uMarketingSuite will tell you that personalization is applied and that makes it impossible to delete the segment at this moment.

![]()

In the popup, it shows on which pages the personalization is applied and you can click directly to these pages.

## Ordering your segments

The **order of your segments is really important**, because the uMarketingSuite will **only apply one segment per visitor**. So if a visitor falls into multiple segments the segment with the highest priority is applied. Please be aware that is only the case if there's an actual personalization available! If the highest ranking segment does not have any personalization applied, the uMarketingSuite will go to the next available segment that has personalization applied. If none of the segments has personalizaton applied the uMarketingSuite will fallback to the default content.

The ordering of segment is based on:

- **Temporary versus Core segments**. Temporary segments are always applied first. Only if the temporary segments do not apply the core segments are being used.
- Within the temporary and core segments the given priority is being used. The **highest segment** will be applied first.

The priority can be changed by using the arrows in the segment overview:

![]()

Now that we've created our segment we can start [personalizing the website experience of our visitors](/personalization/setting-up-personalization/)!