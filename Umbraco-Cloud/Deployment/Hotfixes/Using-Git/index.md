# Apply hotfix by using Git

In this article you'll find a step-by-step guide on how to apply a hotfix to a Live environment by using only Git.

Tools used:
* GitKraken

## The scenario

You have an Umbraco Cloud project with two environments, Development and Live. 

You have been working on building the site on a local clone of the Development environment, and now you want to send some but not all changes to the Live environment.

Three commits have been pushed from your local clone to the Development environment. Out of these three commits, you only need some of the changes on the Live environment.

![Commits](images/commits-for-cherry.png)

## Apply selected changes to the Live environment

Here are the steps to follow in order to apply selected changes to the Live environment without deploying from Development to Live.

### Branching and Cherry picking

1. Open the Development repository in GitKraken (or your preferred Git client)
2. Choose the commit where you want to create a new branch
    * This branch should be created in an early commit, before the changes you've made locally have been committed
    
        ![Creating new branch](images/create-branch.png)

3. With the new branch, _Hotfix_, selected it's now time to _cherry pick_ the commits you want to apply to the Live environment
4. _Right-click_ the commit you want, and choose **"Cherrypick commit"**
    * You will be asked if you want to commit this directly to the new branch - Choose **Yes**
    * Choose **No** if you want to create a new message for the commit
5. You can cherrypick as many commits as you like
6. Your Git history will now look something like this

    ![Cherrypicking](images/cherry-picked-commits.png)

### Push to Live

Before you push the newly created branch to Umbraco Cloud we need to change the _remote destination_. If you simply hit _Push_ now, the branch would be pushed to the Development environment. You need to add the Live environment as a _new remote_.

7. Find the clone URL for the Live environment in the Umbraco Cloud Portal

    ![Live Clone URL](images/live-clone-URL.png)

8. In GitKraken add a **new remote**, by clicking the **+** next to _Remote_

    ![Add new remote](images/add-remote.png)

9. Give the new remote a name - like **Live**, and add the clone URL for the Live environment to both _Push URL_ and _Pull URL_ - click **Add Remote**

    ![Add Live as remote](images/live-remote.png)

10. You will be prompted to login - use your Umbraco Cloud credentials
11. Now you will see that the history from the Live repository is visible in the Git history
12. Next step; Check out the new branch and hit **Push**
13. Choose to push to the newly added remote, and write **master** to make sure you are pushing to the master branch on the Live environment

    ![Choose remote](images/choose-remote.png)

14. Hit **Submit** and the push will start
15. **Note** that when changes are pushing directly to a Live environment and you have more than one environment, the changes are not automatically extracted into the site
16. Access KUDU on the Live environment
17. Navigate to `site/wwwroot/data` in the _CMD Console_
18. Delete the _deploy_ markers already in the folder - `deploy-complete` and `deploy-ready`
19. Create a _deploy_ marker by typing the following: `echo > deploy`
20. Once this is complete and you see a `deploy-complete` marker, you will see the changes reflected on the Live environment