The uMarketingSuite comes with various built-in segment parameters to build a segment, such as "**Customer Journey**" and "**Time of Day**". However, you may want to build segments with custom rules that are not part of the uMarketingSuite by default. We've got you covered; you can add your own custom segment parameters to the uMarketingSuite. Note you need at least version 1.7.0 for this functionality, which is released at the end end of 2020.

The following guide will explain how this can be done. **Note this is aimed at developers**.  
There are 3 steps, 2 of which are mandatory and the 3rd is optional:

1. C# definition
2. AngularJS definition
3. (optional) Cockpit visualization

This guide will use concrete code samples to add a "**Day of week**" segment parameter where you can select a single day of the week. If a pageview happens on that day the segment parameter will be satisfied.

You can also download the following code for adding this parameter directly to your solution. [Download the code](/{localLink:umb://media/50f4fa6c22b54c4db9c3ac402e43e226} "Additional Parameter").

## 1. C# definition

Your custom segment parameter will need to be defined in C# in order for the uMarketingSuite to use it.  
In code we refer to a segment parameter as a "**segment rule**".

A segment rule is not much more than this:

- A unique rule identifier, e.g. "**DayOfWeek**".
- A configuration object, e.g. "{ dayOfWeek: 3 }"  

    - This is optional, but most rules will have some sort of configuration that the user can alter in the Segment Builder. In our example, the user can configure the specific day of the week.
- A method that specifies whether the rule is satisfied by the current pageview.

You will have to implement the following interfaces for a new custom parameter:

- **uMarketingSuite.Business.Personalization.Segments.Rules.ISegmentRule**
    - You can extend the existing **BaseSegmentRule** to simplify the implementation.
    - The most important part to implement is the **bool IsSatisfied(IPersonalizationProfile context)** method.
- **uMarketingSuite.Business.Personalization.Segments.Rules.ISegmentRuleFactory**
    - Register your implementation of the segment rule factory with **Lifetime.Transient** in a composer.

For the "**Day of week**" example, the code looks like this:

    // Define the segment rulepublic class DayOfWeekSegmentRule : BaseSegmentRule{    public DayOfWeekSegmentRuleConfig TypedConfig { get; }
            public override SegmentRuleValidationMode ValidationMode => SegmentRuleValidationMode.Once;    public DayOfWeekSegmentRule(long id, long segmentId, string type, string config, bool isNegation, DateTime created, DateTime? updated, DayOfWeekSegmentRuleConfig typedConfig)        : base(id, segmentId, type, config, isNegation, created, updated)        => TypedConfig = typedConfig;
            public override bool IsSatisfied(IPersonalizationProfile context)        => context.Pageview.Timestamp.DayOfWeek == TypedConfig.DayOfWeek;}

And the factory which is used to create an instance of this rule:

    public class DayOfWeekSegmentRuleFactory : ISegmentRuleFactory{    public string RuleType { get; } = "DayOfWeek";    public ISegmentRule CreateRule(string config, bool isNegation, long id, long segmentId, DateTime created, DateTime? updated)    {        var typedConfig = JsonConvert.DeserializeObject<DayOfWeekSegmentRuleConfig>(config);        return new DayOfWeekSegmentRule(id, segmentId, RuleType, config, isNegation, created, updated, typedConfig);    }}

We are using the class **DayOfWeekSegmentRuleConfig** as a representation of the configuration of the rule, which is not strictly necessary but makes it easier. The configuration is stored as a string in the database but in code we like to have intellisense so we parse the stored configuration to this class:

    public class DayOfWeekSegmentRuleConfig{    public DayOfWeek DayOfWeek { get; set; }}

The segment rule factory needs to be registered so uMarketingSuite can use it.   
The code below registers the factory in a new composer but you can of course use an existing composer for this if you like:

    public class DayOfWeekSegmentRuleComposer : IUserComposer{    public void Compose(Composition composition)    {        composition.Register<ISegmentRuleFactory, DayOfWeekSegmentRuleFactory>(Lifetime.Transient);         }}

That's the C# part of the custom segment parameter.

## 2. AngularJS definition

We have implemented the business logic for the segment parameter in the previous step, but the parameter cannot be added to your segments in the backoffice yet. In this step we will add some JavaScript + HTML to enable you to add and configure your segments in the uMarketingSuite segment builder.

This step will once again show concrete code samples that belong to our demo parameter "**Day of week**".   
You will need to create a folder somewhere in **App\_Plugins\** of your website that will hold the new files. For this example we name it "**day-of-week**". The folder and contents look like this:

- **App\_Plugins\day-of-week**
    - **package.manifest**
        - Instructs Umbraco to load your JavaScript files
    - **segment-rule-day-of-week-display.html**
        - View for displaying the configuration of your segment parameter
    - **segment-rule-day-of-week-display.js**
        - AngularJS component for displaying your segment parameter
    - **segment-rule-day-of-week-editor.html**
        - View for editing the configuration of your segment parameter
    - **segment-rule-day-of-week-editor.js**
        - AngularJS component for editing the configuration of your segment parameter
    - **segment-rule-day-of-week.js**
        - Define your segment parameter and register in the segment rule repository of uMarketingSuite

Note that the exact file name does not matter, you can name the files however you like just make sure to properly reference the JS files in your package.manifest.

The contents for each of the files is below:

**segment-rule-day-of-week.js**

In this file you define the segment parameter and register it in the repository of uMarketingSuite.

    // If you have your own custom module, use this:// angular.module("myCustomModule", ["uMarketingSuite"]);// angular.module("umbraco").requires.push("myCustomModule");// angular.module("myCustomModule").run([ ... ]) angular.module("umbraco").run([    "umsSegmentRuleRepository",    function (ruleRepo) {        var rule = {            name: "Day of week", // Friendly name            type: "DayOfWeek",   // Rule type / identifier                        iconUrl: "/path/to/icon.png",            // You can also reuse existing uMarketingSuite icons by specifying the "icon"            // property rather than the "iconUrl" property. Use either one or the other, not both.            // icon: "icon-browser",             order: 4, // Position in segment builder                                    // Default config is passed in to your editor when a user adds the rule to the segment            defaultConfig: {                dayOfWeek: null            },            // If you need any data in your editor, specify it here            data: {                days: {                    0: "Sunday",                    1: "Monday",                    2: "Tuesday",                    3: "Wednesday",                    4: "Thursday",                    5: "Friday",                    6: "Saturday",                }            },            // Specify the names of the display and editor components here.            // These will be dynamically rendered in our segment builder and in some other            // places.             components: {                display: "segment-rule-day-of-week-display",                editor: "segment-rule-day-of-week-editor",            },            init: function() {                 // Optional. Use this in case you need to fetch some data                // for your segment parameter.                // For example, the built-in "Browser" segment parameter will fetch                // the list of possible browsers here and will update the "data" property.                // The "thisArg" of this function is set to the rule definition object,                // i.e. if you use "this.data" in this callback you can manipulate the data object                 // of this rule.            }        };        ruleRepo.addRule(rule);    }]);

**segment-rule-day-of-week-editor.html**

This contains the view of your parameter editor.   
Our example editor is just a **&lt;select&gt;** filled with the 7 days of the week. We write the picked value to the "**config.dayOfWeek**" property of our rule. Of course you can make the editor as complex as you want, use multiple fields etc. For more inspiration you can look at the built-in rule editors of uMarketingSuite in **App\_Plugins\uMarketingSuite\dashboard\segments\builder\rules**.

Note we use the "**data.days**" property of our rule definition in the editor. The editor gets passed in the rule definition as well as a "**config**" object which we should update according to the user input.

    <ums-segment-rule-editor name="$ctrl.rule.name" type="$ctrl.rule.type" save="$ctrl.save()">    <select ng-options="value as day for (value, day) in $ctrl.rule.data.days"            ng-model="$ctrl.config.dayOfWeek">        <option value="">- Select -</option>    </select></ums-segment-rule-editor>

**segment-rule-day-of-week-editor.js**

This simply registers the editor component in the uMarketingSuite module so we can use it.   
It should not be necessary to update this file other than update the component name and templateUrl.

    // If you have your own custom module, use that name instead of "umbraco" here.angular.module("umbraco").component("segmentRuleDayOfWeekEditor", {    templateUrl: "/App_Plugins/day-of-week/segment-rule-day-of-week-editor.html",    bindings: {        rule: "<",        config: "<",        save: "&",    },});

**segment-rule-day-of-week-display.html**   
This is the view file used for the visual representation of the segment parameter.  
We simply want to display the picked day to the user:

    <span class="ums-segmentrule__wrapper ums-segmentrule__wrapper--thin">    <span class="ums-segmentrule__rulecontent"          ng-bind="$ctrl.rule.data.days[$ctrl.config.dayOfWeek]"></span></span>

We store the chosen day of the week as an **integer 0-6 ($ctrl.config.dayOfWeek)** but in the display component we want to show the actual day (e.g. "**Monday**"). Our rule definition defines the mapping in its "**data.days**" property so we simply convert it using that and display the name of the day. 

**segment-rule-day-of-week-display.js**In this file we register the display component.

    // If you have your own custom module, use that name instead of "umbraco" here.angular.module("umbraco").component("segmentRuleDayOfWeekDisplay", {    templateUrl: "/App_Plugins/day-of-week/segment-rule-day-of-week-display.html",    bindings: {        config: "<",        rule: "<",    },});

**package.manifest**

To make sure Umbraco actually loads your JS files we specify them here.

    {    "javascript": [        "~/App_Plugins/day-of-week/segment-rule-day-of-week.js",        "~/App_Plugins/day-of-week/segment-rule-day-of-week-display.js",        "~/App_Plugins/day-of-week/segment-rule-day-of-week-editor.js"    ]}

That's it. If all went well you will see your custom parameter editor show up in the segment builder:

![Day of week segment parameter]()

## 3. (Optional) Cockpit visualization

The new segment parameter will show up automatically in the [Cockpit](/personalization/cockpit-insights/) that is part of our package. The cockpit is a live view of uMarketingSuite data for the current visitor. This includes active segments of the current visitor, and therefore your new segment parameter can also show up in the cockpit. By default it will simply display the the **raw configuration of the parameter** as stored in the database ("{ dayOfWeek: 3 }" in our example), and if you hover over it you will see the rule identifier "**DayOfWeek**" rather than a friendly name.

![Raw display of DayOfWeek]()

If you would like to change this to be a bit more readable you can implement the **uMarketingSuite.Web.Cockpit.Segments.ICockpitSegmentRuleFactory** interface. For the DayOfWeek demo parameter, this is the implementation:

    public class DayOfWeekCockpitSegmentRuleFactory : ICockpitSegmentRuleFactory{    public bool TryCreate(ISegmentRule segmentRule, bool isSatisfied, out CockpitSegmentRule cockpitSegmentRule)    {        cockpitSegmentRule = null;        if (segmentRule is DayOfWeekSegmentRule dayOfWeekRule)        {            cockpitSegmentRule = new CockpitSegmentRule            {                Name = "Day of week",                Icon = "/path/to/icon.png",                Config = dayOfWeekRule.TypedConfig.DayOfWeek.ToString(),                IsNegation = segmentRule.IsNegation,                IsSatisfied = isSatisfied,                Type = segmentRule.Type,            };            return true;        }        return false;    }}

So we simply transform the JSON into a human readable representation and we configure an icon to show up in the cockpit. Make sure to register this class in a composer (you can reuse the composer from step 1):

    composition.Register<ICockpitSegmentRuleFactory, DayOfWeekCockpitSegmentRuleFactory>(Lifetime.Transient);

After that the uMarketingSuite will use the additional information to properly render your segment parameter in the cockpit as well. Note that the "**DayOfWeek** test" string is the name of the segment. This segment happens to have only 1 parameter which is the DayOfWeek parameter.

![DayOfWeek formatted]()