# Manual opgrade of Umbraco CMS on Cloud

This article will give you a step-by-step on how to manually upgrade your Umbraco Cloud project to run the latest version of Umbraco CMS.

## Prepare for the upgrade

When upgrading an Umbraco Cloud project manually, the very first step is to [clone down your Cloud Development environment to your local machine](../../Setup/Working-locally).

Make sure you can run your Cloud project locally and restore content and media. It's important that you check that everything works once the upgrade has been applied and for this you need to have a clone locally that resembles the Cloud environment as much as possible.

## Get the latest version of Umbraco

* Download the latest version Umbraco CMS from Our
* Unzip the folder to your computer
* Copy the following folders from the inzipped folder to your Cloud project folder:
    * `/bin`
    * `/Umbraco`
    * `Umbraco_Client`

## Merge configuration files

In this step you need to merge the configuration files containing changes. For the we recommend using a tool like [WinMerge](http://winmerge.org/) or [DiifMerge](https://sourcegear.com/diffmerge/).

The reason you shouldn't just overwrite these files is that this will also overwrite any custom configuration you might have setup and it will also overwrite any Umbraco Cloud specific settings.

### Web.config

In the `web.config` file you need to be aware of the following settings:



These are the files you need to merge:

* All files in `/Config` folder
* `Global.asax` 
* `Web.config`