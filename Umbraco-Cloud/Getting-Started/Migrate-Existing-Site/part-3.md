# Generating metadata

You have now moved and merged the files from your own project with the Umbraco Cloud project files. So far, so good! In this part, you are going to generate the so called UDA for all your projects metadata.

## Verify your Cloud project runs locally
* Open a command prompt
* Navigate to the `/data` folder in your local Umbraco Cloud project files
* Add a deploy-marker by typing `echo > deploy`
* Run the Umbraco Cloud project locally
    * The deploy engine will start when the deploy-marker is detected. This also adds the Umbraco Cloud users to the database you merged into the Umbraco Cloud project.
    * When it's done you should see a deploy-complete marker in the `/data` folder
* Go to the backoffice and verify the project has all metadata, content and media as expected.

## Generate UDA files
In order for your project to run on the Umbraco Cloud environments you need to generate UDA files for all your metadata.

* Make sure the folder `/data/revision` on your Umbraco Cloud project is empty
    * If you have any files in the folder, you can safely removes those at this point
* Open a command prompt
* Navigate to the `/data` folder in your local Umbraco Cloud project files
* Add an *export* marker by typing `echo > deploy-export`
    * Generating the UDA files may take a while, depending on the extend of your project
    * You will see a `deploy-complete` marker once the export is done
    * Run `echo > deploy` again in order to run an extraction of your UDA files
    * When you see `deploy-complete` marker, your UDA files has been generated
* You should now see that your `/data/revision` folder has been populated with UDA files corresponding to your projects metadata

![Run echo > deploy-export](images/deploy-export.gif)

At this point you are ready to deploy your site to Umbraco Cloud - Yay!

[Previous chapter: Merge with your Umbraco Cloud project](part-2.md) -- [Next up: Deploy to the Cloud](part-4.md)
