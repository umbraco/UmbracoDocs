# Troubleshooting FAQ
We have gathered a list of frequently asked questions below that have something to do with troubleshooting on Umbraco Cloud. These are not covered by the other sections.

## I’m using Archetype, do I need to do anything special?

Yes, as Archetype is a third-party created data type you’ll need to include the appropriate data resolver.  You simply include the data resolver in your site’s `/bin/` folder and make sure you commit and push the file when you deploy your site.  You can find the data resolver for Archetype here: [Archetype.Courier](https://github.com/leekelleher/Archetype.Courier)

## I’m using BuzzHybrid / DonutCaching / LatestHotStuff / other custom add-ins or I’ve created my own data types - do I need to do anything special?

Probably not! In most cases simply including the custom files (and configuration) is enough for Umbraco Cloud to understand how to deploy your site.  In some cases, namely where you’ve created a data type that serializes data or otherwise stores property data in a non-standard format, you’ll need to also create a corresponding data resolver.  Fortunately these are easily created using the guide and samples [here](https://github.com/umbraco/Courier/blob/master/Documentation/Developer%20Documentation/Data%20Resolvers.md)


## I press the “Deploy to Staging/Live” button, then nothing happens.  What’s going on?

Umbraco Cloud uses web sockets to communicate between your browser session and the remote environment.  If your connection to the internet doesn’t support web sockets, you are behind a proxy server or firewall that blocks web sockets, or if the web socket connection is in any other way not supported then you may find that deployments (and other operations) may not complete successfully.  At this time there is not a workaround to this requirement.


## I have a package.json file in the root of my website and my deploys keep failing

With the package.json file in place, our service will take that to mean: "Look, I'm a Node.js project, don't treat me as an ASP.NET site!". In order to remedy this you can go into your local clone of the website and find the `.deployment` file and make it look like this:

    [config]
    SCM_SCRIPT_GENERATOR_ARGS = --basic
    POST_DEPLOYMENT_ACTIONS_DIR = C:\KuduService\artifacts\

So the addition here is the line that says `SCM_SCRIPT_GENERATOR_ARGS = --basic`.   
Rest assured: This problem is on our list to fix as soon as possible but for now you can use this workaround.

## I have an error saying:

`User: username@domain.net could not be authenticated at...`

This usually mean that the user's account does not have the same user name and password on the environment you're deploying to. So when that user is deploying from development to staging they will get this error if they either don't exist on the staging environment or if their password is different between the dev and staging environment.
