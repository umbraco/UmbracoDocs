# Troubleshooting duplicate dictionary items

If your site has been using Courier in the past and you have dictionary items that have been deployed between your environments, you may see errors and/or duplicated dictionary items when your site is upgraded to using Umbraco Deploy.

## Cause

Due to how Umbraco Courier has been handling dictionary items in the past, old sites having used Courier to transfer these - are currently very likely to see errors when trying to use Deploy with these items.

Courier handled dictionary items only using their `ItemKey` (alias) and did not take into account that dictionary items also carried a unique identifier. Since this unique identifier was not known or handled by Courier - it would not be carried over to other environments when these dictionary items were deployed. As Courier never cared about or used this unique identifier - everything seemed to be in order most of the time.

Upgrading to Deploy, one of the major improvements is that Deploy handles everything by its unique identifier making it much more stable. However when dictionary items are in a state of not having consistent unique identifiers across each individual environment - they will simply not work with Deploy unless they are syncronized.

## Fixing

In order to fix this issue, it is required that all dictionary items are aligned to have the same unique identifier for a specific `ItemKey` across all environments. The easiest way of doing this is to select an environment where you believe all your dictionary items are mostly correct, remove any duplicated items and then ensure that the changes are pushed to your other environments:

1. Ensure you do not have any duplicated dictionary items in your UDA files. If you do - these will need to be cleaned up as a first step.

2. Ensure you remove all duplicate entries in the backoffice if any.

3. When you can successfully create a `deploy` marker and get a `deploy-complete` - your environment is "clean" and you are good to go.

4. Create a `deploy-repairdictionaryids` marker in the `/data/` folder.

Doing this will make Deploy run through all of the existing UDA files and check if there is any duplicates existing for that particular `ItemKey` used in that UDA file. If it finds a duplicate - it will delete the duplicate in your site, not having the correct ID (according to the UDA file).

If no duplicate is found for this `ItemKey` - Deploy will continue to see if there is an existing dictionary item with the specific `ItemKey`, not having the _correct_ ID (again - according to the UDA file). If an existing item is found - it will reassign the `ID` of this item and all references to it, to the correct ID used in the UDA file.

5. When this is done - you will need to transfer your UDA files to the next environment so you are sure the same ID's will be applied here.

6. Clean out any duplicated entries using the backoffice (doesn't matter which one you delete as they should be identical and the ID will be fixed afterwards).

7. Create a `deploy-repairdictionaryids` marker in the `/data/` folder. Deploy will now update the ID's to match what is in the UDA files.

8. Repeat steps 5-7 if there's any other environments.

## Important Notes

What Deploy will **not** help you with, is duplicated items that do not have a corresponding UDA file. Since we do not know what to do with a dictionary item that we don't have a matching UDA file for - duplicates with no UDA files will simply not be handled.

In case you see this in your site, we suggest that you go to your backoffice and resave ONE of the duplicated items.

This will result in a UDA file being created for that particular dictionary item - and re-running the `repairdictionaryids` task (by creating a marker) will now take care of the other duplicated item (since a single UDA file now exists for that `ItemKey`)
