# HealthChecks.config

The `HealthChecks.config` file contains the configuration for the health checks, allowing you to disable certain checks when not applicable and to manage the notifications.

Currently there is no user interface for updating the contents of this file.

The following is an example configuration installed with Umbraco.

    <?xml version ="1.0" encoding="utf-8" ?>
	<HealthChecks>
	  <disabledChecks>
	    <!--<check id="1B5D221B-CE99-4193-97CB-5F3261EC73DF" disabledOn="" disabledBy="0" />-->
	  </disabledChecks>
	  <notificationSettings enabled="true" firstRunTime="" periodInHours="24">
	    <notificationMethods>
	      <notificationMethod alias="email" enabled="true" verbosity="Summary">
	        <settings>
	          <add key="recipientEmail" value="alerts@mywebsite.tld" />
	        </settings>
	      </notificationMethod>
	    </notificationMethods>
	    <disabledChecks>
	      <!--<check id="EB66BB3B-1BCD-4314-9531-9DA2C1D6D9A7" disabledOn="" disabledBy="0" />-->
	    </disabledChecks>    
	  </notificationSettings>
	</HealthChecks> 
    
In the first `<disabledChecks>` section it's possible to mark certain checks as disabled.  To do so, uncomment one of the examples and update `id` field with the Id of the test to disable (the `disabledOn` and `disabledBy` fields are not required, in place currently just as placeholders for when this information is managed via a user interface).  The Ids for each core tests can be found on the [Extending Health checks](../../../Extending/Healthcheck/#built-in-checks).

To enable notifications set the `enabled` attribute on `<notificationSettings>` to `true`.

The timing for notifications can be modified by setting the `periodInHours` attribute to the number of hours that should elapse between tests.  If `firstRunTime` is empty, the tests will run for the first time just after the application is started.  To ensure the tests run at a later time - perhaps during low traffic hours, set the time in `hhmm` format (e.g. 2300) and the tests will not run until that time is reached.

The results of tests will always be written to the log files.

Each notification method can separately be enabled or disabled. The attribute `verbosity` can be set to `Summary` or `Detailed` to get more or less information in the alerts, and the `failureOnly` can be set to `true` or `false` if you'd prefer to get notifications only if at least one potential problem is detected.

An email notification method is built-in to Umbraco. The email method is configured within the `<settings>` section of `<notificationMethod alias="email">`, the email address to send the notification to must be provided as the `recipientEmail` value.

Please note that to use health check notifications you must ensure to set the `umbracoApplicationUrl` value in `umbracoSettings.config`.  Without this the checks will only work when requested via the developer section dashboard.  For more information on this setting, please see [Config > UmbracoSettings](../../../Reference/Config/umbracoSettings/#webrouting).
