---
versionFrom: 7.0.0
---

# How to resolve collision errors

:::note
If your project is using Umbraco Courier, please refer to this article instead: [Schema Mismatches with Courier](../../Courier/Structure-Errors-Courier)
:::

On some occasions, it is possible that you will encounter **collision errors** on your Umbraco Cloud environments. 

This means that two (or more) `.uda` files have been created for the same entity. The `.uda` files contain schema data for each of your entities e.g Document Types, Templates, Macros, Dictionary Items, Data types etc (for a full list of these entities see [What are UDA files?](../../Setup/Power-Tools/Generating-UDA-files/#what-are-uda-files)).

Here's an example of a collision error:

    Some artifacts collide on unique identifiers.
    This means that they have different Udis, yet
    they refer to the same unique Umbraco object
    and therefore cannot be processed.
    ---------------------------------------------
    Collisions for entity type "document-type": 
      Collisions for unique identifier "home":
        UdaFile: ~/data/revision/document-type__4c04d968448747d791b5eae254afc7ec.uda
        UdaFile: ~/data/revision/document-type__f848c577f02b4ee5aea84f87458072a4.uda


In this example there are two `.uda` files who share the same alias which leads to a conflict: it is impossible for Deploy to know which is the "correct" file, so it gives up and sends an error back.

The error message gives a lot of useful information which you can use to resolve the issue:

* Which entities are involved?
* The unique identifier (alias) for the involved entities
* Location and names of the colliding files

In the example above the entity involved is a Document Type with "home" as the alias. There are two colliding files both located in the `/data/revision` folder. The files are colliding because they share the same alias but have different GUIDs (also the name of the files).

## Cause

<iframe width="800" height="450" src="https://www.youtube.com/embed/pF5SUh30FKI?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

The main cause of this problem is when an entity has been manually created in two or more environments, using the same alias. Since each of the environments are isolated and do not know what the other one is doing until they are synchronized, creating an entity with identical aliases in each environment will actually create duplicate entities that are considered separate entities even though they look the same and share the same alias in the backoffice of both environments.

:::tip
When you have two or more Cloud environments, we recommend that you never create or make schema changes directly on the Live or Staging environments. You should work with schema only in your Development environment or even better, your local clone of the project.
::

## Video tutorial

<iframe width="800" height="450" src="https://www.youtube.com/embed/S8tOVxKkqw8?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

You can find a full playlist about Collision errors on our [YouTube Channel](https://www.youtube.com/playlist?list=PLG_nqaT-rbpzgBQkZtRrdzIpeFbRNvO0E).

## Choose the entity you want to use

In order to fix this problem, you will have to decide which of the colliding entities is the correct one and the one you want to use on your Live environment.

Let's use the example from the beginning of this article, where two `.uda` files for the Document Type "home" are colliding.

You can run into an error like this on all of your Cloud environment. Somestimes you might also run into it, on a local clone of your project.

![Before extraction error](images/visualization1.png)

Up until now, this project has been working fine, since no deployments have been made from Development to Live since the Document Type was created on Development.

### Deploying your changes

It’s now time to deploy the newest changes to the Live environment. Since a Document Type with the same alias has been created in both the Development and the Live environment, the deployment will fail.

![After extraction error](images/visualization2.png)

On a deployment between Umbraco Cloud environments, all the `.uda` files in the `/data/revision` folder will get synced. For this project, this means that both the Development and the Live environments will have two different `.uda` files for the Document Type – the only thing that’s different between the two files are the GUID since they were created in different environments.

**NOTE**: This is when you will see an extraction error like the one shown at the beginning of this article. It is simply not possible to add types with the same alias in the database.

### Choosing the correct UDA file

The next step is to decide which of these Document Types is the correct one. For this project, it’s decided that the Document Type created in the Live environment (DocType 1 and document-type__1.uda) is the correct one.

In order to figure out which of the two colliding `.uda` files are the file for the Document Type created on the Live environment follow these steps:

1.    Access **Kudu** for the Live environment / the environment where the correct Document Type is
2. Use the CMD console (found under the 'Debug console' menu) to navigate to your `site/wwwroot/data/` folder
3.    Remove both colliding `.uda` files from the `/data/revision` folder in the `/wwwroot` folder.
4.    In `/wwwroot/data` run this command: `echo > deploy-export` 
5.    This will generate a `.uda` file for the Document Type, and this will be the correct one
6.    Run `echo > deploy` in the same folder, to make sure everything is extracting correctly

![Finding correct UDA file](images/visualization3.png)

You now know which `.uda` file you want, and it’s time to get the rest of your environments in sync.

### Getting your environment in sync

We strongly recommend that you resolve this locally since this will ensure that the changes you make are added to your Git history.

1.    Clone down the Development environment – or simply do a pull via Git if you already have a local clone
2.    Run the project locally and verify that you get the same extraction error as on your Cloud environments (HINT: look for a `deploy-failed` marker in your local `/data ` folder)
3.    Access the local backoffice
4.    Delete the Document Type from the backoffice
    * If you’ve pulled down a fresh clone of the Development environment, you will need to remove the wrong `.uda` file from the `/data/revision` folder, since you will not be able to see the Document Type in the backoffice because the extraction failed.
5.    Open CMD prompt and navigate to your local `/data` folder
6.    Type the following command: `echo > deploy`
7.    You will now see a `deploy-complete` marker in your local `/data` folder
8.    **Important**: Before you commit and push the changes to the Development environment, you need to access the backoffice of the Development environment and remove the Document Type from there
9.    You are now ready to **commit** and **push** the changes from your local clone to the Development environment, using your local Git client.

![Removing wrong UDA file](images/visualization4.png)

When the push from local to the Development environment has completed, refresh the Umbraco Cloud portal and you will see that the Development environment is now green, which means that the extraction error has been resolved.

![Deploying deletion](images/visualization5.png)

The final step is to deploy the changes from Development to the rest of your environments, to ensure everything is completely in sync.

### Additional notes

Sometimes you might need to run another extraction on your Cloud environment after deploying in order to get a `deploy-complete` marker in your `/data` folder and turn your environment *green*. To do this, follow these steps:

1. Access **Kudu** on the affected environment
2. Use the CMD console (found under the 'Debug console' menu) to navigate to your `site/wwwroot/data/` folder
3. In the console, type the following command: `echo > deploy`
4. When the extraction is done, you should see a `deploy-complete` marker, which means the extraction error was successful (and the environment indicator will be green on the project page)
