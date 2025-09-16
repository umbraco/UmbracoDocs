# How to resolve collision errors

This guide is for solving collision errors on your Umbraco Cloud project. Use this guide when you encounter an error like this:

```
Some artifacts collide on unique identifiers.
This means that they have different Udis, yet
they refer to the same unique Umbraco object
and therefore cannot be processed.
---------------------------------------------
Collisions for entity type "document-type":
Collisions for unique identifier "home":
    UdaFile: ~/deploy/revision/document-type__4c04d968448747d791b5eae254afc7ec.uda
    UdaFile: ~/deploy/revision/document-type__f848c577f02b4ee5aea84f87458072a4.uda
```

The error means that two (or more) `.uda` files have been created for the same entity. The `.uda` files contain schema data for each of your entities. For example, Document Types, Templates, Macros, Dictionary Items, Data types, and so on. For a full list of these entities, see [What are UDA files?](../../power-tools/generating-uda-files.md#what-are-uda-files).

In this example, there are two `.uda` files that share the same alias which leads to a conflict: it is impossible for Deploy to know which of the files to use, so it gives up and sends an error back.

{% hint style="info" %}
If the collision error involves Dictionary Items, use this guide instead: [Troubleshooting duplicate dictionary items](duplicate-dictionary-items.md)
{% endhint %}

You can run into an error like this on all of your Cloud environments. Sometimes you might also run into it on a local clone of your project.

This guide uses an example where two files are colliding across two environments: a left-most environment and the Live environment.

For clarity, the left-most environment will be referred to as the Development environment throughout the guide.

## Table of content

* [Video tutorial](structure-error.md#video-tutorial)
* [Using the error message](structure-error.md#using-the-error-message)
* [Deciding which file you want to use](structure-error.md#deciding-which-file-you-want-to-use)
* [Getting your environments in sync](structure-error.md#getting-your-environments-in-sync)

{% hint style="info" %}
When you have two or more Cloud environments, it is recommended that you only work with schema on local, Development, or flexible environments.
{% endhint %}

## Video tutorial

{% embed url="https://www.youtube.com/embed/HPmatVIt0bY" %}
Fixing collision errors tutorial
{% endembed %}

## Using the error message

In the example above, the entity involved is a Document Type with _home_ as the alias. There are two colliding files both located in the `/deploy/revision` folder. The files are colliding because they share the same alias but have different GUIDs (also the name of the files).

## Deciding which file you want to use

In order to fix this problem, you will have to decide which of the colliding entities is the correct one and the one you want to use on your Live environment.

Let's use the example from the beginning of this article, where two `.uda` files for the Document Type "home" are colliding.

```
Some artifacts collide on unique identifiers.
This means that they have different Udis, yet
they refer to the same unique Umbraco object
and therefore cannot be processed.
---------------------------------------------
Collisions for entity type "document-type":
Collisions for unique identifier "home":
    UdaFile: ~/deploy/revision/document-type__4c04d968448747d791b5eae254afc7ec.uda
    UdaFile: ~/deploy/revision/document-type__f848c577f02b4ee5aea84f87458072a4.uda
```

For this example, it’s decided that the Document Type currently used on the Live environment is the one we want to use going forward.

In order to figure out which of the two colliding `.uda` files are the one for the Document Type being used on the Live environment follow these steps:

1. Connect to the database of the Live environment using the [connect to your cloud database locally tutorial](../../../../build-and-customize-your-solution/set-up-your-project/databases/cloud-database/#connecting-to-your-cloud-database-locally).
2.  Run one of the following queries on the database, depending on the type you see the error with

    * Run the following query, if the error states that the error is a `Collisions for entity type "document-type"`:

    ```sql
    SELECT uniqueId
    FROM umbracoNode
    WHERE id = (SELECT nodeId FROM cmsContentType WHERE alias = '[The alias from the error message eg. home]')
    ```

    * Run the following query, if the error states that the error is a `Collisions for entity type "template"`:

    ```sql
    SELECT uniqueId
    FROM umbracoNode
    WHERE id = (SELECT nodeId FROM cmsTemplate WHERE alias = '[The alias from the error message eg. home]')
    ```

    * Run the following query, if the error states that the error is a `Collisions for entity type "macro"`:

    ```sql
    SELECT uniqueId
    FROM cmsMacro
    WHERE macroAlias = '[The alias from the error message eg. home]'
    ```

    * Run the following query, if the error states that the error is a `Collisions for entity type "data-type"`:

    ```sql
    SELECT uniqueId
    FROM umbracoNode
    WHERE text = '[The alias from the error message eg. home]'
    ```
3. The above-mentioned queries will give you the udi of the entity in use on the live environment.

You now know which `.uda` file you want.

## Removing the unused file

{% hint style="warning" %}
We strongly recommend that you resolve this locally since this will ensure that the changes you make are added to your Git repositories. Otherwise, you may end up having the same problem next time you deploy.
{% endhint %}

1. Clone down the Development environment to your local machine.
2. Run the project locally and verify that you get the same extraction error as on your Cloud environments (Look for a `deploy-failed` marker in your local `/deploy` folder).
   * When you run the project, you should see an error message in the browser once the site starts to build.
3. Remove the wrong `.uda` file (It's the one we did not find in the live environment before) from the `/deploy/revision` folder - you will not be able to see the Document Type in the backoffice because of the failed extraction.
4. Open the Umbraco Backoffice and go to Settings -> Deploy to see the Deploy dashboard.
5. Select `Schema deployment from data files` in the dropdown.
6. You will now see a `deploy-complete` marker in your local `/deploy` folder.

{% hint style="info" %}
**Does the error mention Templates?** You might experience that `.uda` files for a template are colliding. When this is the case, we recommend that you copy the content of the `cshtml` file associated with the template you want to keep on your project - this way you'll have a backup of the code you want to use.
{% endhint %}

## Getting your environments in sync

Before pushing the changes to the Development environment, you need to access the backoffice of the Development environment and remove the Document Type from there.

Commit and push the changes from your local clone to the Development environment, using your local Git client.

When the push from local to the Development environment has been completed, refresh the Umbraco Cloud portal and you will see that the Development environment is now green, which means that the extraction error has been resolved.

### Does your Development Environment still have the red indicator?

Sometimes you might need to run another schema deployment on your Cloud environment after deploying to turn your environment green. To do this, follow the steps described in the [schema deployment guide](../../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/deploy-dashboard.md).

The final step is to deploy the pending changes from Development to your Live environment, to ensure everything is in sync.
