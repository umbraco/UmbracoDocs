# January 2022

### [Break reference between baseline and child project](broken-reference)

Umbraco Cloud Portal offers a powerful baseline-child relationship between projects, similar to a fork (forked repository) on GitHub. With this feature you can create a clone of an existing project while maintaining a connection between the two projects.

If you at some point **want to break this connection**, between the baseline and one child project, you can do so now. Users with the role of admin are able to break the connection.

Please be aware that the action **cannot be undone**.

![Break reference between baseline and child project (1)](https://user-images.githubusercontent.com/93588665/149168277-e7ffb2e1-34c3-411f-9962-e834150f62d1.gif)

### [New Project Overview Page](../../../begin-your-cloud-journey/project-overview/)

You are now able to access a simpler project overview page for each of your projects. Initially, you can see basic information such as name, alias, **plan and project status**. In the future, we will likely add more project-related information that currently is not presented in the portal.

![New Project Overview Page](https://user-images.githubusercontent.com/93588665/149168523-088b58f1-5a04-43ff-9ac5-f30b62c74e4e.gif)

### Specify portal project roles on project invites

When inviting a new team member to a project it is now possible **to specify the project roles directly in the project invite**. Often you want the team member to be assigned a different role for each environment. This is now supported from the start of the project invite. A user can now be assigned the Admin role in the development environment while being limited to the Writer role in the Live environment. All helping to make it faster and easier to set up the correct permissions for team members.

![ProjectInvite\_v1](https://user-images.githubusercontent.com/93588665/150125691-cb846cbc-ad7f-4135-9a48-5de640776e62.gif)

### Improved available upgrade notifications

We have reworked a couple of the criteria that triggers **notifications** for an **available upgrade**. Now you will get a notification on Starter projects without a development environment as seen below.

<figure><img src="https://user-images.githubusercontent.com/93588665/150126101-2a5b9de9-b5b8-4091-9e13-801eff1f8f6a.png" alt=""><figcaption></figcaption></figure>

Another change is that the upgrade banner will no longer be displayed on projects with one or more environments already upgraded.

### Baseline loading efficiency in create wizard

The _Create new Cloud project wizard_ has in the last weeks undergone some **performance improvements**. The most significant of these is the loading of potential baselines for users with more than 50 cloud projects. Previously this could be time-consuming, this has now been updated to loading asynchronously.

We have ensured that the potential baselines are loaded much faster to ensure a **better user experience**. This reduces the time wasted before you can start working on a new cloud project. ![BaselineAsyncLoad\_v1](https://user-images.githubusercontent.com/93588665/150125758-3fcb5664-f0b4-4bee-926e-ecbbfb113a09.gif)

### [Blob storage connection information](../../../azure-blob-storage/connect-to-azure-storage-explorer.md)

The blob storage connection information for a project was previously only displayed in Kudu which was not convenient or easy to find. A developer should spend as much time as possible developing fantastic solutions and less time in Kudu. Therefore this connection informantion is now easy to _**copy directly from the portal**_ and ready to post into _Azure Blob Explorer_ whenever needed.

![BlobStorage](https://user-images.githubusercontent.com/93588665/151602205-2784ec6c-1142-4221-9bf4-0ba9727ff8f6.gif)

### Project invitation link to clipboard

The project invitation flow in Umbraco Cloud Portal has until recently suffered from invites ending up in the invitees' spam folder. We have _**optimized**_ the configuration of the portal _**email delivery**_ so every invite will now be delivered to the expected receiver - in the correct inbox.

However, there can be exceptions where an email is either bounced or lands in the spam folder. In such cases, a resend of the project invitation might not do the trick. In rare cases, when the email doesn’t show up, we have added the option to _**copy the project invitation link**_ for active invites.

![CopyProjectInviteLink](https://user-images.githubusercontent.com/93588665/151602357-1bd4b165-eb4d-44b5-bc88-b45594ae5dc0.gif)

### Release notes link in the portal

We added new team members to the Cloud Feature team to support our strategy of making Umbraco Cloud [the best way](https://umbraco.com/blog/umbraco-2022-and-onwards/) to host Umbraco solutions. We will continue our _**customer-centric development**_ with an increased focus on input from partners and portal users, improving existing functionality, and creating new exciting features.

In order for agencies and users to keep up with the improvements, we’ve made it easier to find the latest release notes. You can now find the link for the release notes in the profile settings menu. Release notes will be published multiple times each month and list the most relevant fixes and features added to the portal.

### tweaks and improvements

During December we have provided a lot of small improvements to the Umbraco Cloud Portal. Too many to mention, you can find a few of the highlights in the list below.

* Alignment and consistent order of product versions on the project page.
* Confirmation box for restarting environment (_to avoid accidental restarts_)
* Required technical contact details for projects prior to creation (_so every project always has at least one technical contact_)
* Alerts in the portal when a profile does not have a phone number or when a project does not have a technical contact associated (_contact information is important in case there are issues related to a project or a profile_).
