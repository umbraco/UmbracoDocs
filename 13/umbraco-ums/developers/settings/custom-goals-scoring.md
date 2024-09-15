Prior to uMarketingSuite 1.10.0 goals could only be triggered in 2 ways: pageviews and page events. Starting from 1.10.0 (which will be released towards the end of May 2021) it is possible to define Custom goals which can be triggered through code instead.

To setup Custom goals the approach is quite straightforward:

1. Create your Custom goal
    - This can be done in the uMarketingSuite section at **Settings** &gt; **Goals**
    - Make sure to set the goal type to "**Custom**"
2. Execute C# code to trigger the goal

Creating the goal itself is no different than creating a pageview or page event goal and should be self explanatory. Just make sure to take note of the **goal id** that is displayed in the code snippet after you have saved your goal, this is needed to trigger the goal from code.

![goal id]()

## Trigger goal in C#

When the goal is created the only thing left is to execute C# at some point during the pageview of the visitor to trigger the goal. The code is provided above but will be available below in text so you can copy/paste it. The important part is to inject the **uMarketingSuite.Business.Analytics.Goals.IGoalService**, which has a **TriggerGoal(long goalId, int value)** method. The simplest implementation is something like this:

    using uMarketingSuite.Business.Analytics.Goals;public class YourService{    private IGoalService _goalService;    public YourService(IGoalService goalService) => _goalService = goalService;     public void TriggerGoal()    {         // value of goalId is taken from the code snippet above        _goalService.TriggerGoal(goalId: 37, value: 42);    }}

### Trigger outside of an HttpContext

Note this method will automatically determine the current pageview and in that way ties the goal to a session and visitor as well. This means the HttpContext should be available. If you want to trigger a goal outside of an HTTP request there is an overload of TriggerGoal that takes the GUID of the pageview that the goal relates to. This pageview guid can be retrieved during the original request using the **uMarketingSuite.Business.Analytics.Common.IPageviewGuidManager**. You will need to store this pageview guid somewhere so you can use it at a later time when invoking **\_goalService.TriggerGoal(pageviewGuid, goalId, value);**

That's all. This custom goal can now be used just like the other goals and will show up in any statistics related to goals.