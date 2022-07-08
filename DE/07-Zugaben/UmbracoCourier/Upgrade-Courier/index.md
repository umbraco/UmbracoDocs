---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Upgrade Courier

As with all of our products, it is always recommended to run the latest version of Umbraco Courier.

On the [Courier page in the Packages section](https://our.umbraco.com/packages/umbraco-pro/umbraco-courier/) you can see what the latest version is, as well as read the changelog.

Here are the steps you need to follow carefully to upgrade Umbraco Courier:

1. Download the latest version of Umbraco Courier here: http://nightly.umbraco.org/?container=umbraco-courier-release
    * Choose the file called Courier.vX.Y.Z.HotFix.zip - where *X.Y.Z* is the version number
2. Unzip the file on your computer
3. Copy/Paste the files from the unzipped folder to the root of your website files
    * **Note:** If you've added custom configuration in the `courier.config` file you may not want to overwrite this file
4. Your website will restart and upgrade Courier
