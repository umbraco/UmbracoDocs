# Troubleshooting Content deployment errors

In the unexpected event that you get an error during a Content deployment through the Umbraco backoffice here is how you can debug what went wrong.
First, expanding the technical details within the error-dialog will give you some details about where the error occurred. In most cases this will likely show a stack trace within the Umbraco Deploy code, but it should also provide some details about the item that caused the deployment to fail. Use the name and/or id and search the latest UmbracoTraceLog.txt file found in /App_Data/Logs/.

For projects using Umbraco Courier: Courier has it's own log file, CourierTraceLog.txt, which can also be in /App_Data/Logs/. If you are using a custom PropertyEditor or packages like Archetype, Mortar, or the like you will likely need a Courier provider. Archetype and Mortar already has such available. But using the details from the log file you should be able to determine, which item and possibly PropertyEditor that caused the error and whether a Courier provider is needed.

If you believe it’s an issue caused by Umbraco Deploy then please contact Umbraco support through the Umbraco Cloud Portal.

## Timeout issues
Umbraco Deploy have a few built in timeouts, which on larger sites might needs to be modified. You will usually see these timeouts in the backoffice with an exception mentioning a timeout. It will be as part of a full restore or a full deploy of an entire site. In the normal workflow you shuold never hit these timeouts.

The defaults will cover most though. Changing the defaults is just updating the `/Config/UmbracoDeploy.settings.config`. There are four settings available, which all uses the default timeout which currently is set for 8 minutes.
- sessionTimeout
- sourceDeployTimeout
- httpClientTimeout
- databaseCommandTimeout

The settings are simply set on the deploy element in the file. All settings are in seconds:

    <?xml version="1.0" encoding="utf-8"?>
    <settings xmlns="urn:umbracodeploy-settings">
      <deploy sessionTimeout="1200" sourceDeployTimeout="1200" httpClientTimeout="1200"/>
    </settings>



## You get an error of type `DependencyException`

Sometimes you will get an error that looks like this:

    The source environment has thrown a Umbraco.Deploy.Exceptions.DependencyException with message: Entity umb://document/f2820c7766654300bc7aebf34a24def1 ("Contact page" - nodeId 1234) depends on entity umb://document/051ad11bbd8a4c2c81629c1d01d604f8 ("About Us") which cannot be deployed, because it is in the recycle bin.

Or like this:

    The source environment has thrown a Umbraco.Deploy.Exceptions.DependencyException with message: Entity umb://document/f2820c7766654300bc7aebf34a24def1 ("Contact page" - nodeId 1234) depends on entity umb://document/051ad11bbd8a4c2c81629c1d01d604f8 which cannot be deployed, because it does not exist.

These errors indicate that on the `Contact page` has (for example) a picker on it that refers to another content item. This other content item has either been deleted or is in the recycle bin on the environment you're deploying from.

To resolve the issue, find the Contact page (hint: the nodeId can be used in the search field in the top-left of the backoffice) and publish it again. This should remove the reference to the node that is no longer available. Transferring the Contact page node should now succeed.
