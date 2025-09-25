---


meta.Title: Umbraco Healthcheck
description: >-
  The Settings section of the Umbraco backoffice holds a dashboard named 'Health
  Check'. It is a handy list of checks to see if your Umbraco installation is
  configured according to best practices.
---

# Health Check

The Settings section of the Umbraco backoffice holds a dashboard named "Health Check". It is a handy list of checks to see if your Umbraco installation is configured according to best practices. It's possible to add your custom-built health checks.

For inspiration when building your checks you can look at the checks we've [built into Umbraco](https://github.com/umbraco/Umbraco-CMS/tree/v10/dev/src/Umbraco.Core/HealthChecks/Checks), as well as our [guides](guides/). Some examples will follow in this document.

## Built-in checks

Umbraco comes with the following checks by default:

* Category **Configuration**
  * **Macro errors (id: `D0F7599E-9B2A-4D9E-9883-81C7EDC5616F`)** - checks that the errors are set to `inline` so that pages that error will still load (and shows a small error message)
  * **Notification Email Settings (id: `3E2F7B14-4B41-452B-9A30-E67FBC8E1206`)** - checks that the "from" email address used for email notifications has been changed from its default value
* Category **Data Integrity**
  * **Database data integrity check (id: `73DD0C1C-E0CA-4C31-9564-1DCA509788AF`)** - checks for data integrity issues in the Umbraco database
* Category **Live Environment**
  * **Debug Compilation Mode (id: `61214FF3-FC57-4B31-B5CF-1D095C977D6D`)** - should be set to `debug="false"` on your live site
* Category **Permissions**
  * **Folder & File Permissions (id: `53DBA282-4A79-4B67-B958-B29EC40FCC23`)** - checks that the folders and files set with write permissions that are either required or recommended can be accessed
* Category **Security**
  * **Application URL Configuration (id: `6708CA45-E96E-40B8-A40A-0607C1CA7F28`)** - checks if the Umbraco application URL is configured for your site.
  * **Click-Jacking Protection (id: `ED0D7E40-971E-4BE8-AB6D-8CC5D0A6A5B0`)** - checks to see if a header or meta-tag is in place to indicate whether the site can be hosted in an IFRAME. Normally this is best set to deny permission for this to be done, to prevent what is known as [click-jacking](https://www.owasp.org/index.php/Clickjacking) attacks
  * **Content/MIME Sniffing Protection (id: `1CF27DB3-EFC0-41D7-A1BB-EA912064E071`)** - checks that your site contains a header used to protect against Multipurpose Internet Mail Extensions (MIME) sniffing vulnerabilities
  * **Cookie hijacking and protocol downgrade attacks Protection (HSTS) (id: `E2048C48-21C5-4BE1-A80B-8062162DF124`)** - checks if your HTTPS site contains the Strict-Transport-Security Header (HSTS). If not - adds with a default of 18 weeks
  * **Cross-site scripting Protection (id: `F4D2B02E-28C5-4999-8463-05759FA15C3A`)** - checks for the presence of the X-XSS-Protection-header
  * **Excessive Headers (id: `92ABBAA2-0586-4089-8AE2-9A843439D577`)** - checks to ensure that specific headers that can provide details about the technology used to build and host the website have been removed
  * **HTTPS Configuration (id: `EB66BB3B-1BCD-4314-9531-9DA2C1D6D9A7`)** - to determine if the current site is running on a secure connection
  * **UseHttps check** - when the site is running on HTTPS, `Umbraco.Cms.Core.Configuration.Models.GlobalSettings.UseHttps` needs to be enabled to secure the backoffice. The setting can be found under `Umbraco:CMS:Global` in the `appsettings.json` file
* Category **Services**
  * **SMTP Settings (id: `1B5D221B-CE99-4193-97CB-5F3261EC73DF`)** - checks that an Simple Mail Transfer Protocol (SMTP) server is configured and is accepting requests for sending emails

Each check returns a message indicating whether or not the issue in question has been found on the website installation. This could be an error that should be fixed, or a warning you should be aware of.

Some of them can also be rectified via the dashboard, by clicking the **Fix** button and in some cases providing some required information. These changes usually involve writing to configuration files that will often trigger a restart of the website.

## Configuring and scheduling checks

You can view the results of health checks via the Settings section dashboard. Additionally, you can set up the checks to be run on a schedule and be notified of the results by email. It's also possible to disable certain checks if they aren't applicable in your environment.

For more information, see the [Reference > Configuration > Health checks](../../reference/configuration/healthchecks.md) article.

## Custom checks

You can build your own health checks. There are two types of health checks you can build: **configuration checks** and **general checks**.

Each health check is a class that needs to have a `HealthCheck` attribute. This attribute has a few things you need to fill in:

* GUID - a unique ID that you've generated for this specific check
* Name - give it a short name so people know what the check is for
* Description - describes what the check does in detail
* Group - this is the category for the check if you use an existing group name (like "Configuration") the check will be added in that category, otherwise a new category will appear in the dashboard

### Configuration checks

These are small checks that take an [IConfiguration](https://docs.microsoft.com/en-us/dotnet/api/microsoft.extensions.configuration.iconfiguration?view=dotnet-plat-ext-6.0) key and confirm that the value that's expected is there. If the value is not correct, there will be a link to a guide on how to set this value correct.

* A configuration check needs to inherit from `Umbraco.Cms.Core.HealthChecks.Checks.AbstractSettingsCheck`
* A configuration check needs the `HealthCheck` attribute as noted at the start of this document
* `ReadMoreLink` is a link to an external guide that will help you to troubleshoot any problems
* `ValueComparisonType` can either be `ValueComparisonType.ShouldEqual` or `ValueComparisonType.ShouldNotEqual`
* `ItemPath` is the IConfiguration key path leading to the configuration value that you want to verify
* `Values` is a list of values that are available for this configuration item - in this example it can be `RemoteOnly` or `On`, they're both acceptable for a live site.
  * For checks using the `ShouldEqual` comparison method, make sure to set one of these values to `IsRecommended = true`.
  * Where `ShouldNotEqual` is used the fix will require the user to provide the correct setting
* `CurrentValue` is the current value from the configuration setting
* `CheckSuccessMessage` and `CheckErrorMessage` are the messages returned to the user
  * It is highly recommended to use the `LocalizedTextService` so these can be localized. You can add the text in `~/Config/Lang/en-US.user.xml` (or whatever language you like)

An example check:

```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.Macros;
using Umbraco.Cms.Core.Services;
using Umbraco.Extensions;

namespace Umbraco.Cms.Core.HealthChecks.Checks.Configuration
{
    /// <summary>
    /// Health check for the recommended production configuration for Macro Errors.
    /// </summary>
    [HealthCheck(
        "D0F7599E-9B2A-4D9E-9883-81C7EDC5616F",
        "Macro errors",
        Description = "Checks to make sure macro errors are not set to throw a YSOD (yellow screen of death), which would prevent certain or all pages from loading completely.",
        Group = "Configuration")]
    public class MacroErrorsCheck : AbstractSettingsCheck
    {
        private readonly ILocalizedTextService _textService;
        private readonly IOptionsMonitor<ContentSettings> _contentSettings;

        /// <summary>
        /// Initializes a new instance of the <see cref="MacroErrorsCheck"/> class.
        /// </summary>
        public MacroErrorsCheck(
            ILocalizedTextService textService,
            IOptionsMonitor<ContentSettings> contentSettings)
            : base(textService)
        {
            _textService = textService;
            _contentSettings = contentSettings;
        }

        /// <inheritdoc/>
        public override string ReadMoreLink => Constants.HealthChecks.DocumentationLinks.Configuration.MacroErrorsCheck;

        /// <inheritdoc/>
        public override ValueComparisonType ValueComparisonType => ValueComparisonType.ShouldEqual;

        /// <inheritdoc/>
        public override string ItemPath => Constants.Configuration.ConfigContentMacroErrors;

        /// <summary>
        /// Gets the values to compare against.
        /// </summary>
        public override IEnumerable<AcceptableConfiguration> Values
        {
            get
            {
                var values = new List<AcceptableConfiguration>
                {
                    new AcceptableConfiguration
                    {
                        IsRecommended = true,
                        Value = MacroErrorBehaviour.Inline.ToString()
                    },
                    new AcceptableConfiguration
                    {
                        IsRecommended = false,
                        Value = MacroErrorBehaviour.Silent.ToString()
                    }
                };

                return values;
            }
        }

        /// <inheritdoc/>
        public override string CurrentValue => _contentSettings.CurrentValue.MacroErrors.ToString();

        /// <summary>
        /// Gets the message for when the check has succeeded.
        /// </summary>
        public override string CheckSuccessMessage =>
            _textService.Localize(
                "healthcheck","macroErrorModeCheckSuccessMessage",
                new[] { CurrentValue, Values.First(v => v.IsRecommended).Value });

        /// <summary>
        /// Gets the message for when the check has failed.
        /// </summary>
        public override string CheckErrorMessage =>
            _textService.Localize(
                "healthcheck","macroErrorModeCheckErrorMessage",
                new[] { CurrentValue, Values.First(v => v.IsRecommended).Value });
    }
}
```

### General checks

This can be anything you can think of, the results and the rectify action are entirely under your control.

* A general check needs to inherit from `Umbraco.Cms.Core.HealthChecks.HealthCheck`
* A general check needs the `HealthCheck` attribute as noted at the start of this document
* All checks run when the dashboard is loaded, this means that the `GetStatus()` method gets executed
  * You can return multiple status checks from `GetStatus()`
* A status check returns a `HealthCheckStatus`
  * If a `HealthCheckStatus` has a `HealthCheckAction` defined then the "Fix" button will perform that action once clicked
  * Sometimes, the button to fix something should not be called "Fix", change the `Name` property of a `HealthCheckAction` to provide a better name
  * `HealthCheckAction` has a `Description` property so that you can provide information on what clicking the "Rectify" button will do (or provide links to documentation, for example)
  * `HealthCheckStatus` has a few result levels:
    * `StatusResultType.Success`
    * `StatusResultType.Error`
    * `StatusResultType.Warning`
    * `StatusResultType.Info`
  * A `HealthCheckAction` needs to provide an alias for an action that can be picked up in the `ExecuteAction` method
* It is highly recommended to use the `LocalizedTextService` so text can be localized. You can add the text in `~/Config/Lang/en-US.user.xml` (or whatever language you like)

An example check:

```csharp
using Umbraco.Cms.Core.HealthChecks;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Infrastructure.HostedServices;
using Umbraco.Extensions;
using IHostingEnvironment = Umbraco.Cms.Core.Hosting.IHostingEnvironment;

namespace Umbraco.Web.HealthCheck.Checks.SEO;

[HealthCheck("3A482719-3D90-4BC1-B9F8-910CD9CF5B32", "Robots.txt",
    Description = "Create a robots.txt file to block access to system folders.",
    Group = "SEO")]
public class RobotsTxt : Cms.Core.HealthChecks.HealthCheck
{
    private readonly IHostingEnvironment _hostingEnvironment;
    private readonly ILogger<HealthCheckNotifier> _logger;
    private readonly ILocalizedTextService _textService;

    public RobotsTxt(ILocalizedTextService textService, IHostingEnvironment hostingEnvironment,
        ILogger<HealthCheckNotifier> logger)
    {
        _textService = textService;
        _hostingEnvironment = hostingEnvironment;
        _logger = logger;
    }

    public override Task<IEnumerable<HealthCheckStatus>> GetStatus() =>
        Task.FromResult((IEnumerable<HealthCheckStatus>)new[] { CheckForRobotsTxtFile() });

    public override HealthCheckStatus ExecuteAction(HealthCheckAction action)
    {
        switch (action.Alias)
        {
            case "addDefaultRobotsTxtFile":
                return AddDefaultRobotsTxtFile();
            default:
                throw new InvalidOperationException("Action not supported");
        }
    }

    private HealthCheckStatus CheckForRobotsTxtFile()
    {
        var success = File.Exists(_hostingEnvironment.MapPathContentRoot("~/robots.txt"));
        var message = success
            ? _textService.Localize("healthcheck", "seoRobotsCheckSuccess")
            : _textService.Localize("healthcheck","seoRobotsCheckFailed");

        var actions = new List<HealthCheckAction>();

        if (success == false)
        {
            actions.Add(new HealthCheckAction("addDefaultRobotsTxtFile", Id)
                // Override the "Rectify" button name and describe what this action will do
                {
                    Name = _textService.Localize("healthcheck","seoRobotsRectifyButtonName"),
                    Description = _textService.Localize("healthcheck","seoRobotsRectifyDescription")
                });
        }

        return
            new HealthCheckStatus(message)
            {
                ResultType = success ? StatusResultType.Success : StatusResultType.Error, Actions = actions
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
            File.WriteAllText(_hostingEnvironment.MapPathContentRoot("~/robots.txt"), content);
            success = true;
        }
        catch (Exception exception)
        {
            _logger.LogError(exception, "Could not write robots.txt to the root of the site");
        }

        return
            new HealthCheckStatus(message)
            {
                ResultType = success ? StatusResultType.Success : StatusResultType.Error,
                Actions = new List<HealthCheckAction>()
            };
    }
}
```

## Custom health check notifications

Health check notifications can be scheduled to run periodically and notify you of the results. Included with Umbraco is a notification method to deliver the results via email. In a similar manner to how it's possible to create your health checks, you can also create custom notification methods. These methods can send the message summarizing the status of the health checks via other means. Again, for further details on implementing this please refer to the [existing notification methods within the core code base](https://github.com/umbraco/Umbraco-CMS/tree/v10/dev/src/Umbraco.Core/HealthChecks/NotificationMethods).

Each notification method needs to implement the core interface `IHealthCheckNotificationMethod` and, for ease of creation, can inherit from the base class `NotificationMethodBase`, which itself implements the `IHealthCheckNotificationMethod` interface. The class must also be decorated with an instance of the `HealthCheckNotificationMethod` attribute. There's one method to implement - `SendAsync(HealthCheckResults results)`. This method is responsible for taking the results of the health checks and sending them via the mechanism of your choice.

The following example shows how the core method for sending notification via email is implemented:

```csharp
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.Hosting;
using Umbraco.Cms.Core.Mail;
using Umbraco.Cms.Core.Models.Email;
using Umbraco.Cms.Core.Services;
using Umbraco.Extensions;

namespace Umbraco.Cms.Core.HealthChecks.NotificationMethods
{
    [HealthCheckNotificationMethod("email")]
    public class EmailNotificationMethod : NotificationMethodBase
    {
        private readonly ILocalizedTextService? _textService;
        private readonly IHostingEnvironment? _hostingEnvironment;
        private readonly IEmailSender? _emailSender;
        private readonly IMarkdownToHtmlConverter? _markdownToHtmlConverter;
        private ContentSettings? _contentSettings;

        public EmailNotificationMethod(
            ILocalizedTextService textService,
            IHostingEnvironment hostingEnvironment,
            IEmailSender emailSender,
            IOptionsMonitor<HealthChecksSettings> healthChecksSettings,
            IOptionsMonitor<ContentSettings> contentSettings,
            IMarkdownToHtmlConverter markdownToHtmlConverter)
            : base(healthChecksSettings)
        {
            var recipientEmail = Settings?["RecipientEmail"];
            if (string.IsNullOrWhiteSpace(recipientEmail))
            {
                Enabled = false;
                return;
            }

            RecipientEmail = recipientEmail;

            _textService = textService ?? throw new ArgumentNullException(nameof(textService));
            _hostingEnvironment = hostingEnvironment;
            _emailSender = emailSender;
            _markdownToHtmlConverter = markdownToHtmlConverter;
            _contentSettings = contentSettings.CurrentValue ?? throw new ArgumentNullException(nameof(contentSettings));

            contentSettings.OnChange(x => _contentSettings = x);
        }

        public string? RecipientEmail { get; }

        public override async Task SendAsync(HealthCheckResults results)
        {
            if (ShouldSend(results) == false)
            {
                return;
            }

            if (string.IsNullOrEmpty(RecipientEmail))
            {
                return;
            }

            var message = _textService?.Localize("healthcheck","scheduledHealthCheckEmailBody", new[]
            {
                DateTime.Now.ToShortDateString(),
                DateTime.Now.ToShortTimeString(),
                _markdownToHtmlConverter?.ToHtml(results, Verbosity)
            });

            // Include the Umbraco Application URL host in the message subject so that
            // you can identify the site that these results are for.
            var host = _hostingEnvironment?.ApplicationMainUrl?.ToString();

            var subject = _textService?.Localize("healthcheck","scheduledHealthCheckEmailSubject", new[] { host });


            var mailMessage = CreateMailMessage(subject, message);
            Task? task = _emailSender?.SendAsync(mailMessage, Constants.Web.EmailTypes.HealthCheck);
            if (task is not null)
            {
                await task;
            }
        }

        private EmailMessage CreateMailMessage(string? subject, string? message)
        {
            var to = _contentSettings?.Notifications.Email;

            if (string.IsNullOrWhiteSpace(subject))
                subject = "Umbraco Health Check Status";

            var isBodyHtml = message.IsNullOrWhiteSpace() == false && message!.Contains("<") && message.Contains("</");
            return new EmailMessage(to, RecipientEmail, subject, message, isBodyHtml);
        }
    }
}
```

If a custom configuration is required for a custom notification method, the following extract can be merged in the `appsettings.json` file. This will enable the email notification method to be configured:

```json
{
 "Umbraco": {
    "CMS": {
      "HealthChecks": {
        "Notification": {
          "Enabled": true,
          "NotificationMethods": {
            "email": {
              "Enabled": true,
              "Settings": {
                "RecipientEmail" : "alerts@mywebsite.tld"
              }
            }
          }
        }
      }
    }
  }
}
```

If you want to get the notifications by email, Simple Mail Transport Protocol (SMTP) settings should also be configured in the same JSON file.
