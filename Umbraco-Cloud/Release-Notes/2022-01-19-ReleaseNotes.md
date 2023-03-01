# Release Notes, January 19, 2022

_Project roles on project invite + Improved available upgrade notifications + Baseline loading efficiency_

### Key Takeaways
- **Specify portal project roles on project invites** - When inviting a new user to a project you can specify the portal project role assigned to  the user for each separate environment of the project.
- **Improved available upgrade notifications** - We have improved the notifications for available upgrades on the project page.
- **Baseline loading efficiency in create wizard** - When creating a new cloud project loading of potential baselines is now async for improved performance.

### Specify portal project roles on project invites
When inviting a new team member to a project it is now possible **to specify the project roles directly in the project invite**. Often you want the team member to be assigned a different role for each environment. This is now supported from the very start in the project invite.
A user can now, for example, be assigned with the Admin role on the development environment while being limited to the Write role on the Live environment. All helping to make it faster and easier to set up the correct permissions for team members.

![ProjectInvite_v1](https://user-images.githubusercontent.com/93588665/150125691-cb846cbc-ad7f-4135-9a48-5de640776e62.gif)

### Improved available upgrade notifications
We have reworked a couple of the criteria that triggers **notifications** for an **available upgrade**. Now you will get a notification on Starter projects without a development environment as seen below.

![NotificationAvailableUpgrades](https://user-images.githubusercontent.com/93588665/150126101-2a5b9de9-b5b8-4091-9e13-801eff1f8f6a.png)
Another change is that the upgrade banner will no longer be displayed on projects with one or more environments already upgraded.

### Baseline loading efficiency in create wizard
The _Create new Cloud project wizard_ has in the last weeks undergone some **performance improvements**. The most significant of these is the loading of potential baselines for users with more than 50 cloud projects. Previously this could be quite time-consuming, this has now been updated to loading asynchronously.

We have ensured that the potential baselines are loaded much faster to ensure a **better user experience** and less wasted time before you can start working on a new cloud project.
![BaselineAsyncLoad_v1](https://user-images.githubusercontent.com/93588665/150125758-3fcb5664-f0b4-4bee-926e-ecbbfb113a09.gif)
