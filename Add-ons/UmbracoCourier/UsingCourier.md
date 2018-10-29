# Using Courier

_Outlines the common gotchas, and the recommended way to work with Courier, to perform as smooth deployments of an Umbraco site as possible_

This document will try to outline what Courier does, why it does it, and how you can work with it to make your deployments as smooth as possible.
It will go through the following: 

- A high-level view of what Courier does
- Why it does that
- What it can and cannot do out of the box
- How to handle the initial deployment
- Working with Courier on a day to day basis.


## What Courier does?
From a high-level view, Courier is pretty simple. You tell it to deploy an item from one site to another, and Courier then figures out what is needed
for that specific item to function on the site you want to transfer it to. 

When it has figured this out, it exports the selected item(s) and their dependencies to a folder, as xml files, along with any images, dlls, and so on. 

Optionally it can compare the packaged items as it finds them, to figure out if they have actually changed since the last update, and will skip those that have. 

Finally, it will build a graph of the deployment, based on the order of dependencies, this means that Courier knows that for a document to be installed, it needs to have its document type, template, data types and so on present on the target website. 

So, in short, it:

- Collects the items you tell it to
- Collects the dependencies of these items 
- Compares the items and dependencies to the target website. 
- Stores the entire collection of files and data
- Builds a graph of the deployment to ensure that things are installed in the right order
- Sends the files and data to the target site, which will then install them

## Why does it perform all those things? 
The objective of Courier is to move functioning items from one place to another, but due to the way Umbraco is built, this is not a trivial task.
Let's consider the number of dependencies that goes into moving a document

- The document itself
- The document data
- Property Editors used to edit the document data
- The document type
- Data types used in the document type
- Dlls, files, settings, content referenced by data types, like the RTE, and the content picker
- The template
- Css, JavaScript and images referenced in the template
- macros in the template
- document ids passed as parameters to the macro, which leads to another document its data and so on.

We can sort these things into hard and soft dependencies, the hard ones are document type, data types and template, without these, the document
cannot exist in the database, due to ID references. 

The soft ones are all the items that make the page and editor actually work, so if you try to view a page without a template, it breaks. Try to edit a document with a data type missing its configuration or a needed dll, it breaks. 

So the short version is, you don't want to miss those dependencies, because your site will not work, and you will have no idea why. 

## What Courier can and cannot do.
The whole idea of Courier builds around the idea of dependencies and references, which Courier can understand to a certain degree.
But there are several areas, where Courier has zero chance of understanding what is going on. 

### When a data type stores node ids
Common thing, a data type stores a node ID, but Courier doesn't know, so it cannot add the document as a dependency, and it cannot convert it into
a GUID, so it will be transferable, however, you can add the data type to the courier.config to tell Courier to look for ids and convert them

### Data in external tables are referenced.
Courier doesn't know about it, can't deploy it, you can write your own provider for it, but this provides you with overhead, and it would
be better if you structured your external data so that it can be movable (avoid IDENTITY and so on.)

### You try to transfer really large files
It can be hard to spot, but if a changeset contains large files, and you try to transfer these over a webservice connection
it will die. You can increase the request limit and so, but it will not ever be 100% solid to do, so it's better to zip your
revision files and xcopy them over, when you need to deploy really large things.


## How to handle the initial deployment
A common scenario seen, is that people try to transfer their entire site in one go, to do the initial deploy. This is not recommended, and really just adds
unneeded overhead to your deployment. Courier adds a lot of extra data and overhead, because it needs to convert to a format that be transferred and
referenced between the 2 sites, it also needs to compare data with this other site and determine which items should transfer, and which should not, finally it
all happens over http, which is another bottleneck.

So in short, when you initially want to deploy your site and don't have 2 environments to sync, just deploy your files and database as normal, and let Courier handle the ongoing day-to-day changes which you subsequently will have to deploy. 


## Day to day work with Courier
Due to Courier handling pretty much every object of your site, it can quickly create some rather large deployments. Even though your editors just want to deploy a single document, they can all of sudden have a deployment with a lot of documents and files in them, due to the whole dependency setup. There are not many ways around this currently. Courier will check for dependencies, and it will include those that have changed, as it is right now. 

But for day to day work, let your developers handle deployments of document types, templates and so on, and do these in small batches, as even minor changes do have a great effect on your Umbraco database. For example, if you add a property type to a document type, that will add an additional row for each document version on your site to the property data table, so even small things can mean big changes.

When your infrastructure (document types, templates, etc) is in place, your editors should in most cases not be bothered with too many big deployments using the right-click menu. Courier will try to skip as many things as possible, and only suggest things that have actually changed, but as you have probably guessed by now, this is no simple task. 

## Ongoing fine tuning
We fine tune this process all the time, to cater to all the different ways an Umbraco site can be built. Some scenarios we simply cannot support out of the box, and some we can add configuration options for so it can fit with as many sites as possible. 

Let us know in the [Courier forum](https://our.umbraco.com/forum/umbraco-courier/) if certain scenarios or setups give unreasonable large deployments. Please provide as many details as possible, or even better, provide us with a database backup, so we can try it out on our local machines and adjust the many variables. 


