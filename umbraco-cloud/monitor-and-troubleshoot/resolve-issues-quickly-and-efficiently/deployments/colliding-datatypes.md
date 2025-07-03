# Extraction error: Data Type collisions

When creating a new environment on your Umbraco Cloud project, you might encounter some issues regarding some of the default data types built into Umbraco. The data types in question are:

* Content Picker
* Media Picker
* Member picker
* Multiple Media Picker (using Media Picker)
* Related Links

Since these 5 data types are part of the Umbraco CMS, these will be created by default on each new environment on Umbraco Cloud. If metadata files/structure files for these data types have been generated on your Live environment, you might run into extraction errors on your newly created left-most environment. New environments will be exact clones of the Live environment, thus containing all structure and metadata files from that environment.

## How do I know I have this issue?

The issue will present itself as an extraction error on your mainline environment once you've created them.

<figure><img src="../../../.gitbook/assets/image (53).png" alt=""><figcaption></figcaption></figure>

Open the error message by clicking **More info**.

![Error message](../../../troubleshooting/deployments/images/extraction-on-dev-detailed.png)

In the case illustrated above, there are four data types and each has two `UDA files`.

What this means is that a file has been generated for each data type on both the Live and the left-most environment. The Umbraco Deploy engine needs to create one instance of each data type but is currently not able to do so, since it doesn't know which files to build the data types based on.

See the steps below on how to resolve the issue.

## How to resolve the issue

1. Access the backoffice of the affected left-most environment.
2. Find the **Data Types** folder in the Developer section.
3. Delete **only** the data types mentioned in the error message.
   * In the case above, I would need to delete _Member Picker_, _Multiple Media Picker_, _Related Links_, and _Content Picker_
4. [Access Kudu](../../power-tools/) for the affected environment.
5. Follow the [Kudu Documentation](../../power-tools/manual-extractions.md) to run an extraction on the environment.
6. When you get a `deploy-complete` marker, the issue has been resolved.

When you've followed these steps, go through your left-most environment and make sure everything has been created as expected.

The final step you need to take before your left-most environment is completely in sync with your Live environment is to [restore the content](../../../build-and-customize-your-solution/handle-deployments-and-environments/deployment/restoring-content/).
