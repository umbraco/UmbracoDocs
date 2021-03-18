---
versionFrom: 8.0.0
---
<!--This whole article needs to be verified with help from D-team-->
# How to resolve collision errors

This guide is for solving collision errors when working with Umbraco Deploy. Use this guide when you encounter an error like this:

    Some artifacts collide on unique identifiers.
    This means that they have different Udis, yet
    they refer to the same unique Umbraco object
    and therefore cannot be processed.
    ---------------------------------------------
    Collisions for entity type "document-type":
    Collisions for unique identifier "home":
        UdaFile: ~/data/revision/document-type__4c04d968448747d791b5eae254afc7ec.uda
        UdaFile: ~/data/revision/document-type__f848c577f02b4ee5aea84f87458072a4.uda

The error means that two (or more) `.uda` files have been created for the same entity. The `.uda` files contain schema data for each of your entities e.g Document Types, Templates, Macros, Dictionary Items, Data types, etc (for a full list of these entities see [What are UDA files?](../../../Set-Up/Power-Tools/generating-uda-files/#what-are-uda-files)).

In this example, there are two `.uda` files who share the same alias which leads to a conflict: it is impossible for Deploy to know which of the files to use, so it gives up and sends an error back.

You can run into an error like this on any of your environments. Sometimes you might also run into it on a local clone of your project. This guide will use an example, where two files are colliding on a Development and a Production environment.

## Table of content

* [Video tutorial](#video-tutorial)
* [Using the error message](#using-the-error-message)
* [Deciding which file you want to use](#deciding-which-file-you-want-to-use)
* [Getting your environments in sync](#getting-your-environments-in-sync)

:::tip
When you have two or more environments, we recommend that you never create or make schema changes directly on the Production or Staging environments. You should work with schema only in your Development environment or even better, your local clone of the project.
:::

<!--## Video tutorial
Needs updating
<iframe width="800" height="450" src="https://www.youtube.com/embed/S8tOVxKkqw8?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

You can find a full playlist about Collision errors on our [YouTube Channel](https://www.youtube.com/playlist?list=PLG_nqaT-rbpzgBQkZtRrdzIpeFbRNvO0E).-->

## Using the error message

In the example above the entity involved is a Document Type with "home" as the alias. There are two colliding files both located in the `/data/revision` folder. The files are colliding because they share the same alias but have different GUIDs (also the name of the files).

## Deciding which file you want to use

In order to fix this problem, you will have to decide which of the colliding entities is the correct one and the one you want to use on your Production environment.

Let's use the example from the beginning of this article, where two `.uda` files for the Document Type "home" are colliding.

    Some artifacts collide on unique identifiers.
    This means that they have different Udis, yet
    they refer to the same unique Umbraco object
    and therefore cannot be processed.
    ---------------------------------------------
    Collisions for entity type "document-type":
    Collisions for unique identifier "home":
        UdaFile: ~/data/revision/document-type__4c04d968448747d791b5eae254afc7ec.uda
        UdaFile: ~/data/revision/document-type__f848c577f02b4ee5aea84f87458072a4.uda

For this example, it’s decided that the Document Type currently used on the production environment is the one we want to use going forward.

:::note
Depending on where you are hosting your website there might be different ways that you can access the websites files on your hosting platform, however the principles to how collision errors can be fixed still applies.
:::

In order to figure out which of the two colliding `.uda` files are the one for the Document Type being used on the Live environment follow these steps:

1. Access **Kudu** on the Production environment
2. Use the CMD console (found under the 'Debug console' menu) to navigate to your `site/wwwroot/data/revision` folder
3. Remove the colliding `.uda` files mentioned in the error message from error message
4. Go back to the `/wwwroot/data` folder and run this command: `echo > deploy-export` in the console
5. This will regenerate all `.uda` files for the Live environment - this means only the currently used ones will be there afterward
6. Run the command: `echo > deploy` in the same folder, to make sure everything is extracting correctly

You now know which `.uda` file you want.

## Removing the unused file

:::warning
We strongly recommend that you resolve this locally since this will ensure that the changes you make are added to your repositories. Otherwise, you may end up having the same problem next time you deploy.
:::

1. Clone down the Development environment to your local machine
2. Run the project locally and verify that you get the same extraction error as on your Production environments (*HINT: look for a `deploy-failed` marker in your local `/data ` folder*)
    * When you run the project, you should see an error message in the browser once the site starts to build
3. Remove the wrong `.uda` file from the `/data/revision` folder - you will not be able to see the Document Type in the backoffice because of the failed extraction.
4. Open CMD prompt and navigate to your local `/data` folder
5. Type the following command: `echo > deploy`
6. You will now see a `deploy-complete` marker in your local `/data` folder

:::note
**Does the error mention Templates?**
You might experience that `.uda` files for a template are colliding. When this is the case, we recommend that you copy the content of the `cshtml` file associated with the template you want to keep on your project - this way you'll have a backup of the code you want to use.
:::

## Getting your environments in sync

Before pushing the changes to the Development environment, you need to access the backoffice of the Development environment and remove the Document Type from there.

**Commit** and **push** the changes from your local clone to the Development environment, using your local Git client.

When the push from local to the Development environment has completed, and your build server have run you can see that it goes through without any errors

### Does your Development still have Deploy-failed marker?

Sometimes you might need to run another extraction on your environment after deploying in order to get a `deploy-complete` marker in your `/data` folder.

The final step is to deploy the pending changes from Development to your Production environment, to ensure everything is completely in sync.
