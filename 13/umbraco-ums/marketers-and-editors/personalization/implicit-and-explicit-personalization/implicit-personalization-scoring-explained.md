In the uMarketingSuite you can personalize the website experience of any visitor based on implicit scoring. To do that, please make sure that you've setup at least one [persona](/personalization/implicit-explicit-personalization/setting-up-personas/) or one [customer journey step](/personalization/implicit-explicit-personalization/setting-up-the-customer-journey/).

Implicit personalization is based on gaining confidence that a visitor shows behaviour that can be mapped to a persona or a customer journey step. To gain this confidence it's possible to assign points to specific actions within your website. If a certain threshold of points is reached the uMarketingSuite assumes the visitor is this persona or in a specific customer journey step. As soon as that point is reached, you can use that information to personalize the website experience of your visitor.

There are four ways to score the behaviour of your visitors:

1. [Score the content that a visitor is viewing](/personalization/implicit-personalization-scoring-explained/content-scoring/). This can be done per node.
2. [Score from which (external) website or (external) webpage a visitor was coming](/personalization/implicit-personalization-scoring-explained/referral-scoring/) from when entering your website.
3. [Score the campaigns](/personalization/implicit-personalization-scoring-explained/campaign-scoring/) that a visitor is part of.
4. Or [you can always implement your own scoring](/personalization/extending-personalization/custom-scoring/). In this way the sky is the limit, because you can hook into any external data source you have or behaviour that you want to score.

## Collecting points

The points of all these different source are added and this reaches a certain amount of points per persona. As soon as one of the personas or customer journey steps reaches the threshold that is setup, the algorithm assumes that you are this persona or in that specific journey step.

In the following example the visitor collected 40 points for the "**Data & Privacy officer**" persona, 30 points for the "**Marketer**" persona and 0 points for the developer persona:

![]()

The threshold in this specific case was set to 25 points. As soon as the "**Data & Privacy officer**" reached 25 points the uMarketingSuite assumed that this visitor was a "**Data & Privacy officer**".

In this example there "**Think**" customer journey step is assumed based on the collected amount of points:

![]()

## Tweaking the scoring

You can setup the threshold value and the expected difference between two personas or journey steps in the [setup of the customer journey group](/personalization/implicit-explicit-personalization/setting-up-the-customer-journey/) and [persona group](/personalization/implicit-explicit-personalization/setting-up-personas/).

If you would setup that there should be a deviation of at least 35 points between two each personas the cockpit will show a different visualization in the previous example:

![]()

You can see that the "**Data and privacy officer**" still has 40 points and the marketer 30 points. Both have also reached the treshold of 25 points, but there is not a minimal deviation of 35 points. The uMarketingSuite algorithm now does not assume a persona yet, but will wait until the deviation is big enough (according to the settings) and the "**Data & privacy officer**" reaches 65 points **(30 points of the marketer + a minimal deviation of 35 points)**.