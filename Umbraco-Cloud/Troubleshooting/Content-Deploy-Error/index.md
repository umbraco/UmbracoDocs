#Troubleshooting Content deployment errors

In the unexpected event that you get an error during a Content deployment through the Umbraco backoffice here is how you can debug what went wrong.
First, expanding the technical details within the error-dialog will give you some details about where the error occurred. In most cases this will likely show a stack trace within the Umbraco Deploy code (Courier assemblies), but it should also provide some details about the item that caused the deployment to fail. Use the name and/or id and search the latest CourierTraceLog.txt file found in /App_Data/Logs/.
If you are using a custom PropertyEditor or packages like Archetype, Mortar, or the like you will likely need a Courier provider. Archetype and Mortar already has such available. But using the details from the log file you should be able to determine, which item and possibly PropertyEditor that caused the error and whether a Courier provider is needed.

If you believe it’s an issue caused by Umbraco Deploy then please contact Umbraco support through the Umbraco Cloud Portal.