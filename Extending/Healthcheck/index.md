#Health check

The developer section of the Umbraco backoffice holds a dashboard named "Health Check". It is a handy list of checks to see if your Umbraco installation is configured according to best practices. It's possible to add your custom built health checks.  
This feature has been available since Umbraco version 7.5.

For inspiration when building your own checks you can look at the checks we've [built into Umbraco](https://github.com/umbraco/Umbraco-CMS/tree/dev-v7/src/Umbraco.Web/HealthCheck/Checks). Some examples will follow in this document.

##Built-in checks

Umbraco comes with the following check by default:

* Category "Configuration"
  * Macro errors - checks that the errors are set to `inline` so that pages that error will still load (and just shows a small error message)
  * Try Skip IIS Custom Errors - in IIS 7.5 and higher this should be set to `true` 
* Category "Data Integrity"
  * Data integrity - validates the XML structures for content, media and members that are stored in the `cmsContentXml` table
* Category "Live environment" 
  * Custom errors - should be set to `RemoteOnly` or `On` on your live site
  * Trace mode - should be set to `enabled="false"` on your live site
  * Compilation debug mode - should be set to `debug="false"` on your live site 
* Category "Permissions" 
  * File & folder permissions - checks that folders and files that are either required or recommended to set with write permissions can be accessed
* Category "Security"
  * HTTPS check - to determine if the current site is running on a secure connection
  * `umbracoUseSSL` check - when the site is running on HTTPS, `umbracoUseSSL` needs to be enabled to secure the backoffice
  * HTTPS connectivity check - when connecting to the site over HTTPS, does it return a valid response (i.e. the certificate has not expired)?

##Custom checks

You can build your own health checks. There are two types of health checks you can build: *configuration checks* and *general checks*.

Each health check is a class that needs to have a `HealthCheck` attribute. This attribute has a few things you need to fill in:

* GUID - a unique ID that you've generated for this specific check
* Name - give it a short name so people know what the check is for
* Description - describes what the check does in detail
* Group - this is the category for the check if you use an existing group name (like "Configuration") the check will be added in that category, otherwise a new category will appear in the dashboard


###Configuration checks

These are fairly simple, small checks that take an XPath query and confirm that the value that's expected is there. If the value is not correct, clicking the "Rectify" button will set the recommended value. An example check:

* A configuration check needs to inherit from `Umbraco.Web.HealthCheck.Checks.Config.AbstractConfigCheck`
* A configuration check needs the `HealthCheck` attribute as noted at the start of this document
* `FilePath` is the relative path to which config file you want to check
* `XPath` is the query you want to execute to find the configuration value you want to verify
* `ValueComparisonType` can either be `ValueComparisonType.ShouldEqual` or `ValueComparisonType.ShouldNotEqual`
* `Values` is a list of values that are available for this configuration item - in this example it can be `RemoteOnly` or `On`, they're both acceptable for a live site. 
  * Make sure to set one of these values to `IsRecommended = true` - when the "Rectify" button is pressed, the recommended value will be stored
* `CheckSuccessMessage`, `CheckErrorMessage` and `RectifySuccessMessage` are the messages returned to the user
  * It is highly recommended to use the `LocalizedTextService` so these can be localized. You can add the text in `~/Config/Lang/en-US.user.xml` (or whatever language you like)
  * Don't add the translations to `~/Umbraco/Config/Lang` files, the correct location is `~/Config/Lang/*-*.user.xml`

An example check:

```
using System.Collections.Generic;
using System.Linq;
using Umbraco.Core.Services;

namespace Umbraco.Web.HealthCheck.Checks.Config
{
    [HealthCheck("D0F7599E-9B2A-4D9E-9883-81C7EDC5616F", "Macro errors",
        Description = "Checks to make sure macro errors are not set to throw a YSOD (yellow screen of death), which would prevent certain or all pages from loading completely.",
        Group = "Configuration")]
    public class MacroErrorsCheck : AbstractConfigCheck
    {
        private readonly ILocalizedTextService _textService;

        public MacroErrorsCheck(HealthCheckContext healthCheckContext) : base(healthCheckContext)
        {
            _textService = healthCheckContext.ApplicationContext.Services.TextService;
        }

        public override string FilePath
        {
            get { return "~/Config/umbracoSettings.config"; }
        }

        public override string XPath
        {
            get { return "/settings/content/MacroErrors"; }
        }

        public override ValueComparisonType ValueComparisonType
        {
            get { return ValueComparisonType.ShouldEqual; }
        }

        public override IEnumerable<AcceptableConfiguration> Values
        {
            get
            {
                var values = new List<AcceptableConfiguration>
                {
                    new AcceptableConfiguration
                    {
                        IsRecommended = true,
                        Value = "inline"
                    },
                    new AcceptableConfiguration
                    {
                        IsRecommended = false,
                        Value = "silent"
                    }
                };

                return values;
            }
        }
        
        public override string CheckSuccessMessage
        {
            get
            {
                return _textService.Localize("healthcheck/macroErrorModeCheckSuccessMessage",
                    new[] { CurrentValue, Values.First(v => v.IsRecommended).Value });
            }
        }

        public override string CheckErrorMessage
        {
            get
            {
                return _textService.Localize("healthcheck/macroErrorModeCheckErrorMessage",
                    new[] { CurrentValue, Values.First(v => v.IsRecommended).Value });
            }
        }

        public override string RectifySuccessMessage
        {
            get
            {
                return _textService.Localize("healthcheck/macroErrorModeCheckRectifySuccessMessage",
                    new[] { Values.First(v => v.IsRecommended).Value });
            }
        }
    }
}
```

###General checks
This can be anything you can think of, the results and the rectify action are completely under your control.

* A general check needs to inherit from `Umbraco.Web.HealthCheck.HealthCheck`
* A general check needs the HealthCheck attribute as noted at the start of this document
* All checks run when the dashboard is loaded, this means that the `GetStatus()` method gets executed
  * You can return multiple status checks from `GetStatus()`
* A status check returns a `HealthCheckStatus`
  * If a `HealthCheckStatus` has a `HealthCheckAction` defined then the "Rectify" button will perform that action once clicked
  * Sometimes, the button to fix something should not be called "Rectify", change the `Name` property of a `HealthCheckAction` to provide a better name
  * `HealthCheckAction` has a `Description` property so that you can provide information on what clicking the "Rectify" button will do (or provide links to documentation, for example)
  * `HealthCheckStatus` has a few result levels:
    * `StatusResultType.Success`
    * `StatusResultType.Error`
    * `StatusResultType.Warning`
    * `StatusResultType.Info`
  * A `HealthCheckAction` needs to provide an alias for an action that can be picked up in the `ExecuteAction` method
* It is highly recommended to use the `LocalizedTextService` so text can be localized. You can add the text in `~/Config/Lang/en-US.user.xml` (or whatever language you like)
* Don't add the translations to `~/Umbraco/Config/Lang` files, the correct location is `~/Config/Lang/*-*.user.xml`

An example check:

```
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Hosting;
using Umbraco.Core.Logging;
using Umbraco.Core.Services;

namespace Umbraco.Web.HealthCheck.Checks.SEO
{
    [HealthCheck("3A482719-3D90-4BC1-B9F8-910CD9CF5B32", "Robots.txt",
    Description = "Create a robots.txt file to block access to system folders.",
    Group = "SEO")]
    public class RobotsTxt : HealthCheck
    {
        private readonly ILocalizedTextService _textService;

        public RobotsTxt(HealthCheckContext healthCheckContext) : base(healthCheckContext)
        {
            _textService = healthCheckContext.ApplicationContext.Services.TextService;
        }
        
        public override IEnumerable<HealthCheckStatus> GetStatus()
        {
            return new[] { CheckForRobotsTxtFile() };
        }

        public override HealthCheckStatus ExecuteAction(HealthCheckAction action)
        {
            switch (action.Alias)
            {
                case "addDefaultRobotsTxtFile":
                    return AddDefaultRobotsTxtFile();
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private HealthCheckStatus CheckForRobotsTxtFile()
        {
            var success = File.Exists(HttpContext.Current.Server.MapPath("~/robots.txt"));
            var message = success 
                ? _textService.Localize("healthcheck/seoRobotsCheckSuccess") 
                : _textService.Localize("healthcheck/seoRobotsCheckFailed");

            var actions = new List<HealthCheckAction>();

            if (success == false)
                actions.Add(new HealthCheckAction("addDefaultRobotsTxtFile", Id)
                // Override the "Rectify" button name and describe what this action will do
                { Name = _textService.Localize("healthcheck/seoRobotsRectifyButtonName"),
                    Description = _textService.Localize("healthcheck/seoRobotsRectifyDescription") });

            return
                new HealthCheckStatus(message)
                {
                    ResultType = success ? StatusResultType.Success : StatusResultType.Error,
                    Actions = actions
                };
        }

        private HealthCheckStatus AddDefaultRobotsTxtFile()
        {
            var success = false;
            var message = string.Empty;
            const string content = @"# robots.txt for Umbraco
User-agent: *
Disallow: /umbraco/";

            try
            {
                File.WriteAllText(HostingEnvironment.MapPath("~/robots.txt"), content);
                success = true;
            }
            catch (Exception exception)
            {
                LogHelper.Error<RobotsTxt>("Could not write robots.txt to the root of the site", exception);
            }

            return
                new HealthCheckStatus(message)
                {
                    ResultType = success ? StatusResultType.Success : StatusResultType.Error,
                    Actions = new List<HealthCheckAction>()
                };
        }
    }
}
```