#Troubleshooting Content deployments on Umbraco as a Servivce

##When working locally

If the schema (this includes DocumentTypes, MediaTypes, DataTypes, Templates, Macros and Dictionary items) is different between your local environment and the remote Cloud environment you are deploying to - you cannot start a Content transfer. You will need to deploy these schema updates to ensure that the environments are in-sync before continuing to transfer your content/media (this can contain media from the media section as well).

While Content transfers are done using the Umbraco backoffice, you need to commit the changes to files within the /data/Revision folder in order to sync the remote Cloud environment. The files in this folder represent the serialized version of the schema (DocumentTypes, DataTypes, etc...), and are deployed through the git repository.
If you use a git tool like GitKraken, SourceTree or Git Extensions you should be able to see if there are any pending changes to files within /data/Revision and commit these. Once committed you need to push the committed changes to the remote Development environment (push to the origin master). If the remote has newer commits you need to pull these down and merge with your local changes, and then finally push the changes. Some git tools shows the output from the remote while others don’t.
If you don't have any git tools installed you can use git bash and the following commands:

    # Navigate to the Revision folder
    cd data/Revision
    # Check status of the repository for pending changes
    git status
    # Add pending changes
    git add -A
    # Commit staged files
    git commit -m "Adding updated schema changed"
    # Push to the remote Development environment
    git push origin master
    
    # If the push is rejected you will need to pull first
    git pull origin master
    # Try to push again if there were no conflicts
    git push origin master

If you had to pull down new commits before you could push your changes, then there is a chance that the new commits contained schema changes as well. So in order to ensure that your local site is up-to-date you need to navigate to the /data/ folder and create a deploy  file if one doesn't already exist. From a command line you can simply enter

`/…mysite/data> echo > deploy` 

Now that the schema changes are in sync between your local site and the remote Cloud environment you should be able to transfer your Content changes through the Umbraco backoffice. Go to the Deployment dashboard in the Content section and reload the queue if it’s not shown. In some cases the queue might have been reset during the previous deployment, so if it remains empty please go back and select the Content and/or Media that you want to transfer.

If you continue to see conflicts between the schema parts that were deployed then please refer to the Debugging section below.

##Debugging

If you continue to see conflicts between the schema parts (being DocumentTypes, DataTypes, Templates, etc.) that was just deployed you need to dive into the log files to debug exactly what the problem is.

In order to find the log entries that deals with conflicts in the schema you should log for an entry like the following:


    2015-04-27 14:59:20,546 [10] INFO  Umbraco.Courier.Core.Packaging.RevisionPackaging - [Thread 45] Document types: Home hash-mismatch (local/remote) e5c6dc5f2eee6521b2d024f7777bbd9e / 2628e7c3e4bc7215fd398a2bbb13f423

This error is not very descriptive and if you’re not sure what the difference are then you can investigate it a little bit deeper. If you add a key to your appSettings section in web.config you get to actually see what data we’ve tried to compare, unhashed.
In web.config (on both ends, both source and target), you can add the following key (note: on both the source and target environment):

    <add key="DeployHashDebug" value="true" />

Now when you get the above error, you’ll get the same message with a little more information:

![clone dialog](images/image07.png)

Using a text compare tool like WinMerge we can pretty easily figure out that the property “Test” was added to the local document type but isn’t found on the remote instance.

![clone dialog](images/image00.png)
