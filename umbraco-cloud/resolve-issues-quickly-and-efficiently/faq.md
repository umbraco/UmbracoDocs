
# Troubleshooting FAQ

We have gathered a list of frequently asked questions below that have something to do with troubleshooting on Umbraco Cloud. These are not covered by the other sections.

## I’m using BuzzHybrid / DonutCaching / LatestHotStuff / other custom add-ins or I’ve created my own data types - do I need to do anything special?

Probably not! In most cases including the custom files (and configuration) is enough for Umbraco Cloud to understand how to deploy your site.  In some cases, namely where you’ve created a data type that serializes data or otherwise stores property data in a non-standard format, you’ll need to also create a corresponding value connector.  Fortunately these are created using the samples [here](https://github.com/umbraco/Umbraco.Deploy.ValueConnectors)


## I press the “Deploy to Staging/Live” button, then nothing happens.  What’s going on?

Umbraco Cloud uses web sockets to communicate between your browser session and the remote environment.

For the following scenarios you may find that deployments (and other operations) do not complete successfully. At this time there is not a workaround to this requirement.
* If your connection to the internet doesn’t support web sockets
* You are behind a proxy server or firewall that blocks web sockets, or
* If the web socket connection is in any other way not supported

## User: username@domain.net could not be authenticated at xxx

This error usually mean that the user's account does not have the same user name and password on the environment you're deploying to. So when that user is deploying from development to staging they will get this error if they either don't exist on the staging environment or if their password is different between the dev and staging environment.
