Personalization is one of the key features within the uMarketingSuite. In a fully integrated way you can personalize the experience of each of your visitors within Umbraco. 

Getting started with personalization is really easy and you can start within a couple of minutes.

## Creating a segment

The first thing you need to do is [create a segment](/personalization/creating-a-segment/). A segment is a group of visitors within your website. Which visitors are in a segment can be defined when setting up the segment.

## Personalizing the website for this segment

Once you've created a segment you can [personalize the experience of your visitor](/personalization/setting-up-personalization/). This can be done on a specific page, on multiple pages or per document type.

## Explicit and implicit personalization

The uMarketingSuite allows you to personalize your Umbraco website via [implicit or explicit personalization](/personalization/implicit-explicit-personalization/). To grasp the way the uMarketingSuite handles implicit personalization you can[read the article that explains the workings](/personalization/implicit-personalization-scoring-explained/) of this. Another option is to see in action in [the cockpit view](/personalization/cockpit-insights/) in the frontend of your Umbraco website. 

## Extending personalization

If you want to take your personalization to the next level you can always extend the way the personalization in the uMarketingSuite works by default.

- You can [check if a visitor is part of a specific segment](/personalization/extending-personalization/segment-information/). By doing this you can use C# code to write your own custom logic
- You can extend the scoring algorithm by [adding your own scores to a visitor](/personalization/extending-personalization/custom-scoring/) as well.
- It's also possible to [implement your own segment parameters](/personalization/extending-personalization/implement-your-own-segment-parameters/). If you want to hook the uMarketingSuite into your own data sources for example.