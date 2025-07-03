# Troubleshooting language mismatches

If you are using dictionary items on a multi-lingual setup, you might see errors related to mismatches between languages.

## Cause

This error occurs when a language is deleted from the backoffice after you have defined some dictionary items. When creating a new site, or a new environment on a project, said instance will investigate the dictionary items' UDAs and find that they mention a language that is not present in the backoffice anymore.

## Identify the issue

The issue will show up as an extraction error on your Umbraco Cloud environment with a red indicator.

<figure><img src="../../../.gitbook/assets/image (55).png" alt=""><figcaption></figcaption></figure>

Upon closer inspection, a more detailed error will reveal itself: `Languages in source and destination site do not match.`

![Languages do not match](../../../troubleshooting/deployments/images/detailed-error.png)

This error can occur in two scenarios and is caused by deleting any backoffice language while having **dictionary items** present on your project.

If the below conditions are met on the "source" environment, you will be presented with the 'Languages in source and destination site do not match.' error on the newly created instance:

1. You have at least two languages set in the backoffice
2. You defined some dictionary items and fill out the translations
3. You removed one of the languages via the Settings dashboard after defining the dictionary items

The first scenario (_Scenario 1_) is when you add a new environment to your project (in most cases it would be the Development environment, though it could happen with Staging as well).

The second scenario (_Scenario 2_) is when you create a new project from a baseline, where the baseline would be your project with dictionary items.

## Fixing

There are 2 ways to get this error resolved.

_Method 1_ - prevention is better than cure! If you resave all your dictionary items on the source environment after deleting the backoffice language(s), the newly created Development environment/child project will have no issues whatsoever.

_Method 2_ - if you have already created the new instance and do not wish to re-create it, you could instead follow this flow: Navigate to `site/wwwroot/data/revision` folder via [KUDU tools](../../power-tools/), find the dictionary items, and then edit the UDA files directly.

![KUDU tools procedure](../../../troubleshooting/deployments/images/kudutools.png)

Deleting the section responsible for the removed language and saving the file should clear out the error - as long as you run a [manual extraction](../../power-tools/manual-extractions.md) afterward. Manually re-saving the dictionary items in the backoffice after the extraction is greatly recommended - it will log those changes in the git repository, and will correct said dictionary items on the source environment with the next deployment.
