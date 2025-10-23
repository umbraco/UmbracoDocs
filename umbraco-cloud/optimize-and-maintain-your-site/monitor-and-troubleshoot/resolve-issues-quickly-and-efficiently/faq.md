
# Troubleshooting FAQ

We have gathered a list of frequently asked questions below that have something to do with troubleshooting on Umbraco Cloud. These are not covered by the other sections.

## I’m using BuzzHybrid / DonutCaching / LatestHotStuff / other custom add-ins or I’ve created my own data types - do I need to do anything special?

Probably not! In most cases including the custom files (and configuration) is enough for Umbraco Cloud to understand how to deploy your site. When you create a Data Type that serializes data or stores property data in a non-standard format, create a corresponding value connector. These are created using the samples mentioned at [Umbraco.Deploy.ValueConnectors](https://github.com/umbraco/Umbraco.Deploy.ValueConnectors)

## I press the “Deploy to Staging/Live” button, then nothing happens. What’s going on?

Umbraco Cloud uses web sockets to communicate between your browser session and the remote environment.

For the following scenarios you may find that deployments (and other operations) do not complete successfully. At this time there is not a workaround to this requirement.

* If your connection to the internet doesn’t support web sockets
* You are behind a proxy server or firewall that blocks web sockets, or
* If the web socket connection is in any other way not supported

## User: username@domain.net could not be authenticated at xxx

This error usually mean that the user's account does not have the same user name and password on the environment you're deploying to. So when that user is deploying from development to staging they will get this error if they either don't exist on the staging environment or if their password is different between the dev and staging environment.

##  My project fails to upgrade (for example, Standard → Pro) with build errors

This can happen if your project contains very long file or folder paths (typically over 200 characters). During a plan upgrade, the deployment process may fail to find certain files, resulting in errors such as:

```
error CS0234: The type or namespace name 'X' does not exist in the namespace 'X' (are you missing an assembly reference?) 
```

To fix, shorten the folder structure or rename long files so that the full file paths stay below 200 characters. Commit and push these changes, then try the upgrade again.
