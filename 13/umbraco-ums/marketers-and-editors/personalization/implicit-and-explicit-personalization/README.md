# Implicit and Explicit Personalization

The Umbraco uMS uses both the concept of implicit and explicit personalization.

## Explicit personalization

This is the "**easiest**" concept to grasp. For every explicit parameter the Umbraco uMS is true or false. For example the browser parameter is an example of an explicit parameter. **A visitor is using a Chrome browser, or not**. There cannot be much debate about this and the parameter returns "true" or "false".

Most of the parameters within the Umbraco uMS are explicit and true or false.

## Implicit personalization

But the unique part of the uMarketingSuite is that is also uses implicit personalization. Based on behaviour of a specific visitor the uMarketingSuite can assume that a visitor is a specific persona or in a specific customer journey phase.

In these article you can read how to [setup the customer journey](/personalization/implicit-explicit-personalization/setting-up-the-customer-journey/) or [personas](/personalization/implicit-explicit-personalization/setting-up-personas/). As soon as you have set these up you can use the segment parameters for the customer journey and the personas.

In the [segment builder](/personalization/creating-a-segment/) you can use these implicit parameters in the same way you would apply any other segment parameter.

![]()

By clicking personas you will see an overview of all the personas that you've setup within your installation. In our case we see the persona groups "**Profiles**" and "**Companies**" and the personas "**Data & Privacy Officer**", "**Developer**", "**Marketer**", "**Agency**", "**Company**" and "**Umbraco HQ**". If we want to create a segment for all personas that are "**Data & Privacy officer**" add that persona as a parameter to the segment.

![]()

From now on you can use this segment to personalize the experience of your visitors. 

You can mix and match implicit and explicit segment parameters. If you want to create a segment for the persona "**Marketer**" which is using the browser "**Firefox**" and **is logged in**, that is perfectly fine!

If you want to see how the algorithm works read the documentation or see it in action on your website with the [Umbraco uMS cockpit](/personalization/cockpit-insights/).