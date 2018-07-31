# Manually run extractions on your Cloud environments

When you deploy from one environment to another on your Umbraco Cloud project, the files from the Git repository are merged into the files used on the site. The Deploy engine then runs an extraction. What this means is that the files on the disk will be deserialized into the database on the Cloud environment.

Run an extraction following these steps:

1. Access Kudu
2. Navigate to **CMD** under the **Debug console** menu
3. In the file structure, navigate to `site/wwwroot/data`
4. The `/data` folder contains:
    * `backoffice` folder containing files for the backoffice users
    * `revision` folder containing all your projects UDA files
    * *deploy-marker* indicating the state of the latest extraction (`deploy-complete` or `deploy-failed`)
    * `deploy.log` containing logs from the latest extraction
5. While in this folder, type the following command in the CMD console: `echo > deploy` - this will initiate an extraction on the environment
6. While the extraction is running, the *deploy-marker* will change name to `deploy-progress`
7. The extraction will end in one of two possible outcomes:
    1. `deploy-complete`: The extraction succeeded and your environment is in good shape!
    2. `deploy-failed`: The extraction failed - open the file, to see the error message (the same error message will be shown on your environment in the Umbraco Cloud Portal)

![Run manual extraction](images/manual-extraction.gif)

**NOTE**: Sometimes you might encounter a deploy-marker called `deploy`. This usually means that an extraction cannot run, and you need to restart your environment for the extraction to be able to run.

Sometimes you might also need to run this extraction locally. This can be done by following the above steps using CMD (command prompt) on your local machine, and navigating to the `/data` folder in your local project folder.

Find general information about Kudu and how to access the tool in the [Power tools](../) article.
