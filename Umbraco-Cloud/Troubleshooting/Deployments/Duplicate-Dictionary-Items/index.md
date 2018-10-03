# Troubleshooting duplicate dictionary items 

If your Umbraco Cloud project has been using Courier in the past and you have dictionary items that have been deployed between your environments, you may see errors and/or duplicated dictionary items when your site is upgraded to using Umbraco Deploy.

## Cause

Due to how Umbraco Courier has been handling dictionary items in the past, old sites having used Courier to transfer these - are currently very likely to see errors when trying to use Umbraco Deploy with these items.

Courier handled dictionary items only using their `ItemKey` (alias) and did not take into account that dictionary items also carried a unique identifier. Since this unique identifier was not known or handled by Courier - it would not be carried over to other environments when these dictionary items were deployed. As Courier never cared about or used this unique identifier - everything seemed to be in order most of the time.

Upgrading to Deploy, one of the major improvements is that Deploy handles everything by its unique identifier making it much more stable. However when dictionary items are in a state of not having consistent unique identifiers across each individual environment - they will simply not work with Deploy unless they are synchronized.

## Identify the issue

The issue will show up as an extraction error on your Umbraco Cloud environment with a red indicator.

![Extraction error](images/extraction-error.png)

There are two types of duplicate dictionary item errors. The first scenario (*Scenario 1*) is when you have duplicate *UDA files* for each of your dictionary items. When this is the case, you will see an error message like this:

    Some artifacts collide on unique identifiers.
    This means that they have different Udis, yet
    they refer to the same unique Umbraco object
    and therefore cannot be processed.
    ---------------------------------------------
    Collisions for entity type "dictionary-item": 
        Collisions for unique identifier "Welcome":
            UdaFile: ~/data/revision/dictionary-item__0cff5cd8fca24b9a80d29390dfb917af.uda
            UdaFile: ~/data/revision/dictionary-item__1f1d9fe32e094e6c9b3c8871e123e34c.uda

The second scenario (*Scenario 2*) is when you do not have duplicate files for your dictionary items. In this scenario you will have one UDA file for each of your dictionary items, but each of them are references with a different id in the database. In this scenario you will see an error message like this:

    Some artifacts collide on unique identifiers.
    This means that they have different Udis, yet
    they refer to the same unique Umbraco object
    and therefore cannot be processed.
    ---------------------------------------------
    Collisions for entity type "dictionary-item": 
        Collisions for unique identifier "Welcome":
            Artifact: umb://dictionary-item/01aaeeed662645c8b348b2aa5ff83d6d
            {DictionaryItem umb://dictionary-item/fe1cae45094b43fba0545bdc45d121ed}

You can find more details about UDA files in this article: [Generating UDA files](../../../Set-up/Power-tools/Generating-UDA-files/#what-are-uda-files)

## Fixing

In order to fix this issue, it is required that all dictionary items are aligned to have the same unique identifier for a specific `ItemKey` across all environments. The easiest way of doing this is to select an environment where you believe all your dictionary items are mostly correct, remove any duplicated items and then ensure that the changes are pushed to your other environments:

1. Ensure you do not have any duplicated dictionary items in your UDA files. If you do - these will need to be cleaned up as a first step.

2. Ensure you remove all duplicate entries in the backoffice if any.

3. When you can successfully create a `deploy` marker and get a `deploy-complete` in your `/data/` folder - your environment should be "clean" and you are good to go.
    * If you are encountering Scenario 2, you might not be able to get a `deploy-complete` marker. Instead you need to verify that you do **not** have any duplicate UDA files in your `/data/revisions` folder or dictionary item entries in the backoffice, and then move on to step 4.

4. Create a `deploy-repairdictionaryids` marker in the `/data/` folder. Do this by typing `echo > deploy-repairdictionaryids` in CMD console in Kudu.
    * The command will **not** work on your local clone. If you've done the clean-up from step 1 and 2 on your local machine, you will need to commit and push these changes to your Cloud environment, and run the command there

Doing this will make Deploy run through all of the dictionary items in the database and remove any duplicates (there should be none, if you did the manual cleanup correctly).

When done with this, it will go through all UDA files and check if there is any duplicates existing in your site for that particular `ItemKey` used in that UDA file. If it finds a duplicate - it will update the ID to match, so your dictionary item is synchronized with the UDA file.

5. When this is done - and you end up with a `deploy-complete` marker - you will need to transfer your dictionary item UDA files to the next environment, to ensure the same ID's will be applied here.

6. Create a `deploy-repairdictionaryids` marker in the `/data/` folder.

Deploy will now again delete any existing duplicate entries and update the ID's of the remaining entries to match the IDs in the UDA files.

7. Repeat steps 5-6 if there's any other environments.

## Important Notes

What Deploy will **not** help you with, is duplicated items that do not have a corresponding UDA file. Since we do not know what to do with a dictionary item that we don't have a matching UDA file for - if we find duplicates with no UDA files, we will simply remove one of them to ensure there are no duplicate errors. For this item to be deployed, you will need to recreate a UDA file for it - this can be done simply by saving the item through the backoffice.

Once you've cleaned up the dictionary items on your Umbraco Cloud environments, it is important that you clone down a fresh clone of your project locally to ensure you have all the correct / updated files on your local machine.
